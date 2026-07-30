# Lesson 4: Loops and Autonomous Sequences

Today you will trace a loop that represents repeated autonomous steps. You will
repair an off-by-one error and prove that you understand both why the loop repeats
and why it stops.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | `for`, counters, boundaries, termination |
| **FTC connection** | repeated autonomous steps |
| **AI tutor** | explain why a loop repeats and stops |

## Your goal

By the end of this lesson, you can:

- trace a `for` loop using a counter;
- recognize an off-by-one error;
- explain why a loop terminates; and
- represent repeated autonomous steps without hardware.

## Get ready

Complete [Lesson 3](../03-decisions-and-deadbands/README.md), then open this file in
your local clone:

```text
lessons/04-loops-and-autonomous/src/org/ftc/training/lesson04/AutoSequence.java
```

## Requirement

Print exactly three driving segments, numbered 1, 2, and 3, followed by `Complete`.

## Make a prediction

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

## Build it

1. Compare the output with the requirement.
2. Repair the loop condition.
3. Change the program to print five segments.
4. Add a `totalSegments` variable so one value controls the count.
5. Explain initialization, continuation condition, and update in the loop header.

## Ask your AI tutor

> Explain why this loop prints its current number of segments and why it eventually
> stops. Do not edit it. Ask me to trace the final two values of `step`.

## Check your work

You are finished when:

- the number of segment lines matches `totalSegments`;
- numbering begins at 1 and ends at `totalSegments`;
- `Complete` appears once, after the loop; and
- you can name the value that changes on every iteration.

Do not demonstrate an uncontrolled infinite loop on a shared computer.

## Teach it back

Trace the final two iterations for a teammate and identify the first value that
causes the continuation condition to be false.

Exit question: **What single change could make this loop never terminate?**

## Connect it to FTC

Autonomous code performs sequences, but a real OpMode must remain responsive.
Later robot code should use timed states or commands instead of long blocking loops.

## Continue

Continue to [Lesson 5: Methods, Classes, and Tests](../05-methods-classes-and-tests/README.md).
