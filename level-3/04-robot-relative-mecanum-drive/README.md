# 3.4: Robot-Relative Mecanum Drive

The gamepad supplies three requests: forward, right, and rotation. A mecanum
drivetrain needs four motor powers. In this lesson you will build that conversion
in visible stages and test it before heading is involved.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | mecanum wheel mixing, normalization, proportional power |
| **Git focus** | separate calculation and hardware-test commits |
| **AI tutor** | trace signs and boundary cases instead of replacing the method |

## Your goal

By the end of this lesson, you can:

- explain the contribution of forward, right, and rotation to each wheel;
- calculate raw wheel powers for a simple command;
- normalize values without changing their proportions;
- enforce a mentor-approved training-speed limit; and
- drive the robot relative to its own front.

## Get ready

Keep the wheels raised for the calculation checks. Confirm that the direction
test from 3.2 and heading test from 3.3 both pass.

Open `MecanumDrive.java` and add this constant near the hardware-name constants:

```java
private static final double MAX_SPEED = 0.35;
```

`0.35` is an example training limit. Replace it with the value in the team's
verified robot contract. It must remain between `0.0` and `1.0`.

## Watch 13:03–the four wheel equations

Resume the [video at 13:03](https://www.youtube.com/watch?v=sFCO4du5IZk&t=783s).
Pause as soon as all four raw wheel-power expressions are on screen.

Add the method and only its first four calculations:

```java
public void driveRobotRelative(double forward, double right, double rotate) {
    double frontLeftPower = forward + right + rotate;
    double frontRightPower = forward - right - rotate;
    double backRightPower = forward + right - rotate;
    double backLeftPower = forward - right + rotate;
}
```

Each input contributes to every wheel:

| Request | Front left | Front right | Back left | Back right |
|---|---:|---:|---:|---:|
| Forward | + | + | + | + |
| Right | + | − | − | + |
| Counterclockwise rotation | + | − | + | − |

These signs assume the motor directions were corrected in `initialize(...)`.

### Predict before continuing

Calculate the four raw values:

| `forward` | `right` | `rotate` | FL | FR | BL | BR |
|---:|---:|---:|---:|---:|---:|---:|
| 1.0 | 0.0 | 0.0 | | | | |
| 0.0 | 1.0 | 0.0 | | | | |
| 0.0 | 0.0 | 1.0 | | | | |
| 1.0 | 1.0 | 0.0 | | | | |

The last row produces values outside the legal motor-power range. Clipping each
wheel separately would distort the requested direction, so the method will scale
all four by the same amount.

## Resume until normalization is complete

Continue the video and pause after the four `Math.max(...)` lines.

Add this below the raw calculations:

```java
double maxPower = 1.0;
maxPower = Math.max(maxPower, Math.abs(frontLeftPower));
maxPower = Math.max(maxPower, Math.abs(frontRightPower));
maxPower = Math.max(maxPower, Math.abs(backRightPower));
maxPower = Math.max(maxPower, Math.abs(backLeftPower));
```

Starting at `1.0` matters:

- if every raw value is already between −1 and 1, division will not increase it;
- if one magnitude exceeds 1, that magnitude becomes the common divisor; and
- every wheel keeps the same ratio to the others.

For `forward = 1.0`, `right = 1.0`, and `rotate = 0.0`, the raw front-left and
back-right values are `2.0`. Dividing every value by `2.0` keeps the requested
diagonal direction while bringing all outputs into range.

## Resume until motor power is applied

Finish the **Robot Orientated Drive Method** chapter at 19:31. Add:

```java
frontLeftDrive.setPower(MAX_SPEED * frontLeftPower / maxPower);
frontRightDrive.setPower(MAX_SPEED * frontRightPower / maxPower);
backLeftDrive.setPower(MAX_SPEED * backLeftPower / maxPower);
backRightDrive.setPower(MAX_SPEED * backRightPower / maxPower);
```

Read one line from right to left:

1. Divide the raw value by the common maximum.
2. Multiply by the approved maximum speed.
3. Send the result to the correct motor.

## Create the robot-relative OpMode

Create `RobotRelativeDriveOpMode.java`:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.OpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive;

@TeleOp(name = "L3 Robot Relative Drive", group = "Level 3")
public final class RobotRelativeDriveOpMode extends OpMode {
    private final MecanumDrive drive = new MecanumDrive();

    @Override
    public void init() {
        drive.initialize(hardwareMap);
        telemetry.addData("Status", "Initialized; wheels must be raised");
        telemetry.update();
    }

    @Override
    public void loop() {
        double forward = -gamepad1.left_stick_y;
        double right = gamepad1.left_stick_x;
        double rotate = gamepad1.right_stick_x;

        drive.driveRobotRelative(forward, right, rotate);

        telemetry.addData("Mode", "Robot relative");
        telemetry.addData("Forward", "%.2f", forward);
        telemetry.addData("Right", "%.2f", right);
        telemetry.addData("Rotate", "%.2f", rotate);
        telemetry.update();
    }

    @Override
    public void stop() {
        drive.stop();
    }
}
```

Unlike `LinearOpMode`, an iterative `OpMode` separates `init()`, repeated
`loop()` calls, and `stop()`. Do not add your own inner loop or `sleep()`.

## Test in two stages

### Stage 1 — Wheels raised

| Input | Verify |
|---|---|
| Left stick forward | All wheels indicate robot-forward motion. |
| Left stick right | Wheel directions indicate a right strafe. |
| Right stick right | Wheel directions indicate a clockwise turn. |
| Both sticks released | All four wheels stop. |
| Driver Station Stop | All four wheels stop immediately. |

### Stage 2 — Floor test

After a mentor approves Stage 1, clear the floor and drive at the training limit:

| Input | Verify |
|---|---|
| Forward and backward | Motion follows the robot's front and rear. |
| Left and right | Robot strafes without an unexpected turn. |
| Rotate | Robot turns in place with the expected stick direction. |
| Combined translation and rotation | Motion remains controllable and no output exceeds the training limit. |

Fix configuration and direction errors before changing formulas.

## Git checkpoints

Commit the calculation first:

```text
Add normalized robot-relative mecanum calculation
```

After both physical test stages pass, commit the OpMode:

```text
Verify robot-relative mecanum drive
```

## Ask your AI tutor

> Trace my four wheel calculations for forward, right strafe, clockwise turn,
> and a combined command. Verify normalization preserves ratios and every final
> output stays within the configured training limit. Do not replace the method
> with a library call.

## Check your work

- [ ] I can explain each sign in the wheel-mixing table.
- [ ] Combined inputs are normalized with one common divisor.
- [ ] The approved training limit is applied after normalization.
- [ ] Robot-relative forward follows the robot after it turns.
- [ ] Releasing the sticks and pressing Stop both stop every wheel.

Continue to [3.5](../05-field-relative-mecanum-drive/README.md) to rotate the
driver's request by the measured heading.

## Reflect

Why does independently clipping four raw wheel powers change the direction the
driver requested?
