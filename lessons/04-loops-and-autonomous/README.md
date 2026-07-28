# Lesson 4: Loops and Autonomous Sequences

## Session at a glance

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | `for`, counters, boundaries, termination |
| **FTC connection** | repeated autonomous steps |
| **AI role** | explain why a loop repeats and stops |

## Learning outcomes

By the end of this lesson, you can:

- trace a `for` loop using a counter;
- recognize an off-by-one error;
- explain why a loop terminates; and
- represent repeated autonomous steps without hardware.

## Before you begin

Complete [Lesson 3](../03-decisions-and-deadbands/README.md), then open this file in
your local clone:

```text
lessons/04-loops-and-autonomous/src/org/ftc/training/lesson04/AutoSequence.java
```

## Requirement

Print exactly three driving segments, numbered 1, 2, and 3, followed by `Complete`.

## Predict

Trace the values of `step` on paper before running. Record the value used for every
line you expect the loop to print.

macOS or Linux:

```text
./scripts/run-lesson.sh 04
```

Windows:

```text
scripts\run-lesson.cmd 04
```

## Implement

1. Compare the output with the requirement.
2. Repair the loop condition.
3. Change the program to print five segments.
4. Add a `totalSegments` variable so one value controls the count.
5. Explain initialization, continuation condition, and update in the loop header.

## Ask the assistant

> Explain why this loop prints its current number of segments and why it eventually
> stops. Do not edit it. Ask me to trace the final two values of `step`.

## Verify

You are finished when:

- the number of segment lines matches `totalSegments`;
- numbering begins at 1 and ends at `totalSegments`;
- `Complete` appears once, after the loop; and
- you can name the value that changes on every iteration.

Do not demonstrate an uncontrolled infinite loop on a shared computer.

## Explain

Trace the final two iterations for a teammate and identify the first value that
causes the continuation condition to be false.

Exit question: **What single change could make this loop never terminate?**

## FTC connection

Autonomous code performs sequences, but a real OpMode must remain responsive.
Later robot code should use timed states or commands instead of long blocking loops.

## Next lesson

Continue to [Lesson 5: Methods, Classes, and Tests](../05-methods-classes-and-tests/README.md).
