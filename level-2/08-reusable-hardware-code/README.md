# 2.8: Building Reusable Hardware Code

The earlier OpModes each map and configure their own hardware. That was useful
while learning one device at a time, but it also repeated configuration names,
safe starting commands, and direct SDK calls.

In this lesson, you will **refactor** working code into a reusable hardware
class. Refactoring changes how code is organized without changing what the
program does.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | hardware abstraction, initialization, safe defaults |
| **Git focus** | separate hardware-class and OpMode-refactor commits |
| **AI tutor** | identify accidental behavior changes and misplaced responsibilities |

## Your goal

By the end of this lesson, you can:

- recognize hardware code that is repeated across OpModes;
- move tested code into a reusable class one device at a time;
- keep lifecycle, gamepad, telemetry, and control state in the OpMode;
- expose small operations instead of public SDK device fields; and
- use hardware tests to prove that a refactor preserved behavior.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/reusable-hardware
```

You will refactor code from these earlier lessons:

- `FirstHardwareOpMode.java` from 2.1 and 2.2;
- `ContinuousServoOpMode.java` from 2.4; and
- `TouchSensorOpMode.java` from 2.5.

Make sure all three OpModes build before changing them. A refactor should begin
with working code.

## The steps we will take

| Step | What you will do | Why |
|---|---|---|
| 1 | Find repeated hardware code. | Refactor duplication that actually exists. |
| 2 | Create a small hardware class. | Give hardware setup one clear home. |
| 3 | Move the motor code first. | Learn the pattern with one familiar device. |
| 4 | Refactor and test the motor OpMode. | Prove its behavior did not change. |
| 5 | Repeat with the CR servo and touch sensor. | Apply the pattern to an output and an input. |
| 6 | Finish and review the class boundary. | Decide what belongs in the class and what stays in an OpMode. |

Do not rewrite all the OpModes at once. Build and test after each small change so
you know which change caused a problem.

You will keep modifying the same `TestBenchHardware` class. Each code block shows
what to add at that stage, and Part 6 shows the completed class.

## Part 1 — Find code worth moving

Start with code you have already tested.

From `FirstHardwareOpMode.java`:

```java
benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
benchMotor.setPower(0.0);
```

From `ContinuousServoOpMode.java`:

```java
continuousServo =
        hardwareMap.get(CRServo.class, "continuous_servo");
continuousServo.setPower(0.0);
```

From `TouchSensorOpMode.java`:

```java
touchSensor = hardwareMap.get(TouchSensor.class, "touch_sensor");
```

These blocks repeat the same kinds of details:

- Driver Station configuration names;
- FTC SDK device types;
- `hardwareMap` calls;
- safe starting commands; and
- direct access to hardware objects.

Before editing, record the behavior that must remain unchanged:

| Behavior | Before refactor | After refactor | Preserved? |
|---|---|---|---|
| Motor is stopped after INIT | | | |
| Joystick limits motor power to `0.25` | | | |
| A button starts and stops the CR servo | | | |
| Driver Station Stop stops powered outputs | | | |
| Touch sensor reports pressed and released | | | |
| Each touch-sensor press toggles once | | | |

Fill in the **Before refactor** column using the tests from the earlier lessons.
You will complete the other columns as you refactor.

## Part 2 — Create the class with one motor

In the Level 2 package, create this package and file:

```text
org.firstinspires.ftc.teamcode.level2.hardware.TestBenchHardware
```

Start with the package, imports, class, configuration constant, and private motor
field:

```java
package org.firstinspires.ftc.teamcode.level2.hardware;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.util.Range;

public final class TestBenchHardware {
    private static final String MOTOR_NAME = "bench_motor";
    private static final double MAX_MOTOR_POWER = 0.25;

    private DcMotor benchMotor;
}
```

- `MOTOR_NAME` gives the configuration name one authoritative location.
- `MAX_MOTOR_POWER` gives the bench limit one authoritative location.
- `benchMotor` is private so an OpMode must use the operations supplied by this
  class.
- The class does not extend `LinearOpMode`; it does not own the FTC lifecycle.

### Move motor initialization

Copy the tested motor mapping and safe defaults from `FirstHardwareOpMode` into
this method:

```java
public void initialize(HardwareMap hardwareMap) {
    benchMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
    benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
    benchMotor.setPower(0.0);
}
```

This is a move, not a redesign. The same SDK calls run during INIT; they now live
in `TestBenchHardware`.

### Add the motor operations

Add these methods below `initialize()`:

```java
public void setMotorPower(double requestedPower) {
    double appliedPower =
            Range.clip(requestedPower, -MAX_MOTOR_POWER, MAX_MOTOR_POWER);
    benchMotor.setPower(appliedPower);
}

