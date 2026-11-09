# trunks-spec

**Write what you want first, then let the AI code from that.**

It's the opposite of "vibe coding", where you ask the AI for code and fix whatever comes out.

trunks-spec is one way of working with [Claude Code](https://claude.com/claude-code), shared by all your projects, in any technology. You describe what you want. Claude looks at the code, writes down a plan, and **changes nothing until you approve it**. Every decision stays in a short document in your project. Claude learns from your corrections, but only with your yes.

## Why use it

| Benefit | Without it | With it |
|---|---|---|
| **No surprise code** | Claude writes first, you find out after | You see the exact code before it is written |
| **Your decisions stay yours** | Claude picks names and solutions alone | Claude asks, with 2-3 options, an example and its advice |
| **Fewer silly questions** | Claude asks what the code already answers | Claude reads first and asks only what you alone know |
| **Short answers** | Long messages to read | 10 lines or fewer when it needs you, in plain English |
| **A written memory** | The reason is lost when the chat ends | Each piece of work has a document: why, what, how |
| **The right effort** | The same process for a typo and a big feature | Small work gets a small process |
| **One fix, every project** | Copy each new rule to each project by hand | Change it once in the kit |
| **Gets better as you work** | The same mistake comes back next week | Claude notes each correction and proposes a rule at the end |
| **Any technology** | Rules tied to one stack | The kit names no stack; your project says what it uses |
| **Safe by default** | Easy to run something by accident | Claude never applies database changes, sends emails or creates release tags: it prepares them, you do them |

## A short story

You type this in your project:

```text
/work no orders less than 4 hours before closing
```

1. **Claude looks at the code** and says: "This changes how something already works, so it is a Change. About 3 files." You say OK.
2. **It shows what it understood.** "Order at 15:00, shop closes at 18:00: today it is accepted, after the change it is refused." It also asks what the code can't tell it: "Can staff still order after the limit? I think yes." You answer. ⛔
3. **It proposes how to build it.** Your choices are numbered, including every new name: "Error name? a) `ORDER_CUTOFF` b) `TOO_LATE`. I pick a." You pick. ⛔
4. **It writes the plan: the exact code, before and after.** Nothing is changed yet. You read it and approve. ⛔
5. **It writes the code, exactly as planned,** with tests first, then shows you the changes. If it needs anything else, it stops and asks. You correct an error message on the way; it fixes it and quietly notes this in `learn.md`. ⛔
6. **You approve and it commits.** It then drafts the changelog line, the message to whoever needs to know and the deploy checklist. You send and deploy.
7. **It learns, if you agree.** "You corrected my error message. Should I add a rule: reuse the wording already in the file?" You say yes or no. ⛔

⛔ means Claude stops and waits for you. Type `/next` to go to the next step.

All of this is saved in one folder, `docs/changes/2026-11-12-order-cutoff/`. Six months later, you can still read why it was done.

## How it works

Claude Code reads a folder in your home, `~/.claude`, in every project. The kit plugs into that folder with shortcuts, so all projects see the same kit.

```text
                     ~/dev/trunks-spec   (how we work)
                            │
              install.sh creates shortcuts
                            │
                        ~/.claude
                   ┌────────┴────────┐
                Project A         Project B
         CLAUDE.md: its facts    CLAUDE.md: its facts
```

The kit says **how to work**. Each project says **its facts**.

| Lives in the kit | Lives in the project |
|---|---|
| How Claude talks and asks | What the project is and how it is built |
| The types of work and their steps | Its commands and test rules |
| Commands like `/work` and `/next` | Its deploy steps |
| Templates for documents | The filled documents: bugs, changes, features |
| Packs for one technology | Which pack it uses, if any |

**Example.** The kit says "run the tests". Project A's `CLAUDE.md` says `make test`. Project B's says `npm test`. The same step works in both.

A project's facts go in its `CLAUDE.md`, under a `## Project rules` heading. A project with that heading uses the full process. Any other project gets only the short answers and the asking rules, unless you type `/work`.

**Any technology.** The core never names a language or a database. For exact rules on one technology, a project can use a pack: today there is one, [SQL Server](workflow/packs/sql-server/README.md), and [adding one is easy](workflow/packs/README.md).

## Daily use

| You type | What happens |
|---|---|
| `/work <what you want>` | Claude picks the type of work, you confirm, and it starts |
| `/next` | Runs the next step of the open work |
| `/work status` | Lists all open work and what comes next |

You never need other commands: `/next` finds the right step.

| Type of work | When | Document | You approve |
|---|---|---|---|
| **Question** | You want to understand something | None | Nothing |
| **Trivial** | Small and obvious, 2 code files or fewer, no database or contract change | None | The change, then the result |
| **Bug** | It doesn't work as it should | `bug.md` | The cause, the fix, the code, the result, what to learn |
| **Change** | It works, but should work differently | `change.md` | The scope, the solution, the code, the result, what to learn |
| **Small feature** | Something new, about 10 files or fewer | `feature.md` | The needs, the solution, the code, the result, what to learn |
| **Big feature** | Something new, several stories | One folder, built piece by piece | The same, for each piece |

**Words you will see:**
- **Track:** a type of work from the table above.
- **Item:** one piece of work and its document.
- **Slice:** one piece of a big feature, built and checked on its own.
- **Project rules:** the facts of one project, in its `CLAUDE.md`.
- **Pack:** the exact rules and templates for one technology.

**Tips:**
- Claude writes too much? Say *"short"*.
- It asks what the code can answer? Say *"look first"*.
- It moved on without you? Say *"follow the STOP steps"*.

## How Claude learns

Corrections shouldn't break your flow, and rules shouldn't change behind your back. So learning happens at the end.

1. **During the work:** each time you correct Claude, it adds one line to `learn.md` in the item's folder. No message, no question, no rule changed.
2. **At the end, in the learn step:** it proposes each remark, with the exact text and where it goes: the kit, the project, a test.
3. **You decide.** You say yes or no to each one. Only your yeses are added, and `learn.md` keeps the record.

## Setup

You need Claude Code, git, bash and Python 3.

```bash
git clone https://github.com/Khouini/trunks-spec.git ~/dev/trunks-spec
```

```bash
~/dev/trunks-spec/install.sh
```

Then start a new Claude Code session. `install.sh` does three things in `~/.claude`:
- adds one line to `CLAUDE.md` that loads the kit's rules;
- creates shortcuts to the commands, helpers and templates;
- lets Claude read the kit without asking (it backs up `settings.json` first).

If something is already in the way, it stops and changes nothing.

To remove it:

```bash
~/dev/trunks-spec/install.sh --uninstall
```

This removes only what the kit added. Your own lines stay.

**Add a project:** open it and type `/work <anything>`. Claude offers to add `## Project rules`, filled from what it sees in the code. You check it.

## Keep it up to date

- **Change a rule that fits every project:** edit it in the kit, run `./check.sh`, add a line to `CHANGELOG.md`, commit and push. New sessions use it. Other machines run `git pull`.
- **Change a fact about one project:** edit that project's `CLAUDE.md`.
- `./check.sh` fails if the core names one technology, if a file the kit names is missing, or if a command lost its safety line. To keep your own company words out, list them in `.check-words.local`, which is never committed.

**Example:** "ask about every new name" goes in the kit. "Tests run with `make test`" goes in the project.

## Good to know

- **The kit lives on your machine.** A cloud session, a new machine or a colleague has no `/work` until the kit is installed there. Project rules travel with the project; the kit doesn't.
- **A kit edit reaches all projects at once.** Work in progress continues under the new rules.
- **Project rules only add.** If they contradict the kit, Claude may follow either one.
- **A project can add a command but can't replace one.** With the same name as a kit command, the kit wins. For the two helpers (`code-reviewer`, `test-engineer`) it's the opposite: the project's copy wins.
- **The kit doesn't send or deploy anything.** You do.

## What's inside

| Path | What |
|---|---|
| `CLAUDE.md` | The global rules: how Claude talks and asks, types of work |
| `skills/` | The commands, like `/work` and `/plan-fix` |
| `agents/` | The helpers: `code-reviewer`, `test-engineer` |
| `workflow/steps/` | How Claude does each step |
| `workflow/templates/` | The document templates |
| `workflow/packs/` | Exact rules for one technology: [see them](workflow/packs/README.md) |
| `workflow/WORKFLOW.md` | The full manual: [read it](workflow/WORKFLOW.md) |
| `workflow/database.md` | The rules for any database change: [see them](workflow/database.md) |
| `workflow/PROJECT_RULES_TEMPLATE.md` | What a project fills in: [see it](workflow/PROJECT_RULES_TEMPLATE.md) |
| `workflow/handover-package.md` | How to hand work over to other developers: [see it](workflow/handover-package.md) |
| `install.sh`, `check.sh` | Install the kit, check the kit |

## Help make it better

The kit grows from real work. Read [CONTRIBUTING](CONTRIBUTING.md), see what changed in the [CHANGELOG](CHANGELOG.md) and what's next in the [ROADMAP](ROADMAP.md).

MIT License. Made by Trunks.
