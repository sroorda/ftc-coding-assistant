# Lesson 5: Mechanism Controls, Limits, and Priority

Lesson 4 gave the feeder clear operations, but the OpMode still has an accidental
conflict rule: whichever button appears first in the `if` statement wins. The
subsystem also has no evidence that feeding should stop when the touch sensor is
pressed.

In this lesson, you will make both decisions explicit. The OpMode will select one
operator command per loop, and the subsystem will apply the mechanism's physical
limit before commanding hardware.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | operator command, conflict priority, sampled limit, safe recovery direction |
| **Git focus** | review the requirement table and implementation together |
| **AI tutor** | enumerate input combinations and identify competing output writes |

## Your goal

By the end of this lesson, you can:

- turn several button states into one named command;
- state which command wins when controls conflict;
- prevent motion farther into an active limit;
- allow the reviewed direction that moves away from the limit;
- distinguish requested command from applied hardware output; and
- keep the outer control loop responsive.

## Get ready

Merge Lesson 4 into your cumulative branch, then create:

```text
feature/<your-name>/feeder-controls
```

This walkthrough adds the Level 2 touch sensor named `touch_sensor`. Mount or
position the sensor only through the mentor-approved procedure. For the course
example, **pressed means material is already at the feeder's inward limit**:

- additional `FEED` motion is blocked;
- `REVERSE` is allowed because it moves away from the limit; and
- zero power remains the default.

If that statement does not describe the installed mechanism, stop and revise the
mechanism contract before using the code. A sensor cannot protect a mechanism when
its physical meaning is guessed.

## Part 1 — Write the priority table

Use gamepad 2 right bumper for feed and left bumper for reverse. Apply these rules
from highest to lowest priority:

1. If reverse is requested, select `REVERSE`. This is also the reviewed recovery
   direction when the limit is pressed.
2. Otherwise, if feed is requested, select `FEED`.
3. Otherwise, select `STOP`.
4. Inside the subsystem, if `FEED` was selected while the limit is pressed,
   command zero instead of feeding.

The fourth rule is a hardware safety backstop. The OpMode can still report that
the operator requested `FEED`, while the subsystem reports that the applied output
was blocked.

Predict every button combination:

| Right bumper | Left bumper | Selected command | Limit released: applied result | Limit pressed: applied result |
|---|---|---|---|---|
| false | false | | | |
| true | false | | | |
| false | true | | | |
| true | true | | | |

The final row is not an edge case to ignore. It proves whether the conflict rule
is actually represented in code.

## Part 2 — Add named commands to the subsystem

Open `FeederSubsystem.java`. Add this enum immediately inside the class:

```java
public enum Command {
    STOP,
    FEED,
    REVERSE
}
```

An enum limits the command to three named choices. It is harder to confuse than a
pair of Booleans such as `shouldFeed` and `shouldReverse`, which can both be true.

Add these fields:

```java
private static final String LIMIT_SENSOR_NAME = "touch_sensor";

private TouchSensor limitSensor;
private Command requestedCommand = Command.STOP;
private boolean limitPressed;
private boolean blockedByLimit;
```

Add the import:

```java
import com.qualcomm.robotcore.hardware.TouchSensor;
```

`requestedCommand` records operator intent. `appliedPower` still records the
hardware output. `blockedByLimit` explains why those two may differ.

## Part 3 — Map the sensor and take one snapshot

Replace `initialize(...)` so the powered output is zeroed immediately after it is
mapped, before the new sensor can fail initialization:

```java
feederServo = hardwareMap.get(CRServo.class, SERVO_NAME);
stop(); // This is still the zero-power Lesson 4 operation at this step.
limitSensor = hardwareMap.get(TouchSensor.class, LIMIT_SENSOR_NAME);
limitPressed = limitSensor.isPressed();
requestedCommand = Command.STOP;
blockedByLimit = false;
```

This version compiles before the private `stopHardware()` helper is introduced in
the next part. The complete class later uses that helper directly during
initialization but preserves the same immediate zero-power behavior.

Do not infer pressed or released polarity from a generic digital channel. The
Level 2 hardware contract maps the REV device through the SDK `TouchSensor`
interface, whose `isPressed()` method supplies the Boolean used here.

## Part 4 — Replace separate operations with `update(...)`

Add one update operation that every TeleOp and autonomous call will share:

```java
public void update(Command command) {
    requestedCommand = command;
    limitPressed = limitSensor.isPressed();
    blockedByLimit = false;

    switch (requestedCommand) {
        case FEED:
            if (limitPressed) {
                blockedByLimit = true;
                stopHardware();
            } else {
                setPower(FEED_POWER);
            }
            break;

        case REVERSE:
            setPower(REVERSE_POWER);
            break;

        case STOP:
        default:
            stopHardware();
            break;
    }
}
```

