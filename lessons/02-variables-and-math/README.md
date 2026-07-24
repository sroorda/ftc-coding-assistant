# Lesson 2: Variables and Robot Math

## Goals

- Use `double` and `String` variables.
- Follow units through a calculation.
- Choose names that reveal intent.
- Ask the assistant for a focused naming review.

## Predict

A wheel travels one circumference per rotation. Predict the distance printed for a
4-inch wheel turning three times. An estimate is enough.

## Run

```text
./scripts/run-lesson.sh 02
```

On Windows use `scripts\run-lesson.cmd 02`.

## Exercise

1. Rename `d`, `r`, and `x` so their meaning and units are clear.
2. Add a `String` containing a short label for the wheel being measured.
3. Change the inputs to represent another FTC-sized wheel and rotation count.
4. Round only the displayed result to two decimal places; keep the calculation as a
   `double`.

## Ask the assistant

> Review only the variable names in `WheelCalculator.java`. Suggest clearer names
> and explain what information each name should carry. Do not edit the file or
> rewrite the calculation.

## Verify

Calculate one expected result another way, such as a calculator or hand estimate.
Check that every numeric value has an obvious unit.

## FTC connection

Robot code frequently converts encoder counts, wheel rotations, inches, degrees,
and time. A correct formula with hidden units is a future bug.

## Reflection

Which variable name prevented the most confusion, and why?
