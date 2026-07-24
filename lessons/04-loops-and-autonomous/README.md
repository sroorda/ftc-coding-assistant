# Lesson 4: Loops and Autonomous Sequences

## Goals

- Trace a `for` loop using a counter.
- Recognize an off-by-one error.
- Explain why a loop terminates.
- Represent repeated autonomous steps without robot hardware.

## Requirement

Print exactly three driving segments, numbered 1, 2, and 3, followed by “Complete.”

## Predict and run

Trace the values of `step` on paper before running:

```text
./scripts/run-lesson.sh 04
```

On Windows use `scripts\run-lesson.cmd 04`.

## Exercise

1. Compare the output to the requirement.
2. Repair the loop condition.
3. Change the program to print five segments.
4. Add a `totalSegments` variable so changing one value controls the count.
5. Explain initialization, continuation condition, and update in the loop header.

## Ask the assistant

> Explain why this loop prints its current number of segments and why it eventually
> stops. Do not edit it. Ask me to trace the final two values of `step`.

## Verify

Count the segment lines and confirm their first and last numbers. Confirm “Complete”
appears once, after the loop.

## FTC connection

Autonomous code performs sequences, but a real OpMode must remain responsive.
Later lessons should replace long blocking loops with timed states or commands.

## Reflection

What single change could make a loop never terminate?
