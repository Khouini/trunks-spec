#!/usr/bin/env python3
"""Extract a feature's raw client correspondence into readable text.

Usage: python3 extract_correspondence.py .correspondence/<client>/<feature>/

For every .eml in the folder, in date order:
  - prints the headers and the body (plain text preferred, HTML stripped otherwise);
  - saves each non-inline attachment next to the emails as
    attachment_<YYYY-MM-DD>_<original name> (inline signature images are skipped);
  - converts each .docx attachment to Markdown (<same name>.md): headings, nested
    lists, bold, tables (merged cells kept aligned), tracked changes, comments.
Identical attachments re-sent in later emails are flagged, changed ones are diffed.

Standard library only (no pandoc or python-docx needed). Output files land
in the git-ignored .correspondence/ folder, never in docs/.
"""
import difflib
import email
import glob
import hashlib
import html
import os
import re
import sys
import zipfile
import xml.etree.ElementTree as ET
from email import policy

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"


# ---------- .docx -> Markdown ----------

def _text(el):
    out = []
    for n in el.iter():
        if n.tag == W + "t":
            out.append(n.text or "")
        elif n.tag == W + "delText":
            out.append("~~" + (n.text or "") + "~~")
        elif n.tag == W + "tab":
            out.append(" ")
        elif n.tag in (W + "br", W + "cr"):
            out.append(" ")
    return re.sub(r"[ \t]+", " ", "".join(out)).strip()


def _is_bold(p):
    runs = [r for r in p.iter(W + "r") if _text(r)]
    return bool(runs) and all(
        r.find(W + "rPr") is not None and r.find(W + "rPr").find(W + "b") is not None for r in runs
    )


def _para(p, in_table=False):
    txt = _text(p)
    if not txt:
        return ""
    ppr = p.find(W + "pPr")
    style, level = "", None
    if ppr is not None:
        s = ppr.find(W + "pStyle")
        style = s.get(W + "val", "") if s is not None else ""
        num = ppr.find(W + "numPr")
        if num is not None:
            il = num.find(W + "ilvl")
            level = int(il.get(W + "val")) if il is not None else 0
    if in_table:
        return txt.replace("|", "\\|")
    m = re.match(r"(?:Heading|Titre|Nagwek)(\d)", style)
    if m:
        return "#" * (int(m.group(1)) + 1) + " " + txt
    if style.lower().startswith("title"):
        return "# " + txt
    if _is_bold(p):
        txt = "**" + txt + "**"
    if level is not None:
        return "  " * level + "- " + txt
    return txt


def _table(tbl):
    rows = []
    for tr in tbl.findall(W + "tr"):
        cells = []
        for tc in tr.findall(W + "tc"):
            parts = [_para(p, True) for p in tc.findall(W + "p")]
            cells.append("<br>".join(x for x in parts if x))
            tcpr = tc.find(W + "tcPr")
            span = tcpr.find(W + "gridSpan") if tcpr is not None else None
            if span is not None:
                cells += [""] * (int(span.get(W + "val")) - 1)
        rows.append(cells)
    rows = [r for r in rows if any(r)]
    if not rows:
        return ""
    n = max(len(r) for r in rows)
    rows = [r + [""] * (n - len(r)) for r in rows]
    lines = ["| " + " | ".join(rows[0]) + " |", "|" + "---|" * n]
    lines += ["| " + " | ".join(r) + " |" for r in rows[1:]]
    return "\n".join(lines)


def docx_to_md(path):
    z = zipfile.ZipFile(path)
    body = ET.fromstring(z.read("word/document.xml")).find(W + "body")
    out = []
    for el in body:
        if el.tag == W + "p":
            x = _para(el)
            if x:
                out.append(x)
        elif el.tag == W + "tbl":
            out.append(_table(el))
    md = "\n\n".join(out)
    ins = [_text(i) for i in body.iter(W + "ins") if _text(i)]
    if ins:
        md += "\n\n---\nTRACKED INSERTIONS:\n" + "\n".join("- " + i for i in ins)
    if "word/comments.xml" in z.namelist():
        c = ET.fromstring(z.read("word/comments.xml"))
        md += "\n\n---\nCOMMENTS (author = personal data, do not copy into docs):\n"
        md += "\n".join("- " + _text(cm) for cm in c.findall(W + "comment"))
    media = [n for n in z.namelist() if n.startswith("word/media/")]
    if media:
        md += f"\n\n---\nEMBEDDED IMAGES ({len(media)}): open the .docx to see them: {media}"
    return md + "\n"


# ---------- .eml ----------

def _body(msg):
    part = msg.get_body(preferencelist=("plain", "html"))
    if part is None:
        return ""
    text = part.get_content()
    if part.get_content_type() == "text/html":
        text = re.sub(r"(?is)<(script|style).*?</\1>", "", text)
        text = re.sub(r"(?i)<br\s*/?>|</p>|</div>|</tr>", "\n", text)
        text = html.unescape(re.sub(r"<[^>]+>", "", text))
    return re.sub(r"\n\s*\n\s*\n+", "\n\n", text).strip()


def main(folder):
    emls = []
    for f in glob.glob(os.path.join(folder, "*.eml")):
        msg = email.message_from_bytes(open(f, "rb").read(), policy=policy.default)
        emls.append((msg["date"].datetime if msg["date"] else None, f, msg))
    emls.sort(key=lambda x: (x[0] is None, x[0]))
    seen = {}  # attachment name -> (hash, saved path)
    for i, (dt, f, msg) in enumerate(emls, 1):
        day = dt.strftime("%Y-%m-%d") if dt else "nodate"
        print("=" * 100)
        print(f"E{i} | {os.path.basename(f)}")
        for h in ("From", "To", "Cc", "Date", "Subject"):
            if msg[h]:
                print(f"{h}: {msg[h]}")
        print("-" * 100)
        print(_body(msg))
        for part in msg.iter_attachments():
            name = part.get_filename()
            data = part.get_payload(decode=True) or b""
            if not name or (part.get_content_maintype() == "image" and len(data) < 30000
                            and re.match(r"image\d+\.", name)):
                continue  # inline signature/logo images
            digest = hashlib.sha256(data).hexdigest()
            if name in seen and seen[name][0] == digest:
                print(f"\n[ATTACHMENT] {name}: identical to {os.path.basename(seen[name][1])}")
                continue
            out = os.path.join(folder, f"attachment_{day}_{name}")
            open(out, "wb").write(data)
            print(f"\n[ATTACHMENT] {name} ({len(data)} bytes) -> {os.path.basename(out)}")
            if name.lower().endswith(".docx"):
                md_path = os.path.splitext(out)[0] + ".md"
                md = docx_to_md(out)
                open(md_path, "w").write(md)
                print(f"             converted -> {os.path.basename(md_path)}")
                prev = seen.get(name)
                if prev and prev[1].endswith(".md"):
                    diff = difflib.unified_diff(open(prev[1]).read().splitlines(), md.splitlines(),
                                                os.path.basename(prev[1]), os.path.basename(md_path),
                                                n=0, lineterm="")
                    print("             CHANGED vs previous version:\n" + "\n".join(diff))
                seen[name] = (digest, md_path)
            else:
                seen[name] = (digest, out)
    loose = [p for p in glob.glob(os.path.join(folder, "*"))
             if not p.endswith(".eml") and not os.path.basename(p).startswith("attachment_")]
    if loose:
        print("=" * 100)
        print("OTHER FILES (read them too):", [os.path.basename(p) for p in loose])


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit(__doc__)
    main(sys.argv[1])
