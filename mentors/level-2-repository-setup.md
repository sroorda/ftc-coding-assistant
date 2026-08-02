# Prepare the Level 2 Hardware-Lab Repository

> **Draft for mentor review:** This page prepares the shared repository and student
> branches. It does not define Level 2 lessons or authorize hardware deployment.

The hardware lab should be separate from both the curriculum repository and active
competition code. It needs the same approved FTC SDK version and compatible package
conventions so selected code can later be promoted deliberately.

## Record the source before creating the repository

Document:

- FTC SDK release or tag: `<FTC_SDK_VERSION>`
- Official source: `FIRST-Tech-Challenge/FtcRobotController`
- Exact source commit: `<FTC_SDK_COMMIT>`
- Team repository URL: `<HARDWARE_LAB_REPOSITORY_URL>`
- Supported Android Studio and Java configuration
- Control Hub and Driver Station versions used for validation

FIRST maintains the
[FTC SDK overview](https://ftc-docs.firstinspires.org/en/latest/ftc_sdk/overview/index.html)
and its
[fork-and-clone workflow](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/fork_and_clone_github_repository/Fork-and-Clone-From-GitHub.html).

## Recommended repository ownership

For this student lab, prefer a normal team-owned repository initialized from the
approved official SDK release rather than a GitHub-linked public fork. A fork
prevents direct pushes to FIRST but can still present FIRST's repository as a pull
request destination. A standalone team repository keeps student pull requests
inside the team project.

In the maintainer clone:

- `origin` should be the team hardware-lab repository;
- an optional `upstream` may point to the official FIRST repository; and
- students should normally have only the team repository configured as `origin`.

If the team chooses a GitHub fork instead, explicitly teach students to verify the
base repository and base branch on every pull request.

## Prepare the initial project

1. Start from the approved official SDK tag or commit.
2. Create the team-owned hardware-lab repository.
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
- Use temporary review branches such as `lesson/<name>/<description>`.
- Direct each lesson pull request to the author's `student/<name>` branch.
- Require a peer or mentor review before merging reviewed work.
- Do not merge all student implementations into `main`.

The student workflow is documented in
[Your Level 2 Git Workflow](../docs/level-2-git-workflow.md).

## Keep code portable to competition

Use `org.firstinspires.ftc.teamcode` and keep responsibilities separated:

```text
TeamCode/src/main/java/org/firstinspires/ftc/teamcode/
├── training/       lesson OpModes that normally stay in the lab
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
- all placeholders in the student setup pages have been replaced.
