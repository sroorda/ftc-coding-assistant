# Instructor Guide

## Before teaching: understand the pathway

Every new programmer begins with **Level 1 — Java Foundations** and completes the
same six lessons. Do not assign student leads or add Git instruction during this
level. The goal is to get every student writing, testing, and explaining code.

Adults follow the [Adult Mentor Guide](../mentors/adult-mentor-guide.md) and agree
on assistance, privacy, and safety boundaries before the first session. AI may
support adults and students, but it is not an accountable mentor.

See the [Program Roadmap](../PROGRAM_ROADMAP.md) for the later hardware, TeleOp,
Season Repository architecture, Pedro Pathing, intake, nonblocking autonomous, and
vision levels.

## Preparation

- Confirm each computer has a JDK and can run `./scripts/check-environment.sh` on
  macOS/Linux or `scripts\check-environment.cmd` on Windows.
- For Windows machines, follow [Windows setup](../docs/windows-setup.md) before the
  first meeting and verify that `javac`, not only `java`, is available.
- For Macs, follow [macOS setup](../docs/macos-setup.md). Confirm both Intel and Apple
  silicon students select the installer for their processor architecture.
- Explain the two Java versions once: JDK 17+ runs the current FTC build tools, while
  student code is compiled at the Java 8 language/API level for FTC compatibility.
- Run all six lessons before class.
- Decide who may operate the AI assistant under provider, school, and team rules.
  A mentor demonstration is a workable alternative to individual access.
- Pair students intentionally: one driver types while one navigator explains, then
  switch halfway through.
- Keep this repository separate from active competition robot code.

## Facilitation rules

Do not rescue students at the first compiler error. Ask them to locate the filename,
line number, and first useful message. Likewise, do not let the assistant become the
fastest typist in the room. A good interaction leaves the student with a prediction
to test.

Require students to narrate changed lines in their own words. If they cannot, revert
or rewrite the change more simply. Compilation proves syntax and types; scenario
tests provide evidence about behavior; neither replaces checking the requirement.

Use the help ladder from the
[Adult Mentor Guide](../mentors/adult-mentor-guide.md): question, location hint,
concept hint, pseudocode, small example, then implementation only when appropriate.
Adult reviewers should check requirements and evidence before discussing style.

## Level 1 Lessons

### 1.1 — First program

Watch for confusion between a source file, a class, and a running program. Students
should change the status message and add a second line. The key assistant behavior
is explanation without editing.

Exit ticket: “What does `main` tell Java, and what did you verify by running it?”

### 1.2 — Variables and math

The starter deliberately uses weak names (`d`, `r`, `x`). Expected improvements are
names such as `wheelDiameterInches`, `wheelRotations`, and `distanceInches`.
Circumference times rotations is `Math.PI * diameter * rotations`. Ask about units.

Exit ticket: “Why is `double` appropriate here, and where are the units visible?”

### 1.3 — Decisions and deadbands

The starter bug uses a deadband of `0.01` while the requirement says `0.10`.
Boundary behavior should be discussed explicitly: with `< 0.10`, exactly `0.10`
passes through. Accept either boundary choice if the student states and tests the
requirement consistently.

Exit ticket: “Which three values best test a boundary at 0.10?”

### 1.4 — Loops and autonomous

Students write both loops rather than repair starter code. The intended `for` loop
uses `segment = 1`, continues through `segment <= totalSegments`, and increments
`segment`. The intended `while` loop compares `distanceTraveled` with
`targetDistance` using `<`, adds `distancePerUpdate`, and then prints the updated
distance.

Keep the blocking discussion limited to what students can observe: the final
message cannot run until the `while` loop releases control. Tell students that a
later exercise will teach responsive, non-blocking actions. Do not introduce that
architecture or threads here. Do not demonstrate an uncontrolled infinite loop on
shared machines.

Exit ticket: “When would you choose `for` instead of `while`, and why can a long
`while` loop be dangerous in robot code?”

### 1.5 — Methods, classes, and tests

Frame the lesson as extracting a numerical rule from hardware-facing code so it can
be tested without a robot or FTC SDK. Students implement clamping to the inclusive
range -1.0 through 1.0. Essential cases include below range, each boundary, within
range, and above range.

The small harness avoids external libraries. In the starter state it should run all
five checks, report three passes and two failures, print its summary, and only then
throw an `AssertionError`. After implementation it should report five passes.
Students then add the two exact-boundary checks for a total of seven.

Exit ticket: “Why is this logic easier to trust as a method than when duplicated?”

### 1.6 — Virtual intake

Walk through all four starter files before presenting the requirements. Students
should be able to trace one demo call into `update`, identify all four boolean
parameters, and explain why `IntakeOutput` carries both power and status. The test
harness is supplied; students should add scenarios rather than design new testing
infrastructure.

Use this precedence: emergency stop overrides everything; reverse overrides intake
and object detection; an object detected prevents normal intake; otherwise intake
follows its button and the motor is stopped. Status strings are part of the tested
requirement: `Emergency stop`, `Reversing`, `Object detected`, `Intaking`, and
`Idle`. Encourage a decision table before code.

Required scenarios:

| Intake | Reverse | Object | E-stop | Expected power |
|---:|---:|---:|---:|---:|
| false | false | false | false | 0.0 |
| true | false | false | false | 1.0 |
| true | false | true | false | 0.0 |
| true | true | false | false | -1.0 |
| true | true | false | true | 0.0 |

The starter should run all five scenarios, report zero passes and five failures,
and then throw one final `AssertionError`. After implementing the five rules,
students add the two specified high-conflict scenarios for a total of seven.

Exit ticket: “Which rule wins when inputs conflict, and which test proves it?”

## Review rubric for the final project

Score each dimension as needs support, developing, or ready:

- Requirements: outputs match every scenario and precedence rule.
- Java reasoning: students explain conditionals, methods, objects, and return values.
- Verification: tests cover normal cases, boundaries, and conflicting inputs.
- Clarity: names reveal intent and methods remain focused.
- Assistant use: prompts were constrained and suggestions were evaluated.
- Teamwork: both partners can explain and run the program.

## Adding a Level 1 lesson

Copy the nearest lesson rather than inventing a new format. Add its run mapping to
both `scripts/run-lesson.sh` and `scripts/run-lesson.ps1`, run it on a clean checkout
on at least one Unix-like system and Windows, and have a mentor unfamiliar with the
exercise follow the README literally. Keep FTC hardware work in Level 2 or later,
with explicit adult supervision.
