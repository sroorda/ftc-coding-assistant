# Lesson 3: Decisions and Joystick Deadbands

## Goals

- Use boolean expressions and `if`/`else`.
- Explain a joystick deadband.
- Find a bug from observed behavior and a requirement.
- Test values below, at, and above a boundary.

## Requirement

Joystick magnitudes below `0.10` must produce zero motor power. Other values pass
through unchanged.

## Predict and run

Read the code and predict the output for `joystick = 0.08`, then run:

```text
./scripts/run-lesson.sh 03
```

On Windows use `scripts\run-lesson.cmd 03`.

## Exercise

1. Explain why the observed result violates the requirement.
2. Test `0.0`, `0.09`, `0.10`, `-0.09`, and `-0.10` one at a time.
3. Repair the smallest relevant part of the code.
4. State explicitly what should happen at exactly `0.10` and confirm the code agrees.

## Ask the assistant

> The motor moves when the joystick is nearly centered. The required deadband is
> 0.10. Ask me one diagnostic question and give one hint about where to look. Do not
> propose a corrected line yet.

## Verify

Record expected and actual motor power for the five test values. Include positive
and negative input because FTC joysticks represent direction with sign.

## FTC connection

Real gamepads rarely report perfect zero. Deadbands prevent drift, but incorrect
boundaries can make a robot feel unresponsive or move unexpectedly.

## Reflection

Why are values immediately around a boundary more useful than several random values?
