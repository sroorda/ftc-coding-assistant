# Lesson 3: Motors, Encoders, and Controlled Motion

Open-loop power tells a motor how hard to run, not how far to move. You will read
the encoder, choose motor settings deliberately, and make a bounded movement that
cannot wait forever.

## Your mission

| | |
|---|---|
| **Time** | 75–105 minutes |
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
available for comparison.

Confirm the encoder cable is connected and the configured motor type is correct.
With power off, slowly turn the mechanism by hand only if the mechanism permits it
safely. Observe whether `getCurrentPosition()` changes.

## Separate three motor decisions

| Setting | Question it answers |
|---|---|
| `DcMotor.Direction` | Which physical rotation should Java call positive? |
| `ZeroPowerBehavior` | Should zero power coast or actively resist motion? |
| `RunMode` | How should the controller use encoder information? |

`STOP_AND_RESET_ENCODER` establishes a software zero; it does not physically home
a mechanism. After resetting, choose another run mode before commanding motion.

For `RUN_TO_POSITION`, set the target position before switching to that mode. Use
a positive power magnitude; the target position determines movement direction.

## Plan the bounded move

Choose a small relative move that is safe on the bench. Record:

- starting encoder count;
- requested count change;
- calculated target;
- power magnitude, no greater than `0.25` for the first test;
- timeout; and
- every condition that can end the move.

Before coding, predict the target sign, observed rotation, expected final encoder
range, and which loop condition should end a successful move.

An interruptible wait requires every guard:

```java
while (opModeIsActive()
        && benchMotor.isBusy()
        && runtime.seconds() < timeoutSeconds) {
    // Report evidence. Do not reset the timer here.
}
```

Each condition answers a different safety question:

- `opModeIsActive()` stops waiting when the driver presses Stop.
- `benchMotor.isBusy()` stops waiting when the controller considers the target
  reached.
- `runtime.seconds() < timeoutSeconds` stops waiting when the move takes too long.

## Complete one area at a time

### 1. Map the motor and establish an encoder zero

Add the timer import and create the devices used by the OpMode:

```java
import com.qualcomm.robotcore.util.ElapsedTime;

private DcMotor benchMotor;
private final ElapsedTime runtime = new ElapsedTime();
```

During initialization, apply zero power before changing modes:

```java
benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
benchMotor.setPower(0.0);
benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);

benchMotor.setMode(DcMotor.RunMode.STOP_AND_RESET_ENCODER);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);
```

`STOP_AND_RESET_ENCODER` changes the controller's current count to zero. It does
not move the mechanism to a known physical location. `RUN_USING_ENCODER` then
returns the motor to a mode that can report and regulate motion.

Show the result before Start:

```java
telemetry.addData("Status", "Initialized");
telemetry.addData("Encoder", benchMotor.getCurrentPosition());
telemetry.update();
```

The motor should remain stationary and the displayed count should be at or very
near zero.

### 2. Calculate a relative target

After `waitForStart()`, guard the one-time movement commands so they cannot run if
STOP was pressed while waiting:

```java
waitForStart();

if (opModeIsActive()) {
    int startingPosition = benchMotor.getCurrentPosition();
    int requestedChange = 200; // Replace with a small value safe for the bench.
    int targetPosition = startingPosition + requestedChange;

    // The remaining movement code belongs inside this active check.
}
```

The target is relative to the measured starting count. A negative
`requestedChange` requests the opposite encoder direction.

### 3. Put the controller into position mode in the correct order

Inside the active check, set the target before selecting `RUN_TO_POSITION`:

```java
benchMotor.setTargetPosition(targetPosition);
benchMotor.setMode(DcMotor.RunMode.RUN_TO_POSITION);

runtime.reset();
benchMotor.setPower(0.25);
```

In `RUN_TO_POSITION`, use a positive power magnitude. The target relative to the
current count determines the movement direction. `runtime.reset()` starts this
move's timeout clock; resetting it inside the loop would prevent the timeout.

### 4. Wait only while all three conditions allow it

```java
double timeoutSeconds = 3.0;

while (opModeIsActive()
        && benchMotor.isBusy()
        && runtime.seconds() < timeoutSeconds) {
    telemetry.addData("Target", targetPosition);
    telemetry.addData("Current", benchMotor.getCurrentPosition());
    telemetry.addData("Busy", benchMotor.isBusy());
    telemetry.addData("Elapsed", "%.1f s", runtime.seconds());
    telemetry.update();
    idle();
}
```

`idle()` gives the runtime an opportunity to perform other work while this OpMode
has nothing else to do on that pass. It does not replace any loop guard.

### 5. Stop first, then determine why the loop ended

Every exit must reach the same cleanup:

```java
benchMotor.setPower(0.0);
benchMotor.setMode(DcMotor.RunMode.RUN_USING_ENCODER);

String exitReason;
if (!opModeIsActive()) {
    exitReason = "Driver Station Stop";
} else if (!benchMotor.isBusy()) {
    exitReason = "Target reached";
} else {
    exitReason = "Timed out";
}

telemetry.addData("Exit", exitReason);
telemetry.addData("Final position", benchMotor.getCurrentPosition());
telemetry.update();
```

Place the zero-power and `RUN_USING_ENCODER` commands so they also execute when
the OpMode never became active. Cleanup should not depend on a successful move.

## Student task

Implement `EncoderMoveOpMode` so it:

1. Maps `bench_motor` and initializes it at zero power.
2. Selects and documents direction and zero-power behavior.
3. Resets the encoder during initialization.
4. Changes to `RUN_USING_ENCODER` after resetting.
5. Reports the zeroed encoder position before Start.
6. Waits for Start and guards one-time movement commands with
   `opModeIsActive()`.
7. Calculates a target relative to the current position.
8. Sets the target before selecting `RUN_TO_POSITION`.
9. Starts an `ElapsedTime` timeout and applies limited positive power magnitude.
10. Waits only while active, busy, and before the timeout.
11. Reports target, current position, busy state, and elapsed time.
12. Sets power to zero and returns to `RUN_USING_ENCODER` after the wait.
13. Reports whether the move ended by reaching the target, timing out, or Stop.

The snippets show the required operations but not the complete method structure.
Trace the braces and confirm that the movement commands are inside the active
check while cleanup is reachable from every path.

Run a small positive move, then a small negative move. Compare the requested target
with the final encoder value; exact equality is not required to reason about
whether the move succeeded.

Test the timeout with an intentionally short time—not by holding or jamming the
mechanism. Restore the normal timeout before committing.

## Git checkpoint

Run:

```text
git status
git diff
git log --oneline -5
```

Explain how the feature branch relates to the latest commit on your personal
branch. Commit the bounded movement, push it, and merge it into
`student/<your-name>` through a reviewed pull request.

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
