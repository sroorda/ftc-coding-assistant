# Curriculum

## Three coordinated tracks

The six Java lessons are the core student sequence, not the entire team-development
program. [TRACKS.md](TRACKS.md) coordinates three role-specific paths:

| Track | Audience | Primary outcome | Guide |
|---|---|---|---|
| A — Students | new and developing programmers | write, explain, and verify Java with bounded AI help | [students](tracks/students.md) |
| B — Team Leads | experienced students or software captains | create a safe Git and review system and guide architecture | [team leads](tracks/team-leads.md) |
| C — Mentors | adult and student mentors | use Claude Code to teach and review without replacing student reasoning | [mentors](tracks/mentors.md) |

All tracks share one standard: a change is not complete until a person can explain
it, connect it to a requirement, and show evidence that it works.

## Teaching model

Every lesson uses the same cycle:

1. **Predict** what the program will do.
2. **Try** a small change without AI assistance.
3. **Ask** the assistant for a hint, explanation, review, or test idea.
4. **Decide** which advice is relevant.
5. **Verify** by compiling, running, and testing.
6. **Explain** the result to a teammate.

The sequence starts with plain Java. FTC SDK concepts are introduced by analogy,
then deferred until students can reason about the underlying logic.

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

- 10 minutes: mentor demonstration and vocabulary
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

For the final project, assess requirements coverage, code clarity, tests, explanation,
and responsible assistant use. Avoid grading based on code volume.

## Iteration roadmap

Recommended follow-on modules:

1. Run the Track B Git and review workshops with emerging team leads
2. Arrays, lists, and logged sensor samples
3. Enums and explicit subsystem states
4. FTC OpMode lifecycle and telemetry
5. HardwareMap, motors, servos, and configuration safety
6. Non-blocking timing and state machines
7. Unit-testing logic outside the Robot Controller app
8. Reading and reviewing a real team subsystem
