# FTC Java + AI Coding Assistant Training

A beginner-friendly training program for an FTC software team. It combines three
roles that need different skills:

- **Track A — Students:** learn Java and responsible AI-assisted programming;
- **Track B — Team Leads:** learn Git, code review, project structure, and architecture;
- **Track C — Mentors:** learn to use Claude Code without taking the learning away.

The exercises run without an FTC Robot Controller, so the whole team can practice
before working in the competition repository.

## Course goals

By the end of the course, students should be able to:

- read, change, compile, and run a small Java program;
- use variables, conditionals, loops, methods, classes, and basic tests;
- connect those ideas to FTC concepts such as motor power, joystick deadbands,
  autonomous sequences, and subsystems;
- ask an AI assistant for explanations, hints, reviews, and test ideas;
- verify suggestions instead of accepting generated code blindly; and
- work safely around robot configuration, deployment, credentials, and Git.

## Start here

Requirements: **JDK 17 or newer** and a terminal. The current FTC SDK build tools
require JDK 17, while FTC student source remains Java 8 compatible. The lesson
runners enforce that same Java 8 source/API boundary. See
[Java and FTC compatibility](docs/java-compatibility.md) for the distinction.

Windows, macOS, and Linux are supported; Windows students do not need WSL or Git
Bash. If the environment check fails, follow [Windows setup](docs/windows-setup.md)
or [macOS setup](docs/macos-setup.md).

macOS or Linux:

```text
./scripts/check-environment.sh
./scripts/run-lesson.sh 01
```

Windows Command Prompt or PowerShell:

```text
scripts\check-environment.cmd
scripts\run-lesson.cmd 01
```

Then open [Lesson 1](lessons/01-first-program/README.md). Students should make
changes themselves unless an exercise explicitly allows the assistant to edit.

Team leads and mentors should begin with [TRACKS.md](TRACKS.md), which explains how
the three tracks run together and links to the role-specific guides.

## Repository map

```text
.
├── CLAUDE.md                 AI tutoring and safety rules
├── CURRICULUM.md             Course sequence and learning outcomes
├── TRACKS.md                 Three-track program and shared delivery plan
├── docs/
│   ├── student-workflow.md   Repeatable learn/prompt/verify loop
│   ├── ftc-transition.md     Moving from simulations to the FTC SDK
│   ├── java-compatibility.md FTC build JDK versus source language level
│   ├── macos-setup.md        macOS JDK installation and troubleshooting
│   └── windows-setup.md      Windows JDK installation and troubleshooting
├── tracks/
│   ├── students.md           Track A learning path and readiness checks
│   ├── team-leads.md         Track B Git, reviews, structure, and architecture
│   └── mentors.md            Track C AI-assisted teaching playbook
├── instructor/
│   └── instructor-guide.md   Preparation, pacing, answers, and discussion notes
├── lessons/
│   ├── 01-first-program/
│   ├── 02-variables-and-math/
│   ├── 03-decisions-and-deadbands/
│   ├── 04-loops-and-autonomous/
│   ├── 05-methods-classes-and-tests/
│   └── 06-virtual-intake-project/
└── scripts/
    ├── check-environment.sh  macOS/Linux environment check
    ├── run-lesson.sh         macOS/Linux lesson runner
    ├── check-environment.cmd Windows environment check
    └── run-lesson.cmd        Windows lesson runner
```

Each lesson is self-contained. Its `README.md` gives the concepts, prediction,
exercise, assistant prompt, verification, and reflection. Source files live under
`src/org/ftc/training/lessonNN` to introduce Java package conventions early.

## Recommended delivery

- Six student sessions of 60–90 minutes, ideally in pairs.
- Four short lead workshops using student work as realistic practice.
- A mentor calibration before the course and a ten-minute debrief after each session.
- One computer per pair, with a mentor able to project demonstrations.
- Use a practice clone or branch, never the active competition working copy.
- Commit a known-good state before every AI-assisted exercise.
- Follow account eligibility and school/team policies for the chosen assistant.

The AI tool is deliberately not the subject of the course. It is a tutor and
reviewer inside a Java course. Students remain responsible for every changed line
and every claim that the program works.

## Expanding the course

New lessons should copy the existing shape: a focused `README.md`, minimal Java
source, a robotics connection, one constrained AI interaction, and observable
success criteria. Later modules can add FTC SDK code, Git collaboration, telemetry,
state machines, sensors, command-based design, and hardware-in-the-loop testing.
