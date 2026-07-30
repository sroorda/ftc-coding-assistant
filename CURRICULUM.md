# Level 1 Curriculum — Java Foundations

Level 1 teaches beginning programmers to reason about Java through robot-like
problems without requiring the FTC SDK or physical hardware. It is the first level
of the [five-level student program](PROGRAM_ROADMAP.md), and its six lessons are
available now.

Git and collaboration are intentionally deferred until the
[Team Workflow Bootcamp](team-workflow.md) after Level 1.

## Teaching model

Every lesson uses the same cycle:

1. **Predict** what the program will do.
2. **Try** a small change without AI assistance.
3. **Ask** the assistant for a hint, explanation, review, or test idea.
4. **Decide** which advice is relevant.
5. **Verify** by compiling, running, and testing.
6. **Explain** the result to another person.

The AI assistant supports the learning cycle but does not replace the adult mentor,
student author, or human reviewer.

## Lesson plan

| Lesson | Java focus | Robotics connection | AI-assistant skill | Evidence of learning |
|---|---|---|---|---|
| 1. First program | class, `main`, output, compile/run | initialization and telemetry messages | ask for an explanation without edits | student changes output and explains each line |
| 2. Variables and math | types, variables, arithmetic, naming | wheel distance calculation | request a naming review | student predicts and verifies a calculation |
| 3. Decisions and deadbands | booleans, comparisons, `if`/`else` | joystick deadband | ask for diagnostic hints | student finds a boundary bug and tests it |
| 4. Loops and autonomous | `for`, `while`, counters, termination | repeated autonomous steps | ask why code terminates | student repairs and traces a loop |
| 5. Methods, classes, tests | parameters, returns, objects, assertions | reusable drive-power logic | request test cases, not implementation | student implements a method and passes tests |
| 6. Virtual intake | requirements, decomposition, precedence, integration | intake subsystem state | request a review tied to requirements | pair demonstrates all required scenarios |

## Suggested session shape

- 10 minutes: adult mentor demonstration and vocabulary
- 10 minutes: prediction in pairs
- 25 minutes: coding exercise
- 15 minutes: constrained AI-assistant activity
- 10 minutes: verification and peer explanation
- 5 minutes: exit ticket

Allow extra time in Lesson 1 for editor and JDK setup. Lesson 6 will usually need
two sessions if students write both the implementation and their own scenario tests.

## Assessment

Use short demonstrations rather than syntax quizzes. A student is ready to move on
when they can:

- explain the current program in plain language;
- make one small change without asking the assistant to do it;
- identify the command or action that verifies the change;
- describe at least one edge case; and
- distinguish “it compiled” from “it meets the requirement.”

For the final project, assess requirements coverage, code clarity, tests,
explanation, and responsible assistant use. Avoid grading based on code volume.

## After Level 1

Students complete the
[Level 1 readiness check](levels/01-java-foundations.md#readiness-check), then the
[Team Workflow Bootcamp](team-workflow.md). Only after both should they begin
supervised [Level 2 hardware work](levels/02-hardware-lab.md).
