## Manual Tests

### Left Orientation:
- Run Left <A>
- Run Right <D>
- Jump <W>
- Crouching \<S>
- Shooting:
    <Shoot (in the direction being faced): 
        Spacebar
    >
    <Shoot-Left-Crouch: 
        Shift+A+Return,
        Shift+A+Spacebar
    >
    <Shoot-Right-Crouch: 
        Shift+D+Return, 
        Shift+D+Spacebar
    >
    <Shoot-Up: 
        Shift+W+Return,
        Shift+W+Spacebar
    >

### Right Orientation:
- Run Left <Left-Arrow>
- Run Right <Right-Arrow>
- Jump <Up-Arrow>
- Crouching <Down-Arrow>
- Shooting:
    <Shoot (in the direction being faced): 
        Spacebar
    >
    <Shoot-Left-Crouch: 
        Shift+Left-Arrow+Spacebar
    >
    <Shoot-Right-Crouch: 
        Shift+Right-Arrow+Spacebar
    >
    <Shoot-Up: 
        Shift+Up-Arrow+Spacebar
    >

## Automated Tests

1. Test for when the player or enemy dies:
    - We know that a character (player or enemy) is supposed to eventually die whenever it is hit enough by a projectile. We should test to see that the player is taking damage in the appropriate manner (such as -10hp... or death)
    - We also know that player does whenever he encounters environmental hazards, like falling into the water (or off the world). 

2. Test for proximity or presence: 
    - We know that during the enemy AI chase and attack phase, the player has to be within some proximity of the enemy. We could test to make sure that these proximities are accurate and the chase is handled correctly.
    - We can also test for contact between different entities: Players, enemies, projectiles or other things present in the environment.
