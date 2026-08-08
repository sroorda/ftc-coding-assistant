# Lesson 3: Encoders and Measured Movement

Power tells a motor how hard to run. An encoder lets the program measure shaft
rotation and move toward a repeatable target. In this lesson, you will attach a
marked wheel to the fixed test bench, calculate how encoder ticks relate to the
wheel, and command a specific distance around the wheel's rim.

The test bench will not travel across the floor. The wheel provides a visible way
to connect encoder counts, revolutions, angles, and calculated distance.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | encoder ticks, ticks per revolution, `RUN_TO_POSITION`, distance conversion |
| **Git focus** | inspect a visual diff and review the calculation separately from the motor code |
| **AI tutor** | verify units, formulas, and target calculations without inventing hardware values |

## Your goal

By the end of this lesson, you can:

- explain what an encoder tick represents;
- find the configured ticks-per-revolution value for a motor;
- verify one output-shaft revolution using a marked wheel;
- convert wheel diameter and gearing into ticks per unit of distance; and
- command and observe a specific calculated wheel-rim distance.

## Get ready

Update `student/<your-name>` and create:

```text
feature/<your-name>/encoder-distance
```

Create `EncoderDistanceOpMode.java` in the Level 2 package. Leave the earlier
OpModes available for comparison.

### Build the basic OpMode skeleton

Before adding any encoder calculations, make the new file a complete FTC
`LinearOpMode`. Enter this skeleton, changing the package declaration only if
your Level 2 package has a different name:

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.DcMotor;

@TeleOp(name = "L2 Encoder Distance", group = "Level 2")
public class EncoderDistanceOpMode extends LinearOpMode {
    private DcMotor benchMotor;

    @Override
    public void runOpMode() {
        // Initialization: this runs after INIT and before PLAY.
        benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
        benchMotor.setPower(0.0);

        telemetry.addData("Status", "Initialized");
        telemetry.update();

        // Pause here until the driver presses PLAY.
        waitForStart();

        if (opModeIsActive()) {
            // The encoder movement code will go here later in this lesson.
        }

        // Leave the motor stopped when the OpMode finishes.
        benchMotor.setPower(0.0);
    }
}
```

This gives the lesson code its required structure:

- `@TeleOp` makes the OpMode appear in the Driver Station's TeleOp list.
- `extends LinearOpMode` provides `hardwareMap`, `telemetry`,
  `waitForStart()`, and `opModeIsActive()`.
- `runOpMode()` is the method the FTC SDK runs.
- initialization maps the configured motor and commands zero power before PLAY.
- `waitForStart()` separates initialization from movement.
- `if (opModeIsActive())` is where the one-time encoder movement will go.
- the final `setPower(0.0)` is cleanup reached after the movement finishes or
  Stop is pressed.

Build the project now. Fix any package, import, or syntax errors before adding
the encoder code.

Prepare the fixed test bench:

- confirm `bench_motor` matches the active Driver Station configuration;
- confirm the motor's encoder cable is connected;
- attach a wheel securely to the motor output shaft;
- confirm the wheel can rotate without striking the bench or nearby objects;
- measure the wheel diameter in inches; and
- place a visible tape mark on the wheel and a stationary reference mark on the
  bench.

The wheel will move under motor power. Do not try to turn the motor shaft by hand.

## Part 1 — Why use an encoder?

Running a motor at a particular power for a particular time does not guarantee a
repeatable movement. Battery voltage, friction, and load can change the result.

An encoder allows the program to:

- count shaft rotation;
- move toward a repeatable rotational target;
- compare requested and reported movement; and
- stop based on position rather than time alone.

An encoder does not automatically know:

- the wheel diameter;
- any external gear ratio;
- how many inches a point on the wheel rim traveled;
- whether a wheel slipped; or
- the mechanism's absolute physical position.

`getCurrentPosition()` returns a signed encoder count relative to the most recent
software reset. The count is measured in ticks—not degrees, revolutions, or
inches.

```java
int currentTicks = benchMotor.getCurrentPosition();
```

Your code must supply the mechanical information that gives those ticks physical
meaning.

## Part 2 — Find ticks per revolution

Ticks per revolution tells you how many encoder counts represent one complete
motor-output-shaft revolution.

### Find the manufacturer value

Identify the exact motor and gearbox installed on the bench. Use the model label
or product number to find the manufacturer's ticks-per-output-revolution value.
Do not use a value from a different Yellow Jacket gear ratio merely because the
motors look alike.

Add the verified value as a named class constant:

```java
private static final double MOTOR_TICKS_PER_REV = 0.0;
```

`0.0` is a safe placeholder that cannot request a revolution. Replace it with the
manufacturer value only after identifying the installed motor.

### Compare it with the configured motor type

After mapping the motor, ask the FTC SDK for the value stored by the active motor
configuration:

```java
double configuredTicksPerRevolution =
        benchMotor.getMotorType().getTicksPerRev();

telemetry.addData(
        "Configured ticks/revolution",
        "%.1f",
        configuredTicksPerRevolution);
