# Level 2 Setup

Level 2 moves from small desktop Java programs to an Android Studio project that
can deploy code to FTC hardware. This setup prepares the project and your personal
branch. You will write your first OpMode before connecting to the Control Hub.

## What you need

- Hardware-lab repository: `https://github.com/sroorda/ftc-hardware-lab`
- Access to the team's repository on GitHub
- Android Studio and Git
- The configured hardware test bench

Do not clone the official FIRST repository for the course. The team hardware-lab
repository is the FTC project where your Level 2 work belongs.

> **Note:** The hardware-lab repository is currently based on FTC SDK `11.2.1`.
> The SDK is already part of the project; you do not need to download it
> separately.

## Complete these steps in order

1. [Set Up GitHub and Git](github-and-git-setup.md).
2. [Prepare Android Studio for FTC](android-studio-ftc-setup.md).
3. In Android Studio, clone `https://github.com/sroorda/ftc-hardware-lab` using
   **Get from Version Control**.
4. Allow the first Gradle sync to finish, then build the project without changing
   any files.
5. Create your personal Level 2 branch in Android Studio.
6. Push the new personal branch to the team repository.

The Android Studio guide walks through cloning and creating the personal branch.
Do not connect to the Control Hub during setup. The first lesson will have you
write and build code first, then connect when there is something meaningful to
deploy.

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
- the `TeamCode` module builds successfully.

Once these checks succeed, begin the first Level 2 lesson. It will introduce the
OpMode lifecycle, have you create the first feature branch and Java class, and then
send you to the Control Hub connection guide.
