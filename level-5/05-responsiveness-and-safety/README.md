# 5.5: Prove Responsiveness and Safe Shutdown

Test the integrated TeleOp under transitions and failures that a basic success run
can miss.

## Responsiveness evidence

Add temporary or permanent telemetry that makes loop progress observable. Record:

| Scenario | Drive evidence | Intake evidence | Stop evidence | Pass? |
|---|---|---|---|---|
| Rapid intake start/stop while driving | | | | |
| Rapid reverse transitions | | | | |
| Both intake buttons held | | | | |
| Gamepad disconnect or approved simulation | | | | |
| OpMode Stop while both run | | | | |
| Driver Station emergency Stop | | | | |

Do not create failures by jamming the intake or obstructing a moving robot. Use
released controls, conservative output, simulated decision inputs, or another
coach-approved safe method.

## Inspect the architecture

Confirm:

- the TeleOp contains no sleep, busy wait, or worker thread;
- every loop can reach telemetry and lifecycle handling quickly;
- exactly one subsystem owns each powered output;
- both subsystems receive a safe command when controls are released; and
- `Robot.stop()` reaches every powered subsystem.

Remove diagnostic code that changes timing or behavior, but retain useful telemetry
and the evidence table.

## Ask your AI tutor

> Review my integrated TeleOp and evidence without editing. Identify any path that
> can retain power, delay another subsystem, skip telemetry, or prevent Stop from
> reaching both drivetrain and intake.

## Check your work

The matrix passes and known limitations are recorded. Continue to
[5.6](../06-review-and-release/README.md).

## Reflect

Which transition exposed a problem that steady-state testing would not find?
