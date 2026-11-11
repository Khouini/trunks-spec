# Bug: <short title>

- **Status:** Reported → Investigating → Cause confirmed → Solution → Plan → Approved → Fixed → Shipped (or Not a bug / Moved)
- **Next:** /investigate-bug
- **Severity:** P1 (blocked, or data getting corrupted now) | P2 (wrong, a workaround exists) | P3 (minor)
- **Reported by:** <role>, <client>, YYYY-MM-DD · **Environment:** · **Branch:** · **Ticket:** · **Commit:** · **Version:**

> You confirm the cause (§3), decide the fix (§5) and approve the plan (§6). Nothing is applied before §6. A difference goes in §7.

## 1. Report
- **Symptom:** <short quote> · **Expected:** · **Actual:**
- **Where, IDs, first seen, since a deploy?, for everyone?:** (unknown → `/investigate-bug` finds it)
- **Steps to reproduce:** 1.
- **To ask** (only what code, docs and git can't answer, each with your answer):

## 2. Investigation
- **Call path:** `<entry>` → `<handler>` → `<service>` (`file:line`) → `<data>`
- **Hypotheses:** H1 <what> → <how checked> → <result>
- **Evidence:** E1 <source `file:line`, query Qn, log> → <what it shows>

## 3. Root cause ⛔
- **Cause:** <X happens because Y> at `file:line`. **Type:** code | database logic | data | config | external | works as designed
- **Since:** <commit / date> · **Explains every symptom?** yes / no: <what not> · **Why not caught:**

## 4. Blast radius
Other callers · other repos (Project rules: Consumers to check) · data already wrong · already sent wrong. One line each, "none" if none.

## 5. Solution ⛔
- **What you want:** <your words>
- **Options:** A <what changes, risk, size> · B …  **Recommendation:** <A, why>
- **Decisions:** where the fix goes · repair existing data (which rows) · a guard so it can't come back

## 6. Plan ⛔
- **Size:** +N/-M, N files. Simpler option rejected: <what, why> | none.
- **Code:** `<file>`: `<func>` <current → new signature>, <what changes>
- **Exact code** (permission checks and public contracts only): current (`file:line`) → new
- **Database change:** <file> · undo · before or with the deploy · consumers checked
- **Data repair:** rows <condition>, preview Qn → N rows, old values kept in <where>, script in <file>
- **Regression test:** <name>: <input> → <expected>; fails today because <why>. Not reachable → manual scenario + runnable request.
- **Not changed on purpose:**

## 7. Deviations
<plan said> → <done instead>, <why>, approved <date>

## 8. Plan vs done
<plan item> → <where> → done / not done

## 9. Ship
- **Reply to the reporter** (draft, not sent):
- **Checklist:** backup · database change in prod (rows before → after) · deploy (Project rules: Deploy) · other repos · verified on the reported IDs
- **Undo:** the `UNDO:` lines in reverse order, previous commit redeployed.

## 10. Learn
`learn.md` in this folder.
