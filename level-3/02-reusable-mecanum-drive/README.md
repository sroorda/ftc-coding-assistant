# 3.2: Build a Reusable Mecanum Drive

Level 2 moved repeated hardware setup out of an OpMode. You will use the same
pattern for four drivetrain motors: the OpMode will decide what the driver wants,
while `MecanumDrive` will own motor names, directions, modes, and power output.

## Your mission

| | |
|---|---|
| **Time** | 75–90 minutes |
| **FTC focus** | four-motor mapping, direction, braking, encoder run mode |
| **Git focus** | commit configuration separately from drive mathematics |
| **AI tutor** | compare code with the robot contract and SDK sample |

## Your goal

By the end of this lesson, you can:

- map four drive motors in one reusable class;
- explain why one side of a typical drivetrain is reversed;
- select `RUN_USING_ENCODER` when encoder wires are connected;
- start and stop every drive motor safely; and
- verify individual wheel identity before adding mecanum equations.

## Get ready

Confirm the robot contract from 3.1. Raise the drive wheels clear of the floor,
secure the robot, keep hands and cables away from the wheels, and identify who
will press Driver Station **Stop**.

Create:

```text
org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive
```

## Watch from 5:10 — Create and map the class

Resume the [mecanum-drive video at 5:10](https://www.youtube.com/watch?v=sFCO4du5IZk&t=310s).
Pause after all four motors have been retrieved from `hardwareMap`.

Enter the class, replacing the four configuration-name values with the verified
names from your robot contract:

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;

public final class MecanumDrive {
    private static final String FRONT_LEFT_NAME = "front_left_drive";
    private static final String FRONT_RIGHT_NAME = "front_right_drive";
    private static final String BACK_LEFT_NAME = "back_left_drive";
    private static final String BACK_RIGHT_NAME = "back_right_drive";

    private DcMotor frontLeftDrive;
    private DcMotor frontRightDrive;
    private DcMotor backLeftDrive;
    private DcMotor backRightDrive;

    public void initialize(HardwareMap hardwareMap) {
        frontLeftDrive =
                hardwareMap.get(DcMotor.class, FRONT_LEFT_NAME);
        frontRightDrive =
                hardwareMap.get(DcMotor.class, FRONT_RIGHT_NAME);
        backLeftDrive =
                hardwareMap.get(DcMotor.class, BACK_LEFT_NAME);
        backRightDrive =
                hardwareMap.get(DcMotor.class, BACK_RIGHT_NAME);
    }
}
```

Build now. A successful build proves the package, imports, names, and syntax are
valid Java. It does not prove that the configuration names exist on the robot;
that happens when you press INIT.

## Resume through 10:45 — Direction and run mode

Resume the video and pause when **IMU Initialization** begins.

Add this configuration immediately after the four `hardwareMap.get(...)` calls:

```java
frontLeftDrive.setDirection(DcMotor.Direction.REVERSE);
backLeftDrive.setDirection(DcMotor.Direction.REVERSE);
frontRightDrive.setDirection(DcMotor.Direction.FORWARD);
backRightDrive.setDirection(DcMotor.Direction.FORWARD);

frontLeftDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
frontRightDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
backLeftDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
backRightDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);

frontLeftDrive.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
frontRightDrive.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
backLeftDrive.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
backRightDrive.setMode(DcMotor.RunMode.RUN_USING_ENCODER);

stop();
```

The video and FIRST SDK sample use `RUN_USING_ENCODER` so the motor controller
uses encoder feedback while applying requested power. Keep it only when all four
encoder cables are connected and verified. If the team's drivetrain intentionally
has no encoder feedback, document that decision and use `RUN_WITHOUT_ENCODER` for
all four motors.

The direction values shown are common, not universal. If the physical direction
test fails, correct these values to match the robot. Do not hide a bad direction
by changing the mecanum equations later.

## Add controlled test and stop operations

Add these methods below `initialize(...)`:

```java
public void setTestPowers(
        double frontLeft,
        double frontRight,
        double backLeft,
        double backRight) {
    frontLeftDrive.setPower(frontLeft);
    frontRightDrive.setPower(frontRight);
    backLeftDrive.setPower(backLeft);
    backRightDrive.setPower(backRight);
}

public void stop() {
    if (frontLeftDrive != null) {
        frontLeftDrive.setPower(0.0);
        frontRightDrive.setPower(0.0);
        backLeftDrive.setPower(0.0);
        backRightDrive.setPower(0.0);
    }
}
```

`setTestPowers(...)` exists for the raised-wheel verification. Later drive
methods will calculate these four values for you. `stop()` gives every OpMode one
clear way to command all drivetrain outputs to zero.

## Create the direction-test OpMode

Create `MecanumDirectionTestOpMode.java` in the `level3` package:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive;

@TeleOp(name = "L3 Mecanum Direction Test", group = "Level 3")
public final class MecanumDirectionTestOpMode extends LinearOpMode {
    private static final double TEST_POWER = 0.15;

    @Override
    public void runOpMode() {
        MecanumDrive drive = new MecanumDrive();
        drive.initialize(hardwareMap);

        telemetry.addData("Status", "Ready; wheels must be raised");
        telemetry.update();
        waitForStart();

        if (!opModeIsActive()) {
            drive.stop();
            return;
        }

        drive.setTestPowers(
                TEST_POWER,
                TEST_POWER,
                TEST_POWER,
                TEST_POWER);

        while (opModeIsActive()) {
            telemetry.addData("Expected", "All wheels drive robot forward");
            telemetry.update();
        }

        drive.stop();
    }
}
```

This deliberately uses only 15% power. Driver Station Stop ends the loop and
calls `drive.stop()`.

## Test — Motor identity and direction

With wheels raised:

| Test | Verify |
|---|---|
| Press **INIT**. | All four configured motors are found; no wheel moves. |
| Press **PLAY**. | All four wheels indicate forward robot motion. |
| Press **Stop**. | Every wheel stops immediately. |
| Disconnect one configured motor in software only during a mentor-led test. | INIT reports the configuration error instead of silently selecting another motor. |

If a wheel is wrong, check the contract, wiring, configuration name, motor
placement, and direction setting—in that order.

## Git checkpoint — Reusable drivetrain hardware

Commit the class and direction-test OpMode:

```text
Add verified mecanum drive hardware class
```

## Ask your AI tutor

> Compare my MecanumDrive initialization with my robot-contract table and the
> FIRST SDK sample. Identify mismatched names, inconsistent run modes, missing
> stop paths, or direction assumptions. Do not change the wheel equations because
> I have not added them yet.

## Check your work

- [ ] INIT maps all four verified configuration names.
- [ ] INIT leaves all motors at zero power.
- [ ] All four wheels indicate forward motion during the raised-wheel test.
- [ ] Stop commands all four motors to zero.
- [ ] The selected run mode matches the encoder wiring.

Continue to [3.3](../03-imu-orientation-and-heading/README.md) to initialize the
heading sensor.

## Reflect

Why should a direction problem be corrected in hardware configuration rather
than compensated for inside the mecanum formula?
