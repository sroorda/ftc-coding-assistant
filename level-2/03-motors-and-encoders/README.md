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

## Student task

Implement `EncoderMoveOpMode` so it:

1. Maps `bench_motor` and initializes it at zero power.
2. Selects and documents direction and zero-power behavior.
3. Resets the encoder during initialization.
4. Changes to `RUN_USING_ENCODER` after resetting.
5. Reports the zeroed encoder position before Start.
6. Waits for Start and honors an early Stop request.
7. Calculates a target relative to the current position.
8. Sets the target before selecting `RUN_TO_POSITION`.
9. Starts an `ElapsedTime` timeout and applies limited positive power magnitude.
10. Waits only while active, busy, and before the timeout.
11. Reports target, current position, busy state, and elapsed time.
12. Sets power to zero and returns to `RUN_USING_ENCODER` after the wait.
13. Reports whether the move ended by reaching the target, timing out, or Stop.

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
