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
2. [Prepare Android Studio and Your Level 2 Branch](android-studio-ftc-setup.md).

The combined Android Studio guide walks through installation, cloning, the first
build, and creation of your personal branch. Do not connect to the Control Hub
during setup. The first lesson will have you write and build code first, then
connect when there is something meaningful to deploy.

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
