# Cornerstone - Clothing Items

Clothing that exists as items in your inventory. Each piece of clothing is a `clothing` item that carries its own name, description, gender and appearance numbers.

**This is early test code, not a finished script.** It sets up the clothing items and shows their details in the inventory. It does not yet put the clothing on your character when you use the item.

## What it is

Instead of picking clothes from a menu, players get clothes as inventory items. Four sample pieces are included: a mask, a red T-shirt, a leather jacket and a blue cap.

## How it plays

- A clothing item shows its description and gender when you hover over it in your inventory.
- Different pieces share one item type. The piece you get depends on the style it was created with.
- To keep clothing item-only, the server owner can hide the matching clothing from the clothing store menu.

## Commands and keybinds

| command or key | what it does |
|---|---|
| `/giveclothing <style>` | Meant to give you one clothing item of that style (`blue_jeans`, `red_tshirt`, `leather_jacket`, `blue_cap`). It does not work at the moment (see `Issues.md`). |

There are no keybinds.

## Credit

Released under the MIT License (see `LICENSE`). Testing was done with Illenium Appearance.
