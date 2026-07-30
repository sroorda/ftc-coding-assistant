# Lesson 3: Decisions and Joystick Deadbands

Today you will debug a small input-filtering program. The important skill is not
the filter itself—it is predicting behavior, comparing code with a written
requirement, and choosing test values that expose a bug.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | booleans, comparisons, `if`/`else`, boundaries |
| **FTC connection** | optional input filtering and threshold decisions |
| **AI tutor** | offer one diagnostic hint without giving the fix |

## Your goal

By the end of this lesson, you can:

- use boolean expressions and `if`/`else`;
- explain what a deadband is intended to do;
- find a bug by comparing behavior with a requirement; and
- test immediately below, at, and above a boundary.

## Get ready

Complete [Lesson 2](../02-variables-and-math/README.md), then open this file in your
local clone:

```text
lessons/03-decisions-and-deadbands/src/org/ftc/training/lesson03/JoystickControl.java
```

The program reads its test value from the first command-line argument:

```java
double joystick = Double.parseDouble(args[0]);
```

You used `args[0]` in Lesson 1. `Double.parseDouble` converts that text argument
into a `double` that the program can compare and use as motor power.

## Why someone might write this filter

A **deadband** treats small input values near zero as zero. A programmer might add
one when a controller, sensor, or mechanism produces small unwanted values that
should not cause movement.

Your FTC team may not need a custom joystick deadband. Do not add one automatically.
First observe the real input and decide whether filtering solves an actual problem.
This lesson uses a deadband as a clear practice requirement for debugging
`if`/`else` logic and boundaries.

## Requirement

For this training program, joystick magnitudes below `0.10` must produce zero motor
power. Other values pass through unchanged. Exactly `0.10` and `-0.10` are not
below the boundary, so they pass through.

## Read the decision

The program makes its choice with this structure:

```java
if (Math.abs(joystick) < someBoundary) {
    motorPower = 0.0;
} else {
    motorPower = joystick;
}
```

`Math.abs` returns the magnitude without the sign. For example,
`Math.abs(-0.05)` and `Math.abs(0.05)` both produce `0.05`. That lets one condition
filter small positive and negative values.

The comparison `<` means **strictly less than**. The statements inside the `if`
body run when the comparison is true. The statements inside `else` run when it is
false.

## Student Task

### 1. Predict values that can expose the bug

Before running the program, copy this table into your notes and fill in the
**Expected power** column from the requirement.

Complete your predictions before inspecting or changing the `if` condition.

| Joystick input | Expected power | Actual before repair | Actual after repair |
|---:|---:|---:|---:|
| `0.00` | | | |
| `0.05` | | | |
| `0.09` | | | |
| `0.10` | | | |
| `-0.05` | | | |
| `-0.10` | | | |

The values `0.05`, `0.09`, and `-0.05` are especially useful because they are
below the required boundary but not extremely close to zero.

### 2. Run the program and compare

Pass one joystick value after the lesson number. For example:

macOS or Linux:

```text
./scripts/run-lesson.sh 03 0.05
```

Windows:

```text
scripts\run-lesson.cmd 03 0.05
```

Repeat the command for every value in the table. Record each result under
**Actual before repair**. Circle or mark every row where actual behavior disagrees
with the requirement.

### 3. Repair the decision

1. Find the `if` condition that decides when motor power becomes zero.
2. Compare its value with the written requirement.
3. Repair the smallest relevant part of the condition.
4. Rerun every table value and record **Actual after repair**.
5. Confirm what happens at exactly `0.10` and `-0.10`.

## Ask your AI tutor

> My expected and actual motor-power table has mismatched rows. The written
> requirement uses a magnitude boundary of 0.10. Ask me one diagnostic question
> and give me one hint about the `if` condition. Do not propose the corrected line.

## Check your work

You are finished when:

- values just inside the deadband produce zero;
- values at and outside the boundary pass through unchanged;
- positive and negative inputs are tested; and
- every **Actual after repair** value matches your prediction and the requirement.

## Connect it to FTC

A custom joystick deadband may or may not be useful on your FTC robot. The broader
pattern is important: robot code often compares controller or sensor input with a
threshold and chooses an action. Test the values on both sides of every threshold,
and add filtering only when it addresses observed behavior.

## Continue

Continue to [Lesson 4: Loops and Autonomous](../04-loops-and-autonomous/README.md).
