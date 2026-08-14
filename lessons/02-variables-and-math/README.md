# 1.2: Variables and Robot Math

Today you will use Java to calculate how far a wheel travels. Your main challenge
is not typing the formula—it is making every value and unit clear enough that
another programmer can trust the calculation.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | types, variables, arithmetic, names, units |
| **FTC connection** | calculating wheel travel |
| **AI tutor** | review names without rewriting the calculation |

## Your goal

By the end of this lesson, you can:

- use `double` and `String` variables;
- follow units through a calculation;
- choose names that reveal meaning; and
- estimate an answer before trusting program output.

## Get ready

Complete [1.1](../01-first-program/README.md), then open this file in your
local clone:

```text
lessons/02-variables-and-math/src/org/ftc/training/lesson02/WheelCalculator.java
```

Run the starter from the repository root.

macOS or Linux:

```text
./scripts/run-lesson.sh 02
```

Windows:

```text
scripts\run-lesson.cmd 02
```

## Make a prediction

A wheel travels one circumference per rotation. Estimate the distance for a
4-inch wheel turning three times. Write down your estimate before running.

## Student Task

1. Rename `d`, `r`, and `x` so their meanings and units are clear.
2. Add a `String` variable containing a short label for the wheel, such as
   `"left drive wheel"`. Use that variable in the printed output so the result
   identifies which wheel was measured.
3. Change the inputs to represent another FTC-sized wheel and rotation count.
4. Round only the displayed result to two decimal places; keep the calculation as
   a `double`.
5. Run after each small change.

## Ask your AI tutor

> Review only the variable names in `WheelCalculator.java`. Suggest clearer names
> and explain what information each name should carry. Do not edit the file or
> rewrite the calculation.

Decide which suggestions improve the code. You do not need to accept all of them.

## Check your work

You are finished when:

- your hand estimate and program output are reasonably close;
- another calculation, such as a calculator, confirms one result;
- the printed result includes the wheel label and distance unit;
- every numeric value has an obvious unit; and
- changing one input produces a result you can predict.

## Connect it to FTC

An FTC motor encoder reports movement as counts. Robot code can convert those
counts into wheel rotations, then use the wheel diameter to estimate distance
traveled:

```text
distance = π × wheel diameter × rotations
```

Autonomous and localization code can use that estimated distance in inches. Clear
variable names and visible units help prevent the robot from confusing encoder
counts, rotations, inches, or millimeters—a mistake that can produce believable
numbers but incorrect movement.

## Continue

Continue to [1.3: Decisions and Deadbands](../03-decisions-and-deadbands/README.md).
