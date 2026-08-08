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
- find the manufacturer's ticks-per-revolution value for a motor;
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
motor-output-shaft revolution. FTC examples often call these **counts per motor
revolution**.

Go to the motor manufacturer's website, find the exact motor from the
[Hardware Lab Contract](../../docs/hardware-lab-contract.md), and locate its
encoder resolution at the output shaft.

Add this constant near the top of the class, below the `benchMotor` field:

```java
private static final double COUNTS_PER_MOTOR_REV = 0.0;
```

Replace `0.0` with the value from the manufacturer's specification. Keep it as a
`double` because the value may contain a decimal.

## Part 3 — Command a number of revolutions

The motor cannot be turned by hand, so you will use motor power and the marked
wheel to test the value you found.

### 1. Set the test power

Add this constant next to `COUNTS_PER_MOTOR_REV`:

```java
private static final double TEST_POWER = 0.25;
```

The motor will use 25% power while moving toward its target.

### 2. Set direction and zero-power behavior

Inside `runOpMode()`, add these lines immediately after mapping `benchMotor`:

```java
benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
benchMotor.setPower(0.0);
benchMotor.setDirection(DcMotor.Direction.FORWARD);
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
```

- `FORWARD` defines which rotation produces positive encoder counts.
- `BRAKE` makes the motor resist rotation when its commanded power is zero. It
  does not hold an exact encoder position.

### 3. Reset the encoder and select a run mode

Add these lines next, still before `waitForStart()`:

```java
benchMotor.setMode(DcMotor.RunMode.STOP_AND_RESET_ENCODER);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
```

- `STOP_AND_RESET_ENCODER` changes the current encoder count to zero. Reset mode
  is not used to move the motor.
- `RUN_USING_ENCODER` leaves reset mode and allows the motor controller to use
  encoder feedback while running.
- Later, `RUN_TO_POSITION` will tell the controller to move toward a target
  encoder count and stop when it reaches that target.

The order matters: reset first, then select the mode used after the reset.

### 4. Calculate the encoder target

Add these variables after the run-mode lines and before `waitForStart()`:

```java
double numberOfRevolutions = 1.0;
int targetTicks =
        (int) Math.round(numberOfRevolutions * COUNTS_PER_MOTOR_REV);
```

`numberOfRevolutions` makes the requested movement easy to change. Start with
`1.0`. After that test works, change it to `2.0` and test again.

Add telemetry immediately below the calculation so it appears after INIT:

```java
telemetry.addData("Requested revolutions", "%.1f", numberOfRevolutions);
telemetry.addData("Target ticks", targetTicks);
telemetry.addData("Current ticks", benchMotor.getCurrentPosition());
telemetry.update();
```

Keep the existing `waitForStart()` directly after this telemetry.

### 5. Add the movement code

Replace the empty `if (opModeIsActive())` block after `waitForStart()` with:

```java
if (opModeIsActive()) {
    benchMotor.setTargetPosition(targetTicks);
    benchMotor.setMode(DcMotor.RunMode.RUN_TO_POSITION);
    benchMotor.setPower(TEST_POWER);

    while (opModeIsActive() && benchMotor.isBusy()) {
        telemetry.addData("Target ticks", targetTicks);
        telemetry.addData("Current ticks", benchMotor.getCurrentPosition());
        telemetry.update();
        idle();
    }
}

benchMotor.setPower(0.0);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
```

Read the code in order:

- `setTargetPosition(targetTicks)` gives the controller the encoder count to
  reach. Because the encoder was reset, the starting position is zero.
- `RUN_TO_POSITION` tells the controller to use encoder feedback to approach that
  target.
- `setPower(TEST_POWER)` begins the movement at limited power.
- `isBusy()` remains true while the motor is still moving toward the target.
- telemetry shows the target and current encoder counts while the motor moves.
- the final two lines stop power and return the motor to
  `RUN_USING_ENCODER` after the move or after Driver Station Stop.

### 6. Run and observe

- Align the wheel's tape mark with the stationary reference mark.
- Set `numberOfRevolutions` to `1.0`.
- Press INIT and confirm the requested revolutions, target ticks, and current
  ticks appear on the Driver Station.
- Press PLAY and watch the wheel move at limited power.
- Watch the current count approach the target count.
- Confirm the tape mark returns approximately to the reference after one complete
  revolution.
- Press Driver Station Stop immediately if the wheel approaches interference.
- Change `numberOfRevolutions` to `2.0`, rebuild, and repeat the test. The wheel
  should complete approximately two revolutions.