public double getMotorPower() {
    return benchMotor.getPower();
}

public int getMotorPosition() {
    return benchMotor.getCurrentPosition();
}

public void stopAll() {
    benchMotor.setPower(0.0);
}
```

The OpMode can request motor power, but the hardware class enforces the bench's
maximum. The getter methods expose information needed by existing telemetry
without exposing the `DcMotor` itself.

Build the project before changing an OpMode. The new class should compile even
though no OpMode uses it yet.

### Git checkpoint — Hardware class

In Android Studio:

- inspect only `TestBenchHardware.java` in the Commit window;
- confirm it contains no gamepad, telemetry, or lifecycle code; and
- commit with `Add reusable test bench motor`.

Do not push yet. The next commit will show how an existing OpMode begins using
the class.

## Part 3 — Refactor the motor OpMode

Open `FirstHardwareOpMode.java`.

### Replace the motor field

Remove the `DcMotor` import and field. Import the hardware class and add one
instance:

```java
import org.firstinspires.ftc.teamcode.level2.hardware.TestBenchHardware;

private final TestBenchHardware bench = new TestBenchHardware();
```

`final` means the `bench` reference cannot be replaced with a different object.
The object can still be initialized and used normally.

### Replace mapping and setup

Replace the direct mapping and motor setup:

```java
benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
benchMotor.setPower(0.0);
```

with:

```java
bench.initialize(hardwareMap);
```

Initialization still happens before `waitForStart()`.

### Replace the loop's hardware calls

Keep the existing gamepad calculation and telemetry in the OpMode. Replace only
the direct motor calls:

```java
double rawStickY = gamepad1.left_stick_y;
double requestedPower = -rawStickY * 0.25;
bench.setMotorPower(requestedPower);

telemetry.addData("Status", "Running");
telemetry.addData("Raw stick Y", "%.2f", rawStickY);
telemetry.addData("Requested power", "%.2f", requestedPower);
telemetry.addData("Applied power", "%.2f", bench.getMotorPower());
telemetry.update();
```

The calculation remains in the OpMode because it translates driver input into a
request. The hardware class applies the final safety limit.

After the active loop, replace:

```java
benchMotor.setPower(0.0);
```

with:

```java
bench.stopAll();
```

Keep the lifecycle logging from 2.2 in its existing locations.

### Test — Refactored motor OpMode

Build and deploy the project, then repeat the original motor tests:

| Test | Verify |
|---|---|
| Press **INIT**. | The motor remains stopped, and initialization telemetry and logging still appear. |
| Press **PLAY** and move the left stick. | The motor follows the stick and applied power remains between `-0.25` and `0.25`. |
| Center the stick. | Requested and applied power return to approximately `0.00`. |
| Press Driver Station **Stop**. | The motor stops and the stopped log entry appears. |

Complete the motor rows in the before-and-after table. If telemetry, logging, or
hardware behavior changed, fix it before committing.

### Git checkpoint — First consumer

In Android Studio:

- inspect the `FirstHardwareOpMode.java` diff;
- verify that the commit removes direct motor access without changing gamepad,
  telemetry, or lifecycle logic; and
- commit with `Use hardware class in motor OpMode`.

## Part 4 — Add the continuous-rotation servo

Now repeat the extraction pattern with 2.4.

### Add the device to `TestBenchHardware`

Add the import, configuration name, and private field:

```java
import com.qualcomm.robotcore.hardware.CRServo;

private static final String CONTINUOUS_SERVO_NAME = "continuous_servo";
private static final double MAX_CONTINUOUS_SERVO_POWER = 0.25;

private CRServo continuousServo;
```

Add these lines to `initialize()`:

```java
continuousServo =
        hardwareMap.get(CRServo.class, CONTINUOUS_SERVO_NAME);
