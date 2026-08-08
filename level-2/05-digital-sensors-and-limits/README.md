# Lesson 5: Digital Sensors and Limit Switches

The test bench has a touch sensor and a magnetic limit switch. You will first
observe their raw electrical states, then translate those states into named
meaning and use a limit to prevent motion in one direction.

## Your mission

| | |
|---|---|
| **Time** | 75–105 minutes |
| **FTC focus** | `DigitalChannel`, active-low input, limit enforcement |
| **Git focus** | handle an update or merge conflict without losing intent |
| **AI tutor** | verify polarity and every motor-command path |

## Your goal

By the end of this lesson, you can:

- distinguish raw digital state from interpreted sensor meaning;
- verify whether each device is active-high or active-low;
- name polarity logic once instead of scattering negations; and
- stop motion toward a limit while allowing motion away from it.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/digital-limits
```

Create `DigitalLimitOpMode.java`. Confirm the configured names are `touch_sensor`
and `magnetic_limit`. The hardware contract uses `DigitalChannel` intentionally so
you can see the underlying state.

Check the [Hardware Lab Contract](../../docs/hardware-lab-contract.md) before this
lesson. If the magnetic-limit port is still marked `TBD`, its physical connection
and Driver Station configuration must be completed before testing Part 2.

## Raw state versus meaning

Configure each channel as an input:

```java
DigitalChannel touchSensor =
        hardwareMap.get(DigitalChannel.class, "touch_sensor");
touchSensor.setMode(DigitalChannel.Mode.INPUT);
```

Many FTC switches are active-low: the electrical state is `false` when activated.
Do not assume both devices match. Use telemetry to verify each one in both states.

Translate the verified polarity in a named method or variable:

```java
boolean touchPressed = !touchSensor.getState();
```

If your device behaves differently, use the behavior you measured and document
it. Do not randomly add or remove `!` until the display looks convenient.

## Part 1 — Sensor observation

### 1. Map both channels and set them as inputs

```java
DigitalChannel touchSensor =
        hardwareMap.get(DigitalChannel.class, "touch_sensor");
DigitalChannel magneticLimit =
        hardwareMap.get(DigitalChannel.class, "magnetic_limit");

touchSensor.setMode(DigitalChannel.Mode.INPUT);
magneticLimit.setMode(DigitalChannel.Mode.INPUT);
```

`INPUT` tells the hub that Java will read the channel rather than drive an output.
The quoted names must match the active Driver Station configuration.

### 2. Read raw values before interpreting them

Inside the active loop, take one snapshot of each state:

```java
boolean touchRaw = touchSensor.getState();
boolean magneticRaw = magneticLimit.getState();

telemetry.addData("Touch raw", touchRaw);
telemetry.addData("Magnetic raw", magneticRaw);
```

Record the displayed value with each device clear and activated. Reading the raw
state first prevents an incorrect polarity assumption from hiding the evidence.
During the raw-only test, call `telemetry.update()` after these lines. When you add
interpreted values in the next step, keep one `update()` at the end.

### 3. Convert electrical state into mechanism meaning

After the truth table shows the polarity, add named conversions. If both devices
are confirmed active-low, they would look like:

```java
boolean touchPressed = !touchRaw;
boolean limitReached = !magneticRaw;
```

Do not copy the negation merely because it appears here. If one truth table shows
active-high behavior, its meaningful value should use the raw state directly.

Now report both layers:

```java
telemetry.addData("Touch", touchPressed ? "PRESSED" : "CLEAR");
telemetry.addData("Magnetic limit", limitReached ? "MAGNET PRESENT" : "CLEAR");
telemetry.update();
```

The raw line helps diagnose wiring; the interpreted line lets later motor logic
use names that describe the mechanism.

Implement an OpMode that maps both digital devices and reports for each:

- raw `getState()` value;
- interpreted active/inactive value; and
- a readable status such as `PRESSED`, `CLEAR`, `MAGNET PRESENT`, or
  `MAGNET ABSENT`.

Before pressing or activating anything, predict all four raw readings. Test the
touch sensor and magnet separately, then together. Record a truth table:

| Device | Physical condition | Raw state | Interpreted active |
|---|---|---:|---:|
| Touch | clear | | |
| Touch | pressed | | |
| Magnetic | magnet absent | | |
| Magnetic | magnet present | | |

## Part 2 — Enforce a directional limit

Add `bench_motor` and limited gamepad control. Define which power sign moves the
mechanism **toward** the magnetic limit.

Your decision must follow this rule:

```text
if limit is active and requested motion is toward the limit
    apply zero power
