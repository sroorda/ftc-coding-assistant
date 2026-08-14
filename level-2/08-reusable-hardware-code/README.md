# 2.8: Building Reusable Hardware Code

The earlier OpModes controlled one device at a time. In this lesson, you will
start with one working OpMode that controls the motor and both servos. You will
then refactor a copy of it into a smaller OpMode backed by a reusable hardware
class.

**Refactoring** changes how code is organized without changing what the program
does. The original OpMode will remain unchanged so you can compare code and
hardware behavior throughout the lesson.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | hardware abstraction, initialization, safe defaults |
| **Git focus** | use small commits to record each refactoring step |
| **AI tutor** | identify behavior changes and misplaced responsibilities |

## Your goal

By the end of this lesson, you can:

- control several devices from one OpMode;
- recognize hardware code that makes an OpMode difficult to read or reuse;
- move configuration, mapping, and safety rules into a hardware class;
- keep lifecycle, gamepad decisions, and telemetry in the OpMode; and
- compare working and refactored code to prove behavior was preserved.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/reusable-hardware
```

Confirm these devices are present in the active Driver Station configuration:

| Java configuration name | Control Hub device type |
|---|---|
| `bench_motor` | GoBILDA 5202/3/4 series |
| `position_servo` | Servo |
| `continuous_servo` | Continuous Rotation Servo |

Clear all moving parts before pressing INIT. The positional servo can move
during initialization.

## The steps we will take

| Step | What you will do | Why |
|---|---|---|
| 1 | Build and test one combined OpMode. | Establish known-working behavior. |
| 2 | Copy the working OpMode. | Preserve the original for comparison. |
| 3 | Extract the motor code. | Learn the refactoring pattern with one device. |
| 4 | Extract the positional-servo code. | Repeat the pattern with position commands. |
| 5 | Extract the CR-servo code. | Finish the hardware class and safe shutdown. |
| 6 | Compare and test both versions. | Prove the organization changed but behavior did not. |

Build and test after each extraction. If something breaks, the most recent
small change is the first place to look.

## Part 1 — Create the combined OpMode

Create `CombinedHardwareOpMode.java` in the Level 2 package. Enter this complete
OpMode:

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.CRServo;
import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.Servo;
import com.qualcomm.robotcore.util.Range;
import com.qualcomm.robotcore.util.RobotLog;

@TeleOp(name = "L2 Combined Hardware", group = "Level 2")
public class CombinedHardwareOpMode extends LinearOpMode {
    private static final String LOG_TAG = "L2Combined";
    private static final double MAX_MOTOR_POWER = 0.25;
    private static final double ZERO_POSITION = 0.0;
    private static final double POSITION_STEP = 0.05;
    private static final double RUN_POWER = 0.25;
    private static final double STOP_POWER = 0.0;

    private DcMotor benchMotor;
    private Servo positionServo;
    private CRServo continuousServo;

    @Override
    public void runOpMode() {
        benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
        positionServo = hardwareMap.get(Servo.class, "position_servo");
        continuousServo = hardwareMap.get(CRServo.class, "continuous_servo");

        benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        benchMotor.setPower(0.0);

        double targetPosition = ZERO_POSITION;
        positionServo.setPosition(targetPosition);

        boolean continuousServoRunning = false;
        continuousServo.setPower(STOP_POWER);

        telemetry.addData("Status", "Initialized");
        telemetry.addData("Motor power", "%.2f", benchMotor.getPower());
        telemetry.addData("Position target", "%.2f", targetPosition);
        telemetry.addData("CR-servo power", "%.2f", continuousServo.getPower());
        telemetry.update();
        RobotLog.ii(LOG_TAG, "OpMode initialized");

        waitForStart();

        if (opModeIsActive()) {
            RobotLog.ii(LOG_TAG, "OpMode started");
        }

        while (opModeIsActive()) {
            double rawStickY = gamepad1.left_stick_y;
            double requestedMotorPower = -rawStickY;
            double appliedMotorPower = Range.clip(
                    requestedMotorPower,
                    -MAX_MOTOR_POWER,
                    MAX_MOTOR_POWER);
            benchMotor.setPower(appliedMotorPower);

            if (gamepad1.dpadUpWasPressed()) {
                targetPosition += POSITION_STEP;
            } else if (gamepad1.dpadDownWasPressed()) {
                targetPosition -= POSITION_STEP;
            }

            targetPosition = Range.clip(targetPosition, 0.0, 1.0);
            positionServo.setPosition(targetPosition);

            if (gamepad1.crossWasPressed()) {
                continuousServoRunning = !continuousServoRunning;
            }

            double requestedServoPower =
                    continuousServoRunning ? RUN_POWER : STOP_POWER;
            continuousServo.setPower(requestedServoPower);

            telemetry.addData("Status", "Running");
            telemetry.addData("Raw stick Y", "%.2f", rawStickY);
            telemetry.addData("Requested motor power", "%.2f", requestedMotorPower);
            telemetry.addData("Applied motor power", "%.2f", benchMotor.getPower());
            telemetry.addData("Position target", "%.2f", targetPosition);
            telemetry.addData("Commanded position", "%.2f", positionServo.getPosition());
            telemetry.addData("CR servo running", continuousServoRunning);
            telemetry.addData("CR-servo power", "%.2f", continuousServo.getPower());
            telemetry.update();
        }

        benchMotor.setPower(0.0);
        continuousServo.setPower(STOP_POWER);
        RobotLog.ii(LOG_TAG, "OpMode stopped");
    }
}
```

