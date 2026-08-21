# 3.6: Driver Controls and the TeleOp

The drivetrain class now owns the hardware and coordinate mathematics. The
TeleOp's job is smaller: read the gamepad once, turn raw values into documented
driver intent, select a drive mode, and report evidence.

## Your mission

| | |
|---|---|
| **Time** | 75–90 minutes |
| **FTC focus** | iterative OpMode lifecycle, deadband, heading reset, diagnostic mode |
| **Git focus** | review driver policy separately from drivetrain math |
| **AI tutor** | trace input-to-output flow and find competing commands |

## Your goal

By the end of this lesson, you can:

- explain the `init()`, `loop()`, and `stop()` lifecycle;
- read each gamepad axis once per loop;
- remove small joystick noise with a deadband;
- drive field-relative by default and temporarily compare robot-relative mode;
- reset field heading deliberately; and
- keep the TeleOp responsive without an inner loop or sleep.

## Get ready

Confirm that robot-relative drive, IMU heading, and field-relative drive pass
their separate tests. Keep the approved training-power limit in
`MecanumDrive`, clear the drive area, and review these controls with the driver:

| Control | Behavior |
|---|---|
| Left stick | Field forward/backward and right/left |
| Right stick X | Rotate |
| Right bumper | Precision scale |
| Left bumper | Hold for robot-relative diagnostic |
| Cross (✕) | Reset the current direction as field forward |

## Watch 23:03–end — The thin OpMode

