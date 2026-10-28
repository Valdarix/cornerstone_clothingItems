# Installing Cornerstone - Clothing Items

Written for server owners. This is early test code; read `Issues.md` before relying on it.

## Dependencies

- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [qbx_core](https://github.com/Qbox-project/qbx_core). The manifest loads `@qbx_core/modules/lib.lua`, so `qbx_core` must be installed and started even though no script here uses it yet (see `Issues.md`).
- [oxmysql](https://github.com/overextended/oxmysql). Loaded by the manifest, but this resource runs no queries.

Nothing here is optional, and no other framework or inventory is supported.

## server.cfg

```cfg
ensure ox_lib
ensure qbx_core
ensure ox_inventory
ensure cornerstone_clothingItems
```

## Frameworks

Qbox only, through the `qbx_core` file the manifest loads. The code does not call the framework.

## Inventories

ox_inventory only. Add one item, `clothing`, to `ox_inventory/data/items.lua`:

```lua
['clothing'] = {
    label = 'Clothing',
    weight = 200,
    stack = false,
    close = true,
    description = 'A piece of clothing.',
},
```

The script then fills in the label, description and appearance values of each `clothing` item when it is created, from the table at the top of `server/server.lua`. Stacking must stay off, because every piece carries its own metadata.

Wearing the item is not part of this resource. You need your own item use handler (for example one for Illenium Appearance) that reads the `component` or `prop`, `drawable` and `texture` values from the item's metadata.

## Configuration

There is no config file. The clothing pieces are defined in the `clothingMetadata` table at the top of `server/server.lua`. Each entry is keyed by the style name and holds:

| field | default | what it does |
|---|---|---|
| `label` | per entry | item label |
| `description` | per entry | text shown in the inventory |
| `component` | per entry | clothing component id (masks, tops and so on). Use this or `prop` |
| `prop` | per entry | prop id (hats, glasses and so on). Use this or `component` |
| `drawable` | per entry | drawable number |
| `texture` | per entry | texture number |
| `gender` | `'male'` | gender the piece is for |

Included entries: `blue_jeans` (currently a mask), `red_tshirt`, `leather_jacket` and `blue_cap`. Add your own the same way.

To create an item of a style from the server, give it with `type` set to the style name:

```lua
exports.ox_inventory:AddItem(source, 'clothing', 1, { type = 'red_tshirt' })
```

## Database

The script uses no database tables.

## Troubleshooting

- **The item shows no description:** the item was created without a `type` that matches an entry in `clothingMetadata`. Give it with `{ type = 'red_tshirt' }` or another defined style.
- **`/giveclothing` prints an error or nothing happens:** it is broken (see `Issues.md`). Use the `AddItem` export from a server script or the ox_inventory admin tools.
- **The server stops with a missing file error for `qbx_core`:** start `qbx_core` before this resource, as in the `server.cfg` above.
