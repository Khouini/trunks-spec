# Slice N: <goal>

- **Status:** Choices → Plan → Approved → Built → Committed
- **Stories / rules:** US-.., BR-..
- **Reference code (pattern to copy):** `<file:line>`
- **Commit:**
- **Size:** +N/-M, N files. Simpler option rejected: <what, why> | none.

> No code is written until this plan is **Approved**. While coding, anything that differs from this plan (new file, different signature, different approach) stops for your approval and is recorded in §8.

## 1. Implementation choices

Decided with you **before** writing the rest of this plan.

| # | Question | Options | Recommendation (why) | Decision |
|---|---|---|---|---|
| 1 | | A: … / B: … | | |

## 2. Database (if any)
The exact change. For logic in the database: inputs, outputs, errors, steps. Consumers checked: Project rules: Consumers to check.

| # | Change file | Undo | Can go ahead of the code deploy? |
|---|---|---|---|

## 3. Code

### Types
```
// types and fields
```

### Validation
- rule → error message

### Entry point (route, command, screen)
```
```

### Functions
| Layer | Function | File | Signature | Does |
|---|---|---|---|---|

### Existing code reused
| What | Where (`file:line`) |
|---|---|

### Side effects
Audit, store writes, cache invalidation, emails, background jobs.

## 4. Public contract

**Request**
```json
```

**Response**
```json
```

| Status or error | When |
|---|---|

## 5. Files
| File | Create / change | What |
|---|---|---|

## 6. Tests
| Rule / example | Unit test (name) or `test-guide.md` scenario |
|---|---|

## 7. Not in this slice

## 8. Deviations (approved during coding)
| Plan said | Done instead | Why | Approved |
|---|---|---|---|

## 9. Plan vs done (filled at hand-over)
| Plan item | Implemented in | Status |
|---|---|---|
