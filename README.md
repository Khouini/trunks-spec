# trunks-spec

**Write what you want first, then let the AI code from that.**

trunks-spec is one way of working with [Claude Code](https://claude.com/claude-code), shared by all your projects, in any technology. You say what you want. Claude reads the code, writes a short plan, and **changes nothing until you approve it**. Every decision stays in a short document in your project.

## Why use it

- **No surprise code.** You approve a short plan before any code exists.
- **Simple code.** The fewest lines that do the job. The reviewer blocks the rest.
- **Your decisions stay yours.** Claude asks, with 2-3 options, an example and its pick. It never asks what the code already says.
- **Easy to read.** Every reply is `Done` / `Not done` / `Question`, in plain words, 10 lines or fewer.
- **The right effort.** A typo gets a small process; a big feature gets a full one.
- **It gets better.** Claude notes each correction and proposes a rule at the end. Nothing changes without your yes.
- **Safe.** Claude never applies database changes, sends emails or deploys. It prepares them; you do them.

## A short story

```text
/work no orders less than 4 hours before closing
```

1. Claude reads the code: "This is a Change, about 3 files." You say OK.
2. It shows an example: "Order at 15:00, shop closes at 18:00: today accepted, after refused." It asks what only you know: "Can staff still order late? My answer: yes." ⛔
3. It proposes how to build it, with every new name: "Error name? a) `ORDER_CUTOFF` b) `TOO_LATE`. My pick: a." ⛔ Nothing to decide → no stop.
4. It writes a short plan: functions, tests, size ("+40/-5, 2 files"). ⛔
5. It writes the tests, then the code, then shows the diff. ⛔
6. You approve; it commits and drafts the changelog, the notice and the deploy list.
7. It proposes what to learn: "You fixed my error message. Rule: reuse the wording in the file?" ⛔

⛔ = Claude stops and waits. `/next` goes on. Everything is saved in `docs/changes/2026-11-12-order-cutoff/`.

## How it works

The kit says **how to work**. Each project says **its facts**.

```text
~/dev/trunks-spec ──install.sh──▶ ~/.claude ──▶ every project
                                               (its CLAUDE.md: its facts)
```

**Example:** the kit says "run the tests". Project A says `make test`; project B says `npm test`.

A project's facts go in its `CLAUDE.md`, under `## Project rules`. With that heading, the project uses the full process. Without it, only the rules for replies, questions and simple code apply.

The core names no language or database. For one technology, a project can use a pack: today [SQL Server](workflow/packs/sql-server/README.md) ([add one](workflow/packs/README.md)).

## Daily use

| You type | What happens |
|---|---|
| `/work <what you want>` | Claude picks the type of work, you confirm, it starts |
| `/next` | The next step of the open work |
| `/work status` | All open work and what comes next |

| Type of work | When | Document |
|---|---|---|
| Question | you want to understand something | none |
| Trivial | obvious, 2 code files or fewer, no database or contract change | none |
| Bug | it doesn't work as it should | `bug.md` |
| Change | it works, but should work differently | `change.md` |
| Small feature | something new, one piece | `feature.md` |
| Big feature | something new, several pieces (slices) | one folder |

**Tips:** too long → *"short"*. Asks what the code says → *"look first"*. Moved on without you → *"follow the STOP steps"*.

## Setup

You need Claude Code, git, bash and Python 3.

```bash
git clone https://github.com/Khouini/trunks-spec.git ~/dev/trunks-spec
```

```bash
~/dev/trunks-spec/install.sh
```

Start a new Claude Code session. `install.sh` adds one line to `~/.claude/CLAUDE.md`, links the commands and templates, and lets Claude read the kit (it backs up `settings.json` first). Anything in the way → it stops and changes nothing. `install.sh --uninstall` removes only what it added.

**Add a project:** open it and type `/work <anything>`. Claude offers to fill `## Project rules` from the code. You check it.

**Stop check (optional):** a hook runs your tests when Claude finishes. If they fail, Claude must fix them or say why. [Set it up](workflow/PROJECT_RULES_TEMPLATE.md).

## Keep it up to date

- **A rule for every project:** edit the kit, run `./check.sh`, add a `CHANGELOG.md` line, commit. Other machines: `git pull`.
- **A fact about one project:** edit that project's `CLAUDE.md`.
- `./check.sh` fails if the core names a technology, a named file is missing, a command lost its guard, or a private word (`.check-words.local`) got in. `tests/work.sh` checks that `/work` picks the right track (real runs, costs tokens).

## Good to know

- The kit lives on your machine. A new machine or a colleague needs `install.sh`.
- A kit edit reaches all projects at once.
- Project rules only add. A contradiction makes Claude unpredictable.
- A project can add a command, not replace one. For `code-reviewer` and `test-engineer`, the project's copy wins.

## What's inside

| Path | What |
|---|---|
| `CLAUDE.md` | The rules loaded everywhere: replies, questions, code, tracks |
| `workflow/WORKFLOW.md` | [The manual](workflow/WORKFLOW.md): every track step by step |
| `skills/`, `agents/` | The commands (`/work`, `/next`…) and the 2 helpers |
| `workflow/steps/`, `workflow/templates/` | How each step runs, and the document templates |
| `workflow/packs/`, `workflow/database.md` | Rules for one technology, and for any database change |
| `install.sh`, `check.sh`, `tests/` | Install, check, test |

Read [CONTRIBUTING](CONTRIBUTING.md), the [CHANGELOG](CHANGELOG.md) and the [ROADMAP](ROADMAP.md). MIT License. Made by Trunks.
