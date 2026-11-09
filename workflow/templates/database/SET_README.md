# <Item name>: database changes

<One paragraph: what this set changes and why. Link to the item doc: docs/features/<folder>/05-design.md, feature.md, docs/changes/<folder>/change.md or docs/bugs/<folder>/bug.md>

## Apply order
| # | File | What | Ahead of the code deploy? |
|---|---|---|---|
| 1 | `01_<what>` | | yes (additive) / no (deploy together) |

## Consumers checked
<what changed for callers, and the callers checked (Project rules: Consumers to check)>

## Notes
<run time on big tables, UTF-8 files, low-traffic window, deferred parts>
