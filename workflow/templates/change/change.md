# Change: <short title>

- **Status:** Requested → Scope → Scoped → Solution → Plan → Approved → Built → Committed → Shipped (or Moved / Dropped)
- **Next:** understand + impact
- **Requested by:** <role>, <client>, YYYY-MM-DD · **Branch:** · **Ticket:** · **Commit:** · **Version:**

> You confirm the scope (§1-§2), decide the solution (§3) and approve the plan (§4). Nothing is applied before §4. A difference goes in §5.

## 1. Request ⛔
- **Asked:** <short quote> · **Today** (`file:line`): · **Wanted:**
- **Examples** (they become the tests): EX-1 normal: <input> → today <x> → after <y> · EX-2 edge · EX-3 failure
- **Decision behind today's behavior** (`docs/decisions/`): none | <ADR>
- **To ask** (each with your answer):

## 2. Impact
- **Call path:** `<entry>` → `<handler>` → `<service>` (`file:line`) → `<data>`
- **Who sees the difference** (Project rules: Who sees the difference): one line each
- **Code and database:** <object> → <change>, consumers checked
- **Public contract:** no | yes: <what>, notice to its users
- **Existing data:** only new rows | backfill (Qn → N rows)
- **Risks, tests today, docs to update:**
- **Size:** N files → fits a change | move to <track>

## 3. Solution ⛔
- **What you want:** <your words>
- **Questions** (every choice and new name, 2-3 options with an example, your pick): 1. <question>: a) … b) …  Pick: a (<why>).
- **Decisions:** 1. <decision>

## 4. Plan ⛔
- **Size:** +N/-M, N files. Simpler option rejected: <what, why> | none.
- **Code:** `<file>`: `<func>` <current → new signature>, <what changes>
- **Exact code** (permission checks and public contracts only): current (`file:line`) → new
- **Database change:** <file> · undo · before or with the deploy
- **Data change:** rows <condition>, preview Qn → N, old values kept in <where>
- **Tests:** `"CHANGE: <EX-1 …>"`: <input> → <expected>; fails today because <why>. Not reachable → test-guide scenario + runnable request.
- **Docs to update, not changed on purpose:**

## 5. Deviations
<plan said> → <done instead>, <why>, approved <date>

## 6. Plan vs done
<plan item> → <where> → done / not done

## 7. Ship
- **Notice** to whoever sees the difference (draft, not sent):
- **Checklist:** backup · database change in prod · deploy (Project rules: Deploy) · other repos · EX-n checked in prod
- **Undo:** the `UNDO:` lines in reverse order, previous commit redeployed.

## 8. Learn
`learn.md` in this folder.
