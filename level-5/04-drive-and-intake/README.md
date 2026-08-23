# 5.4: Drive and Operate the Intake Together

Plan and implement one TeleOp loop that updates drivetrain intent and intake intent
on every pass.

## Nonblocking means cooperative updates

This lesson does not use Java threads, futures, or background workers. Each loop
iteration performs a small amount of work and returns quickly to the FTC runtime:

```java
public void loop() {
    updateDriveFromGamepad();
    updateIntakeFromGamepad();
    updateTelemetry();
}
```

Neither update waits for the other. The driver experiences them as simultaneous
because both are refreshed many times per second.

## Plan the integration

Record:

| Concern | Decision |
|---|---|
| Driver and operator gamepads | |
| Intake and reverse buttons | |
| Conflicting-button behavior | |
| Precision-drive behavior during intake | |
| Telemetry needed to isolate each subsystem | |
| Complete shutdown path | |

Reuse the verified subsystem operations. Do not retrieve the intake motor directly
from `hardwareMap`, copy motor power into the TeleOp, or bypass drivetrain safety.

## Test the combined loop

1. Verify driving with the intake stopped.
2. Verify intake with the robot stationary.
3. Drive forward while starting and stopping intake.
4. Strafe and rotate while reversing intake.
5. Release every control and confirm both subsystems stop as designed.
6. Press Driver Station Stop while both subsystems are powered.

Telemetry must keep updating throughout every combination.

## Git checkpoint

Commit and push the integrated TeleOp and results after all combined checks pass.

## Ask your AI tutor

> Trace one combined loop from both gamepads to drivetrain and intake outputs.
> Identify blocking work, direct hardware access, duplicate owners, retained
> outputs, or telemetry that cannot isolate which subsystem failed.

## Check your work

Driving remains responsive while the intake starts, stops, and reverses. Continue
to [5.5](../05-responsiveness-and-safety/README.md).

## Reflect

What observation proves the intake did not freeze drivetrain updates?
