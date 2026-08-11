# Lesson 6: TeleOp Integration Challenge

You now have two independently tested capabilities:

- gamepad 1 produces deadbanded, scaled robot-centric drive commands; and
- gamepad 2 produces one feeder command with explicit conflict and limit rules.

The final Level 3 task is to run both in one responsive TeleOp. This is an
integration lesson, not a blank-page challenge: you will assemble the proven code
in small steps, verify each boundary, and then demonstrate simultaneous operation.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | two-driver TeleOp, nonblocking coordination, subsystem evidence, complete stop |
| **Git focus** | integrate through public interfaces and preserve partner-owned behavior |
| **AI tutor** | trace commands and find blocking or competing hardware writes |

## Your goal

By the end of this lesson, you can:

- describe one fast outer loop that coordinates drive and mechanism behavior;
- operate the drivetrain and feeder during the same interval;
- trace each command from gamepad to final hardware call;
- distinguish drive intent, mechanism request, safety decision, and output;
- prove that one capability does not pause or overwrite the other; and
- stop every powered output when the OpMode ends.

## Get ready

Merge Lesson 5 into your cumulative branch, then create:

```text
feature/<your-name>/teleop-integration
```

Before combining code, rerun these two focused tests:

1. `L3 Driver Intent Drive` passes centered, pure-motion, precision-mode, release,
   and Stop tests.
2. `L3 Feeder Controls` passes normal, conflict, limit, recovery, release, and
   Stop tests.

Integration does not repair an unverified subsystem. If either focused test fails,
fix it in that lesson's boundary before building the combined OpMode.

## Part 1 — Agree on the two public interfaces

If two students are pairing, one can review drive and the other can review the
feeder. Both students should be able to read this interface agreement:

| Capability | Public calls used by TeleOp | Hardware that remains private |
|---|---|---|
| Drive | `initialize(...)`, `setDrivePowers(...)`, four power getters, `stopDrive()` | four `DcMotor` fields |
| Feeder | `initialize(...)`, `update(...)`, evidence getters, `stop()` | `CRServo` and `TouchSensor` fields |

The integration OpMode must not change a field from private to public, add a
second `hardwareMap.get(...)` for an owned device, or call `setPower(...)`
directly. Integrate through the operations that already passed focused tests.

## Part 2 — Draw the outer loop

The combined loop will do this repeatedly:

```text
read gamepad 1 once
→ choose drive intent and scale
→ calculate and apply four wheel powers
→ read gamepad 2 once
→ choose one feeder command
→ update the feeder and its limit rule
→ report both capabilities
→ return immediately to the top
```

There is no inner `while`, long `sleep`, encoder busy wait, or wait for a sensor to
change. Each pass does a small amount of work, which lets drive and feeder respond
during the same interval.

## Part 3 — Create the integration shell

Create `IntegratedTeleOp.java` in the Level 3 package:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.hardware.DriveHardware;
import org.firstinspires.ftc.teamcode.level3.subsystems.FeederSubsystem;

@TeleOp(name = "L3 Integrated TeleOp", group = "Level 3")
public class IntegratedTeleOp extends LinearOpMode {
    private static final double DEADBAND = 0.08;
    private static final double NORMAL_SCALE = 0.35;
    private static final double PRECISION_SCALE = 0.18;

    @Override
    public void runOpMode() {
        DriveHardware drive = new DriveHardware();
        FeederSubsystem feeder = new FeederSubsystem();

        drive.initialize(hardwareMap);
        feeder.initialize(hardwareMap);

        telemetry.addData("Status", "Drive and feeder initialized");
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            // Part 4: Read, calculate, and apply drive behavior.

            // Part 5: Select and update feeder behavior.

            // Part 6: Report both capabilities.
        }

        drive.stopDrive();
        feeder.stop();
    }

    private double applyDeadband(double value) {
        if (Math.abs(value) <= DEADBAND) {
            return 0.0;
        }

        return value;
    }
}
```

Initialization happens before `waitForStart()`, and both classes command their
powered outputs to zero during initialization. The two final stop calls make the
complete TeleOp cleanup visible in one place.

Build the shell before adding loop behavior.

## Part 4 — Add the tested drive behavior

Copy the active-loop drive block from `DriverIntentDriveOpMode` into the first
numbered area:

```java
double rawForward = -gamepad1.left_stick_y;
double rawStrafe = gamepad1.left_stick_x;
double rawTurn = gamepad1.right_stick_x;

double forward = applyDeadband(rawForward);
double strafe = applyDeadband(rawStrafe);
double turn = applyDeadband(rawTurn);

boolean precisionMode = gamepad1.left_bumper;
double driveScale = precisionMode ? PRECISION_SCALE : NORMAL_SCALE;
String driveMode = precisionMode ? "PRECISION" : "NORMAL";