This code intentionally puts hardware details and operator decisions in one
class. It should look familiar because each section comes from an earlier
lesson.

### Test the baseline

Build, deploy, and select **L2 Combined Hardware**. Complete every test before
refactoring:

| Test | Verify |
|---|---|
| Press **INIT**. | The motor and CR servo remain stopped; the positional servo moves to `0.0`. |
| Press **PLAY** and move the left stick. | The motor follows the stick and applied power stays between `-0.25` and `0.25`. |
| Press D-pad Up and D-pad Down. | The positional-servo target changes by `0.05` and remains between `0.0` and `1.0`. |
| Press **Cross (✕)** several times. | Each press alternates the CR servo between `0.25` and `0.0`. |
| Hold **Cross (✕)**. | The CR-servo state changes only once. |
| Start the motor and CR servo, then press Driver Station **Stop**. | Both powered outputs stop. |

Fix any failed test before continuing. This OpMode is the baseline that the
refactored version must match.

### Git checkpoint — Working baseline

In Android Studio:

- inspect `CombinedHardwareOpMode.java`;
- confirm only that file is selected;
- commit with `Add combined hardware OpMode`; and
- do not change this file during the rest of the lesson.

## Part 2 — Make the refactoring copy

In Android Studio:

1. Copy `CombinedHardwareOpMode.java` in the Project window.
2. Paste it into the same Level 2 package.
3. Name the copy `RefactoredCombinedHardwareOpMode`.
4. Change the class declaration:

   ```java
   public class RefactoredCombinedHardwareOpMode extends LinearOpMode {
   ```

5. Change the Driver Station name:

   ```java
   @TeleOp(name = "L2 Refactored Combined", group = "Level 2")
   ```

Build and deploy again. Run the same tests using **L2 Refactored Combined**.
Both OpModes must behave the same before you begin moving code.

Commit the unchanged comparison copy with `Add combined OpMode refactoring copy`.
The next three commits will show the actual refactor.

## Part 3 — Extract the motor code

Create this package and file:

```text
org.firstinspires.ftc.teamcode.level2.hardware.TestBenchHardware
```

Start with the motor configuration, field, initialization, commands, and
telemetry getter:

