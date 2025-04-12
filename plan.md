# Emergence2D

Description: This is our plan for the game we named `Emergence2D`, a 2D platformer shooting game. This game is set in a world that builds itself as you move through it starting from an empty white void, emerging into a fully developed world. The environment is being built in as the user develops and clears new levels, whilst simultaneously coming across new creatures / enemies which become stronger through the new installments of world fragments in the unfinished reality.

## Learning Goals

1. General Game Dev Concepts:
- Understand 2D game physics (collisions, gravity, movement)
- Learn about game loops, frame updates, and scene creation
- State management for enemies, levels, and player actions

2. whatEngine-Specific. We will be using Godot (GDScript):
- Understand GDScript syntax and Godot node system
- Learn how signals and scenes work
- Get comfortable with Godot’s built-in animation and physics systems

3. Asset & Art:
- Basic pixel art or sprite editing (Krita, GIMP)
- Asset sourcing (OpenGameArt.org, Pixabay)

## Core Features

## Essentials
1. Player Mechanics:
- Move (left/right), jump (with gravity), shoot (in direction)
- Health and damage system

2. Enemy System:
- Basic AI (follow player, patrol, shoot)
- Multiple enemy types with different health and speed

## Nice to Have
3. Level System:
- Scene-based or dynamically loaded levels
- Level completion (goal point or defeat all enemies)
- Difficulty progression: enemies, hazards, terrain complexity (might remove terrain complexity and simplify the game a lot more)

## Stretch Goals
4. Extras (If we have time):
- UI: health bar, ammo count, level indicator
- Weapon upgrades / power-ups
- Pickups: health, ammo, speed boost, new weapons
- Save/load level progress
- Audio (background music, SFX for shooting, enemies, jumps), most will most likely be found via royalty free sites

## Architecture Plan

Core Structure (GameManager)
 - UI
 - Player
 - Enemies
 - LevelManager
 - Pickups

### Systems Breakdown:
- Input System – movement, jump, shoot
- Physics & Collision – ground detection, enemy hits, pickups
- Enemy AI – finite state machines (patrol, chase, attack) 
- Health Manager – for both player and enemies
- Level Manager – tracks level number, load/transition
- Game Manager – overall state, UI updates, game loop
- Audio Manager – handles SFX and music (This is an extra)

## Development Strategy

Week 1-2 – Setup & Core Mechanics (April 14-27)
- Install Godot and set it Up
- Set up project structure, player prefab/scene
- Implement player movement and shooting
- Basic ground + platforms + collisions (will most likely start with an empty world and build it up level by level)
- Set up one enemy with basic movement & collision detection

Week 3-4 – Game Logic & Systems (April 28 - May 11)
- Implement health system for player and enemies
- Build AI states (patrol, chase, attack)
- Add hitboxes, enemy projectiles, damage
- Add pickups and power-ups (health boost, weapon change)

Week 5-6 – Level Design & Progression (May 12 - May 25)
- Build multiple levels using tilemaps
- Add increasing difficulty (more enemies, faster projectiles, traps)
- Create transitions between levels

Week 7-8 – Polish & Presentation (May 26 - June 9th)
- Add visual and sound effects
- Add main menu, pause screen, win/lose screens
- Save/load system (optional)
- Playtesting, feedback, bug fixes

## Worries

1. None of us are familiar with the technology. It is going to be a new experience for the both of us but really exciting.

## Communication
It is me and Reece and we talk a lot on the phone and in person. We are planning on meeting at the very least one to two times per week in person. 
