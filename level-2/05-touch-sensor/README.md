# 2.5: Touch Sensor Input

A touch sensor gives the program a simple pressed-or-not-pressed value. In this
lesson, you will read the REV Touch Sensor and make its state visible with
telemetry.

## Your mission

| | |
|---|---|
| **Time** | 30–45 minutes |
| **FTC focus** | `TouchSensor`, Boolean input, press detection, telemetry |
| **Git focus** | commit, push, review, and merge one focused hardware change |
| **AI tutor** | check sensor mapping and state interpretation |

## Your goal

By the end of this lesson, you can:

- map a configured touch sensor;
- read whether it is pressed;
- turn a Boolean reading into a readable status;
- detect a new press and toggle a state once; and
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

### Test Part 4 — Basic sensor readings

Build and deploy the project, then complete each test:

| Test | Verify |
|---|---|
| Press **INIT**. | Telemetry shows `Touch sensor initialized`. |
| Release the sensor, then press **PLAY**. | Telemetry shows `Pressed: false` and `Touch sensor: RELEASED`. |
| Press and hold the sensor until telemetry updates. | Telemetry changes to `Pressed: true` and `Touch sensor: PRESSED`. |
| Release the sensor. | Telemetry changes back to `Pressed: false` and `Touch sensor: RELEASED`. |

Driver Station telemetry refreshes more slowly than the OpMode loop. A very
quick press may change back to `RELEASED` before `PRESSED` appears on the screen,
so hold the sensor until telemetry updates during this test.

## Part 5 — Advanced example: toggle on each press

Suppose one press should turn something on and the next press should turn it
off. Checking only `isPressed()` would toggle the state repeatedly while the
sensor is held. The program must detect the moment the sensor changes from
released to pressed. This change is called a **rising edge**.

The current reading only tells the program what the sensor is doing now. Keeping
the previous reading lets it recognize how the sensor changed:

| Previous reading | Current reading | Meaning |
|---|---|---|
| `false` | `false` | Still released |
| `false` | `true` | New press: rising edge |
| `true` | `true` | Still being held |
| `true` | `false` | Released: falling edge |

The toggle should change only in the rising-edge row.

In **Area 3**, add these variables immediately before the active loop:

```java
boolean previousPressed = false;
boolean toggledOn = false;
```

These variables must be outside the loop so their values are remembered between
loop passes.

Immediately after reading `pressed` inside the loop, add:

```java
if (pressed && !previousPressed) {
    toggledOn = !toggledOn;
}

previousPressed = pressed;
```

- `pressed && !previousPressed` is true only on a new press.
- `toggledOn = !toggledOn` changes `false` to `true` or `true` to `false`.
- Updating `previousPressed` prepares the comparison for the next loop pass.

Immediately before the existing `telemetry.update()`, add:

```java
telemetry.addData("Toggled state", toggledOn ? "ON" : "OFF");
```

### Why a very quick press may not appear

The OpMode reads the sensor once during each loop pass, while Driver Station
telemetry updates the screen at a slower rate. Because of this:

- a short press may be read by the program but change back before `PRESSED`
  appears on the Driver Station;
- the persistent toggled state makes a detected press visible even after the
  sensor is released; and
- a press that begins and ends entirely between two sensor readings cannot be
  detected by this polling code.

During the basic telemetry test, hold the sensor until the Driver Station shows
`PRESSED`. Later, use the toggled state to confirm whether a shorter press was
detected.

### Test Part 5 — Toggle behavior

Build and deploy the updated project, then complete each test:

| Test | Verify |
|---|---|
| Release the sensor, then press **PLAY**. | Telemetry shows `Pressed: false`, `Touch sensor: RELEASED`, and `Toggled state: OFF`. |
| Press and hold the sensor until telemetry updates. | The sensor shows `true` and `PRESSED`, and the toggled state changes to `ON` only once. |
| Continue holding the sensor. | The toggled state remains `ON`; it does not repeatedly change while held. |
| Release the sensor. | The sensor shows `false` and `RELEASED`, while the toggled state remains `ON`. |
| Press the sensor again. | The toggled state changes to `OFF`. |
| Press and release the sensor several times. | Each new press changes the toggled state exactly once. |
| Quickly tap the sensor. | If the program samples the press, the toggled state changes even if `PRESSED` is not visible. If it does not change, the tap occurred entirely between sensor readings. |

## Git checkpoint

In Android Studio:

- confirm the current branch is `feature/<your-name>/touch-sensor`;
- inspect the `TouchSensorOpMode.java` diff;
- commit with a focused message such as `Add touch sensor toggle`;
- push and open a pull request into `student/<your-name>`;
- describe the released, pressed, and toggled-state test results;
- obtain a review and merge the pull request; and
- update your local personal branch before starting 2.6.

## Ask your AI tutor

> Review my touch-sensor OpMode without editing it. Check that I map the correct
> SDK type and configuration name, read the sensor once per loop, detect only
> new presses, and toggle the state exactly once per press.

## Check your work

You are finished when:

- the OpMode finds `touch_sensor`;
- released reports `false` and `RELEASED`;
- pressed reports `true` and `PRESSED`;
- holding the sensor does not repeatedly change the toggled state;
- each new press changes the toggled state exactly once; and
- you can explain what the Boolean value means.

Continue to [2.6: Color Sensor Readings](../06-color-sensing/README.md).
