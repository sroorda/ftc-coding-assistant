# Lesson 1: Map the Robot Before Moving It

A four-motor drivetrain can compile successfully while the wrong wheel moves, a
wheel spins backward, or a motor keeps its previous power. Before writing drive
math, you need a trustworthy connection between the physical robot, the Driver
Station configuration, and Java.

In this lesson, you will record that connection, build a small drive-hardware
class, and use a low-power OpMode to verify one motor at a time.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | configuration names, motor direction, zero-power behavior, safe stop |
| **Git focus** | separate the hardware contract from the code that uses it |
| **AI tutor** | compare names and code without inventing physical facts |

## Your goal

By the end of this lesson, you can:

- identify each drive motor by its physical corner, configured name, and Java
  field;
- explain why a motor direction is a fact to test rather than a value to guess;
- initialize all four drive motors in a safe state;
- command one selected motor while the other three remain stopped; and
- stop the complete drivetrain through one method.

## Get ready

Complete the [Level 2 readiness checkpoint](../../levels/02-hardware-lab.md#your-next-checkpoint)
before beginning. Update your cumulative student branch, then create:

```text
feature/<your-name>/drive-contract
```

Level 3 code belongs in these packages:

```text
org.firstinspires.ftc.teamcode.level3
org.firstinspires.ftc.teamcode.level3.hardware
org.firstinspires.ftc.teamcode.level3.subsystems
```

Do not move or rename your Level 2 files. Level 3 will reuse the ideas you tested
there while keeping the new robot code separate.

Before any powered test, a mentor must confirm:

- which side of the robot is the front;
- that the mecanum rollers form the required pattern for the team's drivetrain;
- the four motor ports and active Driver Station configuration names;
- how the wheels will be raised or the robot otherwise secured;
- the training power limit; and
- who will keep the Driver Station Stop control available.

## Part 1 — Read the SDK example as a reference

Open the FTC SDK sample named `BasicOmniOpMode_Linear`. In this course's SDK
project it appears under the read-only `FtcRobotController` sample package.

Do not edit the sample. Find these four ideas in it:

1. four calls to `hardwareMap.get(...)`;
2. four explicit motor directions;
3. a commented one-button-per-motor test block; and
4. four calls to `setPower(...)`.

The sample is a useful starting point, not a description of your physical robot.
Its default configuration names are:

```text
front_left_drive
front_right_drive
back_left_drive
back_right_drive
```

We will use those names in the walkthrough. If the team's reviewed configuration
uses different names, change the constants in one place after recording the real
names in the contract below.

## Part 2 — Create the robot hardware contract

In the team's robot repository, create or update a short hardware-contract page.
Use a filename agreed on by the team, such as `docs/ROBOT_HARDWARE.md`.

Stand behind the robot and draw it from above. Mark the front, left, and right.
Then trace every drive-motor wire and complete this table:

| Robot corner | Hub and port | Driver Station name | Java field | Direction in code | Verified? |
|---|---|---|---|---|---|
| Front left | | | `frontLeftDrive` | | No |
| Front right | | | `frontRightDrive` | | No |
| Back left | | | `backLeftDrive` | | No |
| Back right | | | `backRightDrive` | | No |

The table begins as a prediction. A direction does not become verified because it
looks like the SDK sample. It becomes verified when the named physical wheel is
observed during the controlled test later in this lesson.

Commit the contract before writing the hardware class. A useful commit message is:

```text
Document drivetrain hardware contract
```

That commit lets a reviewer inspect changes to physical facts separately from
changes to Java.

## Part 3 — Create `DriveHardware`

Create this file:

```text
org.firstinspires.ftc.teamcode.level3.hardware.DriveHardware
```

Start with the package, imports, configuration constants, and private motor fields:

```java
package org.firstinspires.ftc.teamcode.level3.hardware;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;

public final class DriveHardware {
    private static final String FRONT_LEFT_NAME = "front_left_drive";
    private static final String FRONT_RIGHT_NAME = "front_right_drive";
    private static final String BACK_LEFT_NAME = "back_left_drive";
    private static final String BACK_RIGHT_NAME = "back_right_drive";

    private DcMotor frontLeftDrive;
    private DcMotor frontRightDrive;
    private DcMotor backLeftDrive;
    private DcMotor backRightDrive;
}
```

Change the four quoted values only if the reviewed robot contract uses different
names. The constants keep configuration strings out of the OpMode. The private
fields prevent an OpMode from bypassing the operations this class will provide.

### Map the four motors

Add this method inside the class:

```java
public void initialize(HardwareMap hardwareMap) {
    frontLeftDrive = hardwareMap.get(DcMotor.class, FRONT_LEFT_NAME);
    frontRightDrive = hardwareMap.get(DcMotor.class, FRONT_RIGHT_NAME);
    backLeftDrive = hardwareMap.get(DcMotor.class, BACK_LEFT_NAME);
    backRightDrive = hardwareMap.get(DcMotor.class, BACK_RIGHT_NAME);
}
```

`hardwareMap.get(...)` connects a Java field to a device in the active robot
configuration. If one name or device type is wrong, INIT should fail visibly. Do
not catch that error and continue with a partly initialized drivetrain.

### Apply safe initial settings

At the end of `initialize(...)`, add:

```java
frontLeftDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
frontRightDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
backLeftDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
backRightDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);

frontLeftDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
frontRightDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
backLeftDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
backRightDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);

frontLeftDrive.setDirection(DcMotor.Direction.REVERSE);
backLeftDrive.setDirection(DcMotor.Direction.REVERSE);
frontRightDrive.setDirection(DcMotor.Direction.FORWARD);
backRightDrive.setDirection(DcMotor.Direction.FORWARD);

stopDrive();
```

These directions match the current `BasicOmniOpMode_Linear` SDK example. They are
initial predictions, not universal mecanum settings. Gearboxes, motor placement,
and chain or belt routing can require a different direction for one or more motors.

`BRAKE` makes a motor resist rotation when commanded power is zero. It does not
hold an exact encoder position. `RUN_WITHOUT_ENCODER` selects simple open-loop
power control explicitly so the drivetrain does not inherit a target-position
mode from earlier code. Calling `stopDrive()` during initialization makes the
desired starting command explicit.

### Add one command boundary

Add these methods below `initialize(...)`:

```java
public void setDrivePowers(
        double frontLeftPower,
        double frontRightPower,
        double backLeftPower,
        double backRightPower) {
    frontLeftDrive.setPower(frontLeftPower);
    frontRightDrive.setPower(frontRightPower);
    backLeftDrive.setPower(backLeftPower);
    backRightDrive.setPower(backRightPower);
}

public void stopDrive() {
    setDrivePowers(0.0, 0.0, 0.0, 0.0);
}
```

`setDrivePowers(...)` is the one place where four calculated wheel commands cross
into hardware. `stopDrive()` cannot accidentally omit a motor because it uses the
same boundary.

### Add telemetry getters

The OpMode needs to report the commands without exposing the motor fields. Add:

```java
public double getFrontLeftPower() {
    return frontLeftDrive.getPower();
}

public double getFrontRightPower() {
    return frontRightDrive.getPower();
}

public double getBackLeftPower() {
    return backLeftDrive.getPower();
}

public double getBackRightPower() {
    return backRightDrive.getPower();
}
```

These methods report the last requested power. They do not prove wheel speed or
robot movement; only an encoder or physical observation can provide that evidence.

### Check the complete class

Compare your assembled file with this version:

```java
package org.firstinspires.ftc.teamcode.level3.hardware;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;

public final class DriveHardware {
    private static final String FRONT_LEFT_NAME = "front_left_drive";
    private static final String FRONT_RIGHT_NAME = "front_right_drive";
    private static final String BACK_LEFT_NAME = "back_left_drive";
    private static final String BACK_RIGHT_NAME = "back_right_drive";

    private DcMotor frontLeftDrive;
    private DcMotor frontRightDrive;
    private DcMotor backLeftDrive;
    private DcMotor backRightDrive;

    public void initialize(HardwareMap hardwareMap) {
        frontLeftDrive = hardwareMap.get(DcMotor.class, FRONT_LEFT_NAME);
        frontRightDrive = hardwareMap.get(DcMotor.class, FRONT_RIGHT_NAME);
        backLeftDrive = hardwareMap.get(DcMotor.class, BACK_LEFT_NAME);
        backRightDrive = hardwareMap.get(DcMotor.class, BACK_RIGHT_NAME);

        frontLeftDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        frontRightDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        backLeftDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        backRightDrive.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);

        frontLeftDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
        frontRightDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
        backLeftDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
        backRightDrive.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);

        frontLeftDrive.setDirection(DcMotor.Direction.REVERSE);
        backLeftDrive.setDirection(DcMotor.Direction.REVERSE);
        frontRightDrive.setDirection(DcMotor.Direction.FORWARD);
        backRightDrive.setDirection(DcMotor.Direction.FORWARD);

        stopDrive();
    }

    public void setDrivePowers(
            double frontLeftPower,
            double frontRightPower,
            double backLeftPower,
            double backRightPower) {
        frontLeftDrive.setPower(frontLeftPower);
        frontRightDrive.setPower(frontRightPower);
        backLeftDrive.setPower(backLeftPower);
        backRightDrive.setPower(backRightPower);
    }

    public void stopDrive() {
        setDrivePowers(0.0, 0.0, 0.0, 0.0);
    }

    public double getFrontLeftPower() {
        return frontLeftDrive.getPower();
    }

    public double getFrontRightPower() {
        return frontRightDrive.getPower();
    }

    public double getBackLeftPower() {
        return backLeftDrive.getPower();
    }

    public double getBackRightPower() {
        return backRightDrive.getPower();
    }
}
```

Build the `TeamCode` module before creating an OpMode. Fix package, import, and
syntax errors while no hardware is connected.

## Part 4 — Create the one-motor test OpMode

Create `DriveDirectionTestOpMode.java` in the Level 3 package:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.hardware.DriveHardware;

@TeleOp(name = "L3 Drive Direction Test", group = "Level 3")
public class DriveDirectionTestOpMode extends LinearOpMode {
    private static final double TEST_POWER = 0.20;

    @Override
    public void runOpMode() {
        DriveHardware drive = new DriveHardware();
        drive.initialize(hardwareMap);

        telemetry.addLine("X=front left, A=back left");
        telemetry.addLine("Y=front right, B=back right");
        telemetry.addData("Test power", "%.2f", TEST_POWER);
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            double frontLeftPower = 0.0;
            double frontRightPower = 0.0;
            double backLeftPower = 0.0;
            double backRightPower = 0.0;
            String selectedMotor = "none";

            if (gamepad1.x) {
                frontLeftPower = TEST_POWER;
                selectedMotor = "front left";
            } else if (gamepad1.a) {
                backLeftPower = TEST_POWER;
                selectedMotor = "back left";
            } else if (gamepad1.y) {
                frontRightPower = TEST_POWER;
                selectedMotor = "front right";
            } else if (gamepad1.b) {
                backRightPower = TEST_POWER;
                selectedMotor = "back right";
            }

            drive.setDrivePowers(
                    frontLeftPower,
                    frontRightPower,
                    backLeftPower,
                    backRightPower);

            telemetry.addData("Selected", selectedMotor);
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

The `else if` chain allows at most one nonzero command per loop even if several
buttons are held. Every loop starts with four zeroes, so releasing a button stops
the selected motor instead of retaining the previous command.

This button layout comes from the diagnostic block in the SDK omni-drive sample.
The course version reduces the power to `0.20`, makes the test a separate OpMode,
reports the selected corner, and calls one explicit stop method at the end.

## Part 5 — Predict before deploying

Complete this table from the current contract and code:

| Button | Expected Java field | Expected physical corner | Other three commands | Expected positive wheel direction |
|---|---|---|---|---|
| X | `frontLeftDrive` | | `0.0` | |
| A | `backLeftDrive` | | `0.0` | |
| Y | `frontRightDrive` | | `0.0` | |
| B | `backRightDrive` | | `0.0` | |

Do not write “forward” in the last column until the team has agreed what forward
wheel rotation looks like while the robot is raised.

## Part 6 — Run the direction test

Build and deploy the project. Raise or secure the drivetrain using the team's
approved procedure. Clear hands, hair, clothing, tools, and cables from every
wheel.

Test one row at a time:

| Test | Verify |
|---|---|
| Press **INIT** only. | All telemetry powers are zero and no wheel moves. |
| Hold X briefly. | Only the physical front-left wheel moves. |
| Hold A briefly. | Only the physical back-left wheel moves. |
| Hold Y briefly. | Only the physical front-right wheel moves. |
| Hold B briefly. | Only the physical back-right wheel moves. |
| Release each button. | The selected command returns to zero immediately. |
| Press Driver Station **Stop** during a command. | The OpMode ends and the drivetrain stops. |

For each wheel, compare the observed positive direction with the drawing. If the
wrong physical wheel moves, stop and correct the configured name or wiring record.
If the correct wheel moves in the wrong direction, change only that wheel's
`setDirection(...)` value, rebuild, and repeat all four tests.

Update the contract's direction and verification columns from the observations.
Do not make several direction changes at once; that destroys the evidence about
which change corrected which wheel.

## What changed from the SDK sample

| SDK sample idea | Course version |
|---|---|
| Hardware fields are inside one OpMode. | Mapping and stop behavior live in `DriveHardware`. |
| Diagnostic motor buttons are a commented block. | A separate named test OpMode keeps the diagnostic available. |
| Test values use full power when uncommented. | The walkthrough uses a conservative `0.20` test command. |
| Sample directions describe a common layout. | Directions are copied into a robot-specific, observed contract. |
| Wheel powers are written directly in the OpMode. | All four cross one `setDrivePowers(...)` boundary. |

The sample supplied working SDK syntax. The team supplied the physical facts and
the test evidence.

## Git checkpoint

Inspect the feature diff. It should contain the contract, `DriveHardware`, and the
diagnostic OpMode—not unrelated Level 2 or SDK sample changes.

Commit the Java separately from the contract, for example:

```text
Add verified drivetrain hardware mapping
```

In the pull request, include the completed four-motor test table and name any
direction that differs from the initial SDK-sample assumption.

## Ask your AI tutor

> Review my drivetrain contract, `DriveHardware`, and direction-test diff without
> editing. Cross-check each configuration name, Java field, direction, safe
> initialization command, button mapping, and stop path. Separate code facts from
> physical facts that still require observation.

## Check your work

You are finished when:

- all four configured names match the active Driver Station configuration;
- each button moves exactly one predicted physical wheel;
- positive power produces the documented wheel direction;
- INIT, button release, and Driver Station Stop leave all commands at zero;
- `DriveHardware` contains no gamepad, telemetry, or lifecycle code; and
- the contract and verification evidence are included in the reviewed pull
  request.

## Reflect

Which observation tells you that a configuration name is wrong, and which
observation tells you that a motor direction is wrong?

Continue to [Lesson 2: Robot-Centric Mecanum Drive](../02-robot-centric-mecanum-drive/README.md).