continuousServo.setPower(0.0);
```

Add these operations:

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

Build before editing `ContinuousServoOpMode.java`.

In the Commit window, select only `TestBenchHardware.java` and commit with
`Add continuous servo to test bench hardware`.

### Refactor `ContinuousServoOpMode`

Make the same substitutions:

- replace its `CRServo` field with a `TestBenchHardware` instance;
- replace direct mapping with `bench.initialize(hardwareMap)`;
- replace `continuousServo.setPower(...)` with
  `bench.setContinuousServoPower(...)`;
- replace `continuousServo.getPower()` with
  `bench.getContinuousServoPower()`; and
- replace the final zero-power command with `bench.stopAll()`.

Keep this state and gamepad logic in the OpMode:

```java
boolean servoRunning = false;

if (gamepad1.aWasPressed()) {
    servoRunning = !servoRunning;
}

double requestedPower = servoRunning ? RUN_POWER : STOP_POWER;
```

`servoRunning` describes what the operator requested. It is not a hardware
mapping or safety responsibility.

### Test — Refactored continuous servo

Build and deploy the refactored OpMode, then repeat the 2.4 tests:

| Test | Verify |
|---|---|
| Press **INIT**. | The CR servo remains stopped at `0.00`. |
| Press **PLAY**, then press **A**. | The servo runs and telemetry shows `0.25`. |
| Press **A** again. | The servo stops and telemetry shows `0.00`. |
| Hold **A**. | The state changes only once. |
| Start the servo, then press Driver Station **Stop**. | `stopAll()` stops both powered outputs. |

Do not continue until these results match 2.4.

Inspect and commit the consumer change separately with
`Use hardware class in continuous servo OpMode`.

## Part 5 — Add the touch sensor

The touch sensor demonstrates an important boundary: the hardware class reads
the sensor, while the OpMode decides what a new press means.

### Add the device to `TestBenchHardware`

Add the import, configuration name, and private field:

```java
import com.qualcomm.robotcore.hardware.TouchSensor;

private static final String TOUCH_SENSOR_NAME = "touch_sensor";

private TouchSensor touchSensor;
```

Add the mapping call to `initialize()`:

```java
touchSensor = hardwareMap.get(TouchSensor.class, TOUCH_SENSOR_NAME);
```

Add the operation:

```java
public boolean isTouchPressed() {
    return touchSensor.isPressed();
}
```

Build before editing `TouchSensorOpMode.java`.

In the Commit window, select only `TestBenchHardware.java` and commit with
`Add touch sensor to test bench hardware`.

### Refactor `TouchSensorOpMode`

Replace the `TouchSensor` field and mapping code with the hardware class. Inside
the active loop, replace:

```java
boolean pressed = touchSensor.isPressed();
```

with:

```java
boolean pressed = bench.isTouchPressed();
```

Keep the rising-edge and toggle logic in the OpMode:

```java
if (pressed && !previousPressed) {
    toggledOn = !toggledOn;
}

previousPressed = pressed;
```

The hardware class answers, “Is the sensor pressed?” The OpMode decides that a
new press should toggle program state.

### Test — Refactored touch sensor

Build and deploy the refactored OpMode, then repeat the 2.5 tests:

| Test | Verify |
|---|---|
| Release the sensor and press **PLAY**. | Telemetry shows `false`, `RELEASED`, and the initial toggled state. |
| Press and hold the sensor. | Telemetry shows `true` and `PRESSED`; the toggled state changes once. |
| Continue holding the sensor. | The toggled state does not repeatedly change. |
| Release and press again. | The toggled state changes exactly once on the new press. |

Complete the remaining rows in the before-and-after table.

Inspect and commit the consumer change separately with
`Use hardware class in touch sensor OpMode`.

## Part 6 — Finish the test-bench class

The positional servo and color sensor follow the same extraction pattern. Add
their configuration names, private fields, mapping calls, and small operations.

Use this complete class to check the result of all the steps. `HOME_POSITION`
is the position tested in 2.3. The generic `initialize()` method maps every
required bench device and applies zero power to powered outputs. The positional
servo moves only when an OpMode requests a named position operation.

```java
package org.firstinspires.ftc.teamcode.level2.hardware;

import com.qualcomm.robotcore.hardware.CRServo;
import com.qualcomm.robotcore.hardware.ColorSensor;
import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.hardware.Servo;
import com.qualcomm.robotcore.hardware.TouchSensor;
import com.qualcomm.robotcore.util.Range;

public final class TestBenchHardware {
    private static final String MOTOR_NAME = "bench_motor";
    private static final String POSITION_SERVO_NAME = "position_servo";
    private static final String CONTINUOUS_SERVO_NAME = "continuous_servo";
    private static final String TOUCH_SENSOR_NAME = "touch_sensor";
    private static final String COLOR_SENSOR_NAME = "color_sensor";

