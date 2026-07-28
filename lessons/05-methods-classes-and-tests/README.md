# Lesson 5: Methods, Classes, and Tests

## Session at a glance

| | |
|---|---|
| **Time** | 75–90 minutes |
| **Java focus** | parameters, return values, classes, assertions |
| **FTC connection** | reusable and bounded motor-power logic |
| **AI role** | suggest test cases without implementing the method |

> **Expected first result:** this lesson begins with a failing test. The failure is
> the starting evidence for the exercise, not an environment problem.

## Learning outcomes

By the end of this lesson, you can:

- write a method with a parameter and return value;
- keep reusable logic separate from display code;
- use examples as executable tests; and
- distinguish a useful failure from a broken development environment.

## Before you begin

Complete [Lesson 4](../04-loops-and-autonomous/README.md). Open both files in your
local clone:

```text
lessons/05-methods-classes-and-tests/src/org/ftc/training/lesson05/DriveMath.java
lessons/05-methods-classes-and-tests/src/org/ftc/training/lesson05/DriveMathTest.java
```

## Requirement

`limitPower` must return a value in the inclusive range `-1.0` through `1.0`.
Values already in the range must be returned unchanged.

## Predict

Read `DriveMathTest.java` and predict which assertion fails first. Then run it.

macOS or Linux:

```text
./scripts/run-lesson.sh 05
```

Windows:

```text
scripts\run-lesson.cmd 05
```

Read the entire failure message, including the expected and actual values.

## Implement

1. Implement `DriveMath.limitPower` without changing the existing tests.
2. Run the tests after each small change.
3. Add one test for a boundary value.
4. Add one test for an ordinary value you chose.
5. Explain why the method is `static` in this small example.

Never weaken or remove a test merely to make the run appear successful.

## Ask the assistant

> Suggest five test inputs for `limitPower`, including boundaries and values outside
> the allowed range. Explain why each matters. Do not implement the method or edit
> any files.

Compare the suggestions with the tests already present before adding anything.

## Verify

You are finished when:

- all original tests print `PASS`;
- both of your added tests pass;
- below-range and above-range values are limited correctly;
- in-range values remain unchanged; and
- deliberately changing one expected value produces a useful failure before you
  restore it.

## Explain

Explain how a failing assertion points to the requirement, expected value, and
actual value.

Exit question: **What does the test suite prove, and what mistakes might it still miss?**

## FTC connection

Motor APIs expect bounded power. Keeping the calculation in a hardware-independent
method makes it quick to test and safer to reason about on a laptop.

## Next lesson

Continue to [Lesson 6: Virtual Intake Controller](../06-virtual-intake-project/README.md).
