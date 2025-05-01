## Manual Tests

### Left Orientation:
- Run Left <A>
- Run Right <D>
- Jump <W>
- Shooting:
    <Shoot L e>
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
- Shooting:
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

1. Test for player or enemy die:
    - We know that a character (Player or enemy) is supposed to die whenever it is. We should test to see that that behavior is the one that is taking place
    - We also know that player does whenever he encouters environmental hazards, like falling into waters or anything of that kind. 

2. Test for proximity or presence: 
    - We know that during the enemy AI chase and attack phase, the player has to be in some proximity to the enemy. So we need to confirm that proximity or presence of the player
    - We can also test for contact between different things: players, players with the projectiles or other things present in the environment


