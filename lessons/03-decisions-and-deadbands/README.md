# Lesson 3: Decisions and Joystick Deadbands

Today you will debug a decision that could make a real robot drift. The important
skill is comparing the program with a written requirement and testing the exact
boundary where behavior changes.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | booleans, comparisons, `if`/`else`, boundaries |
| **FTC connection** | preventing joystick drift |
| **AI tutor** | offer one diagnostic hint without giving the fix |

## Your goal

By the end of this lesson, you can:

- use boolean expressions and `if`/`else`;
- explain why a joystick needs a deadband;
- find a bug by comparing behavior with a requirement; and
- test immediately below, at, and above a boundary.

## Get ready

Complete [Lesson 2](../02-variables-and-math/README.md), then open this file in your
local clone:

```text
lessons/03-decisions-and-deadbands/src/org/ftc/training/lesson03/JoystickControl.java
```

## Requirement

Joystick magnitudes below `0.10` must produce zero motor power. Other values pass
through unchanged.

## Make a prediction

Read the code and predict the output for `joystick = 0.08`. Then run it.

macOS or Linux:

```text
./scripts/run-lesson.sh 03
```

Windows:

```text
scripts\run-lesson.cmd 03
```

## Build it

1. Explain why the observed result violates the requirement.
2. Try `0.0`, `0.09`, `0.10`, `-0.09`, and `-0.10` one at a time.
3. Record expected and actual motor power for each input.
4. Repair the smallest relevant part of the code.
5. State explicitly what happens at exactly `0.10`.

## Ask your AI tutor

> The motor moves when the joystick is nearly centered. The required deadband is
> 0.10. Ask me one diagnostic question and give one hint about where to look. Do not
> propose a corrected line yet.

## Check your work

You are finished when:

- values just inside the deadband produce zero;
- values at and outside the boundary follow your stated interpretation;
- positive and negative inputs are tested; and
- the code and written requirement agree.

## Teach it back

Show a teammate your boundary table and explain why values near `0.10` reveal more
than several random inputs.

Exit question: **Which three values best test a boundary at `0.10`, and why?**

## Connect it to FTC

Real gamepads rarely report perfect zero. Deadbands prevent drift, but incorrect
boundaries can make a robot move unexpectedly or feel unresponsive.

## Continue

Continue to [Lesson 4: Loops and Autonomous](../04-loops-and-autonomous/README.md).
