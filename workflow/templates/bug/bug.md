# Bug: <short title>

- **Status:** Reported → Investigating → Cause confirmed → Solution → Plan → Approved → Fixed → Shipped (or: Not a bug / Moved to change / Moved to feature)
- **Next:** /investigate-bug
- **Severity:** P1 (production blocked, or data getting corrupted now) | P2 (wrong behavior, a workaround exists) | P3 (minor)
- **Reported by:** <role>, <client>, YYYY-MM-DD (raw: `.correspondence/<client>/<bug-folder>/`)
- **Environment:** production | development
- **Branch:**
- **Ticket:**
- **Commit:**
- **Version:**

> Gates: you confirm the root cause (§3), decide the solution (§5) and approve the exact code (§6). Nothing is applied before §6 is **Approved**, and the code written is exactly §6. Any difference stops for your approval and goes in §7.

## 1. Report

**Symptom** (what the reporter sees, short quote):

**Expected:**

**Actual:**

| Item | Value (from the report; unknown → `/investigate-bug` finds it, not a question) |
|---|---|
| Where (screen, endpoint, command, job, email) | |
| Business IDs | |
| First seen | |
| Since a deploy or a database change? | |
| Always, or only for some users or data? | |

**Steps to reproduce:**
1.

**TO ASK** (only what the code, docs and git can't answer; each with your proposed answer):

## 2. Investigation

### Call path
`<entry point>` → `<validation>` → `<handler>` → `<service func>` (`file:line`) → `<data>` (latest version: <source>)

### Hypotheses
| # | Hypothesis | How to check | Result |
|---|---|---|---|
| H1 | | | |

### Evidence
| # | Source (code `file:line`, diagnostics Qn, log, store, git) | What it shows |
|---|---|---|
| E1 | | |

## 3. Root cause ⛔ confirmed by you

- **Type:** code | database logic | data | config / environment | external system | works as designed → feature
- **Cause:** <X happens because Y>
- **Where:** `file:line`
- **Since:** <commit / database change / date, and how it was found>
- **Explains every symptom?** yes / no: <what is still unexplained>
- **Why it wasn't caught:**

## 4. Blast radius

| Area | Affected? | Detail |
|---|---|---|
| Other callers of the same code | | |
| Other repos (Project rules: Consumers to check) | | |
| Data already wrong (count only if a repair is decided) | | |
| Other users / data / dates | | |
| Already sent wrong (Project rules: Who sees the difference) | | |

## 5. Solution ⛔ decided by you

### What you want
<your words: how you want it fixed>

### Options
| # | Option | What changes | Pros | Cons / risk | Size |
|---|---|---|---|---|---|
| A | | | | | |

**Recommendation:** <option, why>

### Decisions
| # | Question | Decision |
|---|---|---|
| 1 | Where the fix goes (which layer) | |
| 2 | Repair existing data? Which rows? | |
| 3 | Guard so it can't come back? | |

## 6. Exact implementation ⛔ approved by you

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

**Consumers checked** (if a query, schema or contract changes): Project rules: Consumers to check.

### Data repair
- Rows: <condition>; preview diagnostics Qn → <N> rows on production
- Old values kept in:
- Script (full):
```
```

### Regression test
| Test | Input | Expected | Fails before the fix because |
|---|---|---|---|

```
// full test code; for what the suite can't reach: manual scenario + runnable request (diagnostics Qn only if stored data is wrong)
```

### Files
| File | Create / change | What |
|---|---|---|

### Not changed (on purpose)

## 7. Deviations (approved while applying)
| Plan said | Done instead | Why | Approved |
|---|---|---|---|

## 8. Plan vs done (filled at hand-over)
| Change / test / database | Where | Status |
|---|---|---|

## 9. Ship

### Reply to the reporter (draft, not sent)

### Deployment checklist
- [ ] Backup (if a database change or data repair)
- [ ] Database change applied in production (set README order); data repair rows before → after:
- [ ] Deployed (Project rules: Deploy), logs checked
- [ ] Other repos deployed (if touched)
- [ ] Verified: reported IDs checked (diagnostics Qn → expected result, if any)
- [ ] What Project rules: Deploy says to regenerate (if the database changed)
- [ ] Kept data cleanup planned (date):

**Undo:** the `UNDO:` lines of the database files in reverse order (data restored from where it was kept), previous commit redeployed.

## 10. Learn
Claude's remarks: `learn.md` in this folder. Applied only after your yes.
