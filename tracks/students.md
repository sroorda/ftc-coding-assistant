# Track A — Students

## Outcome

Learn enough Java to reason about FTC-style logic and use Claude Code as a tutor,
debugging partner, and reviewer without giving away ownership of the work.

## Before your first session

Complete [Start Here](../GETTING_STARTED.md). Do not continue until the environment
check succeeds and Lesson 1 prints `Robot initialized`.

## Learning path

Complete the lessons in order. Each lesson assumes you can explain the core idea
from the previous lesson.

| Session | Lesson | Ready to continue when |
|---:|---|---|
| 1 | [First Java Program](../lessons/01-first-program/README.md) | you can change output and identify where execution begins |
| 2 | [Variables and Robot Math](../lessons/02-variables-and-math/README.md) | you can name values and track their units |
| 3 | [Decisions and Deadbands](../lessons/03-decisions-and-deadbands/README.md) | you can repair and test a boundary condition |
| 4 | [Loops and Autonomous](../lessons/04-loops-and-autonomous/README.md) | you can trace a loop and explain why it stops |
| 5 | [Methods, Classes, and Tests](../lessons/05-methods-classes-and-tests/README.md) | you can use a failing test to implement a requirement |
| 6 | [Virtual Intake Controller](../lessons/06-virtual-intake-project/README.md) | you can implement and demonstrate conflicting rules |

For every lesson:

1. **Predict** before running.
2. **Implement** the first change without AI.
3. **Ask** only for the kind of help assigned by the lesson.
4. **Decide** which suggestions to accept or reject.
5. **Verify** with the lesson command and required scenarios.
6. **Explain** the result to someone else.

Use [Predict, Ask, Verify](../docs/student-workflow.md) whenever you are stuck.

## Student evidence log

Keep a short entry in your notes for each lesson:

```text
Prediction:
Change I made:
AI help I requested:
Suggestion I accepted or rejected, and why:
Verification command and result:
One thing I can now explain:
```

This is not a transcript. Do not paste private data or every assistant message. The
goal is to record decisions and evidence.

## Readiness check

Using Lesson 6, demonstrate that you can:

- explain the intake precedence rules before opening the implementation;
- make one requirement change in a small method;
- name a normal case, boundary case, and conflicting-input case;
- run the tests and interpret a deliberate failure; and
- describe one AI suggestion you rejected or changed.

Passing means you are ready to begin supervised work in a practice FTC SDK project.
It does not by itself authorize deployment or hardware operation.
