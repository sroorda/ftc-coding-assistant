# 6.6: Complete and Release a Nonblocking Autonomous

Build a routine that drives, performs one intake action, responds to a failure, and
parks. Use only the drivetrain and intake operations independently verified in
earlier levels.

## Required behavior

- Paths, poses, and intake actions work independently before integration.
- One outer loop updates the follower, action, coordinator, and telemetry.
- Every action has start, update, completion, timeout, and cancel behavior.
- Every state defines outputs, success, failure, and maximum duration.
- Safety and interlock decisions outrank autonomous progress.
- `COMPLETE`, `FAULT`, routine timeout, and Stop leave all outputs safe.

## Demonstration matrix

| Run | Required result |
|---|---|
| Normal | Drive, run the intake action, and park successfully. |
| Delayed action | Updates continue and the routine waits or pauses as designed. |
| Action failure | Specific fault is reported and outputs become safe. |
| Routine timeout | Remaining work is cancelled and outputs become safe. |
| Stop in path | Drive and intake stop. |
| Stop during action | Intake and drive stop. |
| Five repeated normal runs | Outcomes and final-pose error are recorded. |

## Review and milestone

Push `feature/nonblocking-auto` and open a pull request into the coach-named
integration branch. Include action/state tables, tests, the demonstration matrix,
known limitations, and the complete Stop path. After review and merge, the coach
reruns the critical checks and creates the annotated tag:

```text
v0.4
```

Use the season-qualified form when required by the
[Season Repository Workflow](../../docs/season-repository-workflow.md).

## Ask your AI tutor

> Review my final autonomous without editing. Trace one normal run and every
> failure run, identify commands without completion evidence, and name the exact
> telemetry and test evidence needed for each claim.

## Finish Level 6

The reviewed change is merged, the matrix passes, and the coach has created the
`v0.4` tag. Return to the [Level 6 checkpoint](../../levels/06-nonblocking-autonomous.md#your-next-checkpoint).

## Reflect

Which failure test added confidence that a normal success run could not provide?