```java
package org.firstinspires.ftc.teamcode.level2.hardware;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.util.Range;

public final class TestBenchHardware {
    private static final String MOTOR_NAME = "bench_motor";
    private static final double MAX_MOTOR_POWER = 0.25;

    private DcMotor benchMotor;

    public void initialize(HardwareMap hardwareMap) {
        benchMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
        benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        benchMotor.setPower(0.0);
    }

    public void setMotorPower(double requestedPower) {
        double appliedPower =
                Range.clip(requestedPower, -MAX_MOTOR_POWER, MAX_MOTOR_POWER);
        benchMotor.setPower(appliedPower);
    }

    public double getMotorPower() {
        return benchMotor.getPower();
    }

    public void stopAll() {
        benchMotor.setPower(0.0);
    }
}
```

The hardware class now owns:

- the Driver Station configuration name;
- the `DcMotor` field and mapping;
- the zero-power behavior;
- the test-bench power limit; and
- the safe stop command.

It does not extend `LinearOpMode` or read the gamepad. Those responsibilities
remain in the OpMode.

### Change only the motor code in the refactored OpMode

In `RefactoredCombinedHardwareOpMode.java`:

1. Remove the `DcMotor` import, `MAX_MOTOR_POWER`, and `benchMotor` field.
2. Import the hardware class and create it near the other fields:

   ```java
   import org.firstinspires.ftc.teamcode.level2.hardware.TestBenchHardware;

   private final TestBenchHardware bench = new TestBenchHardware();
   ```

3. Replace the direct motor mapping and initialization with:

   ```java
   bench.initialize(hardwareMap);
   ```

4. Replace the motor calculation and command inside the active loop with:

   ```java
   double rawStickY = gamepad1.left_stick_y;
   double requestedMotorPower = -rawStickY;
   bench.setMotorPower(requestedMotorPower);
   ```

5. Replace each `benchMotor.getPower()` telemetry call with:

   ```java
   bench.getMotorPower()
   ```

6. Replace the final motor stop command with:

   ```java
   bench.stopAll();
   ```

The OpMode still decides what the left stick means. `TestBenchHardware` maps the
device and enforces the bench limit.

### Test — Motor extraction

| Test | Verify |
|---|---|
| Press **INIT**. | The motor remains stopped. |
| Move the left stick through its full range. | Applied motor power remains between `-0.25` and `0.25`. |
| Center the stick. | Applied power returns to approximately `0.00`. |
| Press Driver Station **Stop**. | The motor stops. |

Confirm the positional and continuous servos still pass their baseline tests.
Commit both changed files with `Extract motor hardware`.

## Part 4 — Extract the positional-servo code

Add the import, constants, and field to `TestBenchHardware`:

```java
import com.qualcomm.robotcore.hardware.Servo;

private static final String POSITION_SERVO_NAME = "position_servo";
private static final double ZERO_POSITION = 0.0;

private Servo positionServo;
```

Add this mapping and safe initial command to `initialize()`:

```java
positionServo = hardwareMap.get(Servo.class, POSITION_SERVO_NAME);
positionServo.setPosition(ZERO_POSITION);
```

Add these methods:

```java
public void setPositionServoPosition(double requestedPosition) {
    positionServo.setPosition(Range.clip(requestedPosition, 0.0, 1.0));
}

public double getPositionServoPosition() {
    return positionServo.getPosition();
}
```

In `RefactoredCombinedHardwareOpMode.java`:

1. Remove the `Servo` import, `ZERO_POSITION`, and `positionServo` field.
2. Remove the direct positional-servo mapping and initialization.
3. After `bench.initialize(hardwareMap)`, initialize the OpMode's target from
   the command stored by the hardware class:

   ```java
   double targetPosition = bench.getPositionServoPosition();
   ```

4. Keep the D-pad and `Range.clip()` logic in the OpMode.
5. Replace `positionServo.setPosition(targetPosition)` with:

   ```java
   bench.setPositionServoPosition(targetPosition);
   ```

6. Replace `positionServo.getPosition()` in telemetry with:

   ```java
   bench.getPositionServoPosition()
   ```

The hardware class owns the servo and its valid SDK range. The OpMode still
decides that D-pad presses change the target by `POSITION_STEP`.

### Test — Positional-servo extraction

