# 4.1: Install Pedro Pathing Without Breaking TeleOp

Install the coach-approved Pedro Pathing version into the existing Season
Repository, choose one dashboard, and prove that the drivetrain still works before
beginning tuning.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | dependency integration, drivetrain and localizer prerequisites |
| **Git focus** | `feature/pedro-pathing`, regression checkpoint |
| **AI tutor** | compare the diff with the pinned official installation guide |

## 1. Verify the hardware choice

Read the current [Pedro Pathing introduction](https://pedropathing.com/docs/pathing).
With a coach, record:

- which physical robot and omnidirectional drivetrain this lesson uses;
- the four drive-motor configuration names and directions;
- which localization hardware is installed;
- odometry-pod type, placement, and encoder connections when applicable;
- goBILDA Pinpoint, OTOS, or other localizer firmware and configuration; and
- the approved training-power limit and test area.

Do not proceed because the robot “should” have odometry. Inspect the hardware and
active Driver Station configuration.

## 2. Create the feature branch

Start from the latest reviewed Season Repository integration branch and create:

```text
feature/pedro-pathing
```

Record the current FTC SDK version and build the unchanged branch once more.

## 3. Install the pinned version

Follow the coach-pinned [official installation guide](https://pedropathing.com/docs/pathing/installation).
Because this course adds Pedro to an existing Season Repository, follow the
approved manual-integration path; do not replace the repository by cloning the
Quickstart over it.

Record the exact Pedro dependency version and the Quickstart commit or release used
for any copied support files. Never leave `x.y.z`, a floating version, or an
unrecorded copied file in season code.

## 4. Choose one dashboard

Review the official [dashboard comparison](https://pedropathing.com/docs/pathing/dashboard).
The coach chooses Panels or FTC Dashboard for the team. Record the choice and
version in `docs/architecture.md`; students should not maintain two tuning stacks.

## 5. Build and rerun TeleOp

Before tuning:

1. synchronize Gradle and build the complete project;
2. confirm the existing TeleOp still appears on the Driver Station;
3. repeat forward, strafe, rotate, precision-mode, and Stop checks;
4. open the selected dashboard and verify telemetry reaches it; and
5. record every warning or change required by the integration.

Commit and push the installation result only after this regression passes. Use a
focused checkpoint such as:

```text
Install pinned Pedro Pathing dependencies
```

## Ask your AI tutor

> Compare my installation diff with the pinned Pedro guide. Identify unpinned
> versions, copied files without a source, SDK-setting changes, duplicate dashboard
> dependencies, and any reason the existing TeleOp regression is incomplete.

## Check your work

The Season Repository builds, TeleOp behavior is unchanged, the dashboard works,
and the feature branch contains a clean installation checkpoint. Continue to
[4.2](../02-constants-and-localization/README.md).

## Reflect

Why is “Gradle sync succeeded” weaker evidence than rerunning the existing TeleOp?
