# Prepare the Level 2 Hardware-Lab Repository

The hardware lab should be separate from both the curriculum repository and active
competition code. It needs the same approved FTC SDK version and compatible package
conventions so selected code can later be promoted deliberately.

## Record the source before creating the repository

Document:

- FTC SDK release: `11.2.1`
- Official source: `FIRST-Tech-Challenge/FtcRobotController`
- Exact source commit: `26cd1fdd2a3c4b26173d9ff33a3279c27d1c7ad1`
- Team repository URL: `https://github.com/sroorda/ftc-hardware-lab`
- Supported Android Studio: Narwhal 3 Feature Drop or later
- Control Hub and Driver Station versions used for validation

FIRST maintains the
[FTC SDK overview](https://ftc-docs.firstinspires.org/en/latest/ftc_sdk/overview/index.html)
and its
[fork-and-clone workflow](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/fork_and_clone_github_repository/Fork-and-Clone-From-GitHub.html).

## Repository ownership

The hardware lab is a public fork under `sroorda`. This prevents student work from
changing the official FIRST repository, while preserving a clear relationship to
upstream SDK releases. Because GitHub may offer the official repository as a pull
request destination, students must verify both the base repository and base branch
before creating each pull request.

In the maintainer clone:

- `origin` should be the team hardware-lab repository;
- `upstream` points to the official FIRST repository; and
- students should normally have only the team repository configured as `origin`.

## Prepare the initial project

1. Start from the approved official SDK tag or commit.
2. Fork the official project into the team maintainer's GitHub account.
3. Preserve the official project structure.
4. Keep team changes inside `TeamCode`; do not modify `FtcRobotController` samples
   or SDK sources.
5. Add only the minimum team-owned foundation needed before Level 2 begins.
6. Do not add Wi-Fi credentials, signing material, tokens, student information, or
   machine-specific Android Studio files.
7. Build the untouched project on a supported student operating system.
8. Install it on the actual Control Hub and verify reconnection from the Driver
   Station.
9. Record the verified versions and source commit in the repository README.

## Configure GitHub access

- Protect `main` from direct student pushes.
- Give each student enough access to create and push branches.
- Use one cumulative branch per student: `student/<name>`.
- Use temporary review branches such as `feature/<name>/<description>`.
- Direct each lesson pull request to the author's `student/<name>` branch.
- Require a peer or mentor review before merging reviewed work.
- Do not merge all student implementations into `main`.

The personal-branch setup is documented in
[Level 2 Setup](../docs/level-2-setup.md). 2.1 will provide the complete
feature-branch and pull-request procedure.

## Keep code portable to competition

Student Level 2 code begins in `org.firstinspires.ftc.teamcode.level2`. As reusable
code emerges, keep responsibilities separated inside that package:

```text
TeamCode/src/main/java/org/firstinspires/ftc/teamcode/level2/
├── opmodes/        lesson OpModes that normally stay in the lab
├── hardware/       hardware initialization candidates
├── subsystems/     reusable mechanism behavior candidates
└── util/           small hardware-independent helpers
```

Do not promise that lab code will automatically enter the competition repository.
At the end of Level 2, select candidates, adapt them to the real robot, test them
again, and submit a separate competition-code pull request.

## Release the repository to students when

- the source SDK version and commit are recorded;
- `main` builds from a clean clone;
- Android Studio does not require an unplanned project upgrade;
- wireless ADB deployment works on the actual Control Hub;
- the Driver Station reconnects after installation;
- repository permissions and branch protection have been tested with a non-owner
  account; and
- the hardware contract matches the physical Driver Station configuration.