The method takes one sensor snapshot per update and applies exactly one output
path. It does not contain an inner loop or wait for the sensor to change.

Rename the original zero-power implementation so `update(...)` can stop hardware
without changing the requested command:

```java
private void stopHardware() {
    setPower(0.0);
}
```

Then change both powered public operations to use the same update path. Keep Stop
independent from the sensor read so a sensor problem cannot prevent a zero-power
command:

```java
public void feed() {
    update(Command.FEED);
}

public void reverse() {
    update(Command.REVERSE);
}

public void stop() {
    requestedCommand = Command.STOP;
    blockedByLimit = false;
    stopHardware();
}
```

This gives every powered caller—including later autonomous code—the same limit
rule. The private `stopHardware()` method remains important: when `FEED` is
blocked, telemetry should continue to show the requested command as `FEED`,
applied power as zero, and `blockedByLimit` as true. Calling public `stop()` inside
that case would erase the evidence about why the mechanism did not move.

## Part 5 — Add evidence getters

Add:

```java
public Command getRequestedCommand() {
    return requestedCommand;
}

public boolean isLimitPressed() {
    return limitPressed;
}

public boolean isBlockedByLimit() {
    return blockedByLimit;
}
```

`getAppliedPower()` remains unchanged. The OpMode can now report request, evidence,
decision, and output without reading the sensor or servo directly.

## Part 6 — Check the complete updated subsystem

Compare your assembled file with this version:

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.robotcore.hardware.CRServo;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.hardware.TouchSensor;
import com.qualcomm.robotcore.util.Range;

public final class FeederSubsystem {
    public enum Command {
        STOP,
        FEED,
        REVERSE
    }

    private static final String SERVO_NAME = "continuous_servo";
    private static final String LIMIT_SENSOR_NAME = "touch_sensor";

    private static final double MAX_POWER = 0.25;
    private static final double FEED_POWER = 0.25;
    private static final double REVERSE_POWER = -0.25;

    private CRServo feederServo;
    private TouchSensor limitSensor;

    private double appliedPower;
    private Command requestedCommand = Command.STOP;
    private boolean limitPressed;
    private boolean blockedByLimit;

    public void initialize(HardwareMap hardwareMap) {
        feederServo = hardwareMap.get(CRServo.class, SERVO_NAME);
        stopHardware();
        limitSensor = hardwareMap.get(TouchSensor.class, LIMIT_SENSOR_NAME);
        limitPressed = limitSensor.isPressed();
        requestedCommand = Command.STOP;
        blockedByLimit = false;
    }

    public void feed() {
        update(Command.FEED);
    }

    public void reverse() {
        update(Command.REVERSE);
    }

    public void stop() {
        requestedCommand = Command.STOP;
        blockedByLimit = false;
        stopHardware();
    }

    public void update(Command command) {
        requestedCommand = command;
        limitPressed = limitSensor.isPressed();
        blockedByLimit = false;

        switch (requestedCommand) {
            case FEED:
                if (limitPressed) {
                    blockedByLimit = true;
                    stopHardware();
                } else {
                    setPower(FEED_POWER);
                }
                break;

            case REVERSE:
                setPower(REVERSE_POWER);
                break;

            case STOP:
            default:
                stopHardware();
                break;
        }
    }

    public double getAppliedPower() {
        return appliedPower;
    }

    public Command getRequestedCommand() {
        return requestedCommand;
    }

    public boolean isLimitPressed() {
        return limitPressed;
    }

    public boolean isBlockedByLimit() {
        return blockedByLimit;
    }

    private void stopHardware() {
        setPower(0.0);
    }