else
    apply the limited requested power
```

The mechanism must still be able to move away from an active limit. Otherwise it
can become trapped at the switch.

### 1. Turn the physical direction into a named fact

After a low-power test with the limit clear, record which sign moves toward it:

```java
private static final boolean POSITIVE_POWER_MOVES_TOWARD_LIMIT = true;
```

Change this value only if your observed mechanism direction is negative. The name
is more useful than scattering comparisons with unexplained signs.

### 2. Separate requested, limited, and applied power

```java
double requestedPower = -gamepad1.left_stick_y;
double limitedPower = requestedPower * 0.25;

boolean movingTowardLimit = POSITIVE_POWER_MOVES_TOWARD_LIMIT
        ? limitedPower > 0.0
        : limitedPower < 0.0;
boolean commandBlocked = limitReached && movingTowardLimit;
double appliedPower = commandBlocked ? 0.0 : limitedPower;

benchMotor.setPower(appliedPower);
```

When the limit is clear, the requested direction is allowed. When the limit is
active, only the direction farther into the limit becomes zero; the opposite sign
still moves the mechanism away.

### 3. Explain every decision in telemetry

```java
telemetry.addData("Requested power", "%.2f", requestedPower);
telemetry.addData("Applied power", "%.2f", benchMotor.getPower());
telemetry.addData("Limit reached", limitReached);
telemetry.addData("Command", commandBlocked ? "BLOCKED BY LIMIT" : "ALLOWED");
telemetry.update();
```

This evidence distinguishes a centered stick, a blocked command, and a motor that
was allowed to run but did not physically move.

Display requested power, applied power, limit state, and the reason for any
blocked command. Stop motor power after the active loop.

Test the logic in stages:

1. With motor power disabled in code, confirm sensor interpretation.
2. Command motion away from the limit at low power.
3. Approach the limit at low power and confirm it blocks that direction.
4. While the limit remains active, confirm reverse motion can move away.
5. Press Driver Station Stop and confirm zero power.

## If Git reports a conflict

Do not discard either side automatically. Identify:

1. what your personal branch changed;
2. what the feature branch changed;
3. the intended final behavior; and
4. the build and hardware test that will verify the resolution.

Use Android Studio's merge view, resolve one block at a time, then inspect the
resulting diff. Ask for help if you cannot explain the combined code. Never use a
destructive reset as an experiment.

## Git checkpoint

Commit the sensor observation and motor limit behavior, push, and open a pull
request into your personal branch. Include the completed truth table and physical
limit test. Obtain review, merge, and update `student/<your-name>`.

## Ask your AI tutor

> Review my digital-limit OpMode without editing it. Start from my recorded truth
> table, verify the polarity conversion, and enumerate every combination of limit
> state and requested direction. Identify any combination that can drive farther
> into an active limit.

## Check your work

You are finished when:

- telemetry shows both raw and interpreted states;
- your truth table matches repeated physical tests;
- motion toward the active limit is blocked;
- motion away from the active limit remains possible;
- Stop leaves zero motor power; and
- polarity logic has one clear, documented home.

## Reflect

Why is a variable named `limitReached` safer to reason about than using
`!magneticLimit.getState()` throughout the OpMode?

Continue to [Lesson 6: Color Sensing](../06-color-sensing/README.md).
