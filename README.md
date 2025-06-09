# Emergence2D

A 2D platformer shooting game. You spawn in by an ocean, and go on to explore the terrain which has enemies consisting of boars, bees, snails, bats, and so on. There are checkpoints referred to as levels throughout your adventure. Additionally, as you explore you can collect potions, coins, and other resources.

## Getting Started
### MacOS
- Download the Macos DMG file
- Move Emergence2D.app into Applications folder

### Windows
- Download the Emergence2D.exe file

## Development
- Refer to the the doc/development.md & doc/running.md

## Exisiting Features
- Player Movement, Actions, and Projectiles
- Game Sounds (Music, and SFX)
- All Level Terrains (1, 2, 3)
- All Enemies (Boar, Bees, Flying Eyeball, Snails, Wizards)
- All Menus (Main Menu, Settings, About, Paused, Lost, Won)
- Hotbar w/ hotslots on left hand side of screen (Use hotkeys to trigger collectibles such as healing & cooldown)
- Collectibles (Coins which can be Hearts or Powerups (lowers cooldown))
- Keybind Handling
- Sound Customization (Volume, Music, SFX)
- Player Unit Testing (Player damage tests, player health tests, player projectile cooldown tests)

## Features that could have been nice to have
- Keybindings are not perfect (you can only keybind 1 key at a time, so you can't bind a new SHIFT+A keybinding for example)
- Keybindings do not persist through sessions (so for example if you quit the game it will not store the keybindings in disk)
- Maybe more collectibles, enemies, and levels (but base ones are great for the scope of the project)
- If more levels were added persisting the checkpoints to disk would be ideal so users could continue off where they left off rather than restarting the game once they've returned to the main menu
- An Inventory (This was a potential avenue, some code is in place for its implementation, it would be included if the game had more than 5 collectibles leading to the user needing to rearrange what powerups were a must have quick access to and so they wanted at the foremost of their inventory, i.e. in hotbar / hotslot)

## While in Game
- Play the game and try to win
- Refer to the settings pages for keybindings and audio control
- Refer to about page for details on the game, acknowledgements