If the wheel does not complete approximately one revolution, stop and investigate
the exact motor model, installed gearbox, encoder specification, wheel attachment,
encoder cable, and target calculation before changing power. Correct the constant
only when your research and the physical test support the change.

## Part 4 — Convert ticks into wheel-rim distance

To convert encoder counts into distance, the code also needs the gear ratio
between the motor output shaft and the wheel. The FTC SDK examples call this
`DRIVE_GEAR_REDUCTION`.

```text
DRIVE_GEAR_REDUCTION = motor output-shaft revolutions ÷ wheel revolutions
```

- A wheel attached directly to the motor output shaft uses `1.0`.
- A 12-tooth motor gear driving a 24-tooth wheel gear uses `2.0`, because the
  motor turns twice for each wheel revolution.
- Do not include the motor's internal gearbox again. It is already included in
  `COUNTS_PER_MOTOR_REV`.

Add these constants near the other class constants:

```java
private static final double DRIVE_GEAR_REDUCTION = 1.0;
private static final double WHEEL_DIAMETER_INCHES = 4.0;

private static final double COUNTS_PER_INCH =
        (COUNTS_PER_MOTOR_REV * DRIVE_GEAR_REDUCTION)
        / (WHEEL_DIAMETER_INCHES * Math.PI);
```

Replace `4.0` with the measured diameter of the wheel on the bench.

The formula has two parts:

- `COUNTS_PER_MOTOR_REV * DRIVE_GEAR_REDUCTION` calculates encoder counts for one
  wheel revolution.
- `WHEEL_DIAMETER_INCHES * Math.PI` calculates how many inches are in one wheel
  revolution.

Display the result with the other initialization telemetry, before
`waitForStart()`:

```java
telemetry.addData("Wheel diameter", "%.2f in", WHEEL_DIAMETER_INCHES);
telemetry.addData("Drive gear reduction", "%.2f", DRIVE_GEAR_REDUCTION);
telemetry.addData("Counts per inch", "%.2f", COUNTS_PER_INCH);
telemetry.update();
```

## Part 5 — Move a calculated distance

For now, replace the revolution target with a distance target calculated from
`COUNTS_PER_INCH`:

```java
double moveDistanceInches = 6.0;
int moveTicks =
        (int) Math.round(moveDistanceInches * COUNTS_PER_INCH);

int startingPosition = benchMotor.getCurrentPosition();
int targetPosition = startingPosition + moveTicks;
```

Use `targetPosition` with the same limited-power `RUN_TO_POSITION` sequence from
Part 3.

Before each test, complete this prediction table:

| Value | Prediction |
|---|---:|
| Researched counts per motor revolution | |
| Measured wheel diameter | |
| Calculated wheel circumference | Example: `4.0 in × π ≈ 12.57 in` |
| Drive gear reduction | |
| Calculated counts per inch | |
| Requested rim distance | |
| Calculated move counts | |

Test the calculation in this order:

- request one wheel circumference and verify approximately one full revolution;
- request half the circumference and verify approximately half a revolution;
- request one quarter of the circumference and verify approximately a quarter
  revolution;
- request a different safe rim distance and compare the final encoder count with
  the calculated target; and
- use a negative distance and verify the wheel moves the opposite direction.

The fixed bench does not travel the requested number of inches. The calculated
distance describes how far a point on the wheel rim would travel along the wheel's
circular path.

## Understand the limits of the calculation

The encoder can report the intended shaft rotation accurately while calculated
real-world travel is still imperfect. Sources of error include:

- a ticks-per-revolution value from the wrong motor or gearbox;
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
> for my exact motor model, specification source, researched encoder value,
> measured wheel diameter, and observed wheel movement before deciding whether
> the calculation is correct.

## Check your work

You are finished when:

- the ticks-per-revolution value is supported by a manufacturer source;
- the marked wheel completes approximately one revolution for one revolution's
  worth of ticks;
- the code calculates ticks per inch without premature integer rounding;
- full-, half-, and quarter-revolution tests match the predictions;
- a requested rim distance produces the predicted approximate wheel angle;
- negative distance reverses the movement direction;
- Driver Station Stop and normal completion both reach zero motor power; and
- you can explain why encoder rotation is not the same as robot field position.

## Reflect

If the encoder reaches its calculated target but a future robot travels the wrong
distance, which mechanical values and physical effects would you check first?

Continue to [Lesson 4: Positional Servos](../04-positional-servos/README.md).
