# 3.5: Field-Relative Mecanum Drive

Robot-relative drive now converts a command into four verified wheel powers.
Field-relative drive will not replace that work. It will rotate the driver's
forward/right request into the robot's coordinate frame and call the tested
method.

## Your mission

| | |
|---|---|
| **Time** | 75–90 minutes |
| **FTC focus** | vector magnitude, angle, yaw compensation, method reuse |
| **Git focus** | add one coordinate transformation without rewriting drive output |
| **AI tutor** | trace coordinate values at known headings |

## Your goal

By the end of this lesson, you can:

- describe a joystick request as a direction and magnitude;
- explain why robot heading is subtracted from the requested direction;
- convert the result back into robot-relative forward and right values;
- reuse `driveRobotRelative(...)` for final wheel output; and
- compare robot-relative and field-relative behavior on the same robot.

## Get ready

Do not begin until:

- the robot-relative floor test from 3.4 passes;
- the IMU heading test from 3.3 passes;
- the robot has a marked field-forward starting direction; and
- the driver can reach Driver Station Stop without entering the test area.

## Watch 19:31–the polar conversion

Resume the [video at 19:31](https://www.youtube.com/watch?v=sFCO4du5IZk&t=1171s).
Pause after `theta` and `r` have been calculated.

Add this new method to `MecanumDrive`:

```java
public void driveFieldRelative(double forward, double right, double rotate) {
    double theta = Math.atan2(forward, right);
    double r = Math.hypot(right, forward);
}
```

The gamepad supplies Cartesian components:

- `right` is the horizontal component;
- `forward` is the vertical component;
- `theta` is the requested direction; and
- `r` is the requested distance from the stick center, or magnitude.

`Math.atan2(forward, right)` safely determines the angle in every quadrant.
`Math.hypot(right, forward)` calculates the vector magnitude.

## Resume until heading is subtracted

Pause after the call to `getYaw(AngleUnit.RADIANS)`. Add:

```java
theta = AngleUnit.normalizeRadians(
        theta - getHeadingRadians());
```

Suppose the robot is turned 90° counterclockwise while the driver still requests
field forward. The requested field angle has not changed, but the robot's front
has. Subtracting the robot heading expresses the same request from the robot's
new point of view.

`normalizeRadians(...)` keeps the angle in a predictable range around one full
rotation.

## Resume through 23:03 — Convert and reuse

Finish the **Field Orientated Drive Method** chapter. Add:

```java
double robotForward = r * Math.sin(theta);
double robotRight = r * Math.cos(theta);

driveRobotRelative(robotForward, robotRight, rotate);
```

The last line is the important design decision. Heading changes the translation
request, but rotation remains the driver's direct turn request. The tested
robot-relative method still owns wheel mixing, normalization, the training limit,
and hardware output.

The complete field-relative method is:

```java
public void driveFieldRelative(double forward, double right, double rotate) {
    double theta = Math.atan2(forward, right);
    double r = Math.hypot(right, forward);

    theta = AngleUnit.normalizeRadians(
            theta - getHeadingRadians());

    double robotForward = r * Math.sin(theta);
    double robotRight = r * Math.cos(theta);

    driveRobotRelative(robotForward, robotRight, rotate);
}
```

This follows FIRST's `RobotTeleopMecanumFieldRelativeDrive` SDK sample. The
course names the transformed values explicitly to show the boundary between
field and robot coordinates.

## Predict at known headings

Assume the driver pushes the left stick field-forward and requests no rotation:

| Robot yaw | Expected robot-relative request |
|---:|---|
| 0° | forward |
| +90° | strafe in the direction that still moves field-forward |
| 180° or −180° | backward |
| −90° | opposite strafe direction |

Work through one row with `theta`, `r`, `robotForward`, and `robotRight` before
testing hardware. Exact floating-point results near zero may appear as a very
small positive or negative number.

## Temporarily select field-relative drive

In `RobotRelativeDriveOpMode.loop()`, temporarily replace:

```java
drive.driveRobotRelative(forward, right, rotate);
```

with:

```java
if (gamepad1.crossWasPressed()) {
    drive.resetHeading();
}

drive.driveFieldRelative(forward, right, rotate);
```

Also change the telemetry mode to `"Field relative"`. Lesson 3.6 will create the
final OpMode and allow both modes for comparison. Reset heading in this same
OpMode after pointing the robot field-forward; do not rely on a reset performed
by a previously stopped OpMode.

## Test — Same field direction, different headings

Start the drive OpMode, point the robot field-forward, and press Cross (✕) to
establish zero before moving the sticks:

| Test | Verify |
|---|---|
| Robot at 0°, stick forward | Robot moves field-forward. |
| Robot near +90°, stick forward | Robot still moves field-forward. |
| Robot near 180°, stick forward | Robot still moves field-forward. |
| Right stick only | Robot rotates normally at every heading. |
| Translate while rotating | Translation remains attached to the field. |
| Release both sticks or press Stop | Every wheel stops. |

If the 0° test fails, return to robot-relative drive. If 0° works but the 90° or
180° tests fail, inspect IMU orientation, heading sign, reset procedure, and the
field-relative transform.

## Check the assembled `MecanumDrive`

Compare your class with this completed learning version. Keep your team's
verified names, directions, hub orientation, and power limit:

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.hardware.rev.RevHubOrientationOnRobot;
import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.hardware.IMU;

import org.firstinspires.ftc.robotcore.external.navigation.AngleUnit;

public final class MecanumDrive {
    private static final String FRONT_LEFT_NAME = "front_left_drive";
    private static final String FRONT_RIGHT_NAME = "front_right_drive";
    private static final String BACK_LEFT_NAME = "back_left_drive";
    private static final String BACK_RIGHT_NAME = "back_right_drive";
    private static final double MAX_SPEED = 0.35;

    private DcMotor frontLeftDrive;
    private DcMotor frontRightDrive;
    private DcMotor backLeftDrive;
    private DcMotor backRightDrive;
    private IMU imu;

    public void initialize(HardwareMap hardwareMap) {
        frontLeftDrive =
                hardwareMap.get(DcMotor.class, FRONT_LEFT_NAME);
        frontRightDrive =
                hardwareMap.get(DcMotor.class, FRONT_RIGHT_NAME);
        backLeftDrive =
                hardwareMap.get(DcMotor.class, BACK_LEFT_NAME);
        backRightDrive =
                hardwareMap.get(DcMotor.class, BACK_RIGHT_NAME);

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

        imu = hardwareMap.get(IMU.class, "imu");
        RevHubOrientationOnRobot orientationOnRobot =
                new RevHubOrientationOnRobot(
                        RevHubOrientationOnRobot.LogoFacingDirection.UP,
                        RevHubOrientationOnRobot.UsbFacingDirection.FORWARD);
        imu.initialize(new IMU.Parameters(orientationOnRobot));
    }

    public void driveFieldRelative(double forward, double right, double rotate) {
        double theta = Math.atan2(forward, right);
        double r = Math.hypot(right, forward);

        theta = AngleUnit.normalizeRadians(theta - getHeadingRadians());

        double robotForward = r * Math.sin(theta);
        double robotRight = r * Math.cos(theta);

        driveRobotRelative(robotForward, robotRight, rotate);
    }

    public void driveRobotRelative(double forward, double right, double rotate) {
        double frontLeftPower = forward + right + rotate;
        double frontRightPower = forward - right - rotate;
        double backRightPower = forward + right - rotate;
        double backLeftPower = forward - right + rotate;

        double maxPower = 1.0;
        maxPower = Math.max(maxPower, Math.abs(frontLeftPower));
        maxPower = Math.max(maxPower, Math.abs(frontRightPower));
        maxPower = Math.max(maxPower, Math.abs(backRightPower));
        maxPower = Math.max(maxPower, Math.abs(backLeftPower));

        setTestPowers(
                MAX_SPEED * frontLeftPower / maxPower,
                MAX_SPEED * frontRightPower / maxPower,
                MAX_SPEED * backLeftPower / maxPower,
                MAX_SPEED * backRightPower / maxPower);
    }

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

    public double getHeadingRadians() {
        return imu.getRobotYawPitchRollAngles().getYaw(AngleUnit.RADIANS);
    }

    public double getHeadingDegrees() {
        return imu.getRobotYawPitchRollAngles().getYaw(AngleUnit.DEGREES);
    }

    public void resetHeading() {
        imu.resetYaw();
    }

    public void stop() {
        if (frontLeftDrive != null) {
            setTestPowers(0.0, 0.0, 0.0, 0.0);
        }
    }
}
```

## Git checkpoint — Field transformation

```text
Add field-relative mecanum transformation
```

## Ask your AI tutor

> Trace field-forward input through theta, magnitude, heading subtraction,
> robotForward, robotRight, and the robot-relative method at headings 0°, 90°,
> and 180°. Use my coordinate names and identify the first value that disagrees
> with the expected motion.

## Check your work

- [ ] Field-relative drive calls the tested robot-relative method.
- [ ] IMU yaw and trigonometric calculations use radians.
- [ ] Translation stays field-relative as the robot turns.
- [ ] Rotation remains under direct driver control.
- [ ] The complete class still uses verified robot-specific constants.

Continue to [3.6](../06-driver-controls-and-teleop/README.md) to assemble the
driver-facing OpMode.

## Reflect

Why is the field-relative method easier to diagnose when it delegates final
wheel output to robot-relative drive?
