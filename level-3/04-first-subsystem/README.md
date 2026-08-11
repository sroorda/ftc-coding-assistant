# Lesson 4: Build One Reusable Mechanism Subsystem

Level 2 taught you to place repeated device mapping and safe limits in a hardware
class. A subsystem takes the next step: it gives a mechanism operations named in
robot language, such as `feed()`, `reverse()`, and `stop()`.

This walkthrough uses the tested continuous-rotation servo from Level 2 as a small
feeder. The mechanism is intentionally simple so you can see exactly which code
moves behind the new boundary. The same pattern can later be adapted to the team's
intake, conveyor, or another already-tested mechanism.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | subsystem boundary, private hardware, named operations, safe output |
| **Git focus** | preserve behavior while moving responsibility |
| **AI tutor** | trace every old hardware call to its new location |

## Your goal

By the end of this lesson, you can:

- explain the difference between an OpMode and a subsystem;
- move tested mapping and power rules without redesigning them;
- keep hardware fields private;
- expose mechanism operations in team vocabulary; and
- prove that behavior before and after the refactor is the same.

## Get ready

Merge Lesson 3 into your cumulative branch, then create:

```text
feature/<your-name>/feeder-subsystem
```

This lesson uses the Level 2 hardware-contract values:

```text
configuration name: continuous_servo
maximum magnitude:   0.25
```

Run the Level 2 continuous-servo OpMode and confirm its start, reverse, release,
and Stop behavior before refactoring. If the team's mechanism uses another tested
device or safe value, update the written mechanism contract first and substitute
those reviewed facts consistently.

Record the baseline:

| Behavior | Before refactor | After refactor | Preserved? |
|---|---|---|---|
| INIT commands zero power. | | | |
| Feed direction uses limited power. | | | |
| Reverse direction uses limited power. | | | |
| Releasing controls commands zero. | | | |
| Driver Station Stop commands zero. | | | |

## Part 1 — Decide what crosses the boundary

Create this small contract before writing the class:

| Operation | Meaning | Servo command | Expected end or release behavior |
|---|---|---:|---|
| `initialize(...)` | map the configured feeder and start safely | `0.0` | remains stopped |
| `feed()` | move material into the robot | `+0.25` | caller later selects another operation |
| `reverse()` | move material out of the robot | `-0.25` | caller later selects another operation |
| `stop()` | remove powered motion | `0.0` | remains stopped |

The positive and negative meanings must come from the observed mechanism. If the
installed feeder runs the opposite physical direction, swap the two reviewed
constants and update the contract. Do not scatter extra minus signs through the
OpMode.

The responsibilities divide like this:

| `FeederSubsystem` owns | The OpMode keeps |
|---|---|
| configuration name and mapping | `waitForStart()` and `opModeIsActive()` |
| private servo field | gamepad button choices |
| safe power limit | conflict priority between controls |
| `feed()`, `reverse()`, and `stop()` | Driver Station telemetry |
| last applied power | deciding when the test begins and ends |

A subsystem does not read `gamepad2`, call `waitForStart()`, or own the Driver
Station display. Those are coordination and lifecycle responsibilities.

## Part 2 — Create the subsystem shell

Create this file:

```text
org.firstinspires.ftc.teamcode.level3.subsystems.FeederSubsystem
```

Enter the package, imports, class, constants, and fields:

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.robotcore.hardware.CRServo;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.util.Range;

public final class FeederSubsystem {
    private static final String SERVO_NAME = "continuous_servo";
    private static final double MAX_POWER = 0.25;
    private static final double FEED_POWER = 0.25;
    private static final double REVERSE_POWER = -0.25;

    private CRServo feederServo;
    private double appliedPower;
}
```

The servo is private. Code outside this class can request feeder behavior but
cannot call `setPower(...)` directly and bypass `MAX_POWER`.

## Part 3 — Move initialization without changing it

Add:

```java
public void initialize(HardwareMap hardwareMap) {
    feederServo = hardwareMap.get(CRServo.class, SERVO_NAME);
    stop();
}
```

This is the same mapping and zero-power initialization proven in Level 2. The
method does not send telemetry or wait for Start because the subsystem does not
own the FTC lifecycle.

Build now. At this checkpoint the new class compiles, but no OpMode uses it and no
behavior has changed.

## Part 4 — Add one private hardware command

Add this private method:

```java
private void setPower(double requestedPower) {
    appliedPower = Range.clip(requestedPower, -MAX_POWER, MAX_POWER);
    feederServo.setPower(appliedPower);
}
```

Every named operation will pass through this method. `Range.clip(...)` keeps an
accidental future request inside the reviewed feeder limit. `appliedPower` stores
the value used for telemetry without exposing the servo object.

## Part 5 — Add operations in robot language

Add:

```java
public void feed() {
    setPower(FEED_POWER);
}

public void reverse() {
    setPower(REVERSE_POWER);
}

public void stop() {
    setPower(0.0);
}

