# 4.6: Merge Pedro Pathing into Main

Finish Level 4 by submitting `feature/pedro-pathing` for coach review. The coach
will merge the code into `main` and create the `v0.2` milestone tag.

## Before you open the pull request

- [ ] All Level 4 changes are committed and pushed.
- [ ] There are no uncommitted changes.
- [ ] The project builds.
- [ ] TeleOp still works.
- [ ] `First Pedro Auto` works.
- [ ] `Visualizer Auto` works.

## Open the pull request

Create the pull request in GitHub:

- **Base:** `main`
- **Compare:** `feature/pedro-pathing`
- **Title:** `Add Pedro Pathing autonomous motion`

In the description, state that:

- Pedro Pathing was installed and tuned;
- localization works;
- the hand-built Auto works;
- the Visualizer Auto works;
- TeleOp still works; and
- any known limitations are listed.

Request review from the coach. If changes are requested, commit and push them to
the same feature branch so the pull request updates automatically.

## After coach review

The coach will merge the pull request in GitHub, delete the remote feature branch,
and create the `v0.2` tag.

After the merge, use Android Studio to update your local `main` branch. Build and
deploy from `main`, then run a quick final check of TeleOp and both Autonomous
OpModes.

## Troubleshooting

| Problem | What to check |
|---|---|
| Pull request contains unrelated files | Confirm the base is `main` and compare branch is `feature/pedro-pathing` |
| Pull request has merge conflicts | Update the feature branch from `main`, resolve the conflicts with the coach, and retest |
| Code worked before merging but not afterward | Confirm local `main` contains the merged changes, then rebuild and deploy |
| Autonomous OpMode is missing | Confirm its Java file was merged, then rebuild and deploy |
| Feature branch was deleted before the work was merged | Stop and ask the coach to help recover the branch or commits |

## You are done with Level 4 when

- [ ] The pull request is approved and merged.
- [ ] Local `main` is updated.
- [ ] The project builds from `main`.
- [ ] TeleOp and both Autos work from `main`.
- [ ] The coach created the `v0.2` tag.
- [ ] The feature branch is deleted.

Return to the [Level 4 checkpoint](../../levels/04-autonomous-motion.md#your-next-checkpoint).
