# Lesson 3: Turn Gamepad Input into Driver Intent

The Lesson 2 OpMode sends every small joystick value into the drive calculation.
Real joysticks rarely return exactly zero, and drivers need a precise low-speed
mode for alignment. You will add both behaviors without hiding the input or
changing the verified mecanum math.

The important idea is **driver intent**: raw gamepad readings become named values
that describe what the driver wants the robot to do.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | joystick drift, deadband boundary, held precision mode, observable intent |
| **Git focus** | make one behavior change and preserve the earlier drive evidence |
| **AI tutor** | test boundary values and locate duplicated sign or scale changes |

## Your goal

By the end of this lesson, you can:

- distinguish raw gamepad input from processed driver intent;
- apply and explain a specific deadband rule;
- switch between normal and precision scales while a button is held;
- report raw input, processed intent, active mode, and applied output separately;
- preserve the wheel patterns proven in Lesson 2.

## Get ready

Merge Lesson 2 into your cumulative branch, then create:

```text
feature/<your-name>/driver-intent
```

Copy `RobotCentricDriveOpMode.java` to `DriverIntentDriveOpMode.java`. Change its
annotation so both OpModes have unique Driver Station names:

```java
@TeleOp(name = "L3 Driver Intent Drive", group = "Level 3")
```

Keep the earlier OpMode as a known comparison while you test the new behavior.

## Part 1 — Measure centered-stick drift

Before changing code, run the Lesson 2 OpMode with the wheels raised. Do not touch
either stick. Record the raw values shown in telemetry for at least ten seconds:

| Axis | Smallest observed | Largest observed |
|---|---:|---:|
| Left stick Y | | |
| Left stick X | | |
| Right stick X | | |

The deadband must be large enough to cover ordinary centered drift but small
enough to preserve deliberate driver movement. The walkthrough uses `0.08` as an
example. If the team's measurements require another reviewed value, change the
constant and record why.

## Part 2 — Add named control constants

Replace the one `TRAINING_SCALE` constant with:

```java
private static final double DEADBAND = 0.08;
private static final double NORMAL_SCALE = 0.35;
private static final double PRECISION_SCALE = 0.18;
```

These names separate three decisions:

- `DEADBAND` defines which small input values count as centered;
- `NORMAL_SCALE` preserves the reviewed Lesson 2 training limit; and
- `PRECISION_SCALE` reduces the maximum command while the driver aligns the robot.

Both scales remain below full motor power. A mode change should never bypass the
team's approved drive limit.

## Part 3 — Write the deadband rule

Add this method below `runOpMode()`:

```java
private double applyDeadband(double value) {
    if (Math.abs(value) <= DEADBAND) {
        return 0.0;
    }

    return value;
}
```

This rule includes the exact boundary in the zero region:

```text
absolute value <= 0.08  →  0.0
absolute value > 0.08   →  unchanged input
```

It is intentionally simple. An input just outside the deadband jumps to its
original value rather than being rescaled. Rescaling can make the transition
smoother, but it is a separate design change that should be explained and tested,
not silently mixed into this lesson.

Predict the method's output:

| Input | Expected output |
|---:|---:|
| `0.00` | |
| `0.07` | |
| `0.08` | |
| `0.081` | |
| `-0.08` | |
| `-0.30` | |

## Part 4 — Read raw input once

Replace the three input lines in the loop with:

```java
double rawForward = -gamepad1.left_stick_y;
double rawStrafe = gamepad1.left_stick_x;
double rawTurn = gamepad1.right_stick_x;

double forward = applyDeadband(rawForward);
double strafe = applyDeadband(rawStrafe);
double turn = applyDeadband(rawTurn);
```

The leading minus sign still appears exactly once, where the raw Y axis becomes
the course's positive-forward convention. The mixer receives only the processed,
named intent.

Reading each axis once also makes telemetry honest: `rawForward` and `forward`
refer to the same pass through the loop.

## Part 5 — Add a held precision mode

After processing the axes, choose a scale:

```java
boolean precisionMode = gamepad1.left_bumper;
double driveScale = precisionMode ? PRECISION_SCALE : NORMAL_SCALE;
String driveMode = precisionMode ? "PRECISION" : "NORMAL";
```