    private void setPower(double requestedPower) {
        appliedPower = Range.clip(requestedPower, -MAX_POWER, MAX_POWER);
        feederServo.setPower(appliedPower);
    }
}
```

`feed()`, `reverse()`, and direct `update(...)` calls now apply the same sensor
snapshot and command rules. `stop()` always commands zero without depending on a
fresh sensor read. The subsystem is ready to preserve this behavior when
autonomous code begins using its named operations.

## Part 7 — Build the operator-control OpMode

Create `FeederControlOpMode.java`:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.FeederSubsystem;

@TeleOp(name = "L3 Feeder Controls", group = "Level 3")
public class FeederControlOpMode extends LinearOpMode {
    @Override
    public void runOpMode() {
        FeederSubsystem feeder = new FeederSubsystem();
        feeder.initialize(hardwareMap);

        telemetry.addLine("Right bumper=feed");
        telemetry.addLine("Left bumper=reverse/recovery");
        telemetry.addData("Status", "Feeder initialized");
        telemetry.update();

        waitForStart();

        while (opModeIsActive()) {
            boolean feedRequested = gamepad2.right_bumper;
            boolean reverseRequested = gamepad2.left_bumper;

            FeederSubsystem.Command selectedCommand;

            if (reverseRequested) {
                selectedCommand = FeederSubsystem.Command.REVERSE;
            } else if (feedRequested) {
                selectedCommand = FeederSubsystem.Command.FEED;
            } else {
                selectedCommand = FeederSubsystem.Command.STOP;
            }

            feeder.update(selectedCommand);

            telemetry.addData("Feed requested", feedRequested);
            telemetry.addData("Reverse requested", reverseRequested);
            telemetry.addData(
                    "Selected command",
                    feeder.getRequestedCommand());
            telemetry.addData("Limit pressed", feeder.isLimitPressed());
            telemetry.addData("Blocked by limit", feeder.isBlockedByLimit());
            telemetry.addData(
                    "Applied power",
                    "%.2f",
                    feeder.getAppliedPower());
            telemetry.update();
        }

        feeder.stop();
    }
}
```

Read the active loop as a short pipeline:

```text
read both buttons once
→ select one command using documented priority
→ sample the limit and apply one subsystem output
→ report request, evidence, decision, and output
→ repeat
```

There are not two independent `if` blocks that can write two different powers in
the same loop. There is one selected command and one subsystem update.

## Part 8 — Test with powered output disabled

For the first run, temporarily change all three branches in `update(...)` to call
`stopHardware()`. Keep the selected command, limit snapshot, and blocked decision
active.

Use telemetry to complete your prediction table for all four button combinations
with the sensor released and pressed. Verify especially that both buttons select
`REVERSE`.

Restore the reviewed feed and reverse calls only after the decision evidence is
correct.

## Part 9 — Test the physical limit

Secure the mechanism and begin at the approved limited powers:

| Scenario | Verify |
|---|---|
| No buttons, limit released | Selected command is `STOP`; applied power is zero. |
| Feed only, limit released | Selected command is `FEED`; positive limited power is applied. |
| Reverse only, limit released | Selected command is `REVERSE`; negative limited power is applied. |
| Both buttons, limit released | `REVERSE` wins and only reverse power is applied. |
| Feed while limit is pressed | Requested command remains `FEED`, blocked is true, and power is zero. |
| Reverse while limit is pressed | Reverse power is allowed as the reviewed recovery direction. |
| Release all controls | Selected command becomes `STOP` and power becomes zero. |
| Driver Station **Stop** during motion | The loop ends and final `stop()` removes power. |

Never create a limit test by jamming or obstructing a powered mechanism. Activate
the sensor through the approved fixture or manual procedure while the mechanism
cannot injure a person or damage itself.

## Optional extension — Toggle only when the mechanism needs it

Some mechanisms use a press-to-toggle control instead of a held button. Level 2
already introduced rising-edge detection, and SDK 11.2.1 includes the
`ConceptGamepadEdgeDetection` sample. Use that pattern only when the written
control contract calls for a toggle.

Do not copy the sample's two-second telemetry delay into a driving TeleOp. A long
sleep would make drive, mechanism, telemetry, and Stop-related application logic
unresponsive between loop updates.

## Git checkpoint

Keep the requirement visible in the review. Useful commits are:

```text
Add feeder command and limit handling
Add explicit operator control priority
```

The pull request should include the completed four-combination table and the
normal, conflict, limit, recovery, release, and Stop results.

## Ask your AI tutor

> Review my priority table, `FeederSubsystem`, and control OpMode without editing.
> For every button combination and both sensor states, list the selected command,
> applied power, blocked value, and rule that wins. Find duplicate output writes,
> unsafe retained power, and any path that blocks the recovery direction.

## Check your work

You are finished when:

- every button combination has one documented result;
- both buttons select the reviewed recovery command;
- the active limit blocks feed but allows the reviewed reverse direction;
- telemetry distinguishes raw request, selected command, limit, block, and output;
- the loop contains no blocking wait and calls one subsystem update; and
- release and Driver Station Stop remove powered output.

## Reflect

Why is “the selected command was `FEED`” not enough evidence that the feeder
actually received feed power?

Continue to [Lesson 6: TeleOp Integration Challenge](../06-teleop-integration-challenge/README.md).
