# 3.3: Turn Gamepad Input into Driver Intent

You will make the drivetrain easier to control with named input processing rather
than scattering signs, deadbands, and scale factors through the OpMode.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | deadband, scaling, slow mode, observable intent |
| **Git focus** | tests before behavior integration |
| **AI tutor** | challenge boundary cases and control conflicts |

## Design first

Record the team's choices for stick mapping, deadband boundary, normal scale, slow
scale, and slow-mode button. Predict output for `0`, just below the deadband,
exactly at it, just above it, and full stick travel.

Create small hardware-independent methods for deadband and scale. Decide whether
input immediately outside the deadband jumps or is rescaled; either approach is
acceptable when documented and tested. Keep FTC `gamepad` access in the OpMode.

## Hands-on change

1. Read each gamepad axis once per loop and apply its sign once.
2. Convert the raw values to named `forward`, `strafe`, and `turn` intent.
3. Select normal or slow scale with an explicit priority rule.
4. Call the drivetrain with processed intent.
5. Show raw axes, processed intent, active mode, and applied wheel powers.

| Scenario | Verify |
|---|---|
| Sticks centered | Intent and motor commands remain zero despite small drift. |
| Deadband boundary | Behavior matches the documented comparison. |
| Slow mode | Direction is unchanged and magnitude is reduced. |
| Release slow mode | Normal scale returns immediately. |
| Stop | Drivetrain stops regardless of previous input. |

## Ask your AI tutor

> Review my input-processing methods and tests without editing. Look for duplicate
> sign changes, undocumented boundary behavior, a scale that can exceed one, and
> telemetry that confuses raw input with applied output.

## Check your work

The PR includes the input contract and boundary evidence. Explain where gamepad
input becomes robot intent and why that decision does not belong in the hardware
mapping class. Continue to [3.4](../04-first-subsystem/README.md).

## Reflect

Which input-processing choice most changed how the robot felt, and what evidence
shows it preserved the driver's intended direction?
