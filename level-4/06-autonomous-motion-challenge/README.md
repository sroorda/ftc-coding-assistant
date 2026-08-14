# 4.6: Autonomous Motion Challenge

Create a repeatable `START → TARGET → PARK` routine using drivetrain motion only.
Mechanism actions belong in Level 5.

## Requirements

- Named, measured poses and a field drawing agree.
- Paths are constructed before Start and begun through explicit states.
- `follower.update()` runs on every active loop.
- Each transition uses `!follower.isBusy()` or another documented condition plus
  a separate routine timeout/failsafe.
- Telemetry reports state, target, pose, error, busy state, elapsed time, and
  failure reason.
- Driver Station Stop ends motion from every state.
- Five trials begin from the same placement and record final error and outcome.

Test state transitions with drivetrain output disabled, then each path alone, then
the complete routine. Include one safe failure test such as an intentionally short
routine timeout; do not physically obstruct a moving robot.

## Ask your AI tutor

> Review my motion-only autonomous without editing. Trace every state, path start,
> completion condition, timeout, telemetry field, and Stop path. Distinguish path
> definition, localization, tuning, and sequencing risks.

## Finish Level 4

The PR includes drawings, tuning evidence, five-run results, failure evidence, and
known limitations. Return to the [Level 4 checkpoint](../../levels/04-autonomous-motion.md#your-next-checkpoint).

## Reflect

Which evidence let you classify a failed run without guessing?
