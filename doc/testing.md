
NOTE
----
We only have a front end and the logic for how the game elements behave. So, we could only write tests for that. Another important note is that it is really hard to write tests for godot, because there are not really that many things that require automated testing. Also, even the things that we could write automated tests for require that the game be at a certain state, which is sometimes impossible to simulate. We would need to generate the hierarchical structure of the scenes, and their children which is really difficult to do, especially because we also need to instantiate them and the player.


## Testing Tool 
For this project, we chose to use GUT, which is a testing framework with godot, which is pretty convenient since it is compatible with DGscript

## Source code containing our tests

Folder that contains our tests is the test folder: https://github.com/Mauricio-IRV/Emergence2D/tree/main/emergence2d/tests/unit. You might also want to check the addons folder, since it comes with the installation of GUT and only serves during tests, although we do not write anything to it directory. 

## How to run the tests

1. Open our godot project
2. In the lower toolbar, click GUT
3. Make sure that, in the right hand menu, the sub-directory is set to the test directory
4. On the top right of the lower small window, click run all
5. A new window should open that shows you which tests were run and what the veridicts  were


## Unimplemented tests

2. Test for proximity or presence: 
    - We know that during the enemy AI chase and attack phase, the player has to be within some proximity of the enemy. We could test to make sure that these proximities are accurate and the chase is handled correctly.
    - We can also test for contact between different entities: Players, enemies, projectiles or other things present in the environment.


## Manual Tests

### Player Mechanics:
**New Controls, Refer to in-game keybindings for up to date controls**

## Automated Tests

1. Test for when the player or enemy dies:
    - We know that a character (player or enemy) is supposed to eventually die whenever it is hit enough by a projectile. We should test to see that the player is taking damage in the appropriate manner (such as -10hp... or death)
    - We also know that player does whenever he encounters environmental hazards, like falling into the water (or off the world). 

2. Test for proximity or presence: 
    - We know that during the enemy AI chase and attack phase, the player has to be within some proximity of the enemy. We could test to make sure that these proximities are accurate and the chase is handled correctly.
    - We can also test for contact between different entities: Players, enemies, projectiles or other things present in the environment.