public double getAppliedPower() {
    return appliedPower;
}
```

Compare these two possible calling styles:

```java
feederServo.setPower(0.25);
```

```java
feeder.feed();
```

The first line describes an electrical command and relies on the caller to know
the correct sign and limit. The second describes the robot behavior the caller
wants. TeleOp and autonomous code can later request the same operation.

### Check the complete subsystem

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.robotcore.hardware.CRServo;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.util.Range;

public final class FeederSubsystem {
    private static final String SERVO_NAME = "continuous_servo";
    private static final double MAX_POWER = 0.25;
    private static final double FEED_POWER = 0.25;
    private static final double REVERSE_POWER = -0.25;

    private CRServo feederServo;
    private double appliedPower;

    public void initialize(HardwareMap hardwareMap) {
        feederServo = hardwareMap.get(CRServo.class, SERVO_NAME);
        stop();
    }

    public void feed() {
        setPower(FEED_POWER);
    }

    public void reverse() {
        setPower(REVERSE_POWER);
    }

    public void stop() {
        setPower(0.0);
    }

    public double getAppliedPower() {
        return appliedPower;
    }

    private void setPower(double requestedPower) {
        appliedPower = Range.clip(requestedPower, -MAX_POWER, MAX_POWER);
        feederServo.setPower(appliedPower);
    }
}
```

Build again. Inspect this file by itself and confirm that it contains no gamepad,
telemetry, loop, timer, or `LinearOpMode` reference.

## Part 6 — Create a focused subsystem test

Create `FeederTestOpMode.java` in the Level 3 package:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.FeederSubsystem;

@TeleOp(name = "L3 Feeder Test", group = "Level 3")
public class FeederTestOpMode extends LinearOpMode {
    @Override
    public void runOpMode() {
        FeederSubsystem feeder = new FeederSubsystem();
        feeder.initialize(hardwareMap);

        telemetry.addLine("Right bumper=feed");
        telemetry.addLine("Left bumper=reverse");
        telemetry.addData("Status", "Feeder initialized");
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            String requestedOperation;

            if (gamepad2.right_bumper) {
                feeder.feed();
                requestedOperation = "FEED";
            } else if (gamepad2.left_bumper) {
                feeder.reverse();
                requestedOperation = "REVERSE";
            } else {
                feeder.stop();
                requestedOperation = "STOP";
            }

            telemetry.addData("Requested operation", requestedOperation);
            telemetry.addData(
                    "Applied feeder power",
                    "%.2f",
                    feeder.getAppliedPower());
            telemetry.update();
        }

        feeder.stop();
    }
}
```

The OpMode reads gamepad 2 and chooses an operation. The subsystem translates
that operation into a limited hardware command. Releasing both bumpers reaches
the `else` on the next loop and explicitly stops the servo.

For this first test, press only one bumper at a time. The `if` order currently
makes feed win when both are held; Lesson 5 will replace that accidental code
order with a documented conflict rule.

## Part 7 — Test behavior before and after

Secure the mechanism using the same safety procedure as Level 2. Build, deploy,
and complete the right side of the baseline table:

| Test | Verify |
|---|---|
| Press **INIT**. | Applied power is `0.00`; the feeder does not move. |
| Hold gamepad 2 right bumper. | Telemetry shows `FEED` and limited positive power. |
| Release right bumper. | The requested operation becomes `STOP` and power becomes zero. |
| Hold gamepad 2 left bumper. | Telemetry shows `REVERSE` and limited negative power. |
| Release left bumper. | Power becomes zero. |
| Press Driver Station **Stop** while feeding. | The OpMode ends and the final `stop()` command removes power. |

Behavior should match the Level 2 device test. The important change is where the
responsibility lives, not how fast or which way the mechanism moves.

If behavior changes unexpectedly, compare one old call at a time:

| Before | After |
|---|---|
| `hardwareMap.get(CRServo.class, "continuous_servo")` | `feeder.initialize(hardwareMap)` maps the same name. |
| `continuousServo.setPower(0.25)` | `feeder.feed()` applies the same reviewed value. |
| `continuousServo.setPower(-0.25)` | `feeder.reverse()` applies the same reviewed value. |
| `continuousServo.setPower(0.0)` | `feeder.stop()` applies zero. |

## How this relates to the FTC SDK example

The SDK pair `RobotHardware` and `ConceptExternalHardwareClass` demonstrates
moving hardware access into a reusable class. This lesson uses the same core idea
with a narrower boundary:

- the subsystem receives `HardwareMap`, not the whole `LinearOpMode`;
- gamepad and telemetry stay in the OpMode;
- hardware fields remain private; and
- public methods use mechanism language instead of exposing generic servo power.

The SDK example gives you a proven pattern to inspect. The course adaptation makes
the ownership boundary visible for later TeleOp and autonomous reuse.

## Git checkpoint

Use at least two commits so the refactor remains reviewable:

```text
Add reusable feeder subsystem
Use feeder subsystem from test OpMode
```

In the pull request, include the completed before/after table and one trace written
in this form:

```text
gamepad 2 right bumper
→ FeederTestOpMode selects FEED
→ FeederSubsystem.feed()
→ private setPower(...) applies the limit
→ CRServo.setPower(...)
```

## Ask your AI tutor

> Review my feeder refactor without editing. Trace each old mapping, power, and
> stop call to the new subsystem. Flag behavior changes and any gamepad, telemetry,
> lifecycle, or public hardware field that crossed the intended boundary. Suggest
> one before/after test for each material difference.

## Check your work

You are finished when:

- the pre-refactor and post-refactor hardware results match;
- all feeder power commands pass through one private limited method;
- the subsystem exposes named operations and no raw hardware field;
- the OpMode owns gamepad decisions, lifecycle, and telemetry;
- INIT, release, and Driver Station Stop all command zero; and
- the reviewed pull request contains the responsibility trace and test evidence.

## Reflect

Which responsibility became clearer after the refactor, and what additional
abstraction would still be premature for this one-device mechanism?

Continue to [Lesson 5: Mechanism Controls, Limits, and Priority](../05-mechanism-controls-and-limits/README.md).
