
NOTE
----
We only have a front end and the logic for how the game elements behave. So, we could only write tests for that. Another important note is that it is really hard to write tests for godot, because there are not really that many things that require automated testing. Also, even the things that we could write automated tests for require that the game be at a certain state, which is sometimes impossible to simulate. We would need to generate the hierarchical structure of the scenes, and their children which is really difficult to do, especially because we also need to instantiate them and the player.

## Manual Tests

### Player Mechanics:
**Refer to the in-game settings which contains an up to date version of the in game keybindings, for using the game's features**
**Refer to the about page for more information on what you can do in the game as well as what the objectives are**
- Simply play the game
- Run, kill enemies by shooting them, perform parkour, use collectibles, and so on.

## Automated Unit Tests

This project uses [GUT (Godot Unit Test)](https://github.com/bitwes/Gut) for automated testing. Below is a summary of the available tests:

### Player Damage & Health

- `test_take_damage`  
  Verifies that the player’s health decreases correctly when taking damage.

- `test_decrease_hearts`  
  Checks that the heart display reflects the reduced health after damage.

- `test_heal_increases_health`  
  Ensures that healing restores the player's health by the expected amount.

- `test_heal_updates_heart_display`  
  Verifies that the heart UI updates correctly after healing.

### Cooldown Bar Mechanics

- `test_cooldown_starts_at_100`  
  Confirms that the cooldown bar starts full (value = 100) when activated.

- `test_cooldown_decreases_over_time`  
  Ensures the cooldown value drops with time when active.

- `test_cooldown_resets_when_finished`  
  Tests that the cooldown bar resets back to 100 and deactivates when complete.

- `test_cooldown_speed_affects_duration`  
  Verifies that higher cooldown speeds decrease the cooldown bar faster.

### Running Tests
Ensure GUT is installed and enabled in your `project.godot` settings, to run all tests using GUT.

## Source code containing our tests

Folder that contains our tests is the test folder: 'https://github.com/Mauricio-IRV/Emergence2D/tree/main/emergence2d/tests/unit/'. You might also want to check the addons folder, since it comes with the installation of GUT and only serves during tests, although we do not write anything to it directory. 

## How to run the tests

1. Open our godot project
2. In the lower toolbar, click GUT
3. Make sure that, in the right hand menu, the sub-directory is set to the test directory
4. On the top right of the lower small window, click run all
5. A new window should open that shows you which tests were run and what the veridicts  were
