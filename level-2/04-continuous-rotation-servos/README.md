# Lesson 4: Continuous-Rotation Servos

A continuous-rotation servo uses a power command instead of a position command.
In this lesson, you will initialize the servo with a `0.0` power command and use
one gamepad button to alternate between running and stopped.

## Your mission

| | |
|---|---|
| **Time** | 45–60 minutes |
| **FTC focus** | `CRServo`, power commands, gamepad press detection, telemetry |
| **Git focus** | commit, push, review, and merge one focused hardware change |
| **AI tutor** | check the start/stop logic and every power-command path |

## Your goal

By the end of this lesson, you can:

- explain how a CR-servo power command differs from a positional-servo position
  command;
- initialize a CR servo with a `0.0` power command;
- use one button to start and stop the servo; and
- use telemetry to observe the requested and stored power commands.

## Get ready

Update `student/<your-name>` and create:

```text
feature/<your-name>/continuous-servo
```

Create `ContinuousServoOpMode.java` in the Level 2 package. Confirm the active
Driver Station configuration contains a `Continuous Rotation Servo` named
exactly `continuous_servo`.

Clear the servo horn and anything connected to it before pressing INIT. Confirm
that continuous rotation cannot wind a cable or strike the bench.

## Start with an OpMode skeleton

Enter this complete skeleton first. The numbered areas show where you will add
code during the lesson.

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.CRServo;

@TeleOp(name = "L2 Continuous Servo", group = "Level 2")
public class ContinuousServoOpMode extends LinearOpMode {
    private CRServo continuousServo;

    @Override
    public void runOpMode() {
        // Area 1: Map and initialize the servo.

        // Area 2: Wait for PLAY.
        waitForStart();

        // Area 3: Read the gamepad and command the servo.
        while (opModeIsActive()) {

        }

        // Area 4: Stop the servo when the OpMode ends.
    }
}
```

Build the project before continuing. Fix any package, import, or syntax errors
first.

## Part 1 — Understand CR-servo power commands

A positional servo uses `setPosition()`. A continuous-rotation servo uses
`setPower()`:

- `0.0` commands the servo to stop;
- a positive command rotates in one direction; and
- a negative command rotates in the opposite direction.

The value passed to `setPower()` is a normalized SDK control command, not a
measurement or direct setting of electrical watts or current. Its sign requests
direction, and its magnitude requests rotation speed. `getPower()` reports the
last power command; it does not measure the servo's rotation speed.

## Part 2 — Map the servo and command stop

Add these constants near the top of the class, above the `continuousServo`
field:

```java
private static final double RUN_POWER = 0.25;
private static final double STOP_POWER = 0.0;
```

In **Area 1**, map the servo, create its running state, and command `0.0`:

```java
continuousServo = hardwareMap.get(CRServo.class, "continuous_servo");

boolean servoRunning = false;
continuousServo.setPower(STOP_POWER);
```

Still in **Area 1**, add initialization telemetry:

```java
telemetry.addData("Status", "Servo stopped");
telemetry.addData("Power command", "%.2f", continuousServo.getPower());
telemetry.update();
```

Leave the existing `waitForStart()` directly below this code in **Area 2**.

## Part 3 — Toggle the running state with one button

Inside the active loop in **Area 3**, add:

```java
if (gamepad1.aWasPressed()) {
    servoRunning = !servoRunning;
}
```

Each new A-button press reverses the Boolean value:

- `false` becomes `true`, starting the servo; and
- `true` becomes `false`, stopping the servo.

Because `aWasPressed()` is true once for each new press, holding A does not
repeatedly switch between running and stopped.

## Part 4 — Convert the state into a power command

Immediately after the button code in **Area 3**, add:

```java
double requestedPower = servoRunning ? RUN_POWER : STOP_POWER;
continuousServo.setPower(requestedPower);
```

The conditional expression selects `RUN_POWER` when `servoRunning` is true and
`STOP_POWER` when it is false.

## Part 5 — Show telemetry

Add this next, still inside the loop in **Area 3**:

```java
telemetry.addData("Running", servoRunning);
telemetry.addData("Requested power command", "%.2f", requestedPower);
telemetry.addData(
        "Stored power command",
        "%.2f",
        continuousServo.getPower());
telemetry.update();
```

- `requestedPower` is selected by your start/stop logic.
- `getPower()` is the command stored by the CR-servo object. It is not measured
  speed.

## Part 6 — Stop when the OpMode ends

In **Area 4**, after the active loop, add:

```java
continuousServo.setPower(STOP_POWER);
```

When Driver Station Stop ends the loop, this line sends the `0.0` stop command.

## Part 7 — Run and test

Build and deploy the project, then complete each test:

| Test | Verify |
|---|---|
| Press **INIT**. | The servo remains stopped, the status says `Servo stopped`, and the power command is `0.00`. |
| Press **PLAY**, then press **A** once. | The servo rotates, `Running` is `true`, and both power commands shown in telemetry are `0.25`. |
| Press **A** again. | The servo stops, `Running` is `false`, and both power commands are `0.00`. |
| Hold **A**. | The running state changes only once because `aWasPressed()` detects a new press rather than a held button. |
| Press **A** several times. | Each new press alternates between running at `0.25` and stopped at `0.00`. |
| Start the servo, then press Driver Station **Stop**. | The servo stops because the code after the active loop sends the `0.0` power command. |

If the servo creeps while its power command is `0.0`, stop the test and check its
neutral calibration.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/continuous-servo`;
- inspect the `ContinuousServoOpMode.java` diff;
- commit with a focused message such as `Add continuous servo toggle`;
- push and open a pull request into `student/<your-name>`;
- describe what happened during INIT, each A-button press, and Driver Station
  Stop;
- obtain a review and merge the pull request; and
- update your local personal branch before starting Lesson 5.

## Ask your AI tutor

> Review my continuous-servo OpMode without editing it. Check that each new
> A-button press toggles the state once, false always sends a 0.0 power command,
> and leaving the active loop stops the servo.

## Check your work

You are finished when:

- INIT sends a `0.0` power command;
- the first A-button press starts the servo with a `0.25` power command;
- the next A-button press stops the servo;
- holding A does not repeatedly toggle the state;
- telemetry shows the running state and power commands; and
- Driver Station Stop leaves the servo with a `0.0` power command.

Continue to
[Lesson 5: Touch Sensor Input](../05-touch-sensor/README.md).
