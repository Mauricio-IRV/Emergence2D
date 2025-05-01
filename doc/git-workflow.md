## Our Git work flow

1. ## When to branch: 
    - We should work on separate branches at the beginning of a sprint. That is on Monday, but this is only possible if we have very independent tasks which has not been the case so far. I honestly do not  think we need branches, but we may consider putting them into practice.

2. ## When and how to merge: 
    - If we use branches, we would create a branch and push it to main on its completion, on a ticket by ticket basis. Additionally, we would work together to best resolve any conflicts, were they to appear.

3. ## Code review:
    - Code review has not been an issue so far. Throughout our game development, we can often tell if things are working as expected by simply playing it. We would, however, welcome the opportunity to review code if we deem it necessary depending on the task. 

## Some additional notes:
We were reviewing the following godot version control [documentation](https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html) and are considering integrating some what is discussed into practice with our project such as:
    - Using the official git version control plugin specified
    - Excluding the files specified (e.g. .godot/, *.translation, ...) using gitignore
    - And enabling Godot's built in metadata generation option for version control