| Test | Verify |
|---|---|
| Press **INIT**. | The positional servo moves to `0.0`. |
| Press D-pad Up once. | The target and commanded position increase by `0.05`. |
| Press D-pad Down once. | The target and commanded position decrease by `0.05`. |
| Continue pressing at either endpoint. | Both values remain between `0.0` and `1.0`. |

Confirm the motor and CR servo still work. Commit both changed files with
`Extract positional servo hardware`.

## Part 5 — Extract the continuous-rotation servo code

Add the import, constants, and field to `TestBenchHardware`:

```java
import com.qualcomm.robotcore.hardware.CRServo;

private static final String CONTINUOUS_SERVO_NAME = "continuous_servo";
private static final double MAX_CONTINUOUS_SERVO_POWER = 0.25;

private CRServo continuousServo;
```

Add this mapping and safe initial command to `initialize()`:

```java
continuousServo = hardwareMap.get(CRServo.class, CONTINUOUS_SERVO_NAME);
continuousServo.setPower(0.0);
```

Add these methods:

```java
public void setContinuousServoPower(double requestedPower) {
    double appliedPower = Range.clip(
            requestedPower,
            -MAX_CONTINUOUS_SERVO_POWER,
            MAX_CONTINUOUS_SERVO_POWER);
    continuousServo.setPower(appliedPower);
}

public double getContinuousServoPower() {
    return continuousServo.getPower();
}
```

Update `stopAll()` so it stops both powered outputs:

```java
public void stopAll() {
    benchMotor.setPower(0.0);
    continuousServo.setPower(0.0);
}
```

In `RefactoredCombinedHardwareOpMode.java`:

1. Remove the `CRServo` import, `STOP_POWER`, and `continuousServo` field.
2. Remove the direct CR-servo mapping and initial stop command.
3. Keep `continuousServoRunning`, `RUN_POWER`, and the Cross-button logic in the
   OpMode.
4. Replace the CR-servo power command with:

   ```java
   double requestedServoPower = continuousServoRunning ? RUN_POWER : 0.0;
   bench.setContinuousServoPower(requestedServoPower);
   ```

5. Replace `continuousServo.getPower()` in telemetry with:

   ```java
   bench.getContinuousServoPower()
   ```

6. Remove the separate final CR-servo stop command. `bench.stopAll()` now stops
   both powered outputs.

The Boolean toggle remains an operator-control decision. The power limit and
safe stop belong to the hardware class.

### Test — CR-servo extraction

| Test | Verify |
|---|---|
| Press **INIT**. | The CR servo remains stopped at `0.00`. |
| Press **PLAY**, then press **Cross (✕)**. | The CR servo runs and telemetry shows `0.25`. |
| Press **Cross (✕)** again. | The CR servo stops and telemetry shows `0.00`. |
| Hold **Cross (✕)**. | The running state changes only once. |
| Run the motor and CR servo, then press Driver Station **Stop**. | `stopAll()` stops both outputs. |

Confirm the motor and positional servo still work. Commit both changed files
with `Extract continuous servo hardware`.

## Part 6 — Check the completed hardware class

Compare your result with this complete class:

