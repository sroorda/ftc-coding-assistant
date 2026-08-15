# 3.3: Initialize and Verify the IMU

Field-relative drive needs to know how the robot is turned on the field. The
Control Hub's IMU can supply that heading only after the software knows how the
hub is physically mounted.

This lesson initializes the IMU and tests heading separately. The drivetrain
will remain stopped.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **FTC focus** | Control Hub orientation, yaw, radians, heading reset |
| **Git focus** | isolate sensor initialization from drive behavior |
| **AI tutor** | verify coordinate assumptions without guessing hub mounting |

## Your goal

By the end of this lesson, you can:

- identify the Control Hub logo and USB directions on the physical robot;
- initialize `RevHubOrientationOnRobot` with verified values;
- read yaw in degrees and radians;
- establish the field-forward heading with `resetYaw()`; and
- detect an incorrect orientation before enabling field-relative drive.

## Get ready

Keep the drive wheels raised or remove the robot battery from the drivetrain test
area. Find the Control Hub on the actual robot and complete:

| Physical fact | Verified value |
|---|---|
| Direction the REV logo faces | |
| Direction the USB ports face | |
| Robot direction used as field forward at start | |
| Driver control used to reset heading | Cross (✕), unless team contract says otherwise |

Do not infer these values from a photograph or from the video.

## Watch 10:45–13:03 — IMU initialization

Resume the [video at 10:45](https://www.youtube.com/watch?v=sFCO4du5IZk&t=645s).
Pause when **Robot Orientated Drive Method** begins.

The video uses logo **UP** and USB **FORWARD** as an example. Those values are
correct only if they describe your Control Hub's physical mounting.

## Add the IMU to `MecanumDrive`

Add these imports:

```java
import com.qualcomm.hardware.rev.RevHubOrientationOnRobot;
import com.qualcomm.robotcore.hardware.IMU;

import org.firstinspires.ftc.robotcore.external.navigation.AngleUnit;
```

Add this field:

```java
private IMU imu;
```

At the end of `initialize(HardwareMap hardwareMap)`, after `stop()`, add the
verified mounting values:

```java
imu = hardwareMap.get(IMU.class, "imu");

RevHubOrientationOnRobot.LogoFacingDirection logoDirection =
        RevHubOrientationOnRobot.LogoFacingDirection.UP;
RevHubOrientationOnRobot.UsbFacingDirection usbDirection =
        RevHubOrientationOnRobot.UsbFacingDirection.FORWARD;

RevHubOrientationOnRobot orientationOnRobot =
        new RevHubOrientationOnRobot(logoDirection, usbDirection);
imu.initialize(new IMU.Parameters(orientationOnRobot));
```

Replace `UP` and `FORWARD` when your table contains different verified values.
The `"imu"` configuration name is the standard Control Hub IMU name; confirm it
in the active configuration.

## Add heading operations

Add these methods to `MecanumDrive`:

```java
public double getHeadingRadians() {
    return imu.getRobotYawPitchRollAngles().getYaw(AngleUnit.RADIANS);
}

public double getHeadingDegrees() {
    return imu.getRobotYawPitchRollAngles().getYaw(AngleUnit.DEGREES);
}

public void resetHeading() {
    imu.resetYaw();
}
```

The field-relative calculation will use radians because Java's trigonometric
methods use radians. Degrees remain useful for readable telemetry.

`resetYaw()` does not rotate the robot. It declares the robot's current direction
to be zero, so point the robot toward the team's field-forward direction first.

## Create a heading-test OpMode

Create `HeadingTestOpMode.java`:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive;

@TeleOp(name = "L3 Heading Test", group = "Level 3")
public final class HeadingTestOpMode extends LinearOpMode {
    @Override
    public void runOpMode() {
        MecanumDrive drive = new MecanumDrive();
        drive.initialize(hardwareMap);

        telemetry.addData("Status", "Point robot field-forward");
        telemetry.addData("Heading degrees", "%.1f", drive.getHeadingDegrees());
        telemetry.update();
        waitForStart();

        while (opModeIsActive()) {
            if (gamepad1.crossWasPressed()) {
                drive.resetHeading();
            }

            telemetry.addData("Cross (X)", "Reset heading");
            telemetry.addData("Heading degrees", "%.1f", drive.getHeadingDegrees());
            telemetry.addData("Heading radians", "%.3f", drive.getHeadingRadians());
            telemetry.update();
        }

        drive.stop();
    }
}
```

## Test — Heading evidence

Do not command motor power during these tests:

| Action | Expected evidence |
|---|---|
| Point robot field-forward and press **Cross (✕)**. | Heading becomes approximately 0°. |
| Turn robot counterclockwise about 90°. | Heading changes smoothly by approximately 90° with the expected sign. |
| Turn robot clockwise about 180°. | Heading changes smoothly in the opposite direction. |
| Tilt the robot slightly without changing its field direction. | Yaw remains a meaningful heading rather than swapping axes. |
| Restart the OpMode. | Heading behavior remains consistent with the documented reset procedure. |

Small measurement error is normal. A reversed axis, discontinuous value, or yaw
that changes mainly when the robot tips indicates an orientation problem that
must be fixed before 3.5.

## Git checkpoint — Verified heading

Commit the IMU initialization and test separately from drivetrain mathematics:

```text
Add verified drivetrain heading
```

## Ask your AI tutor

> Review my IMU initialization and heading-test results. Ask me for the physical
> logo and USB directions before judging the constants. Explain any sign or axis
> mismatch, but do not add field-relative drive code yet.

## Check your work

- [ ] The logo and USB directions were inspected on the physical robot.
- [ ] INIT succeeds without moving a wheel.
- [ ] Cross (✕) resets the field-forward direction to approximately zero.
- [ ] Turning the robot changes yaw smoothly and predictably.
- [ ] I know why the calculation will use radians but telemetry uses degrees.

Continue to [3.4](../04-robot-relative-mecanum-drive/README.md) to calculate and
test the four wheel powers.

## Reflect

What observable symptom would tell you that the hub orientation is wrong even
though the Java code compiles?
