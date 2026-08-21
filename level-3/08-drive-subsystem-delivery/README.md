# 3.8: Deliver the Drivetrain Framework

Implement the approved architecture in the Season Repository while preserving the
TeleOp behavior that passed in 3.7.

## Your mission

| | |
|---|---|
| **Time** | 2–3 hours plus review |
| **FTC focus** | drivetrain subsystem, thin TeleOp, complete shutdown |
| **Git focus** | focused commits, pull request, coach review, release tag |
| **AI tutor** | review the change against the approved architecture and evidence |

## 1. Implement one reviewed slice at a time

Create the approved `Robot` and `DrivetrainSubsystem` structure. Move or copy only
the drivetrain behavior needed by the current TeleOp. Preserve verified hardware
names, motor directions, coordinate conventions, power limits, and Stop behavior.

The finished boundary should have these properties:

- the drivetrain subsystem exclusively owns the drive motors;
- its hardware fields remain private;
- the TeleOp expresses driver intent and does not configure motors;
- `Robot` assembles the current subsystems and stops all powered outputs;
- repeated `stop()` calls remain safe; and
- no future mechanism framework is added without a current requirement.

Build after every structural step. Keep compilation fixes separate from behavior
changes when practical so reviewers can understand the history.

## 2. Verify behavior preservation

Repeat the same TeleOp checks recorded before the refactor:

| Check | Before refactor | After refactor | Pass? |
|---|---|---|---|
| Build from a clean checkout | | | |
| Forward and reverse | | | |
| Left and right strafe | | | |
| Rotate both directions | | | |
| Reduced-power or precision mode | | | |
| Driver Station Stop | | | |

Also inspect telemetry and confirm that a stopped OpMode leaves every drivetrain
motor at zero power. A successful build is not evidence that behavior was
preserved.

## 3. Commit and push the feature branch

Review the diff and confirm it contains only the planned architecture, drivetrain,
TeleOp, tests, and documentation changes. Commit meaningful checkpoints, then push
`feature/drive-subsystem`.

Never include passwords, Control Hub Wi-Fi credentials, generated build output,
or unrelated formatting changes.

## 4. Submit the pull request

Open a pull request from `feature/drive-subsystem` into the integration branch
named by the coach. Include:

- the approved architecture decision or link;
- the before-and-after verification table;
- hardware and Driver Station configuration used;
- build and TeleOp evidence;
- known limitations or follow-up work; and
- confirmation that Stop was tested.

Do not merge your own pull request. Address coach comments on the same feature
branch so the pull request updates in place.

## 5. Merge and mark the milestone

After approval, the coach merges the pull request and verifies the integration
branch again. The coach then creates an annotated tag on the merged commit:

```text
v0.1
```

If the repository contains multiple seasons, use the season-qualified tag named in
the [Season Repository Workflow](../../docs/season-repository-workflow.md).

## Ask your AI tutor

> Review only my drivetrain-framework diff. Compare it with the approved
> architecture, identify behavior that may have changed, trace shutdown from the
> OpMode to every motor, and list missing verification evidence. Do not edit.

## Finish Level 3

Level 3 is complete when the reviewed drivetrain framework is merged, the target
branch passes the baseline checks, and the coach has created the `v0.1` milestone
tag. Return to the [Level 3 checkpoint](../../levels/03-robot-systems-and-teleop.md#your-next-checkpoint).

## Reflect

Which test gave the strongest evidence that the refactor preserved behavior?
