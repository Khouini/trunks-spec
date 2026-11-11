# Feature: <short title>

- **Track:** small feature (one slice)
- **Status:** Requested → Requirements → (Validation) → Scoped → Solution → Plan → Approved → Built → Committed → Shipped (or Moved / Dropped)
- **Next:** requirements
- **Client:** · **Requested by:** <role>, YYYY-MM-DD · **Branch:** · **Ticket:** · **Reference feature:** · **Commit:** · **Version:**
- **Database changes:** · **System docs updated:**

> You approve the requirements (§2), decide the solution (§4) and approve the plan (§5). Nothing is applied before §5. A difference goes in §6.

## 1. Request
- **Asked:** <short quote, or the sections of `00-client-requirements.md`>
- **To ask** (each with your answer):

## 2. Requirements ⛔
- **Stories:** US-01 As a <role> I want <x> so that <y>. Must.
- **Rules:** BR-01 <rule> (US-01)
- **Examples** (they become the tests): BR-01 normal: <input> → <expected> · edge · failure
- **Out of scope:**
- **Today's behavior it contradicts:** none | <what>
- **Client validation:** not needed (<why>) | draft in this section (`/email-client`), answer of YYYY-MM-DD

## 3. Impact
Code (`file:line`) · database (latest version) · consumers (Project rules: Consumers to check) · who sees it · public contract · existing data · docs · tests today. One line each. **Risks:** · **Size:** N files → one slice | move to big feature

## 4. Solution ⛔
- **What you want:** <your words>
- **Choices** (architecture and code, every new name): 1. <question>: a) … b) …  Pick: a (<why>). → **Decision:**

## 5. Plan ⛔
- **Size:** +N/-M, N files. Simpler option rejected: <what, why> | none.
- **Database:** <file> · undo · ahead of the code deploy?
- **Code:** <types> · validation · entry point (route, command, screen) · `<file>`: `<func>` <signature>, does <what>
- **Exact code** (permission checks only): current → new
- **Public contract:** request and response JSON; errors: <status> when <case>
- **Tests:** `"BR-01: <normal>"` … or a `test-guide.md` scenario
- **Files:** <file> create / change
- **Not in this feature:**

## 6. Deviations
<plan said> → <done instead>, <why>, approved <date>

## 7. Plan vs done
<plan item> → <where> → done / not done

## 8. Ship
- **Delivery note** per audience (draft, not sent):
- **Checklist:** backup · database change in prod · deploy (Project rules: Deploy) · other repos · smoke test (runnable requests, `test-guide.md`)
- **Undo:** the `UNDO:` lines in reverse order, previous commit redeployed.

## 9. Learn
`learn.md` in this folder.
