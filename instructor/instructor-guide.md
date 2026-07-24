# Instructor Guide

## Before teaching: assign the tracks

- Every new programmer follows **Track A** and completes the six Java lessons.
- Software captains and experienced students follow **Track B** while supporting,
  not completing, Track A exercises.
- Adults and designated student mentors follow **Track C** and agree on the same
  assistance boundaries before the first session.

See [TRACKS.md](../TRACKS.md) for the shared schedule and role handoffs. A person may
hold more than one role, but should state which role they are acting in during a
review or coaching interaction.

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

Use the help ladder from [Track C](../tracks/mentors.md): question, location hint,
concept hint, pseudocode, small example, then implementation only when appropriate.
Team leads should review for requirements and evidence before discussing style.

## Lesson notes

### 1 — First program

Watch for confusion between a source file, a class, and a running program. Students
should change the status message and add a second line. The key assistant behavior
is explanation without editing.

Exit ticket: “What does `main` tell Java, and what did you verify by running it?”

### 2 — Variables and math

The starter deliberately uses weak names (`d`, `r`, `x`). Expected improvements are
names such as `wheelDiameterInches`, `wheelRotations`, and `distanceInches`.
Circumference times rotations is `Math.PI * diameter * rotations`. Ask about units.

Exit ticket: “Why is `double` appropriate here, and where are the units visible?”

### 3 — Decisions and deadbands

The starter bug uses a deadband of `0.01` while the requirement says `0.10`.
Boundary behavior should be discussed explicitly: with `< 0.10`, exactly `0.10`
passes through. Accept either boundary choice if the student states and tests the
requirement consistently.

Exit ticket: “Which three values best test a boundary at 0.10?”

### 4 — Loops and autonomous

The initial loop is finite but has an off-by-one error: it prints four segments when
the requirement says three. Have students trace `step` in a table before editing.
Do not demonstrate an uncontrolled infinite loop on shared machines.

Exit ticket: “What changes each iteration, and why does the loop stop?”

### 5 — Methods, classes, and tests

Students implement clamping to the inclusive range -1.0 through 1.0. Essential
cases include below range, each boundary, within range, and above range. The small
test harness avoids external libraries and should report five passing tests.

Exit ticket: “Why is this logic easier to trust as a method than when duplicated?”

### 6 — Virtual intake

Use this precedence: emergency stop overrides everything; reverse overrides intake;
an object detected prevents normal intake; otherwise intake follows its button and
the motor is stopped. Students may choose different wording but outputs must be
unambiguous. Encourage a decision table before code.

Required scenarios:

| Intake | Reverse | Object | E-stop | Expected power |
|---:|---:|---:|---:|---:|
| false | false | false | false | 0.0 |
| true | false | false | false | 1.0 |
| true | false | true | false | 0.0 |
| true | true | false | false | -1.0 |
| true | true | false | true | 0.0 |

Exit ticket: “Which rule wins when inputs conflict, and which test proves it?”

## Review rubric for the final project

Score each dimension as needs support, developing, or ready:

- Requirements: outputs match every scenario and precedence rule.
- Java reasoning: students explain conditionals, methods, objects, and return values.
- Verification: tests cover normal cases, boundaries, and conflicting inputs.
- Clarity: names reveal intent and methods remain focused.
- Assistant use: prompts were constrained and suggestions were evaluated.
- Teamwork: both partners can explain and run the program.

## Adding a lesson

Copy the nearest lesson rather than inventing a new format. Add its run mapping to
both `scripts/run-lesson.sh` and `scripts/run-lesson.ps1`, run it on a clean checkout
on at least one Unix-like system and Windows, and have a mentor unfamiliar with the
exercise follow the README literally. Keep FTC hardware work in a later, explicitly
supervised track.
