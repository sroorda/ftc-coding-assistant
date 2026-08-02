# Level 2 Setup

> **Draft for review:** The team must fill in the FTC SDK version and hardware-lab
> repository URL before students use this guide.

Level 2 moves from small desktop Java programs to an Android Studio project that
can deploy code to FTC hardware. Complete this setup before beginning the hardware
labs.

## What you need

- Hardware-lab repository: `<HARDWARE_LAB_REPOSITORY_URL>`
- FTC SDK version used by the repository: `<FTC_SDK_VERSION>`
- Access to the team's repository on GitHub
- Android Studio and Git
- The configured hardware test bench

Do not clone the official FIRST repository for the course. The team hardware-lab
repository is based on the correct SDK version and is where your work belongs.

## Complete these steps in order

1. [Set Up GitHub and Git](github-and-git-setup.md).
2. [Prepare Android Studio for FTC](android-studio-ftc-setup.md).
3. In Android Studio, clone `<HARDWARE_LAB_REPOSITORY_URL>` using **Get from
   Version Control**.
4. Allow the first Gradle sync to finish, then build the project without changing
   any files.
5. Create your personal Level 2 branch in Android Studio.
6. Push the new personal branch to the team repository.
7. Follow [Connect Android Studio to the Control Hub](control-hub-connection.md).

The Android Studio guide walks through cloning and creating the personal branch.

## Choose your personal branch name

Your branch holds all of your cumulative Level 2 work. Choose a short name that
teammates can recognize. You can use your first name, GitHub username, or another
team nickname:

```text
student/alex
student/robotdog17
```

Each student chooses a different name. The first hardware exercise will create a
temporary feature branch from this personal branch and explain why real software
teams work that way.

## You are ready when

- Android Studio shows the team hardware-lab repository as the Git remote;
- Android Studio shows `student/<your-name>` as the current branch;
- the personal branch appears in the team repository on GitHub;
- Git reports no uncommitted changes;
- Android Studio completes Gradle sync without requiring project upgrades;
- the `TeamCode` module builds successfully; and
- Android Studio can see the Control Hub on its Program & Manage network.

Once these checks succeed, you may deploy when you are ready. Before pressing Run,
make sure you understand which hardware can move, what the code should do, and how
you will stop the OpMode if the behavior is unexpected.
