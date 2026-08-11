# Lesson 2: Robot-Centric Mecanum Drive

The direction test proved which Java field controls each wheel. Now you will turn
three driver requests—forward, strafe, and turn—into four wheel commands.

You will begin with the same mecanum calculation used by the FTC SDK's
`BasicOmniOpMode_Linear` sample. We will rename its axes, walk through the math,
normalize combined commands, apply a training limit, and send the result through
the `DriveHardware` boundary from Lesson 1.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | robot-centric axes, mecanum mixing, normalization, controlled floor test |
| **Git focus** | keep the verified hardware mapping unchanged while adding drive behavior |
| **AI tutor** | check signs and calculations against named test cases |

## Your goal

By the end of this lesson, you can:

- explain robot-centric forward, strafe, and turn commands;
- calculate the four mecanum wheel powers for a pure or combined request;
- normalize wheel powers without changing their ratios;
- explain why joystick Y needs one sign change; and
- drive forward, strafe, and turn at a reviewed training scale.

## Get ready

Merge the reviewed Lesson 1 work into your cumulative branch, then create:

```text
feature/<your-name>/robot-centric-drive
```

Confirm that the complete direction test still passes before changing drive
behavior. Create `RobotCentricDriveOpMode.java` in the Level 3 package.

## Part 1 — Name the three robot motions

The SDK omni-drive sample calls the three requests **axial**, **lateral**, and
**yaw**. This course uses names that describe what the driver sees:

| Course name | SDK sample name | Positive request |
|---|---|---|
| `forward` | `axial` | move toward the robot's physical front |
| `strafe` | `lateral` | move toward the robot's right |
| `turn` | `yaw` | rotate clockwise when viewed from above |

These are **robot-centric** directions. If the robot turns around, pushing the
stick forward still commands motion toward the robot's front, not toward a fixed
side of the field.

Use these gamepad axes:

```java
double forward = -gamepad1.left_stick_y;
double strafe = gamepad1.left_stick_x;
double turn = gamepad1.right_stick_x;
```

FTC gamepads report a negative left-stick Y value when the driver pushes the stick
forward. The one leading minus sign turns that raw convention into a positive
`forward` request. Do not reverse Y again in the mixer or hardware class.

## Part 2 — Predict the wheel patterns

For the verified wheel order from Lesson 1, calculate the four raw powers with:

```java
double frontLeftPower = forward + strafe + turn;
double frontRightPower = forward - strafe - turn;
double backLeftPower = forward - strafe + turn;
double backRightPower = forward + strafe - turn;
```

Each wheel receives some combination of the three requests. A plus or minus sign
does not directly describe motor shaft rotation because `setDirection(...)` has
already established what positive power means for each installed motor.

Before writing the OpMode, fill in the four raw commands for these inputs:

| Request | `forward` | `strafe` | `turn` | FL | FR | BL | BR |
|---|---:|---:|---:|---:|---:|---:|---:|
| No motion | `0` | `0` | `0` | | | | |
| Pure forward | `1` | `0` | `0` | | | | |
| Pure right strafe | `0` | `1` | `0` | | | | |
| Pure clockwise turn | `0` | `0` | `1` | | | | |
| Combined | `1` | `1` | `1` | | | | |

Check your first four rows against these sign patterns:

```text
no motion:       0   0   0   0
forward:         +   +   +   +
right strafe:    +   -   -   +
clockwise turn:  +   -   +   -
```

For `(1, 1, 1)`, the front-left raw command is `3`. A motor power outside
`[-1.0, 1.0]` cannot be applied as requested, so combined commands need another
step.

## Part 3 — Normalize combined commands

Find the largest absolute raw wheel command:

```java
double largestPower = Math.max(
        Math.abs(frontLeftPower),
        Math.abs(frontRightPower));
largestPower = Math.max(largestPower, Math.abs(backLeftPower));
largestPower = Math.max(largestPower, Math.abs(backRightPower));
```

If it is greater than `1.0`, divide all four values by the same number:

```java
if (largestPower > 1.0) {
    frontLeftPower /= largestPower;
    frontRightPower /= largestPower;
    backLeftPower /= largestPower;
    backRightPower /= largestPower;
}
```

For the combined row `(1, 1, 1)`, the raw wheel commands are:

```text
3, -1, 1, 1
```

Dividing every value by `3` produces approximately:

```text
1.00, -0.33, 0.33, 0.33
```

The ratio between the wheel commands remains the same. Clipping only the first
value from `3` to `1` would produce `1, -1, 1, 1`, which represents a different
motion.

## Part 4 — Apply the training scale

Add this class constant:

```java
private static final double TRAINING_SCALE = 0.35;
```

After normalization, multiply all four values by the scale:

```java
frontLeftPower *= TRAINING_SCALE;
frontRightPower *= TRAINING_SCALE;
backLeftPower *= TRAINING_SCALE;
backRightPower *= TRAINING_SCALE;
```

The example limits every applied drive command to 35% power. A mentor must approve
the actual value for the robot and test area. Do not raise it to correct wrong
directions, incorrect mixing, wheel slip, or a mechanical problem.

Normalization and scaling do different jobs:

- normalization keeps every result inside the motor API range while preserving
  the requested motion ratio;
- scaling limits the overall training speed after that ratio is correct.

## Part 5 — Build the complete OpMode

Enter this guided version:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.hardware.DriveHardware;

