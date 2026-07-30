# Level 3 Preview — Robot Systems and TeleOp

> **Coming later:** You will begin this level after you can safely control and
> explain the individual devices used on the robot.

In Level 3, you will combine separate hardware skills into a working robot. You
will learn how gamepad input becomes drivetrain and mechanism behavior while the
control loop keeps everything responsive.

## What you will learn

1. Read gamepad inputs and apply deadbands and scaling.
2. Test drivetrain directions one motor at a time.
3. Drive robot-centric at reduced power.
4. Organize one mechanism as a reusable subsystem.
5. Drive and operate a mechanism without blocking the control loop.
6. Handle limits, conflicting controls, and safe stop behavior.
7. Complete an integration challenge: drive while operating an intake, arm, or servo.

You will start with robot-centric driving. Field-centric driving can follow after
you understand the drivetrain and the robot's heading sensor.

## Follow one command

By the end, you should be able to trace:

```text
gamepad input → OpMode decision → subsystem method → hardware command
```

See [Robot Code Architecture](../docs/robot-code-architecture.md) for the structure
you will build toward.

## Your next checkpoint

You will be ready for Level 4 when you can safely drive, operate a mechanism,
explain why the control loop must keep running, integrate a partner's subsystem,
and diagnose unexpected movement without guessing.
