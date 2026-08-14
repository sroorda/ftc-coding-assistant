# 5.6: Coordinated Autonomous Challenge

Build a routine that drives, performs one acquire-or-score action, responds to a
failure, and parks. Use the same subsystem operations proven in TeleOp.

## Required behavior

- Paths, poses, and mechanism actions work independently before integration.
- One outer loop updates follower, every active subsystem, coordination, and
  telemetry.
- Every action has start, update, completion, timeout, and cancel behavior.
- Every state defines outputs, success, failure, and maximum duration.
- Safety/interlock decisions outrank scoring progress.
- `COMPLETE`, `FAULT`, routine timeout, and Driver Station Stop leave all powered
  outputs safe.
- Telemetry identifies routine state, path, pose, busy state, action state,
  target, observed evidence, elapsed times, and failure reason.

## Demonstration matrix

| Run | Required result |
|---|---|
| Normal | Drive, act, and park successfully. |
| Delayed action | Updates continue and the routine waits or pauses as designed. |
| Action failure | Specific fault is reported and outputs become safe. |
| Routine timeout | Remaining work is cancelled and outputs become safe. |
| Stop in path | Drive and mechanism stop. |
| Stop during action | Mechanism and drive stop. |
| Five repeated normal runs | Outcomes and final-pose error are recorded. |

Integrate through reviewed interfaces. Keep season coordinates and tuned constants
easy to find. Do not “fix” an integration failure by bypassing a subsystem limit or
weakening a test.

## Ask your AI tutor

> Review my final autonomous against this matrix without editing. Trace one normal
> run and every failure run, identify commands without completion evidence, and
> name the exact telemetry and test evidence needed for each claim.

## Finish Level 5

The PR includes the state/action tables, five-run data, failure evidence, partner
review, and known limitations. Explain one full trace:

```text
autonomous condition → coordinator → subsystem action → hardware command
```

Return to the [Level 5 checkpoint](../../levels/05-coordinated-autonomous.md#your-final-checkpoint).

## Reflect

Which failure test added confidence that a normal success run could not provide?
