# Student Program Roadmap

Every student follows the same progression. The program begins with Java away from
the robot, then adds hardware, complete robot behavior, autonomous motion, and
coordinated autonomous actions. Students advance by demonstrating readiness, not by
title or prior experience.

## The five levels

| Level | Focus | Student outcome | Status |
|---|---|---|---|
| [1 — Java Foundations](levels/01-java-foundations.md) | Java and robot-like logic without hardware | write, test, debug, and explain small Java programs | **Available now** |
| [2 — Hardware Lab](levels/02-hardware-lab.md) | FTC SDK, telemetry, motors, servos, and sensors | safely control and observe one device at a time | Planned |
| [3 — Robot Systems and TeleOp](levels/03-robot-systems-and-teleop.md) | gamepads, drivetrain, mechanisms, and subsystems | drive while operating a mechanism | Planned |
| [4 — Autonomous Motion](levels/04-autonomous-motion.md) | poses, localization, tuning, and Pedro Pathing | build and verify reliable autonomous movement | Planned |
| [5 — Coordinated Autonomous](levels/05-coordinated-autonomous.md) | actions, state machines, callbacks, and recovery | coordinate mechanisms with path following | Planned |

“Planned” pages define outcomes and design constraints. They are not complete
student lessons yet. Build and test each level with the team's actual hardware before
presenting it as ready for independent student use.

## Progression

Level 1 deliberately contains no robot SDK, hardware setup, or team Git process. It
gives beginners a fast environment in which they can concentrate on code.

After Level 1, students complete the [Team Workflow Bootcamp](team-workflow.md). Git
then becomes the normal way work moves through Levels 2–5, but it remains a team
practice rather than a programming lesson objective.

Each later level adds one new boundary:

1. ordinary Java logic;
2. Java logic connected to individual hardware;
3. subsystems coordinated by a TeleOp;
4. drivetrain movement coordinated by a path follower; and
5. drivetrain and mechanism actions coordinated without blocking the control loop.

## Readiness gates

A student is ready to advance when they can demonstrate the prior level without the
AI assistant speaking for them. Adults may adjust pace and accommodations, but
should not waive hardware safety or understanding checks.

| Move to | Required evidence |
|---|---|
| Level 2 | complete the Level 1 readiness check and the Team Workflow Bootcamp |
| Level 3 | safely initialize, command, stop, and explain each device used on the robot |
| Level 4 | operate the drivetrain and mechanisms in TeleOp and explain the robot code structure |
| Level 5 | create, tune, and verify a simple path with reliable localization |
| Competition work | demonstrate coordinated behavior, recovery, review, and safe deployment with an adult mentor |

## Supporting guides

- [Team Workflow Bootcamp](team-workflow.md) introduces Git after Level 1.
- [Robot Code Architecture](docs/robot-code-architecture.md) shows how the base
  framework grows through Levels 2–5.
- [Adult Mentor Guide](mentors/adult-mentor-guide.md) defines teaching, AI, privacy, and safety
  responsibilities.

AI can explain, question, review, and suggest verification. It is not an accountable
mentor. Adults remain responsible for student supervision, hardware safety, and
final technical decisions.
