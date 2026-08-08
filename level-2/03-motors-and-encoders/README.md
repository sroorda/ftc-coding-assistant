# Lesson 3: Motors, Encoders, and Controlled Motion

Open-loop power tells a motor how hard to run, not how far to move. You will read
the encoder, choose motor settings deliberately, and make a bounded movement that
cannot wait forever.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | direction, zero-power behavior, encoders, run modes, timeout |
| **Git focus** | inspect history and isolate one behavioral change |
| **AI tutor** | trace every exit path from the movement loop |

## Your goal

By the end of this lesson, you can:

- explain power direction separately from encoder position;
- choose a zero-power behavior and run mode for a stated reason;
- command a relative encoder move; and
- guarantee that target completion, timeout, or Stop ends motor power.

## Get ready

Update `student/<your-name>` and create:

```text
feature/<your-name>/motor-encoders
```

Create `EncoderMoveOpMode.java` in the Level 2 package so the first OpMode remains
available for comparison. Confirm that:

- the active branch is `feature/<your-name>/motor-encoders`;
- `bench_motor` still matches the active Driver Station configuration;
- the motor's encoder cable is connected to the Control Hub; and
- the mechanism can turn a small amount without interference.

Do not turn the mechanism to “check the encoder” yet. First write code that makes
the encoder reading visible.

## Part 1 — Observe the encoder without moving the motor

An encoder converts shaft rotation into a changing count. FTC reports that count
with `getCurrentPosition()`. The value is measured in encoder ticks, not degrees,
inches, or a known mechanism position.

### 1. Create a zero-power observation OpMode

Start `EncoderMoveOpMode.java` with this complete observation program:

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.DcMotor;

@TeleOp(name = "L2 Encoder Move", group = "Level 2")
public class EncoderMoveOpMode extends LinearOpMode {
    private DcMotor benchMotor;

    @Override
    public void runOpMode() {
        benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
        benchMotor.setPower(0.0);

        telemetry.addData("Status", "Encoder observer ready");
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            telemetry.addData(
                    "Current position",
                    benchMotor.getCurrentPosition());
            telemetry.update();
            idle();
        }

        benchMotor.setPower(0.0);
    }
}
```

The OpMode maps the same motor as Lesson 1 but always commands zero power. The
active loop repeatedly reads and displays the encoder count.

### 2. Build and verify the encoder

- Build `TeamCode` before connecting to the test bench.
- Connect and deploy with the USB cable.
- Select **L2 Encoder Move**, press INIT, then PLAY.
- Confirm the motor remains stopped.
- If the mechanism can be moved safely by hand, turn it slowly while watching
  `Current position` on the Driver Station.
- Turn it in the opposite direction and watch the count change the other way.

If the value never changes, stop and check the encoder cable and configured motor
type before writing movement code. A successful build cannot prove that an
encoder is electrically connected.

## Part 2 — Make three motor decisions

Mapping a `DcMotor` does not explain how this mechanism should behave. Make these
three decisions explicitly before commanding encoder motion.

### Decision 1: Which physical direction is positive?

Add a direction immediately after the motor is mapped:

```java
benchMotor.setDirection(DcMotor.Direction.FORWARD);
```

`Direction` defines the motor's logical positive direction. It affects how future
power commands and encoder direction are interpreted by the SDK.

- Choose `FORWARD` if its positive direction matches the convention you want for
  the test bench.
- Choose `REVERSE` if the opposite physical rotation should be positive.
- Do not change direction merely to make one target number look convenient.
- Calling `setDirection(...)` does not power or move the motor.

Keep the selected direction unchanged for the rest of the lesson so power signs,
encoder counts, and targets keep the same meaning.

### Decision 2: What should happen at zero power?

Add the zero-power behavior after direction:

```java
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
```

`ZeroPowerBehavior` applies only when the requested motor power is zero:

| Choice | Result at zero power |
|---|---|
| `BRAKE` | The controller electrically resists rotation. |
| `FLOAT` | The motor is allowed to coast more freely. |

- `BRAKE` does not command a precise encoder position.
- `FLOAT` does not guarantee immediate stopping.
- Neither choice replaces `benchMotor.setPower(0.0)`.

Use `BRAKE` for this bounded bench move and explain why. With power still at zero,
you may compare the feel of `BRAKE` and `FLOAT` by turning the shaft by hand only
when the mechanism permits it safely.

### Decision 3: How should the controller use the encoder?

The run mode determines what the motor controller does with encoder information:

| Run mode | Purpose in this lesson |
|---|---|
| `RUN_WITHOUT_ENCODER` | Apply power without encoder-based speed regulation. The count can still be read. |
| `RUN_USING_ENCODER` | Apply power while using encoder feedback to regulate motor speed. |
| `STOP_AND_RESET_ENCODER` | Set the current encoder count to software zero. It is a reset step, not a movement mode. |
| `RUN_TO_POSITION` | Move toward a target encoder count while power is applied. |

Establish the starting software zero during initialization:

```java
benchMotor.setMode(DcMotor.RunMode.STOP_AND_RESET_ENCODER);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);