double frontLeftPower = forward + strafe + turn;
double frontRightPower = forward - strafe - turn;
double backLeftPower = forward - strafe + turn;
double backRightPower = forward + strafe - turn;

double largestPower = Math.max(
        Math.abs(frontLeftPower),
        Math.abs(frontRightPower));
largestPower = Math.max(largestPower, Math.abs(backLeftPower));
largestPower = Math.max(largestPower, Math.abs(backRightPower));

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
```

Do not “clean up” signs, direction values, or normalization while copying. This
integration step should preserve the behavior already proven in Lesson 3.

Build again. Temporarily leave the feeder area empty and repeat centered, pure
motion, precision, release, and Stop tests. The drive should behave exactly as it
did before integration.

## Part 5 — Add the tested feeder behavior

Copy the operator-selection block from `FeederControlOpMode` into the second area:

```java
boolean feedRequested = gamepad2.right_bumper;
boolean reverseRequested = gamepad2.left_bumper;

FeederSubsystem.Command feederCommand;

if (reverseRequested) {
    feederCommand = FeederSubsystem.Command.REVERSE;
} else if (feedRequested) {
    feederCommand = FeederSubsystem.Command.FEED;
} else {
    feederCommand = FeederSubsystem.Command.STOP;
}

feeder.update(feederCommand);
```

The drive variables and feeder variables have different names and different
hardware boundaries. Adding the second behavior does not create a second outer
loop.

Build again. Raise the drivetrain or force the four drive commands to zero while
you repeat the feeder normal, conflict, limit, recovery, release, and Stop tests.

## Part 6 — Add integration telemetry

Add this in the third area:

```java
telemetry.addData("Drive mode", driveMode);
telemetry.addData(
        "Raw drive F/S/T",
        "%.2f / %.2f / %.2f",
        rawForward,
        rawStrafe,
        rawTurn);
