---
name: deliver-feature
description: Prepare the delivery of a reviewed feature: one email + technical-documentation package per audience (business team, developers, partners), changelog entry, release notes and deployment checklist. Use when a feature is ready to ship, or whenever the user asks for a delivery email, frontend documentation, release notes or changelog. Only in a repo whose CLAUDE.md has a Project rules section, or when the user types this command.
---

# Deliver the feature

## Inputs
- `02-requirements.md`, `03-client-validation.md`, `05-design.md`, `06-review.md`
- `docs/clients/<client>.md` (language, tone, contacts by role, delivery audiences)
- Developer packages: `~/.claude/workflow/handover-package.md` (rules, skeletons)

## Steps
1. **Pick the audiences** that are affected (from the client file and Project rules: Who sees the difference). Name them in one line in your message; I correct the list if needed.
2. **One package per audience** in `docs/features/<feature>/07-delivery/<n>. <audience>/`:
   - **Developer audiences:** follow `~/.claude/workflow/handover-package.md` exactly: a short email and a technical doc (prompt) about the contract and the screens only, never their code.
   - **Other audiences** (business team, partners): `1. Email body.md` only, in their language and tone from the client file: what's new and the problem it solves, what changes for them, limits, what we need from them. Recipients as role placeholders.
3. **Version, changelog ("Added"), release notes `docs/releases/v<x.y.z>.md` and the deployment checklist** in `07-delivery.md`: follow `~/.claude/workflow/steps/ship.md` (track: big feature). The checklist also gives the database set and its order and which can go ahead of the code deploy, and the deploy order (Project rules: Deploy).
4. Update the feature README status to "Delivered" with the date, `Next: /close-feature`, and the features index.

## Output
`07-delivery.md` (deployment checklist + changelog/release-note ticks) and the `07-delivery/` packages. Do NOT send anything.
