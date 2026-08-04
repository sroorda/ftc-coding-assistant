# Lesson 7: Color Sensing and Calibration

A color sensor returns numbers, not the meaning “red game piece” or “blue marker.”
You will collect evidence under real conditions, create a simple classifier, and
keep raw sensing separate from interpretation.

## Your mission

| | |
|---|---|
| **Time** | 75–105 minutes |
| **FTC focus** | `ColorSensor`, RGB readings, calibration, classification |
| **Git focus** | make test evidence part of the pull request |
| **AI tutor** | challenge thresholds with missing or ambiguous cases |

## Your goal

By the end of this lesson, you can:

- read and display raw red, green, blue, and alpha values;
- explain how distance and ambient light affect measurements;
- derive thresholds from repeated observations; and
- return a named classification separately from raw sensor access.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/color-sensor
```

Create `ColorSensorOpMode.java`. Confirm the configured name is `color_sensor`.
Prepare at least two target colors plus a neutral or unknown sample. Use the same
physical presentation you expect the final mechanism to use.

## Raw readings need context

Map the device with:

```java
ColorSensor colorSensor =
        hardwareMap.get(ColorSensor.class, "color_sensor");
```

The `red()`, `green()`, `blue()`, and `alpha()` values depend on the sensor model,
surface, distance, angle, illumination, and gain behavior. A threshold copied from
another robot is not calibration evidence for this bench.

## Part 1 — Build a data collector

Create an OpMode that displays:

- red;
- green;
- blue;
- alpha; and
- the sample name you are currently testing.

Before running, predict which channel will be largest for each target and which
sample will be hardest to distinguish. The measured data, not the prediction,
will determine the classifier.

Collect at least five readings for each target and for the unknown sample. Keep
distance and angle as consistent as practical. Then repeat one target at a clearly
different distance to see how the readings change.

Record the results in a table in your notes or pull-request description:

| Sample | Distance | Red | Green | Blue | Alpha |
|---|---:|---:|---:|---:|---:|
| Target A | | | | | |
| Target B | | | | | |
| Unknown | | | | | |

## Part 2 — Choose a classification rule

Begin with a simple rule that your data can defend. For example, compare the
dominant channel or compare each channel's share of total RGB:

```java
int total = red + green + blue;
double redRatio = total == 0 ? 0.0 : red / (double) total;
```

Ratios can reduce sensitivity to overall brightness, but they do not eliminate
distance, reflection, saturation, or low-signal problems. Include an `UNKNOWN`
result when the readings do not clearly match a calibrated target.

Create a method such as:

```java
private String classifyColor(int red, int green, int blue) {
    // TODO: implement an evidence-based rule
}
```

Keep the sensor read outside the method. This lets the decision logic be reasoned
about with recorded numbers and later moved into reusable code.

## Student task

Your completed OpMode must:

1. Map `color_sensor`.
2. Display all raw channels and the interpreted result.
3. Classify at least two targets plus `UNKNOWN`.
4. Store thresholds as named constants.
5. Avoid division by zero and define boundary behavior.
6. Demonstrate every classification with repeated readings.
7. Record at least one ambiguous or failure case.

Do not change a threshold because one convenient reading failed. Look at the full
data set, adjust one rule, and repeat all target tests.

## Git checkpoint

Run `git diff` and verify the calibration constants, method, and telemetry are all
intentional. Commit, push, and open a pull request into your personal branch.
Include the reading table, rule, and one known limitation. Obtain review, merge,
and update `student/<your-name>`.

## Ask your AI tutor

> Review my color classifier without editing it. Use my recorded readings to find
> an ambiguous boundary, a low-signal case, and a sample my rules do not cover.
> Suggest test inputs, not replacement thresholds, until I explain my calibration
> evidence.

## Check your work

You are finished when:

- telemetry shows raw readings and the classification together;
- at least two target colors are distinguished repeatedly;
- uncertain readings return `UNKNOWN`;
- named thresholds can be traced to collected evidence;
- sensor reading and classification are separate responsibilities; and
- the pull request documents a known limitation.

## Reflect

Why can a classifier that works perfectly on today's five samples still fail when
mounted on a competition robot?

Continue to
[Lesson 8: Building Reusable Hardware Code](../08-reusable-hardware-code/README.md).