The left bumper is a **held** control:

- press and hold it to use precision scale;
- release it to return immediately to normal scale.

This behavior does not need edge detection or toggle state. The current button
value fully explains the current mode.

Replace the four multiplications by `TRAINING_SCALE` with:

```java
frontLeftPower *= driveScale;
frontRightPower *= driveScale;
backLeftPower *= driveScale;
backRightPower *= driveScale;
```

The order remains mix, normalize, then scale. Precision mode changes magnitude,
not direction or the ratios between wheels.

## Part 6 — Separate input, intent, and output telemetry

Replace the loop telemetry with:

```java
telemetry.addData("Drive mode", driveMode);
telemetry.addData(
        "Raw F/S/T",
        "%.2f / %.2f / %.2f",
        rawForward,
        rawStrafe,
        rawTurn);
telemetry.addData(
        "Intent F/S/T",
        "%.2f / %.2f / %.2f",
        forward,
        strafe,
        turn);
telemetry.addData(
        "Front left/right",
        "%.2f / %.2f",
        drive.getFrontLeftPower(),
        drive.getFrontRightPower());
telemetry.addData(
        "Back left/right",
        "%.2f / %.2f",
        drive.getBackLeftPower(),
        drive.getBackRightPower());
telemetry.update();
```

The three layers answer different questions:

| Telemetry layer | Question it answers |
|---|---|
| Raw | What did the SDK report from the gamepad? |
| Intent | What motion did our input rule select? |
| Wheel output | What power did the program request from each drive motor? |

If the raw value drifts but intent remains zero, the deadband is working. If
intent is correct but a wheel command has the wrong sign, inspect the mixer. If
commands are correct but physical motion is wrong, inspect the hardware contract.

## Part 7 — Check the complete OpMode

Compare your assembled file with this version:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.hardware.DriveHardware;

@TeleOp(name = "L3 Driver Intent Drive", group = "Level 3")
public class DriverIntentDriveOpMode extends LinearOpMode {
    private static final double DEADBAND = 0.08;
    private static final double NORMAL_SCALE = 0.35;
    private static final double PRECISION_SCALE = 0.18;

    @Override
    public void runOpMode() {
        DriveHardware drive = new DriveHardware();
        drive.initialize(hardwareMap);

        telemetry.addData("Status", "Drive initialized");
        telemetry.addData("Deadband", "%.2f", DEADBAND);
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            double rawForward = -gamepad1.left_stick_y;
            double rawStrafe = gamepad1.left_stick_x;
            double rawTurn = gamepad1.right_stick_x;

            double forward = applyDeadband(rawForward);
            double strafe = applyDeadband(rawStrafe);
            double turn = applyDeadband(rawTurn);

            boolean precisionMode = gamepad1.left_bumper;
            double driveScale =
                    precisionMode ? PRECISION_SCALE : NORMAL_SCALE;
            String driveMode = precisionMode ? "PRECISION" : "NORMAL";

            double frontLeftPower = forward + strafe + turn;
            double frontRightPower = forward - strafe - turn;
            double backLeftPower = forward - strafe + turn;
            double backRightPower = forward + strafe - turn;

            double largestPower = Math.max(
                    Math.abs(frontLeftPower),
                    Math.abs(frontRightPower));
            largestPower = Math.max(
                    largestPower,
                    Math.abs(backLeftPower));
            largestPower = Math.max(
                    largestPower,
                    Math.abs(backRightPower));

            if (largestPower > 1.0) {
                frontLeftPower /= largestPower;
                frontRightPower /= largestPower;
                backLeftPower /= largestPower;
                backRightPower /= largestPower;
            }

            frontLeftPower *= driveScale;
            frontRightPower *= driveScale;
            backLeftPower *= driveScale;
            backRightPower *= driveScale;

            drive.setDrivePowers(
                    frontLeftPower,
                    frontRightPower,
                    backLeftPower,
                    backRightPower);

            telemetry.addData("Drive mode", driveMode);
            telemetry.addData(
                    "Raw F/S/T",
                    "%.2f / %.2f / %.2f",
                    rawForward,
                    rawStrafe,
                    rawTurn);
            telemetry.addData(
                    "Intent F/S/T",
                    "%.2f / %.2f / %.2f",
                    forward,
                    strafe,
                    turn);
            telemetry.addData(
                    "Front left/right",
                    "%.2f / %.2f",
                    drive.getFrontLeftPower(),
                    drive.getFrontRightPower());
            telemetry.addData(
                    "Back left/right",
                    "%.2f / %.2f",
                    drive.getBackLeftPower(),
                    drive.getBackRightPower());
            telemetry.update();
        }

