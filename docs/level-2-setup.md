# Level 2 Setup

> **Draft for review:** An adult mentor must fill in the approved FTC SDK version
> and hardware-lab repository URL before students use this guide.

Level 2 moves from small desktop Java programs to an Android Studio project that
can deploy code to FTC hardware. Complete this setup before beginning any hardware
lesson.

## What an adult mentor will provide

- Hardware-lab repository: `<HARDWARE_LAB_REPOSITORY_URL>`
- Approved FTC SDK version: `<FTC_SDK_VERSION>`
- Your branch name: `student/<your-name>`
- Repository access through the team's GitHub organization or account
- A configured test bench and an approved deployment procedure

Do not clone the official FIRST repository for the course. The team repository is
based on the approved SDK and is where student branches and pull requests belong.

## Complete these steps in order

1. [Set Up GitHub and Git](github-and-git-setup.md).
2. [Prepare Android Studio for FTC](android-studio-ftc-setup.md).
3. Clone the team hardware-lab repository and create your personal branch by
   following [Your Level 2 Git Workflow](level-2-git-workflow.md).
4. Open the cloned repository in Android Studio and allow the first Gradle sync to
   finish.
5. Build the project without changing any files.
6. With an adult mentor present, follow
   [Connect Android Studio to the Control Hub](control-hub-connection.md).

## You are ready when

- `git remote -v` shows the team hardware-lab repository as `origin`;
- `git branch --show-current` shows your `student/<your-name>` branch;
- `git status` reports a clean working tree;
- Android Studio completes Gradle sync without suggesting required project
  upgrades;
- the `TeamCode` module builds successfully; and
- Android Studio can see the Control Hub when you are connected to its
  Program & Manage network.

Seeing the Control Hub does not authorize deployment. An adult mentor must approve
the test area, wiring, power, expected motion, and stop procedure before code runs
on hardware.