telemetry.addData(
        "Manufacturer ticks/revolution",
        "%.1f",
        MOTOR_TICKS_PER_REV);
telemetry.update();
```

This value comes from the motor type selected in the Driver Station configuration.
The Java method can return a number even when the wrong motor type was selected,
so configuration is part of the calculation—not merely a name used by
`hardwareMap`.

Check the value three ways:

- identify the exact motor and gearbox installed on the bench;
- find its ticks-per-output-revolution value in the manufacturer's specifications;
  and
- compare that specification with `getTicksPerRev()` telemetry.

Keep both values as `double`. Gearbox ratios can produce a fractional number of
ticks per output revolution. If the values do not agree, do not enable movement.
Recheck the motor model and Driver Station motor type, then update the hardware
configuration or Hardware Lab Contract before continuing.

## Part 3 — Command exactly one revolution

The motor cannot be turned by hand, so use a conservative powered movement to
verify ticks per revolution.

### 1. Map and prepare the motor

Add these constants and timer alongside the existing `benchMotor` field:

```java
private static final double TEST_POWER = 0.20;
private static final double TIMEOUT_SECONDS = 5.0;
private static final double MOTOR_TICKS_PER_REV = 0.0;

private final ElapsedTime runtime = new ElapsedTime();
```

Add this import with the other imports:

```java
import com.qualcomm.robotcore.util.ElapsedTime;
```

During initialization:

```java
benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
benchMotor.setPower(0.0);
benchMotor.setDirection(DcMotor.Direction.FORWARD);
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);

double configuredTicksPerRevolution =
        benchMotor.getMotorType().getTicksPerRev();

benchMotor.setMode(DcMotor.RunMode.STOP_AND_RESET_ENCODER);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
```

These settings have specific jobs:

- `Direction.FORWARD` defines the sign used for this test. Use `REVERSE` only if
  the opposite physical rotation should be positive.
- `BRAKE` makes zero power resist rotation; it does not hold an exact position.
- `STOP_AND_RESET_ENCODER` establishes software zero; it does not physically home
  the wheel.
- `RUN_USING_ENCODER` leaves reset mode and prepares the motor for encoder-aware
  operation.

Before `waitForStart()`, display both ticks-per-revolution values. Do not continue
until `MOTOR_TICKS_PER_REV` contains the verified manufacturer value and it agrees
with the configured value.

### 2. Convert one revolution into a target

One output revolution should equal the configured ticks-per-revolution value:

```java
int oneRevolutionTicks =
        (int) Math.round(MOTOR_TICKS_PER_REV);
```

Use `Math.round()` only when producing the final integer target. Do not discard the
fraction earlier in the calculation.

### 3. Command and observe the revolution

After `waitForStart()`, guard the one-time movement commands:

```java
if (opModeIsActive()) {
    benchMotor.setTargetPosition(oneRevolutionTicks);
    benchMotor.setMode(DcMotor.RunMode.RUN_TO_POSITION);
    runtime.reset();
    benchMotor.setPower(TEST_POWER);

    while (opModeIsActive()
            && benchMotor.isBusy()
            && runtime.seconds() < TIMEOUT_SECONDS) {
        telemetry.addData("Target ticks", oneRevolutionTicks);
        telemetry.addData(
                "Current ticks",
                benchMotor.getCurrentPosition());
        telemetry.update();
        idle();
    }
}

benchMotor.setPower(0.0);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
```

The order matters:

- set the target before selecting `RUN_TO_POSITION`;
- use a positive power magnitude—the target determines direction;
- reset the timeout once before movement; and
- place zero-power cleanup outside the active check so every exit reaches it.

### 4. Run the one-revolution test

- Align the wheel's tape mark with the stationary reference mark.
- Press INIT and confirm the configured and manufacturer values agree.
- Press PLAY and watch the wheel move at limited power.
- Confirm the tape mark returns approximately to the reference after one
  revolution.
- Compare the final encoder count with `oneRevolutionTicks`.
- Press Driver Station Stop immediately if the wheel approaches interference.

If the wheel does not complete approximately one revolution, investigate the
configured motor type, installed gearbox, wheel attachment, encoder cable, and
target calculation before changing power.

## Part 4 — Convert ticks into wheel-rim distance

A point on the edge of a wheel travels one circumference during one wheel
revolution:

```text
wheel circumference = π × wheel diameter
```

If the wheel is attached directly to the motor output shaft, one motor-output
revolution equals one wheel revolution:

```text
motor revolutions per wheel revolution = 1.0
```

If external gears or chain are added later:

```text
motor revolutions per wheel revolution
    = driven wheel gear teeth ÷ motor gear teeth
```

For example, a 12-tooth motor gear driving a 24-tooth wheel gear requires two
motor revolutions for one wheel revolution.

### Calculate ticks per inch

Add measured mechanism values:

```java
private static final double WHEEL_DIAMETER_INCHES = 4.0;
private static final double MOTOR_REVS_PER_WHEEL_REV = 1.0;
private static final double MOVE_DISTANCE_INCHES = 6.0;
```

The example diameter is a placeholder. Replace it with the wheel measurement from
your bench.

Using the verified manufacturer value, calculate:

```java
double wheelCircumferenceInches =
        Math.PI * WHEEL_DIAMETER_INCHES;