    private static final double MAX_MOTOR_POWER = 0.25;
    private static final double MAX_CONTINUOUS_SERVO_POWER = 0.25;
    private static final double HOME_POSITION = 0.0;

    private DcMotor benchMotor;
    private Servo positionServo;
    private CRServo continuousServo;
    private TouchSensor touchSensor;
    private ColorSensor colorSensor;

    public void initialize(HardwareMap hardwareMap) {
        benchMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
        positionServo = hardwareMap.get(Servo.class, POSITION_SERVO_NAME);
        continuousServo =
                hardwareMap.get(CRServo.class, CONTINUOUS_SERVO_NAME);
        touchSensor = hardwareMap.get(TouchSensor.class, TOUCH_SENSOR_NAME);
        colorSensor = hardwareMap.get(ColorSensor.class, COLOR_SENSOR_NAME);

        benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        benchMotor.setPower(0.0);
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

    public int getMotorPosition() {
        return benchMotor.getCurrentPosition();
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

    public void movePositionServoHome() {
        positionServo.setPosition(HOME_POSITION);
    }

    public void setPositionServoPosition(double requestedPosition) {
        positionServo.setPosition(Range.clip(requestedPosition, 0.0, 1.0));
    }

    public double getPositionServoPosition() {
        return positionServo.getPosition();
    }

    public boolean isTouchPressed() {
        return touchSensor.isPressed();
    }

    public String classifyColor() {
        int red = colorSensor.red();
        int green = colorSensor.green();
        int blue = colorSensor.blue();

        if (red > green && red > blue) {
            return "RED";
        } else if (green > red && green > blue) {
            return "GREEN";
        } else if (blue > red && blue > green) {
            return "BLUE";
        }

        return "UNKNOWN";
    }

    public void stopAll() {
        benchMotor.setPower(0.0);
        continuousServo.setPower(0.0);
    }
}
```

The class intentionally does not:

- extend `LinearOpMode`;
- call `waitForStart()` or `opModeIsActive()`;
- read a gamepad;
- send telemetry or log messages;
- store toggle state; or
- contain an autonomous sequence.

A positional servo is not included in `stopAll()` because it uses a position
command rather than a power command. Returning it home is a separate,
intentional operation.

`initialize()` treats every device in the Hardware Lab Contract as required. A
missing or incorrectly named device should fail visibly during INIT instead of
leaving the class partly initialized.

Build the complete class, inspect only its final positional-servo and
color-sensor additions, and commit with `Add remaining test bench hardware`.

## Part 7 — Review the boundary

Use this table to check each responsibility:

| Belongs in `TestBenchHardware` | Stays in an OpMode |
|---|---|
| Configuration names | `waitForStart()` and `opModeIsActive()` |
| Hardware mapping | Gamepad decisions |
| Safe zero-power commands | Telemetry and logging |
| Bench power limits | Rising-edge and toggle state |
| Reading a sensor | Autonomous sequences |
| `stopAll()` | Deciding when to call `stopAll()` |

Do not add a method only to wrap every SDK getter. Add an operation when it
centralizes a hardware rule or makes the calling OpMode clearer.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/reusable-hardware`;
- inspect the commit history and verify that the hardware-class extraction and
  consumer refactors are separate commits;
- inspect every changed OpMode and confirm its gamepad, telemetry, logging, and
  lifecycle code stayed in place;
- push and open a pull request into `student/<your-name>`;
- include the completed before-and-after behavior table in the description;
- obtain a review and merge the pull request; and
- update your local personal branch before starting 2.9.

## Ask your AI tutor

> Review my hardware-class refactor without editing it. Compare the original and
> refactored OpModes, identify any behavior change, find lifecycle or gamepad
> logic that does not belong in the hardware class, and ask for my before-and-after
> test results.

## Check your work

You are finished when:

- configuration names have one authoritative location;
- hardware devices are private fields;
- initialization maps the required devices and applies safe zero-power commands;
- motor and CR-servo power limits are enforced by the hardware class;
- touch-sensor rising-edge state remains in the OpMode;
- `stopAll()` stops every powered output;
- the original motor, CR-servo, and touch-sensor tests still pass;
- the refactor and consumer changes are understandable as separate commits; and
- you can explain why each responsibility belongs in its current class.

Continue to the
[2.9 Integrated Hardware Challenge](../09-integrated-hardware-challenge/README.md).
