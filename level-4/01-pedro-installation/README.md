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

Verify the Hardware before starting

- which physical robot and omnidirectional drivetrain you will use
- the four drive-motor configuration names and directions
- which localization hardware is installed (pinpoint, OTOS, etc)
- odometry-pod type, placement, and encoder connections

Do not proceed because the robot “should” have odometry. Inspect the hardware and active Driver Station configuration.

## 2. Create the feature branch

Start from your season's main branch, create a feature branch

```text
feature/pedro-pathing
```

## 3. Install the pinned version

Follow the [official installation guide](https://pedropathing.com/docs/pathing/installation) to install Pedro Pathing.  Follow the
approved manual-integration path.  Do not replace the repository by cloning the Quickstart over it.

## 4. Choose one dashboard

Review the official [dashboard comparison](https://pedropathing.com/docs/pathing/dashboard). Decide on which you want to use and follow the appropriate instructions to install it.

## 5. Build and rerun TeleOp

Before tuning:

1. synchronize Gradle and build the complete project
2. confirm the existing TeleOp still appears on the Driver Station
3. repeat forward, strafe, rotate, precision-mode, and Stop checks
4. open the selected dashboard and verify telemetry reaches it

Commit and push the installation result only after this regression passes. Use a focused commit message such as:

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