double ticksPerInch =
        MOTOR_TICKS_PER_REV
        * MOTOR_REVS_PER_WHEEL_REV
        / wheelCircumferenceInches;

int moveTicks =
        (int) Math.round(MOVE_DISTANCE_INCHES * ticksPerInch);
```

Track the units through the calculation:

```text
ticks              motor revolutions          1 wheel revolution
---------------- × ------------------------ × --------------------
motor revolution   wheel revolution            circumference

= ticks per inch
```

### Predict the visible wheel movement

Calculate how much of a wheel revolution the requested rim distance represents:

```java
double expectedWheelRevolutions =
        MOVE_DISTANCE_INCHES / wheelCircumferenceInches;

double expectedWheelDegrees =
        expectedWheelRevolutions * 360.0;
```

Display the calculation before movement:

```java
telemetry.addData("Wheel diameter", "%.2f in", WHEEL_DIAMETER_INCHES);
telemetry.addData("Wheel circumference", "%.2f in", wheelCircumferenceInches);
telemetry.addData("Ticks/revolution", "%.1f", MOTOR_TICKS_PER_REV);
telemetry.addData("Ticks/inch", "%.2f", ticksPerInch);
telemetry.addData("Requested distance", "%.2f in", MOVE_DISTANCE_INCHES);
telemetry.addData("Target ticks", moveTicks);
telemetry.addData("Expected wheel turn", "%.1f degrees", expectedWheelDegrees);
telemetry.update();
```

Students should be able to explain every displayed value before pressing PLAY.

## Part 5 — Move a calculated distance

Replace the one-revolution target with the calculated distance target:

```java
int startingPosition = benchMotor.getCurrentPosition();
int targetPosition = startingPosition + moveTicks;
```

Use `targetPosition` with the same limited-power `RUN_TO_POSITION` sequence and
timeout from Part 3.

Before each test, complete this prediction table:

| Value | Prediction |
|---|---:|
| Configured ticks per motor revolution | |
| Manufacturer ticks per motor revolution | |
| Measured wheel diameter | |
| Calculated wheel circumference | |
| Motor revolutions per wheel revolution | |
| Calculated ticks per inch | |
| Requested rim distance | |
| Calculated move ticks | |
| Expected wheel revolutions | |
| Expected wheel degrees | |

Test the calculation in this order:

- request one wheel circumference and verify approximately one full revolution;
- request half the circumference and verify approximately half a revolution;
- request one quarter of the circumference and verify approximately a quarter
  revolution;
- request a different safe rim distance and compare the observed wheel angle with
  the predicted degrees; and
- use a negative distance and verify the wheel moves the opposite direction.

The fixed bench does not travel the requested number of inches. The calculated
distance describes how far a point on the wheel rim would travel along the wheel's
circular path.

## Understand the limits of the calculation

The encoder can report the intended shaft rotation accurately while calculated
real-world travel is still imperfect. Sources of error include:

- an incorrect Driver Station motor type;
- using nominal rather than measured wheel diameter;
- an incorrect external gear ratio;
- wheel or hub slipping on the shaft;
- gear backlash; and
- rounding the tick calculation too early.

On a future driving robot, wheel compression and floor slip add more error. An
encoder measures rotation; it does not directly measure the robot's position on
the field.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/encoder-distance`;
- inspect the `EncoderDistanceOpMode.java` diff in the Commit window;
- check that wheel measurements and conversion constants are named and explained;
- commit with a focused message such as `Add encoder distance calculation`;
- push the feature branch and open a pull request into
  `student/<your-name>`;
- include the completed prediction table and observed wheel movements in the pull
  request description;
- obtain a review and merge the pull request; and
- update your local personal branch before starting Lesson 4.

## Ask your AI tutor

> Review my encoder-distance calculation without editing it. Track the units from
> ticks per motor revolution through wheel circumference and target ticks. Ask me
> for my configured motor type, manufacturer value, measured wheel diameter, and
> observed wheel movement before deciding whether the calculation is correct.

## Check your work

You are finished when:

- configured and manufacturer ticks-per-revolution values agree;
- the marked wheel completes approximately one revolution for one revolution's
  worth of ticks;
- the code calculates ticks per inch without premature integer rounding;
- full-, half-, and quarter-revolution tests match the predictions;
- a requested rim distance produces the predicted approximate wheel angle;
- negative distance reverses the movement direction;
- timeout, Stop, and normal completion all reach zero motor power; and
- you can explain why encoder rotation is not the same as robot field position.

## Reflect

If the encoder reaches its calculated target but a future robot travels the wrong
distance, which mechanical values and physical effects would you check first?

Continue to [Lesson 4: Positional Servos](../04-positional-servos/README.md).
