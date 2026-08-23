# 5.6: Review and Release the Intake TeleOp

Prepare `feature/intake-subsystem` for coach review, merge it into the protected
Season Repository integration branch, and mark the `v0.3` milestone.

## Pull-request checklist

Include:

- approved intake hardware and behavior contracts;
- updated `docs/architecture.md` ownership and shutdown path;
- subsystem implementation and standalone test OpMode;
- every button-combination result;
- integrated drive-and-intake evidence;
- responsiveness and safe-failure matrix;
- Driver Station Stop evidence; and
- known limitations or future sensor/interlock work.

Keep unrelated Pedro tuning, path, or vision changes out of this pull request.

## Coach review and merge

Open the pull request from `feature/intake-subsystem` into the coach-named
integration branch. Address review comments on the same branch. After approval,
the coach merges and reruns standalone-intake, drive-only, combined, and Stop
checks.

The coach then creates the annotated milestone tag:

```text
v0.3
```

Use the season-qualified form when required by the
[Season Repository Workflow](../../docs/season-repository-workflow.md).

## Ask your AI tutor

> Review this intake pull request without editing. Trace every driver request to a
> subsystem state and hardware output, then trace release and Stop through the
> complete robot. Identify claims that lack recorded evidence.

## Finish Level 5

Level 5 is complete when standalone intake and integrated TeleOp tests pass on the
merged integration branch and the coach has created the `v0.3` tag. Return to the
[Level 5 checkpoint](../../levels/05-nonblocking-robot-operations.md#your-next-checkpoint).

## Reflect

Which architectural boundary made the integration easiest to review?
