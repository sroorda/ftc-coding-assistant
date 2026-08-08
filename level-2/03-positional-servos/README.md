# Lesson 3: Positional Servos

A positional servo moves toward a commanded position and attempts to hold it. You
will explore a safe portion of its range, replace unexplained numbers with named
positions, and trigger each movement once per button press.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | `Servo`, mechanical limits, named positions, button edges |
| **Git focus** | review another student's intent and test evidence |
| **AI tutor** | look for unsafe ranges and unexplained constants |

## Your goal

By the end of this lesson, you can:

- explain how the normalized servo range relates to physical motion;
- distinguish a software limit from a mechanical stop;
- use named constants for meaningful positions; and
- command a servo without repeatedly retriggering one button press.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/positional-servo
```

Create `PositionalServoOpMode.java`. Confirm the configured device name is
`position_servo` and that the servo horn has clearance through a small movement
around its current position.

## Position is not angle

FTC's `Servo` interface accepts a normalized command from `0.0` through `1.0`.
Those endpoints represent the configured PWM range, not a guaranteed number of
degrees. The physical result depends on the servo, its programming, linkage, horn,
and installation.

A software command inside `0.0–1.0` can still drive a linkage into a mechanical
stop. Begin near the middle and change only a small amount at a time.

## Explore a conservative range

Map the device:

```java
Servo positionServo = hardwareMap.get(Servo.class, "position_servo");
```

Start with a position of `0.50`. Use two buttons to request changes of `0.02`, and
clip the experimental value to a deliberately narrow initial range such as
`0.40–0.60`.

Before the first command, predict which physical direction an increase will move
the horn and write down what would tell you to stop the test.

A normal active loop runs many times while a button is held. Use rising-edge
detection so one press produces one step. You may track the previous button state
yourself or use the button edge helpers supported by FTC SDK `11.2.1`.

Report the requested position before calling `setPosition(...)` and after the
command. `getPosition()` reports the last commanded logical position; it does not
measure the horn's physical angle.

## Complete one area at a time

### 1. Define the experimental limits

Place named values near the top of the class:

```java
private static final double START_POSITION = 0.50;
private static final double STEP_SIZE = 0.02;
private static final double MIN_TEST_POSITION = 0.40;
private static final double MAX_TEST_POSITION = 0.60;
```

These are software limits for the first exploration, not proof of the mechanism's
physical limits. The names make the safety assumptions visible in code.

### 2. Map and initialize the servo

Add the `Range` import, then map the configured servo:

```java
import com.qualcomm.robotcore.util.Range;

Servo positionServo = hardwareMap.get(Servo.class, "position_servo");
double requestedPosition = START_POSITION;
positionServo.setPosition(requestedPosition);
```

Calling `setPosition()` during initialization can move the horn as soon as INIT is
pressed. Clear the mechanism before INIT, not only before PLAY. The expected
result is one movement toward the conservative start position.

### 3. Detect a new press instead of a held button

Before the active loop, remember the previous state of each button:

```java
boolean previousIncreaseButton = false;
boolean previousDecreaseButton = false;
```

Inside the loop, compare the current and previous states:

```java
boolean increaseButton = gamepad1.dpad_up;
boolean decreaseButton = gamepad1.dpad_down;

boolean increasePressed = increaseButton && !previousIncreaseButton;
boolean decreasePressed = decreaseButton && !previousDecreaseButton;
```

`increasePressed` is true for only the first loop after the button changes from
not pressed to pressed. Holding the button does not create another edge.

### 4. Change and clip the requested position

```java
if (increasePressed && !decreasePressed) {
    requestedPosition += STEP_SIZE;
} else if (decreasePressed && !increasePressed) {
    requestedPosition -= STEP_SIZE;
}

requestedPosition = Range.clip(
        requestedPosition,
        MIN_TEST_POSITION,
        MAX_TEST_POSITION);
positionServo.setPosition(requestedPosition);
```

If both buttons are newly pressed together, this rule makes no change. `Range.clip`
prevents the variable from crossing the chosen test limits. At a limit, another
press requests the same boundary value rather than moving farther.

### 5. Report the command and save button history

At the end of each loop:

```java
telemetry.addData("Requested position", "%.2f", requestedPosition);
telemetry.addData("Servo command", "%.2f", positionServo.getPosition());
telemetry.update();

previousIncreaseButton = increaseButton;
previousDecreaseButton = decreaseButton;
```

Saving the current states prepares the next loop to detect a new edge. The two
telemetry values normally match because neither one measures the horn's physical
position.

## Student task

Implement an OpMode that:

1. Maps `position_servo` and initializes it to a conservative center position.
2. Waits for Start and honors Stop.
3. Moves one small increment for each selected increase-button press.
4. Moves one small increment for each selected decrease-button press.
5. Clips the requested value to the experimental range.
6. Displays requested position and reported servo position in telemetry.
7. Never scans automatically from `0.0` to `1.0`.

Build after mapping and initialization, then test one button and one direction at
a time. Do not wait until the whole checklist is finished to discover a wrong
configuration name or unsafe starting position.

Test one increment at a time. Observe the mechanism after every change. If the
motion approaches interference or strain, stop, return to the last safe value, and
record the limit.

After finding three conservative useful positions, replace the exploratory
numbers with named constants such as:

```java
private static final double HOME_POSITION = 0.48;
private static final double MID_POSITION = 0.52;
private static final double ACTIVE_POSITION = 0.58;
```

The example values are placeholders. Use the safe values supported by your test
evidence. Map three separate buttons to the named positions and keep telemetry.
You can reuse the same rising-edge pattern, replacing the `STEP_SIZE` calculation
with assignment to the selected named position.

## Review another student's pull request

When reviewing this lesson, look for:

- a narrow, evidence-based range;
- constants named for mechanism intent;
- one action per button press;
- telemetry that distinguishes requested from measured behavior; and
- no unrelated changes to SDK or sample files.

Do not approve solely because the project builds. Ask what physical movement was
observed at each named position.

## Git checkpoint

Commit, push, and open a pull request into your personal branch. Include the three
tested positions and observed movement in the description. Review another
student's servo pull request while yours is awaiting review, then merge the
approved work and update `student/<your-name>`.

## Ask your AI tutor

> Review my positional-servo OpMode without editing. Find commands outside my
> documented safe range, unexplained numeric positions, and buttons that could
> trigger repeatedly while held. Ask me for physical test evidence for each named
> position.

## Check your work

You are finished when:

- one button press produces one intended movement;
- all commands stay within the tested safe range;
- three meaningful positions have descriptive names;
- telemetry reports the commanded value accurately;
- you can explain why `getPosition()` is not physical feedback; and
- the reviewed change is merged into your personal branch.

## Reflect

Why is `0.0–1.0` a valid API range but not automatically a safe mechanism range?

Continue to
[Lesson 4: Continuous-Rotation Servos](../04-continuous-rotation-servos/README.md).
