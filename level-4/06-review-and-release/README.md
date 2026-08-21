# 4.6: Review and Release Pedro Pathing

Prepare the complete `feature/pedro-pathing` change for coach review, merge it into
the Season Repository's protected integration branch, and mark the `v0.2`
milestone.

## Pull-request checklist

The pull request includes:

- pinned Pedro, FTC SDK, dashboard, and relevant firmware versions;
- drivetrain and localization hardware contract;
- installation and unchanged-TeleOp evidence;
- constants and the source of their initial and tuned values;
- completed tuning-test evidence;
- the hand-built four-segment path and its repeated results;
- the Visualizer-authored path and its repeated results;
- timeout and Driver Station Stop evidence; and
- known limitations or conditions that require retuning.

Keep dependency installation, constants, paths, and evidence understandable in the
commit history. Do not combine unrelated mechanism or vision work into this pull
request.

## Coach review and merge

Open the pull request from `feature/pedro-pathing` into the integration branch
named in the [Season Repository Workflow](../../docs/season-repository-workflow.md).
Address review comments on the same branch. The coach confirms the target, reviews
the hardware evidence, merges, and reruns the critical regression checks.

After the merged commit passes, the coach creates the annotated milestone tag:

```text
v0.2
```

Use the season-qualified form when the repository contains multiple seasons.

## Ask your AI tutor

> Review this Pedro Pathing pull request without editing. Trace installation,
> constants, localization, tuning, both paths, completion, timeout, and Stop
> evidence. Identify claims that are not supported by a repeatable observation.

## Finish Level 4

Level 4 is complete when the reviewed code is merged, both paths repeat from their
documented starts, TeleOp still works, and the coach has created the `v0.2` tag.
Return to the [Level 4 checkpoint](../../levels/04-autonomous-motion.md#your-next-checkpoint).

## Reflect

Which pull-request artifact will be most useful when the robot changes later?
