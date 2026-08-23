# 5.2: Implement the Intake Subsystem

Create the intake subsystem and its hardware implementation using the approved
contract from 5.1.

## Required structure

Use the course's [Robot Code Architecture](../../docs/robot-code-architecture.md)
as a reference, then adapt it to the Season Repository's actual package names and
hardware. Do not paste the example over verified season code.

The subsystem must:

- exclusively own its motor or servo fields;
- initialize the approved hardware name and direction;
- apply the reviewed power or position limits;
- provide domain operations for intake, reverse, and stop;
- report its current state and applied output for telemetry;
- start in a safe stopped state;
- make repeated `stop()` calls safe; and
- contain no gamepad or OpMode lifecycle logic.

Add the subsystem to `Robot` and include it in the complete shutdown path. Do not
change the drivetrain or Pedro interfaces to make the intake fit.

## Verify in layers

1. Build before connecting to the robot.
2. Inspect the diff for the exact approved hardware name and limits.
3. With output disabled or disconnected when practical, verify initialization and
   state decisions.
4. Apply the smallest useful output with the mechanism secured.
5. Verify start, reverse, stop, and repeated stop independently.

Do not test conflicting buttons yet; button policy belongs in the test OpMode.

## Git checkpoint

Commit and push the subsystem implementation after the layered checks pass. Keep
this checkpoint separate from the upcoming OpMode when practical.

## Ask your AI tutor

> Review only my intake subsystem. Trace initialization and each public operation
> to the hardware output, verify clipping and state reporting, find retained-power
> paths, and confirm no gamepad or lifecycle responsibility leaked into it.

## Check your work

The intake responds safely through public operations and `Robot.stop()` stops it.
Continue to [5.3](../03-intake-test-opmode/README.md).

## Reflect

Which safety property remains true no matter which OpMode calls the subsystem?
