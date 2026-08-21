# 4.3: Complete the Pedro Tuning Tests

Tune the robot through the complete coach-selected path in the pinned official
[Pedro tuning guide](https://pedropathing.com/docs/pathing/tuning). Do not skip to
path building because one test looks impressive.

## Choose and record the tuning path

The current Pedro guide may offer more than one drive-algorithm path. The coach
records which path the team supports for this version. Follow its setup,
localization, velocity, heading, drive-algorithm, test, and troubleshooting steps
in the documented order.

For every retained change, record:

| Test | Constant | Old | New | Reason | Quantitative result | Keep? |
|---|---|---:|---:|---|---|---|
| | | | | | | |

Change one category at a time. Preserve a known-good commit so recovery does not
depend on memory.

## Require repeatable evidence

Run each required test under the approved battery and training-power conditions.
Record repeated results, not only the best run:

| Run | X error | Y error | Heading error | Time | Overshoot/oscillation |
|---:|---:|---:|---:|---:|---|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |

If results drift, inspect mechanical looseness, traction, start placement, wiring,
and localization before changing follower values.

## Git checkpoint

Once every required item under the selected tuning path and its final Tests section
passes, review the constants diff, commit the retained values and evidence, and
push the checkpoint.

## Ask your AI tutor

> Analyze my tuning log without proposing several simultaneous changes. State
> what the data supports, what remains ambiguous, and one next experiment whose
> result could disprove the current hypothesis.

## Check your work

The team can reproduce the passing tests from the documented starting conditions.
Continue to [4.4](../04-hand-built-path/README.md).

## Reflect

Which tempting tuning change did the evidence not justify?
