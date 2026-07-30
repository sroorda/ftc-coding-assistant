# Level 3 — Robot Systems and TeleOp

> **Status: Planned.** Build these lessons around the team's actual drivetrain and
> mechanisms after Level 2 hardware exercises are proven safe.

## Outcome

Students can operate a drivetrain and a mechanism at the same time, explain how
gamepad input reaches hardware, and organize reusable behavior without hiding the
FTC control loop.

## Planned modules

1. Gamepad inputs, deadbands, scaling, and telemetry
2. Drivetrain directions and individual motor tests
3. Robot-centric driving at reduced power
4. One mechanism as a reusable subsystem
5. Operating drive and mechanism together without blocking
6. Limits, conflicting controls, and safe stop behavior
7. Integration project: drive while operating an intake, arm, or servo

Field-centric driving can follow after students understand robot-centric behavior
and the team's heading sensor. It should not conceal drivetrain fundamentals.

## Architecture milestone

Students evolve the base code toward thin OpModes and reusable subsystems. They
should be able to trace:

```text
gamepad input → OpMode decision → subsystem method → hardware command
```

Pairs may own different subsystems, but integration is reviewed together. See
[Robot Code Architecture](../docs/robot-code-architecture.md).

## Readiness for Level 4

Students can:

- safely drive the robot and operate at least one mechanism;
- explain why the control loop must keep running;
- identify where hardware is initialized and where behavior belongs;
- test drivetrain directions and mechanism limits independently;
- integrate two student-owned changes through reviewed pull requests; and
- stop and diagnose unexpected movement without guessing.
