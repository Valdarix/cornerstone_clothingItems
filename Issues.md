# Issues: Cornerstone - Clothing Items

Known bugs and deviations from the Cornerstone standard and the FiveM Dev Tool house rules. First-pass review, 2026-10-28. Line numbers are for the current tree. The untracked `cornerstone_clothingItems/` folder inside the repo is an older copy and was not reviewed.

## Bugs

- **`/giveclothing` cannot work.** `client/client.lua:8-18` registers the command on the client, but `clothingMetadata` is a local in `server/server.lua:1`, so line 11 indexes a nil global and errors. Even past that, `exports.ox_inventory:AddItem` (line 15) is a server export, and a client command's `source` is not a server id. Fix: register the command in `server/server.lua`, check the style against `clothingMetadata`, and give the item with the real player id.
- **The `Style` label never shows.** `client/client.lua:4` asks ox_inventory to display `type`, but the `createItem` hook returns the whole `clothingMetadata` entry (`server/server.lua:45`), which replaces the item's metadata and drops `type`. Fix: return the entry with `type = clothingType` added, or remove the label.
- **`blue_jeans` is a mask.** `server/server.lua:2-9` has the key `blue_jeans`, label `MaskTest`, description `Mask test`, and `component = 1`, which is the mask slot. Fix: replace it with real jeans (`component = 4`) or rename it.
- **Clothing does nothing when used.** No script here wears an item: there is no use handler, no appearance call and no `client.export` to hook up. The README says it is test code. Fix: add a use handler that applies `component` or `prop`, `drawable` and `texture` through the appearance resource the server uses.
- **Unknown styles leave the item blank.** `server/server.lua:41-46` returns nothing when `type` matches no entry, so a `clothing` item given with a typo or no type has no label, description or appearance. Fix: reject the creation or return a visible "invalid clothing" metadata.

## Deviations from the standard

From the FiveM Dev Tool validator run.

- **`manifest-missing-dependency` (2 info).** `client/client.lua:1` and `server/server.lua:40` call `ox_inventory` exports but the manifest has no `dependencies` block. Fix: add `dependencies { 'ox_lib', 'ox_inventory', 'qbx_core' }`.
- **`@qbx_core/modules/lib.lua` is loaded for nothing.** `fxmanifest.lua:13` shares it with every script, and nothing uses its functions, so the resource needs Qbox to start for no reason. Fix: remove the line.
- **`@oxmysql/lib/MySQL.lua` is loaded for nothing.** `fxmanifest.lua:17`; there are no queries. Fix: remove the line.
- **`ox_lib 'locale'` is declared but unused.** `fxmanifest.lua:9`; there is no `locales/` folder and no `locale()` call. Fix: remove the line.
- **No config file and no `escrow_ignore` block.** The clothing pieces are a table inside `server/server.lua:1-37`, so an escrowed build would lock them. Fix: move them to `config/config.lua` and list it in `escrow_ignore`.
- **Config is not split.** The house rules want `config/shared.lua`, `config/client.lua` and `config/server.lua`.
- **No locale for strings.** `client/client.lua:2-4` and `client/client.lua:12` use fixed English text.
- **No `.sql` and no tables.** Nothing to create on start, so the database rule is met.

## Security

Checked against the FiveM Dev Tool security checklist.

- **Giving clothing needs a permission check once it is moved to the server.** The `/giveclothing` command (`client/client.lua:8`) has no permission check (`false` at line 18 only means it is not restricted by ACE). When it is fixed as above, restrict it with `lib.addCommand` and `restricted = 'group.admin'`, and take the target from `source`, never from an argument.
- **Nothing else trusts the client.** The `createItem` hook (`server/server.lua:40`) runs on the server from the inventory's own item creation, and the script registers no net events or callbacks. The hook reads `payload.metadata.type` as a table key only, which is safe.