telemetry.addData(
        "Drive intent F/S/T",
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

telemetry.addData("Feeder request", feeder.getRequestedCommand());
telemetry.addData("Feeder limit", feeder.isLimitPressed());
telemetry.addData("Feeder blocked", feeder.isBlockedByLimit());
telemetry.addData(
        "Feeder power",
        "%.2f",
        feeder.getAppliedPower());
telemetry.update();
```

Each line should help locate a problem:

- raw drive values show the gamepad reading;
- drive intent shows deadband processing;
- wheel powers show the final drive command;
- feeder request shows the operator decision;
- limit and blocked values show the safety evidence; and
- feeder power shows what was actually applied.

Avoid adding every available sensor value. Telemetry should explain the current
decision without overwhelming the Driver Station display.

## Part 7 — Check the complete TeleOp

Compare the assembled result with this complete version:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.hardware.DriveHardware;
import org.firstinspires.ftc.teamcode.level3.subsystems.FeederSubsystem;

@TeleOp(name = "L3 Integrated TeleOp", group = "Level 3")
public class IntegratedTeleOp extends LinearOpMode {
    private static final double DEADBAND = 0.08;
    private static final double NORMAL_SCALE = 0.35;
    private static final double PRECISION_SCALE = 0.18;

    @Override
    public void runOpMode() {
        DriveHardware drive = new DriveHardware();
        FeederSubsystem feeder = new FeederSubsystem();

        drive.initialize(hardwareMap);
        feeder.initialize(hardwareMap);

        telemetry.addData("Status", "Drive and feeder initialized");
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

            boolean feedRequested = gamepad2.right_bumper;
            boolean reverseRequested = gamepad2.left_bumper;

            FeederSubsystem.Command feederCommand;

            if (reverseRequested) {
                feederCommand = FeederSubsystem.Command.REVERSE;
            } else if (feedRequested) {
                feederCommand = FeederSubsystem.Command.FEED;
            } else {
                feederCommand = FeederSubsystem.Command.STOP;
            }

            feeder.update(feederCommand);

            telemetry.addData("Drive mode", driveMode);
            telemetry.addData(
                    "Raw drive F/S/T",
                    "%.2f / %.2f / %.2f",
                    rawForward,
                    rawStrafe,
                    rawTurn);
            telemetry.addData(
                    "Drive intent F/S/T",
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

            telemetry.addData(
                    "Feeder request",
                    feeder.getRequestedCommand());
            telemetry.addData("Feeder limit", feeder.isLimitPressed());
            telemetry.addData(
                    "Feeder blocked",
                    feeder.isBlockedByLimit());
            telemetry.addData(
                    "Feeder power",
                    "%.2f",
                    feeder.getAppliedPower());
            telemetry.update();
        }

        drive.stopDrive();
        feeder.stop();
    }

    private double applyDeadband(double value) {
        if (Math.abs(value) <= DEADBAND) {
            return 0.0;
        }

        return value;
    }
}
```

The repeated drive calculation is acceptable at this checkpoint because the
student can still trace it. A later refactor may move it behind a tested drive
subsystem operation. Do not introduce that abstraction during integration unless
the team has a separate behavior-preserving test for it.

## Part 8 — Walk through scenarios before moving hardware

Read each row aloud and trace both outputs:

| Scenario | Expected drive result | Expected feeder result |
|---|---|---|
| No controls | all four commands zero | `STOP`, zero power |
| Gamepad 1 forward only | four scaled forward commands | `STOP`, zero power |
| Gamepad 2 feed only, limit released | drive zero | `FEED`, positive limited power |
| Forward and feed together | four scaled forward commands | `FEED`, positive limited power |
| Precision strafe and reverse together | reduced strafe pattern | `REVERSE`, negative limited power |
| Drive while feed limit is pressed | drive follows gamepad 1 | `FEED` request blocked to zero |
| Both feeder buttons while driving | drive follows gamepad 1 | `REVERSE` wins |
| Driver Station Stop during both | all drive commands stop | feeder power stops |

If either column is unclear, return to the focused lesson before deployment.

## Part 9 — Test integration in layers

Use the team's reviewed robot and mechanism safety setup.

1. Force all five powered outputs to zero and verify both gamepads, command
   selection, deadband, precision mode, limit, conflict rule, and telemetry.
2. Enable drive only and repeat the complete Lesson 3 test set.
3. Raise or disable drive, enable the feeder, and repeat the Lesson 5 test set.
4. Enable both and perform short combined requests at conservative values.
5. Press Driver Station Stop during each combined request.

Record these final demonstrations:

| Demonstration | Evidence to record |
|---|---|
| Drive while feeding | Both power groups are nonzero during the same telemetry interval. |
| Drive while reversing | Both respond without a pause or retained previous command. |
| Drive with an active feeder limit | Wheel commands remain responsive; unsafe feed output is zero. |
| Conflicting feeder buttons while driving | Drive remains responsive and `REVERSE` wins. |
| Release all controls | All four wheel commands and feeder power return to zero. |
| Stop during combined operation | The OpMode ends and every powered output stops. |

A successful drive-only test plus a successful feeder-only test does not prove
integration. The combined rows are the evidence that one behavior does not starve
or overwrite the other.

## Part 10 — Adapt one reviewed team mechanism

After the complete course example works, replace the feeder example only if the
team has another Level 2-verified mechanism ready. Keep the same learning boundary:

1. write its operation and limit contract;
2. test it independently;
3. expose named subsystem operations;
4. integrate through those public operations; and
5. repeat combined and Stop tests.

Do not copy the feeder's signs, powers, sensor meaning, or configuration names to
a different mechanism. Reuse the structure; supply new physical facts from that
mechanism's evidence.

This adaptation is the only open-ended code portion of the lesson. The working
feeder walkthrough remains a complete reference if the team is not ready to add
another mechanism.

## Git checkpoint

Inspect the complete feature diff. It should integrate tested classes without
modifying private hardware fields or unrelated SDK files.

Use commits that show the integration sequence, for example:

```text
Create integrated TeleOp shell
Add verified drive behavior
Add verified feeder behavior and telemetry
```

The pull request should include:

- the interface agreement;
- confirmation that both focused OpModes still pass;
- the scenario walkthrough;
- simultaneous-operation and Stop evidence;
- any team-mechanism adaptation and its separate contract; and
- known limitations or follow-up work.

## Ask your AI tutor

> Review my integrated TeleOp diff without editing. Trace one drive command and
> one feeder command from gamepad reading to final hardware API call. Find any
> inner wait, long sleep, duplicate hardware mapping, competing output write,
> bypassed subsystem limit, or powered output missing from final cleanup. Propose
> one combined test that could fail even when both focused OpModes pass.

## Check your work

You are finished when:

- the integrated TeleOp preserves every focused drive and feeder behavior;
- gamepad 1 and gamepad 2 can command their capabilities simultaneously;
- the feeder limit and conflict rule do not pause the drivetrain;
- one outer loop handles input, decisions, outputs, and telemetry without blocking;
- all powered outputs have an explicit initialization, release, and final Stop
  path;
- both command traces can be explained without accessing private fields; and
- the reviewed pull request contains combined-operation evidence.

## Reflect

What integration problem was invisible when drive and feeder were tested only in
separate OpModes?

Return to the [Level 3 readiness checkpoint](../../levels/03-robot-systems-and-teleop.md#your-next-checkpoint).
