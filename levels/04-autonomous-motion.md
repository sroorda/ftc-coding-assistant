# Level 4 — Autonomous Motion with Pedro Pathing

> **Status: Planned.** Pedro Pathing and the FTC SDK evolve. Confirm the current
> official installation and tuning guidance when these lessons are implemented.

## Outcome

Students understand poses, field coordinates, localization, paths, and tuning well
enough to build and verify reliable autonomous drivetrain movement.

## Entry requirements

Before using Pedro Pathing, the team needs:

- a reliable omnidirectional drivetrain;
- a supported and tested localization method;
- an Android Studio FTC project;
- known motor directions and drivetrain measurements; and
- safe Level 3 TeleOp operation.

## Planned modules

1. Field coordinates, poses, headings, and units
2. Localization and measuring error
3. Pedro Pathing project structure and follower lifecycle
4. Straight paths, turns, and heading interpolation
5. Building and following a short path chain
6. Tuning through recorded evidence rather than guesswork
7. Start pose, end constraints, stop behavior, and recovery
8. Autonomous project: repeatable start-to-target-to-park motion

Students should first make drivetrain motion reliable. Mechanism actions during a
path belong in Level 5.

## Architecture milestone

Keep named poses, path definitions, tuning constants, and mechanism behavior
separate enough to review independently. Record the coordinate convention beside
the season's field definitions.

## Readiness for Level 5

Students can:

- draw and explain the coordinate system before writing a path;
- report expected and observed start/end poses;
- explain how localization affects correction;
- build, tune, and repeat a simple path safely;
- identify what must update on every control-loop iteration; and
- distinguish a path-definition problem from a localization or tuning problem.

## Planning references

- [Pedro Pathing introduction and prerequisites](https://pedropathing.com/docs/pathing)
- [Pedro Pathing installation](https://pedropathing.com/docs/pathing/installation)
- [Pedro Pathing coordinate system](https://pedropathing.com/docs/pathing/reference/coordinates)