@TeleOp(name = "L3 Robot-Centric Drive", group = "Level 3")
public class RobotCentricDriveOpMode extends LinearOpMode {
    private static final double TRAINING_SCALE = 0.35;

    @Override
    public void runOpMode() {
        DriveHardware drive = new DriveHardware();
        drive.initialize(hardwareMap);

        telemetry.addData("Status", "Drive initialized");
        telemetry.addData("Training scale", "%.2f", TRAINING_SCALE);
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            double forward = -gamepad1.left_stick_y;
            double strafe = gamepad1.left_stick_x;
            double turn = gamepad1.right_stick_x;

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

            frontLeftPower *= TRAINING_SCALE;
            frontRightPower *= TRAINING_SCALE;
            backLeftPower *= TRAINING_SCALE;
            backRightPower *= TRAINING_SCALE;

            drive.setDrivePowers(
                    frontLeftPower,
                    frontRightPower,
                    backLeftPower,
                    backRightPower);

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
}
```

Read one pass through the loop from top to bottom:

1. read the three gamepad axes once;
2. convert the raw axes into named robot intent;
3. mix that intent into four raw wheel powers;
4. normalize only when a command is outside the valid range;
5. apply the reviewed training scale;
6. send all four commands through `DriveHardware`; and
7. report both intent and applied commands.

The loop contains no `sleep()`, encoder movement loop, or other wait. It must
return quickly so the next gamepad reading and Driver Station Stop are handled.

## Part 6 — Build before connecting

Build the `TeamCode` module. Inspect the feature diff and confirm that Lesson 1's
verified configuration names and directions did not change.

Use Driver Station telemetry with the robot disabled or wheels raised to check
the math first:

| Stick request | Expected command pattern |
|---|---|
| Centered | four values near zero |
| Forward only | four values with the same sign |
| Right strafe only | `+ - - +` |
| Clockwise turn only | `+ - + -` |
| Full combined input | no absolute value greater than `0.35` |

Small nonzero values with centered sticks are normal joystick drift. Do not solve
that yet; Lesson 3 adds a documented deadband.

## Part 7 — Test with the wheels raised

Follow the same safety setup as Lesson 1. Move only one axis at a time:

| Test | Verify |
|---|---|
| Push left stick forward slowly. | All wheels produce the physical rotation that previously meant robot forward. |
| Push left stick right slowly. | Wheel rotation matches the predicted `+ - - +` strafe pattern. |
| Push right stick right slowly. | Wheel rotation matches the predicted `+ - + -` turn pattern. |
| Move both sticks. | Commands remain within the training scale and change smoothly. |
| Release both sticks. | Commands return near zero; drift may remain until Lesson 3. |
| Press Driver Station **Stop**. | The OpMode ends and all drive commands are zero. |

If a pure input has the wrong command pattern in telemetry, inspect the mixer. If
telemetry has the correct pattern but one physical wheel is wrong, return to the
Lesson 1 contract and direction test. Do not change mixer signs to hide a hardware
mapping or direction error.

## Part 8 — Run the controlled floor test

Lower the robot only after the raised-wheel results match every prediction. Clear
a large test area, choose one driver, and keep Stop immediately available.

Use short, low-stick requests:

| Floor test | Verify |
|---|---|
| Forward only | The robot translates toward its marked front without a strong strafe or turn. |
| Backward only | The robot reverses the forward motion. |
| Right and left strafe | The robot moves sideways in both directions. |
| Clockwise and counterclockwise turn | The robot rotates in both directions. |
| Combined input | The robot blends motions and remains limited to the training scale. |

Mecanum robots may drift because of weight distribution, wheel contact, friction,
or construction. Record the observation before changing software. This lesson
verifies the basic mapping and mixer; it does not tune closed-loop driving.

## How this relates to the FTC SDK example

The mix and normalization follow `BasicOmniOpMode_Linear`. This course version:

- uses `forward`, `strafe`, and `turn` instead of `axial`, `lateral`, and `yaw`;
- reuses the verified `DriveHardware` class instead of remapping devices;
- applies a separate, reviewed training scale;
- makes the explicit final stop visible; and
- explains how to distinguish a math error from a direction error.

You should be able to move between the sample and this OpMode and point to the
corresponding lines.

## Git checkpoint

Commit the OpMode separately from any test-evidence document, for example:

```text
Add reduced-power robot-centric drive
```

The pull request should include the completed prediction table, raised-wheel
results, floor-test results, approved scale, and any observed mechanical drift.

## Ask your AI tutor

> Review my robot-centric drive diff without editing. Calculate the expected four
> wheel commands for zero, pure forward, pure strafe, pure turn, and `(1, 1, 1)`.
> Check that normalization preserves ratios, scaling happens after normalization,
> the Y sign changes once, and the final stop reaches all four motors.

## Check your work

You are finished when:

- pure inputs produce the predicted telemetry sign patterns;
- no applied command exceeds the approved training scale;
- raised-wheel and controlled floor tests agree with the robot contract;
- releasing the sticks and pressing Stop leave the drivetrain stopped;
- `DriveHardware` still owns mapping and directions; and
- the reviewed pull request contains math and physical evidence.

## Reflect

What evidence would show that the mecanum calculation is correct but one motor
direction is still wrong?

Continue to [Lesson 3: Turn Gamepad Input into Driver Intent](../03-driver-intent/README.md).
