# Lesson 6: Color Sensor Readings

A color sensor reports numeric color channels rather than a color name. In this
lesson, you will read those channels with telemetry and use a simple comparison
to identify the strongest red, green, or blue reading.

## Your mission

| | |
|---|---|
| **Time** | 45–60 minutes |
| **FTC focus** | `ColorSensor`, RGB values, comparison, telemetry |
| **Git focus** | commit, push, review, and merge one focused hardware change |
| **AI tutor** | check that one sensor snapshot drives telemetry and the decision |

## Your goal

By the end of this lesson, you can:

- map a configured color sensor;
- read its red, green, blue, and alpha channels;
- display the readings with telemetry; and
- turn the strongest RGB channel into a simple color name.

## Get ready

Update `student/<your-name>` and create:

```text
feature/<your-name>/color-sensor
```

Create `ColorSensorOpMode.java` in the Level 2 package. Confirm the active Driver
Station configuration contains a `REV Color/Range Sensor` named exactly
`color_sensor`.

Prepare red, green, and blue samples. Hold each sample at a consistent distance
and angle during testing.

## Start with an OpMode skeleton

Enter this complete skeleton first. The numbered areas show where you will add
code during the lesson.

```java
package org.firstinspires.ftc.teamcode.level2;

import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;
import com.qualcomm.robotcore.hardware.ColorSensor;

@TeleOp(name = "L2 Color Sensor", group = "Level 2")
public class ColorSensorOpMode extends LinearOpMode {
    private ColorSensor colorSensor;

    @Override
    public void runOpMode() {
        // Area 1: Map the sensor.

        // Area 2: Wait for PLAY.
        waitForStart();

        // Area 3: Read, interpret, and report the sensor.
        while (opModeIsActive()) {

        }
    }
}
```

Build the project before continuing. Fix any package, import, or syntax errors
first.

## Part 1 — Understand the color channels

The sensor provides four integer readings:

- `red()` reports the red channel;
- `green()` reports the green channel;
- `blue()` reports the blue channel; and
- `alpha()` reports overall brightness.

The values depend on the sample, distance, angle, and surrounding light. They are
measurements to compare—not guaranteed color names.

## Part 2 — Map the color sensor

In **Area 1**, add:

```java
colorSensor = hardwareMap.get(ColorSensor.class, "color_sensor");

telemetry.addData("Status", "Color sensor initialized");
telemetry.update();
```

Leave the existing `waitForStart()` directly below this code in **Area 2**.

## Part 3 — Read one sensor snapshot

Inside the active loop in **Area 3**, add:

```java
int red = colorSensor.red();
int green = colorSensor.green();
int blue = colorSensor.blue();
int alpha = colorSensor.alpha();
```

Store the readings once and use these same variables for telemetry and the color
decision during this loop.

## Part 4 — Show the raw readings

Immediately after reading the sensor, add:

```java
telemetry.addData("Red", red);
telemetry.addData("Green", green);
telemetry.addData("Blue", blue);
telemetry.addData("Alpha", alpha);
```

Do not call `telemetry.update()` yet. You will add the interpreted result first.

## Part 5 — Identify the strongest RGB channel

Add this below the raw telemetry:

```java
String detectedColor = "UNKNOWN";

if (red > green && red > blue) {
    detectedColor = "RED";
} else if (green > red && green > blue) {
    detectedColor = "GREEN";
} else if (blue > red && blue > green) {
    detectedColor = "BLUE";
}
```

This first rule selects a color only when one channel is greater than both
others. A tie remains `UNKNOWN`.

Add the result and update telemetry:

```java
telemetry.addData("Detected color", detectedColor);
telemetry.update();
```

This comparison is a starting point, not a fully calibrated competition color
detector.

## Part 6 — Run and observe

- Build and deploy the project.
- Press INIT and confirm the initialization message appears.
- Press PLAY.
- Present each red, green, and blue sample at the same distance and angle.
- Compare the four numeric readings for each sample.
- Confirm the detected name matches the strongest RGB channel.
- Try a neutral or poorly lit sample and observe whether the simple rule is still
  useful.

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/color-sensor`;
- inspect the `ColorSensorOpMode.java` diff;
- commit with a focused message such as `Add color sensor readings`;
- push and open a pull request into `student/<your-name>`;
- describe the strongest channel observed for each sample;
- obtain a review and merge the pull request; and
- update your local personal branch before starting Lesson 7.

## Ask your AI tutor

> Review my color-sensor OpMode without editing it. Check that I read each
> channel once per loop, display those stored readings, and base the detected
> color on the same values.

## Check your work

You are finished when:

- the OpMode finds `color_sensor`;
- telemetry shows red, green, blue, and alpha readings;
- each detected name matches the strongest RGB channel;
- ties remain `UNKNOWN`; and
- you can explain why this simple rule is not a calibrated classifier.

Continue to
[Lesson 7: Encoders and Measured Movement](../07-motors-and-encoders/README.md).