```java
package org.firstinspires.ftc.teamcode.level2.hardware;

import com.qualcomm.robotcore.hardware.CRServo;
import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.hardware.Servo;
import com.qualcomm.robotcore.util.Range;

public final class TestBenchHardware {
    private static final String MOTOR_NAME = "bench_motor";
    private static final String POSITION_SERVO_NAME = "position_servo";
    private static final String CONTINUOUS_SERVO_NAME = "continuous_servo";

    private static final double MAX_MOTOR_POWER = 0.25;
    private static final double MAX_CONTINUOUS_SERVO_POWER = 0.25;
    private static final double ZERO_POSITION = 0.0;

    private DcMotor benchMotor;
    private Servo positionServo;
    private CRServo continuousServo;

    public void initialize(HardwareMap hardwareMap) {
        benchMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
        positionServo = hardwareMap.get(Servo.class, POSITION_SERVO_NAME);
        continuousServo = hardwareMap.get(CRServo.class, CONTINUOUS_SERVO_NAME);

        benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        benchMotor.setPower(0.0);
        positionServo.setPosition(ZERO_POSITION);
        continuousServo.setPower(0.0);
    }

    public void setMotorPower(double requestedPower) {
        double appliedPower =
                Range.clip(requestedPower, -MAX_MOTOR_POWER, MAX_MOTOR_POWER);
        benchMotor.setPower(appliedPower);
    }

    public double getMotorPower() {
        return benchMotor.getPower();
    }

    public void setPositionServoPosition(double requestedPosition) {
        positionServo.setPosition(Range.clip(requestedPosition, 0.0, 1.0));
    }

    public double getPositionServoPosition() {
        return positionServo.getPosition();
    }

    public void setContinuousServoPower(double requestedPower) {
        double appliedPower = Range.clip(
                requestedPower,
                -MAX_CONTINUOUS_SERVO_POWER,
                MAX_CONTINUOUS_SERVO_POWER);
        continuousServo.setPower(appliedPower);
    }

    public double getContinuousServoPower() {
        return continuousServo.getPower();
    }

    public void stopAll() {
        benchMotor.setPower(0.0);
        continuousServo.setPower(0.0);
    }
}
```

## Part 7 — Compare the two OpModes

Open `CombinedHardwareOpMode.java` and
`RefactoredCombinedHardwareOpMode.java` side-by-side.

| Stays in the OpMode | Moves to `TestBenchHardware` |
|---|---|
| `waitForStart()` and `opModeIsActive()` | Configuration names |
| Gamepad decisions | SDK device fields and mapping |
| Position and toggle state | Safe initialization |
| Telemetry and logging | Bench power limits |
| Deciding when to call `stopAll()` | Device commands and readings |

Verify that the refactored OpMode:

- contains no `hardwareMap.get(...)` calls;
- contains no `DcMotor`, `Servo`, or `CRServo` fields;
- still owns all gamepad, telemetry, logging, and lifecycle code; and
- produces the same observable behavior as the original.

The hardware class intentionally does not extend `LinearOpMode`, wait for PLAY,
read a gamepad, send telemetry, store toggle state, or decide when the OpMode
should stop.

## Final test

Run the original and refactored OpModes one after the other:

| Test | Verify in both OpModes |
|---|---|
| INIT | The motor and CR servo are stopped; the positional servo moves to `0.0`. |
| Left stick | Motor direction and limited power match. |
| D-pad Up and Down | Positional-servo steps and limits match. |
| Cross (✕) | CR-servo start, stop, and press detection match. |
| Driver Station Stop | The motor and CR servo stop. |
| Telemetry and logs | The same values and lifecycle events appear. |

If a result differs, compare the corresponding section of the two OpModes and
the most recent extraction commit before changing code.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/reusable-hardware`;
- confirm `CombinedHardwareOpMode.java` did not change after its baseline commit;
- inspect the five focused commits created during the lesson;
- push and open a pull request into `student/<your-name>`;
- describe how the original and refactored tests matched;
- obtain a review and merge the pull request; and
- update your local personal branch.

## Ask your AI tutor

> Review my hardware refactor without editing it. Compare
> CombinedHardwareOpMode, RefactoredCombinedHardwareOpMode, and
> TestBenchHardware. Identify any behavior change, SDK device access left in the
> refactored OpMode, or lifecycle, gamepad, telemetry, or logging code moved into
> the hardware class.

## Check your work

You are finished when:

- the original combined OpMode still works and remains unchanged;
- the refactored OpMode controls the motor and both servos;
- all hardware mapping is inside `TestBenchHardware`;
- power limits and safe initialization are enforced by the hardware class;
- lifecycle, gamepad state, telemetry, and logging remain in the OpMode;
- `stopAll()` stops the motor and continuous servo;
- both OpModes pass the same tests; and
- you can explain why each responsibility belongs in its current class.

You have completed Level 2. Review the
[Level 2 learning goals](../../levels/02-hardware-lab.md) before continuing to
Level 3.