Resume the [video at 23:03](https://www.youtube.com/watch?v=sFCO4du5IZk&t=1383s)
and watch to the end.

The video's final OpMode does three important things:

1. creates one reusable drive object;
2. initializes it with `hardwareMap`; and
3. reads forward, strafe, and rotation before calling the drive method.

FIRST's SDK sample adds two useful diagnostics: Cross/A resets yaw, and the left
bumper temporarily selects robot-relative drive. We will keep both so a driver
can distinguish an IMU problem from a drivetrain problem.

## Start with the lifecycle

Create `MecanumTeleOp.java`:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.OpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive;

@TeleOp(name = "L3 Mecanum TeleOp", group = "Level 3")
public final class MecanumTeleOp extends OpMode {
    private final MecanumDrive drive = new MecanumDrive();

    @Override
    public void init() {
        drive.initialize(hardwareMap);

        telemetry.addData("Status", "Initialized");
        telemetry.addData("Before PLAY", "Point robot field-forward");
        telemetry.addData("Cross (X)", "Reset field heading");
        telemetry.addData("Left bumper", "Hold for robot-relative drive");
        telemetry.update();
    }

    @Override
    public void loop() {
        // Driver intent will go here.
    }

    @Override
    public void stop() {
        drive.stop();
    }
}
```

The FTC runtime calls `loop()` repeatedly. Do not place `while`, `sleep()`, or a
busy wait inside it. Returning quickly lets the runtime read new controls and
respond to Stop.

## Read each input once

Add this at the top of `loop()`:

```java
double rawForward = -gamepad1.left_stick_y;
double rawRight = gamepad1.left_stick_x;
double rawRotate = gamepad1.right_stick_x;

double forward = applyDeadband(rawForward);
double right = applyDeadband(rawRight);
double rotate = applyDeadband(rawRotate);
```

Add this helper below `stop()`:

```java
private static final double JOYSTICK_DEADBAND = 0.05;

private double applyDeadband(double value) {
    return Math.abs(value) < JOYSTICK_DEADBAND ? 0.0 : value;
}
```

Named raw and processed values make telemetry and diagnosis possible. The
deadband turns small centered-stick noise into an exact zero.

## Add precision mode

Still in `loop()`, add:

```java
double precisionScale = gamepad1.right_bumper ? 0.50 : 1.0;
forward *= precisionScale;
right *= precisionScale;
rotate *= precisionScale;
```

Scaling all three commands equally preserves the requested motion. The
`MecanumDrive` training limit still applies after wheel mixing and normalization.

## Reset and select the coordinate frame

Add:

```java
if (gamepad1.crossWasPressed()) {
    drive.resetHeading();
}

boolean robotRelative = gamepad1.left_bumper;
if (robotRelative) {
    drive.driveRobotRelative(forward, right, rotate);
} else {
    drive.driveFieldRelative(forward, right, rotate);
}
```

Field-relative is the normal driver mode. Holding the left bumper is a diagnostic
comparison, not a second permanent control scheme. If robot-relative works while
field-relative fails, inspect heading initialization and the coordinate
transformation.

## Report the decision

Finish `loop()` with:

```java
telemetry.addData("Drive mode",
        robotRelative ? "Robot relative" : "Field relative");
telemetry.addData("Heading degrees", "%.1f", drive.getHeadingDegrees());
telemetry.addData("Raw forward", "%.2f", rawForward);
telemetry.addData("Raw right", "%.2f", rawRight);
telemetry.addData("Raw rotate", "%.2f", rawRotate);
telemetry.addData("Forward command", "%.2f", forward);
telemetry.addData("Right command", "%.2f", right);
telemetry.addData("Rotate command", "%.2f", rotate);
telemetry.addData("Precision scale", "%.2f", precisionScale);
telemetry.update();
```

Telemetry now separates what the controller reported from what the program
commanded.

## Check the complete TeleOp

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.OpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive;

@TeleOp(name = "L3 Mecanum TeleOp", group = "Level 3")
public final class MecanumTeleOp extends OpMode {
    private static final double JOYSTICK_DEADBAND = 0.05;

    private final MecanumDrive drive = new MecanumDrive();

    @Override
    public void init() {
        drive.initialize(hardwareMap);

        telemetry.addData("Status", "Initialized");
        telemetry.addData("Before PLAY", "Point robot field-forward");
        telemetry.addData("Cross (X)", "Reset field heading");
        telemetry.addData("Left bumper", "Hold for robot-relative drive");
        telemetry.update();
    }

    @Override
    public void loop() {
        double rawForward = -gamepad1.left_stick_y;
        double rawRight = gamepad1.left_stick_x;
        double rawRotate = gamepad1.right_stick_x;

        double forward = applyDeadband(rawForward);
        double right = applyDeadband(rawRight);
        double rotate = applyDeadband(rawRotate);

        double precisionScale = gamepad1.right_bumper ? 0.50 : 1.0;
        forward *= precisionScale;
        right *= precisionScale;
        rotate *= precisionScale;

        if (gamepad1.crossWasPressed()) {
            drive.resetHeading();
        }

        boolean robotRelative = gamepad1.left_bumper;
        if (robotRelative) {
            drive.driveRobotRelative(forward, right, rotate);
        } else {
            drive.driveFieldRelative(forward, right, rotate);
        }

        telemetry.addData("Drive mode",
                robotRelative ? "Robot relative" : "Field relative");
        telemetry.addData("Heading degrees", "%.1f", drive.getHeadingDegrees());
        telemetry.addData("Raw forward", "%.2f", rawForward);
        telemetry.addData("Raw right", "%.2f", rawRight);
        telemetry.addData("Raw rotate", "%.2f", rawRotate);
        telemetry.addData("Forward command", "%.2f", forward);
        telemetry.addData("Right command", "%.2f", right);
        telemetry.addData("Rotate command", "%.2f", rotate);
        telemetry.addData("Precision scale", "%.2f", precisionScale);
        telemetry.update();
    }

    @Override
    public void stop() {
        drive.stop();
    }

    private double applyDeadband(double value) {
        return Math.abs(value) < JOYSTICK_DEADBAND ? 0.0 : value;
    }
}
```

## Test the driver contract

| Scenario | Verify |
|---|---|
| Sticks released | Processed commands show `0.00` and robot remains stopped. |
| Push left stick forward | Raw forward and command are positive. |
| Hold right bumper | All three commands are half their normal values. |
| Hold left bumper | Telemetry shows robot-relative; forward follows robot front. |
| Release left bumper | Telemetry shows field-relative; forward follows field. |
| Point field-forward and press Cross (✕) | Heading becomes approximately zero. |
| Rotate while translating | Both requests update during the same loop. |
| Press Driver Station Stop while moving | `stop()` commands every drive motor to zero. |

## Git checkpoint — Driver-facing TeleOp

```text
Add field-relative mecanum TeleOp controls
```

## Ask your AI tutor

> Trace one loop of my TeleOp from raw gamepad values through deadband, precision
> scaling, mode selection, coordinate transformation, wheel normalization, and
> motor output. Identify duplicate reads, competing drive calls, blocking work,
> or missing Stop behavior.

## Check your work

- [ ] The OpMode reads each drive axis once per loop.
- [ ] Small joystick noise becomes zero.
- [ ] Field-relative is the normal mode.
- [ ] Robot-relative mode helps isolate heading problems.
- [ ] Cross (✕) resets yaw only on a new press.
- [ ] `stop()` commands the entire drivetrain to zero.

Continue to [3.7](../07-architecture-and-season-repository/README.md) to plan the
architecture and move into the team's Season Repository.

## Reflect

Which telemetry value most quickly distinguishes joystick noise from a drivetrain
or IMU problem?
