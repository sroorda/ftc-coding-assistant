# Lesson 3: Positional Servos

A positional servo moves toward a commanded position and attempts to hold it.
In this lesson, you will command the servo's zero position, then use the D-pad to
increase and decrease its position one step at a time.

## Your mission

| | |
|---|---|
| **Time** | 45–60 minutes |
| **FTC focus** | `Servo`, normalized position, gamepad press detection, telemetry |
| **Git focus** | commit, push, review, and merge one focused hardware change |
| **AI tutor** | check position limits and explain code without inventing hardware behavior |

## Your goal

By the end of this lesson, you can:

- explain what servo positions `0.0` through `1.0` mean;
- command a servo's zero position;
- increment and decrement its position with the D-pad; and
- use telemetry to observe the requested and commanded positions.

## Get ready

Update `student/<your-name>` and create:

```text
feature/<your-name>/positional-servo
```

Create `PositionalServoOpMode.java` in the Level 2 package. Confirm the active
Driver Station configuration contains a `Servo` named exactly
`position_servo`.

Clear the servo horn and linkage before pressing INIT. The servo can move during
initialization.

## Start with an OpMode skeleton

Enter this complete skeleton first. The numbered areas show where you will add
code during the lesson.

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.Servo;
import com.qualcomm.robotcore.util.Range;

@TeleOp(name = "L2 Positional Servo", group = "Level 2")
public class PositionalServoOpMode extends LinearOpMode {
    private Servo positionServo;

    @Override
    public void runOpMode() {
        // Area 1: Map and initialize the servo.

        // Area 2: Wait for PLAY.
        waitForStart();

        // Area 3: Read the gamepad and command the servo.
        while (opModeIsActive()) {

        }
    }
}
```

Build the project before continuing. Fix any package, import, or syntax errors
first.

## Part 1 — Understand servo position

The FTC `Servo` class uses normalized position values:

- `0.0` is one end of the configured range;
- `0.5` is the midpoint; and
- `1.0` is the other end.

These values are not degrees. The physical angle depends on the servo and how it
is installed. `getPosition()` reports the last commanded position; it does not
measure the horn's physical position.

## Part 2 — Map the servo and command zero

Add these constants near the top of the class, above the `positionServo` field:

```java
private static final double ZERO_POSITION = 0.0;
private static final double POSITION_STEP = 0.05;
```

In **Area 1**, map the servo, create the position variable, and command zero:

```java
positionServo = hardwareMap.get(Servo.class, "position_servo");

double targetPosition = ZERO_POSITION;
positionServo.setPosition(targetPosition);
```

This commands position `0.0`; it does not mechanically home or measure the
servo. The servo may move as soon as INIT is pressed.

Still in **Area 1**, add initialization telemetry:

```java
telemetry.addData("Status", "Servo initialized");
telemetry.addData("Position", "%.2f", targetPosition);
telemetry.update();
```

Leave the existing `waitForStart()` directly below this code in **Area 2**.

### Run the initialization checkpoint

Test the code before adding the D-pad controls:

- clear the servo horn and linkage;
- build and deploy the project;
- select **L2 Positional Servo** on the Driver Station; and
- press INIT.

You should see:

- the servo move once toward position `0.0`, unless it is already there;
- `Status: Servo initialized` on the Driver Station; and
- `Position: 0.00` on the Driver Station.

Do not press PLAY yet; the active loop does not contain control code. Press Stop
after checking initialization. If the OpMode cannot find `position_servo`, the
servo approaches interference, or telemetry does not show `0.00`, correct that
problem before continuing.

## Part 3 — Change the target with the D-pad

Inside the active loop in **Area 3**, add:

```java
if (gamepad1.dpadUpWasPressed()) {
    targetPosition += POSITION_STEP;
} else if (gamepad1.dpadDownWasPressed()) {
    targetPosition -= POSITION_STEP;
}
```

`dpadUpWasPressed()` and `dpadDownWasPressed()` are true once for each new
press. Holding a direction does not repeatedly change the target. The `else if`
ensures that at most one change is applied during each loop.

## Part 4 — Keep the target in range

Immediately after the D-pad code in **Area 3**, add:

```java
targetPosition = Range.clip(targetPosition, 0.0, 1.0);
```

This keeps the command inside the FTC servo range even if the student continues
pressing the D-pad at an endpoint.

## Part 5 — Command the servo and show telemetry

Add this next, still inside the loop in **Area 3**:

```java
positionServo.setPosition(targetPosition);

telemetry.addData("Target position", "%.2f", targetPosition);
telemetry.addData(
        "Commanded position",
        "%.2f",
        positionServo.getPosition());
telemetry.update();
```

- `targetPosition` is the value calculated by your program.
- `getPosition()` is the position command stored by the servo object. It is not
  physical feedback from the servo.

## Part 6 — Run and observe

- Build and deploy the project.
- Press INIT and confirm the servo moves to position `0.0`.
- Press PLAY.
- Press D-pad Up several times and confirm each press adds `0.05`.
- Press D-pad Down and confirm each press subtracts `0.05`.
- Hold a D-pad direction and confirm the position changes only once.
- Confirm telemetry never shows a target below `0.0` or above `1.0`.
- Compare the servo's movement with the telemetry values.

Press Driver Station Stop immediately if the servo approaches interference or
places strain on the mechanism.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/positional-servo`;
- inspect the `PositionalServoOpMode.java` diff;
- commit with a focused message such as `Add positional servo control`;
- push and open a pull request into `student/<your-name>`;
- describe how INIT, D-pad Up, and D-pad Down moved the servo;
- obtain a review and merge the pull request; and
- update your local personal branch before starting Lesson 4.

## Ask your AI tutor

> Review my positional-servo OpMode without editing it. Check that each D-pad
> press changes the target once, the position stays between 0.0 and 1.0, and my
> telemetry distinguishes the calculated target from the stored command.

## Check your work

You are finished when:

- INIT commands position `0.0`;
- each D-pad press changes the target by `0.05`;
- holding the D-pad does not repeatedly change the target;
- all commands stay between `0.0` and `1.0`;
- telemetry shows the target and commanded positions; and
- you can explain why `getPosition()` is not physical feedback.

Continue to
[Lesson 4: Continuous-Rotation Servos](../04-continuous-rotation-servos/README.md).
