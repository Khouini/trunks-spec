# Feature: <short title>

- **Track:** small feature (one slice)
- **Status:** Requested → Requirements → (Validation) → Scoped → Solution → Plan → Approved → Built → Committed → Shipped (or: Moved to big feature / Dropped)
- **Next:** requirements
- **Client(s):**
- **Requested by:** <role>, YYYY-MM-DD (raw: `.correspondence/<client>/<feature-folder>/`; clean copy: `00-client-requirements.md` if any)
- **Branch:**
- **Ticket:**
- **Reference feature (pattern):**
- **Database changes:** 
- **System docs updated:**
- **Commit:**
- **Version:**

> Gates: you approve the requirements (§2), decide the solution (§4) if there is something to decide, and approve the plan (§5). Nothing is applied before §5 is **Approved**. Any difference from it stops for your approval and goes in §6.

## 1. Request

**Asked** (short quote, or the sections of `00-client-requirements.md`):

**TO ASK** (only what the code, docs and git can't answer; each with your proposed answer):

## 2. Requirements ⛔ approved by you

### Stories
| ID | As a… I want… so that… | Priority |
|---|---|---|
| US-01 | | Must |

### Rules
| ID | Rule | Stories |
|---|---|---|
| BR-01 | | US-01 |

### Examples (they become the tests)
| Rule | Case | Input | Expected |
|---|---|---|---|
| BR-01 | normal | | |
| BR-01 | edge | | |
| BR-01 | failure | | |

### Acceptance criteria
- US-01: Given … When … Then …

### Out of scope

### Non-functional (permissions, audit, languages), if relevant

### Contradictions with today's behavior

### Client validation
No client validation: <why> | Email draft (not sent): … | Client answer (YYYY-MM-DD, summarized):

## 3. Impact
| Area | What | Detail |
|---|---|---|
| Code (`file:line`) | | |
| Database (latest version) | | |
| Consumers (Project rules: Consumers to check) | | |
| Who sees it (Project rules: Who sees the difference) | | |
| Public contract | | |
| Existing data | | |
| Docs to create / update | | |
| Tests today / gaps | | |

**Risks:**
**Size:** <N files> → one slice | move to big feature

## 4. Solution ⛔ decided by you

### What you want
<your words>

### Choices (architecture + code)
| # | Question | Options | Recommendation (why) | Decision |
|---|---|---|---|---|
| 1 | | A: … / B: … | | |

## 5. Plan ⛔ approved by you

**Size:** +N/-M, N files. Simpler option rejected: <what, why> | none.

### Database (if any)
The exact change. For logic in the database: inputs, outputs, errors, steps.

| # | Change file | Undo | Ahead of the code deploy? |
|---|---|---|---|

### Code
```
// types and fields
```
- Validation:
- Entry point (route, command, screen):

| Layer | Function | File | Signature | Does |
|---|---|---|---|---|

Exact code, only for permission checks (Current → New; remove if none):

### Public contract
**Request** / **Response** JSON, and:

| Status or error | When |
|---|---|

### Tests
| Rule / example | Unit test (`"BR-01: …"`) or `test-guide.md` scenario |
|---|---|

### Files
| File | Create / change | What |
|---|---|---|

### Not in this feature

## 6. Deviations (approved while coding)
| Plan said | Done instead | Why | Approved |
|---|---|---|---|

## 7. Plan vs done (filled at hand-over)
| Plan item | Implemented in | Status |
|---|---|---|

## 8. Ship

### Delivery note per audience (draft, not sent)

### Deployment checklist
- [ ] Backup (if a database change)
- [ ] Database change applied in production (set README order)
- [ ] Deployed (Project rules: Deploy), logs checked
- [ ] Other repos deployed (if touched)
- [ ] Smoke test: runnable requests, `test-guide.md` scenarios
- [ ] What Project rules: Deploy says to regenerate (if the database changed)

**Undo:** the `UNDO:` lines of the database files in reverse order, previous commit redeployed.

## 9. Learn
Claude's remarks: `learn.md` in this folder. Applied only after your yes.