        drive.stopDrive();
    }

    private double applyDeadband(double value) {
        if (Math.abs(value) <= DEADBAND) {
            return 0.0;
        }

        return value;
    }
}
```

Build before deploying. The complete code should differ from Lesson 2 only in the
new constants, raw-versus-processed variables, selected scale, telemetry, class
name, and deadband method.

## Part 8 — Test with commands disabled first

For the first run, temporarily replace the four arguments to
`drive.setDrivePowers(...)` with zeroes. This lets you test the input decisions
without moving the drivetrain.

Add these temporary telemetry checks before `telemetry.update()` so the exact
boundary can be tested without trying to hold a physical joystick at precisely
`0.080`:

```java
telemetry.addData(
        "Deadband below/at/above",
        "%.3f / %.3f / %.3f",
        applyDeadband(DEADBAND - 0.001),
        applyDeadband(DEADBAND),
        applyDeadband(DEADBAND + 0.001));
```

Remove this temporary line after recording the result.

| Input test | Verify in telemetry |
|---|---|
| Sticks centered | Raw values may drift, but all three intent values are zero. |
| Temporary value just below the boundary | Output is zero. |
| Temporary value at `0.08` | Output is zero under the documented `<=` rule. |
| Temporary value just outside the boundary | Output is `0.081`. |
| Hold left bumper | Mode becomes `PRECISION`. |
| Release left bumper | Mode immediately returns to `NORMAL`. |

Restore the four calculated arguments only after these results match the rule.

## Part 9 — Verify raised-wheel and floor behavior

Repeat the Lesson 2 safety setup and pure-motion tests:

| Behavior test | Verify |
|---|---|
| Centered sticks | All wheel commands remain zero despite measured drift. |
| Small deliberate motion | The robot begins responding after the deadband boundary. |
| Normal mode | No command exceeds `NORMAL_SCALE`. |
| Precision mode | No command exceeds `PRECISION_SCALE`. |
| Same stick position in both modes | Wheel signs and ratios match; only magnitude changes. |
| Release precision button while moving | Normal scale returns without pausing the loop. |
| Driver Station **Stop** | All drive commands become zero. |

Ask the same driver to compare the two modes at low speed. “Feels better” is
useful feedback, but preserve the measured boundary and telemetry results too.

## Git checkpoint

Inspect the diff against Lesson 2. There should be no changes to configuration
names, motor directions, or the mixer signs.

Commit with a focused message such as:

```text
Add deadband and precision drive mode
```

Include the measured drift range, chosen deadband, boundary test, normal and
precision scales, and hardware results in the pull request.

## Ask your AI tutor

> Review the diff from `RobotCentricDriveOpMode` to
> `DriverIntentDriveOpMode` without editing. Check the exact deadband boundary,
> one-time Y sign change, held precision-mode rule, scale limits, raw-versus-intent
> telemetry, unchanged mecanum signs, and final stop behavior. Give an input value
> that tests each boundary claim.

## Check your work

You are finished when:

- the deadband value is supported by observed centered-stick data;
- zero, boundary, and just-outside-boundary tests match the written rule;
- normal and precision modes preserve direction and wheel-power ratios;
- telemetry separates raw input, intent, mode, and applied output;
- Lesson 2's pure-motion tests still pass; and
- the reviewed pull request explains every changed behavior.

## Reflect

Which input-processing choice changed how the robot felt most, and what evidence
shows that it did not change the driver's intended direction?

Continue to [Lesson 4: Build One Reusable Mechanism Subsystem](../04-first-subsystem/README.md).
