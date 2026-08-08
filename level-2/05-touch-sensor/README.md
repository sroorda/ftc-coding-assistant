# Lesson 5: Touch Sensor Input

A touch sensor gives the program a simple pressed-or-not-pressed value. In this
lesson, you will read the REV Touch Sensor and make its state visible with
telemetry.

## Your mission

| | |
|---|---|
| **Time** | 30–45 minutes |
| **FTC focus** | `TouchSensor`, Boolean input, telemetry |
| **Git focus** | commit, push, review, and merge one focused hardware change |
| **AI tutor** | check sensor mapping and state interpretation |

## Your goal

By the end of this lesson, you can:

- map a configured touch sensor;
- read whether it is pressed;
- turn a Boolean reading into a readable status; and
- use telemetry to observe changes in real time.

## Get ready

Update `student/<your-name>` and create:

```text
feature/<your-name>/touch-sensor
```

Create `TouchSensorOpMode.java` in the Level 2 package. Confirm the active Driver
Station configuration contains a `REV Touch Sensor` named exactly
`touch_sensor`.

## Start with an OpMode skeleton

Enter this complete skeleton first. The numbered areas show where you will add
code during the lesson.

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.TouchSensor;

@TeleOp(name = "L2 Touch Sensor", group = "Level 2")
public class TouchSensorOpMode extends LinearOpMode {
    private TouchSensor touchSensor;

    @Override
    public void runOpMode() {
        // Area 1: Map the sensor.

        // Area 2: Wait for PLAY.
        waitForStart();

        // Area 3: Read and report the sensor.
        while (opModeIsActive()) {

        }
    }
}
```

Build the project before continuing. Fix any package, import, or syntax errors
first.

## Part 1 — Understand the sensor value

`isPressed()` returns a Boolean:

- `true` means the sensor is pressed; and
- `false` means the sensor is released.

The `TouchSensor` interface translates the electrical signal into this useful
pressed-or-released meaning for your code.

## Part 2 — Map the touch sensor

In **Area 1**, add:

```java
touchSensor = hardwareMap.get(TouchSensor.class, "touch_sensor");

telemetry.addData("Status", "Touch sensor initialized");
telemetry.update();
```

`TouchSensor.class` is the SDK type Java expects. `"touch_sensor"` must exactly
match the active Driver Station configuration name.

Leave the existing `waitForStart()` directly below this code in **Area 2**.

## Part 3 — Read the sensor

Inside the active loop in **Area 3**, add:

```java
boolean pressed = touchSensor.isPressed();
```

This takes one sensor reading for the current pass through the loop.

## Part 4 — Show telemetry

Immediately after reading the sensor, add:

```java
telemetry.addData("Pressed", pressed);
telemetry.addData("Touch sensor", pressed ? "PRESSED" : "RELEASED");
telemetry.update();
```

The first line shows the Boolean value. The second turns the same value into a
status that is easier to read quickly.

## Part 5 — Run and observe

- Build and deploy the project.
- Press INIT and confirm the initialization message appears.
- Press PLAY with the sensor released.
- Confirm telemetry shows `false` and `RELEASED`.
- Press and hold the sensor.
- Confirm telemetry shows `true` and `PRESSED`.
- Release it and confirm the display changes back.
- Repeat the test several times.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/touch-sensor`;
- inspect the `TouchSensorOpMode.java` diff;
- commit with a focused message such as `Add touch sensor telemetry`;
- push and open a pull request into `student/<your-name>`;
- describe the released and pressed telemetry results;
- obtain a review and merge the pull request; and
- update your local personal branch before starting Lesson 6.

## Ask your AI tutor

> Review my touch-sensor OpMode without editing it. Check that I map the correct
> SDK type and configuration name, read the sensor once per loop, and use that
> reading consistently in telemetry.

## Check your work

You are finished when:

- the OpMode finds `touch_sensor`;
- released reports `false` and `RELEASED`;
- pressed reports `true` and `PRESSED`;
- telemetry follows repeated presses and releases; and
- you can explain what the Boolean value means.

Continue to [Lesson 6: Color Sensor Readings](../06-color-sensing/README.md).
