# Your Robotics Programming Roadmap

You will build your robotics skills in seven levels. Each level adds one new layer,
so you understand the code beneath the robot behavior instead of only copying a
finished solution.

## The seven levels

| Level | Your challenge | Status |
|---|---|---|
| [1 — Java Foundations](levels/01-java-foundations.md) | write, test, debug, and explain robot-like Java | **Ready now** |
| [2 — Hardware Lab](levels/02-hardware-lab.md) | safely command and observe one device at a time | Coming later |
| [3 — Robot Systems and TeleOp](levels/03-robot-systems-and-teleop.md) | build drive, plan the architecture, and deliver the Season Repository drivetrain framework | Published draft for robot validation |
| [4 — Autonomous Motion](levels/04-autonomous-motion.md) | install and tune Pedro Pathing, then deliver two repeatable paths | Draft for robot/version validation |
| [5 — Nonblocking Robot Operations](levels/05-nonblocking-robot-operations.md) | add an intake and operate it while driving | Draft for mechanism validation |
| 6 — Nonblocking Autonomous | coordinate Pedro paths with observable intake actions | GitHub planning draft; not in student navigation |
| 7 — Vision | convert a verified camera observation into a safe autonomous decision | Mentor planning only |

Levels 2–5 contain student-facing lesson drafts. Level 6 preserves the coordinated
autonomous draft in GitHub for further validation. Level 7 contains only planning
decisions. Hardware-dependent claims and procedures require the validation named
on each level page before publication.

## How the levels build on one another

1. You begin with ordinary Java logic.
2. You connect Java logic to individual hardware devices.
3. You build and explain robot- and field-relative drive, then move the verified
   drivetrain into the team's Season Repository architecture.
4. You install and tune Pedro Pathing and create two motion-only autonomous paths.
5. You add and independently test an intake, then operate it while driving.
6. You coordinate drivetrain movement with observable, cancellable intake actions.
7. You add a verified vision observation and a conservative fallback decision.

Level 1 intentionally leaves out the FTC SDK, physical hardware, and most Git
workflow. That gives you a fast place to experiment while you learn the language.

## Your checkpoints

| Before you begin | Show that you can |
|---|---|
| Level 2 | complete Level 1 and the Level 2 computer setup |
| Level 3 | initialize, command, stop, and explain each device you will use |
| Level 4 | deliver the reviewed Season Repository drivetrain framework and `v0.1` milestone |
| Level 5 | create, tune, and repeat both a hand-built and Visualizer-authored path |
| Level 6 | drive while operating the intake and stop both safely from every tested combination |
| Level 7 | demonstrate safe nonblocking autonomous success, timeout, cancellation, and failure |
| Competition work | validate the current vision goal and demonstrate the team's review and deployment process |

## Season Repository milestones

Beginning with Lesson 3.7, all implementation work happens in the team's Season
Repository:

| Milestone | Feature branch | Tag after coach-reviewed merge |
|---|---|---|
| Drivetrain framework | `feature/drive-subsystem` | `v0.1` |
| Pedro Pathing | `feature/pedro-pathing` | `v0.2` |
| Intake and integrated TeleOp | `feature/intake-subsystem` | `v0.3` |
| Nonblocking autonomous | `feature/nonblocking-auto` | `v0.4` |
| Vision | `feature/vision` | `v0.5` |

See the [Season Repository Workflow](docs/season-repository-workflow.md) for the
access gate, integration-branch models, PR evidence, and season-qualified tags.

An AI tutor can help you ask questions and review evidence. It cannot demonstrate
your understanding for you, replace hardware safety checks, or make final team
decisions.
