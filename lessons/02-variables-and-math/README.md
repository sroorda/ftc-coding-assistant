# Lesson 2: Variables and Robot Math

## Session at a glance

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | types, variables, arithmetic, names, units |
| **FTC connection** | calculating wheel travel |
| **AI role** | review names without rewriting the calculation |

## Learning outcomes

By the end of this lesson, you can:

- use `double` and `String` variables;
- follow units through a calculation;
- choose names that reveal meaning; and
- estimate an answer before trusting program output.

## Before you begin

Complete [Lesson 1](../01-first-program/README.md), then open this file in your
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

## Predict

A wheel travels one circumference per rotation. Estimate the distance for a
4-inch wheel turning three times. Write down your estimate before running.

## Implement

1. Rename `d`, `r`, and `x` so their meanings and units are clear.
2. Add a `String` containing a short label for the wheel being measured.
3. Change the inputs to represent another FTC-sized wheel and rotation count.
4. Round only the displayed result to two decimal places; keep the calculation as
   a `double`.
5. Run after each small change.

## Ask the assistant

> Review only the variable names in `WheelCalculator.java`. Suggest clearer names
> and explain what information each name should carry. Do not edit the file or
> rewrite the calculation.

Decide which suggestions improve the code. You do not need to accept all of them.

## Verify

You are finished when:

- your hand estimate and program output are reasonably close;
- another calculation, such as a calculator, confirms one result;
- every numeric value has an obvious unit; and
- changing one input produces a result you can predict.

## Explain

Explain why `double` is appropriate and how the variable names prevent inches,
rotations, and other units from being confused.

Exit question: **Which variable name prevented the most confusion, and why?**

## FTC connection

Robot code converts encoder counts, wheel rotations, inches, degrees, and time. A
correct formula with hidden units is still a future bug.

## Next lesson

Continue to [Lesson 3: Decisions and Deadbands](../03-decisions-and-deadbands/README.md).
