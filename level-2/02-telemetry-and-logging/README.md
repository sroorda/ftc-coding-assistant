# Lesson 2: Seeing What the Robot Is Doing

The motor moved in Lesson 1, but the Driver Station did not explain what the
program requested or which lifecycle state it reached. You will add live telemetry
for the operator and event logging for later diagnosis.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | telemetry, `RobotLog`, observable behavior |
| **Git focus** | `git status`, `git diff`, focused commit messages |
| **AI tutor** | judge whether each message provides useful evidence |

## Your goal

By the end of this lesson, you can:

- distinguish Driver Station telemetry from Robot Controller logs;
- report requested and applied values with useful labels;
- record lifecycle events without flooding the log; and
- use evidence to isolate a hardware or software mismatch.

## Get ready

Switch to `student/<your-name>` and pull the Lesson 1 merge. Create and check out:

```text
feature/<your-name>/telemetry-logging
```

Open `FirstHardwareOpMode.java`. Before editing, run it once and list three
questions the Driver Station cannot currently answer.

This lesson changes only what the program reports. The joystick-to-motor behavior
from Lesson 1 should remain the same.

## Telemetry versus logging

Telemetry is live information sent to the Driver Station. Values added with
`telemetry.addData(...)` are sent when `telemetry.update()` runs. Rapidly changing
values such as stick input and motor power belong here.

```java
telemetry.addData("Stick Y", "%.2f", gamepad1.left_stick_y);
telemetry.addData("Requested power", "%.2f", requestedPower);
telemetry.addData("Applied power", "%.2f", benchMotor.getPower());
telemetry.update();
```

Logs record diagnostic events on the Robot Controller. Use `RobotLog` for events
such as initialization, Start, Stop, and faults—not for the same value on every
fast loop.

```java
import com.qualcomm.robotcore.util.RobotLog;

private static final String LOG_TAG = "L2Hardware";
```

An informational event can be written with:

```java
RobotLog.ii(LOG_TAG, "OpMode initialized");
```

View live entries in Android Studio's Logcat window while connected to the Control
Hub and filter on `L2Hardware`. The exact Logcat interface may differ by Android
Studio version; preserve the tag so the filter remains useful.

## Complete one area at a time

Add and test each area below before moving to the next. Keep the motor limited to
the same power used in Lesson 1.

### 1. Add the logging import and tag

Place the import with the other imports and the constant inside the class:

```java
import com.qualcomm.robotcore.util.RobotLog;

private static final String LOG_TAG = "L2Hardware";
```

The tag gives related log messages one searchable name. It does not appear on the
Driver Station unless you also add it to telemetry.

### 2. Report that initialization finished

After the motor is mapped and its safe defaults are applied, add:

```java
telemetry.addData("Status", "Initialized");
telemetry.update();
RobotLog.ii(LOG_TAG, "OpMode initialized");
```

`addData(...)` prepares one Driver Station line. `update()` sends the prepared
telemetry. The log call records a separate event for Logcat. The expected result
after INIT is a stationary motor, `Status: Initialized` on the Driver Station,
and one initialization event in Logcat.

### 3. Record Start without mislabeling an early Stop

Use the lifecycle condition to record Start only if the OpMode is actually active:

```java
waitForStart();

if (opModeIsActive()) {
    RobotLog.ii(LOG_TAG, "OpMode started");
}
```

This guard matters because `waitForStart()` can also return after STOP. Unlike the
Lesson 1 loop, this is a one-time action after the wait, so its condition must be
checked explicitly.

### 4. Make each motor command observable

Keep the three values separate inside the active loop:

```java
double rawStickY = gamepad1.left_stick_y;
double requestedPower = -rawStickY * 0.25;
benchMotor.setPower(requestedPower);

telemetry.addData("Status", "Running");
telemetry.addData("Raw stick Y", "%.2f", rawStickY);
telemetry.addData("Requested power", "%.2f", requestedPower);
telemetry.addData("Applied power", "%.2f", benchMotor.getPower());
telemetry.update();
```

- `rawStickY` is what the gamepad supplied.
- `requestedPower` is what your calculation asked the motor to use.
- `getPower()` reports the power command currently stored by the motor object; it
  does not measure physical speed or torque.

With the stick centered, all three numeric values should be close to zero. Moving
the stick should show the sign change and the `0.25` limit.

### 5. Record the normal end of the loop

Keep the safe stop from Lesson 1, then log the lifecycle event:

```java
benchMotor.setPower(0.0);
RobotLog.ii(LOG_TAG, "OpMode stopped");
```

These lines run after `opModeIsActive()` becomes false. The expected result is a
zero motor-power command and one stopped event—not a repeated message from every
loop.

## Put the pieces together

Your revised Lesson 1 OpMode should now provide:

- `Initialized` telemetry before `waitForStart()`;
- `Running` telemetry inside the active loop;
- raw left-stick input;
- calculated requested power;
- power returned by `benchMotor.getPower()`;
- an initialization log event;
- a Start log event only when the OpMode becomes active; and
- a stopped log event after the loop.

Do not log on every loop. Do not include names, credentials, Wi-Fi information, or
other private data in telemetry or logs.

Before running, predict how the raw stick value, requested power, and applied power
will relate. Collect evidence for:

1. the stick centered;
2. the stick approximately halfway forward;
3. the stick fully backward; and
4. the OpMode after Stop.

Record one observation that confirms the calculation and one value that would have
exposed a sign or scaling mistake.

## Diagnose one mismatch

Temporarily introduce one harmless mismatch, such as an incorrect telemetry label
or a different calculation displayed from the one applied. Ask another student to
diagnose it using the code, telemetry, and your observations. Restore the correct
code before committing.

Use this debugging loop:

```text
observe → form one hypothesis → inspect evidence → change one cause → retest
```

## Git checkpoint

Before committing, run:

```text
git status
git diff
```

Confirm the branch and changed files match this lesson. Commit with a focused
message, push, and open a pull request into `student/<your-name>`. Include your
observations in the description. Obtain a review, merge, then update your personal
branch.

## Ask your AI tutor

> Review my telemetry and logging without editing. For each message, explain what
> question it answers, whether it belongs in live telemetry or a log, and whether
> it could flood output. Ask me for an observed value before deciding the behavior
> is correct.

## Check your work

You are finished when:

- telemetry distinguishes raw input, requested power, and applied power;
- lifecycle messages appear at the expected times;
- repeated loop data is telemetry rather than high-volume logging;
- Logcat can find the events using your tag;
- Stop still leaves the motor at zero power; and
- the reviewed change is merged into your personal branch.

## Reflect

What information is useful to the driver right now but would become noise in a
persistent log?

Continue to [Lesson 3: Motors and Encoders](../03-motors-and-encoders/README.md).