telemetry.addData("Status", "Encoder zeroed");
telemetry.addData("Current position", benchMotor.getCurrentPosition());
telemetry.update();
```

- Stop power before resetting the encoder.
- `STOP_AND_RESET_ENCODER` does not physically move or home the mechanism.
- Select another run mode immediately after the reset.
- The displayed current position after the reset should be at or near zero.

Your three decisions are now visible together:

```java
benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
benchMotor.setPower(0.0);
benchMotor.setDirection(DcMotor.Direction.FORWARD);
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
benchMotor.setMode(DcMotor.RunMode.STOP_AND_RESET_ENCODER);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
```

Replace `FORWARD` only if your chosen physical convention requires `REVERSE`.

## Part 3 — Plan a bounded move

Choose a small relative move that is safe on the bench. Identify:

- the starting encoder count;
- a small requested count change;
- the calculated target;
- a positive power magnitude no greater than `0.25`;
- a short timeout; and
- every condition that can end the move.

Before coding, predict:

- whether the target will be positive or negative;
- which physical direction the motor will rotate;
- approximately where the final encoder count should be; and
- which condition should end a successful move.

## Part 4 — Build the bounded move

### 1. Add named movement values and a timer

Add the timer import and class fields:

```java
import com.qualcomm.robotcore.util.ElapsedTime;

private static final int MOVE_TICKS = 200;
private static final double MOVE_POWER = 0.25;
private static final double TIMEOUT_SECONDS = 3.0;

private final ElapsedTime runtime = new ElapsedTime();
```

`MOVE_TICKS` is a relative count change, not a universal distance. Replace `200`
with a smaller value if that is safer for the bench.

### 2. Calculate the target only after Start

Replace the observation loop with this active check and target calculation:

```java
waitForStart();

String exitReason = "Stopped before move";
int targetPosition = benchMotor.getCurrentPosition();

if (opModeIsActive()) {
    int startingPosition = benchMotor.getCurrentPosition();
    targetPosition = startingPosition + MOVE_TICKS;

    // Target, mode, power, and wait code goes here.
}
```

The active check prevents one-time motor commands from running if Stop was pressed
while `waitForStart()` was waiting. A negative `MOVE_TICKS` value requests the
opposite encoder direction.

### 3. Set target, mode, timer, and power in order

Inside the active check:

```java
benchMotor.setTargetPosition(targetPosition);
benchMotor.setMode(DcMotor.RunMode.RUN_TO_POSITION);
runtime.reset();
benchMotor.setPower(MOVE_POWER);
```

- Set the target before selecting `RUN_TO_POSITION`.
- Use a positive power magnitude in `RUN_TO_POSITION`.
- The target count determines the movement direction.
- Reset the timer once when the move begins, not inside the wait loop.

### 4. Wait only while every condition allows motion

```java
while (opModeIsActive()
        && benchMotor.isBusy()
        && runtime.seconds() < TIMEOUT_SECONDS) {
    telemetry.addData("Target", targetPosition);
    telemetry.addData("Current", benchMotor.getCurrentPosition());
    telemetry.addData("Busy", benchMotor.isBusy());
    telemetry.addData("Elapsed", "%.1f s", runtime.seconds());
    telemetry.update();
    idle();
}
```

- `opModeIsActive()` ends the wait when the driver presses Stop.
- `isBusy()` becomes false when the controller considers the target reached.
- the timer ends the wait if the movement takes too long.
- `idle()` gives the runtime an opportunity to perform other work; it does not
  replace any loop condition.

### 5. Identify the exit reason inside the active check

Immediately after the wait loop:

```java
if (!opModeIsActive()) {
    exitReason = "Driver Station Stop";
} else if (!benchMotor.isBusy()) {
    exitReason = "Target reached";
} else {
    exitReason = "Timed out";
}
```

The three branches correspond to the three wait conditions. Do not assume that
leaving the loop automatically means the target was reached.

### 6. Put cleanup outside the active check

```java
benchMotor.setPower(0.0);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);

telemetry.addData("Exit", exitReason);
telemetry.addData("Target", targetPosition);
telemetry.addData("Final position", benchMotor.getCurrentPosition());
telemetry.update();
```

Cleanup remains reachable when the target is reached, the timer expires, Stop is
pressed, or the OpMode never becomes active. The final power command must be zero.

## Test one exit path at a time

- Run a small positive move and compare the target with the final count.
- Change only `MOVE_TICKS` and run a small negative move.
- Test the timeout by temporarily using a very short time—not by holding or
  jamming the mechanism.
- Press Driver Station Stop during a move.
- Restore the normal timeout before committing.

Exact target equality is not required to determine whether the bounded move
behaved correctly. The important result is that every exit path reaches zero
power and reports why it ended.

## Git checkpoint

In Android Studio:

- open the Commit window and confirm the current branch is
  `feature/<your-name>/motor-encoders`;
- confirm only `EncoderMoveOpMode.java` and other intentional lesson changes are
  selected;
- inspect every highlighted change before committing;
- open **View → Tool Windows → Git**, select the **Log** tab, and find where the
  feature branch starts from the latest commit on `student/<your-name>`;
- commit with a focused message such as `Add bounded encoder move`;
- push the feature branch and open a pull request into
  `student/<your-name>`;
- include the positive, negative, timeout, and Stop test results in the pull
  request description;
- obtain a review and merge the pull request; and
- update your local personal branch before starting Lesson 4.

## Ask your AI tutor

> Review my encoder OpMode without editing it. Trace the exact order of target,
> run mode, power, timer, and loop operations. List every way the loop can end and
> show whether each path reaches zero motor power. Do not suggest larger test
> values.

## Check your work

You are finished when:

- encoder counts change consistently with shaft movement;
- both requested directions complete a small move;
- the wait exits on target, timeout, or Stop;
- telemetry identifies the exit reason;
- the motor is at zero power after every exit; and
- you can explain why encoder reset is not physical homing.

## Reflect

What unsafe behavior could occur if `isBusy()` were the only condition in the
movement loop?

Continue to [Lesson 4: Positional Servos](../04-positional-servos/README.md).
