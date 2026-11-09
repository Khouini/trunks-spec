# Change: <short title>

- **Status:** Requested → Scope → Scoped → Solution → Plan → Approved → Built → Committed → Shipped (or: Moved to <track> / Dropped)
- **Next:** understand + impact
- **Requested by:** <role>, <client>, YYYY-MM-DD (raw: `.correspondence/<client>/<change-folder>/`)
- **Branch:**
- **Ticket:**
- **Commit:**
- **Version:**

> Gates: you confirm the scope (§1-§2), decide the solution (§3) and approve the exact code (§4). Nothing is applied before §4 is **Approved**, and the code written is exactly §4. Any difference stops for your approval and goes in §5.

## 1. Request ⛔ confirmed by you

**Asked** (short quote):

**Current behavior** (`file:line`):

**Wanted behavior:**

### Before / after examples
| # | Case | Input | Today | After the change |
|---|---|---|---|---|
| EX-1 | normal | | | |
| EX-2 | edge | | | |
| EX-3 | failure | | | |

**Recorded decision behind today's behavior** (`docs/decisions/`): none | <ADR>

**TO ASK** (only what the code, docs and git can't answer; each with your proposed answer):

## 2. Impact

### Call path
`<entry point>` → `<validation>` → `<handler>` → `<service func>` (`file:line`) → `<data>` (latest version: <source>)

### Who sees the difference
| Who | Affected? | How |
|---|---|---|
| <each row of Project rules: Who sees the difference> | | |

### Code and database
| Object (file / table / contract) | Change | Consumers checked (Project rules: Consumers to check) |
|---|---|---|

- **Public contract change:** no | yes: <what> → notice to whoever uses it, docs
- **Existing data:** follows the new rule? <only new rows | backfill: diagnostics Qn → N rows>
- **Docs to update:**
- **Tests today / gaps:**
- **Risks:**
- **Size:** <N files> → fits a change | move to <track>

## 3. Solution ⛔ decided by you

### What you want
<your words>

### Questions
Every implementation choice and every new name (API fields, columns, commands, error codes, types): 2-3 options, each with an example, and a pick.
1. <question>: a) <option> → <example>; b) <option> → <example>. Pick: <letter> (<why>).

### Decisions
| # | Question | Your decision |
|---|---|---|

## 4. Exact implementation ⛔ approved by you

### Change 1: `<file>`, `<function or fragment>`
Why:

**Current** (`<file>:<line>`)
```
```

**New**
```
```

### Database change (if any)
| # | File | What | Undo | Before or with the code deploy? |
|---|---|---|---|---|

### Data change (if decided)
- Rows: <condition>; preview diagnostics Qn → <N> rows
- Script (full), where old values are kept, `UNDO:` line:
```
```

### Tests
| Test (`"CHANGE: …"`) / scenario | Example | Input | Expected | Fails before because |
|---|---|---|---|---|

```
// full test code; for what the suite can't reach: test-guide scenario + runnable request (diagnostics query only if stored data is wrong)
```

### Files
| File | Create / change | What |
|---|---|---|

### Docs to update

### Not changed (on purpose)

## 5. Deviations (approved while applying)
| Plan said | Done instead | Why | Approved |
|---|---|---|---|

## 6. Plan vs done (filled at hand-over)
| Change / test / database | Where | Status |
|---|---|---|

## 7. Ship

### Notice to whoever sees the difference (draft, not sent)

### Deployment checklist
- [ ] Backup (if a database change or data change)
- [ ] Database change applied in production (set README order); data change rows before → after:
- [ ] Deployed (Project rules: Deploy), logs checked
- [ ] Other repos deployed (if touched)
- [ ] Verified: examples EX-n on production, runnable requests
- [ ] What Project rules: Deploy says to regenerate (if the database changed)

**Undo:** the `UNDO:` lines of the database files in reverse order, previous commit redeployed.

## 8. Learn
Claude's remarks: `learn.md` in this folder. Applied only after your yes.
