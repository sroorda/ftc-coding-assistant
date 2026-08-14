# 4.4: Heading, Curves, and Path Chains

You will separate where the robot travels from which direction it faces.

Draw and predict three paths before running them: a straight line with constant
heading, a straight line with linear heading interpolation, and a gentle Bézier
curve with a reviewed control point. Pedro headings are radians.

Build each as a `PathChain` using the pinned version's API. Test one change at a
time and record whether the unexpected result came from geometry, heading,
localization, or follower tuning. Then join two verified segments into one short
chain and verify that their shared pose agrees.

| Path | Position goal | Heading goal | Expected end | Observed end |
|---|---|---|---|---|
| Constant-heading line | | | | |
| Turning line | | | | |
| Curve | | | | |
| Two-segment chain | | | | |

## Ask your AI tutor

> Review my path definitions without editing. For each segment, describe geometry
> separately from heading interpolation, check endpoint continuity and radians,
> and identify the smallest test that isolates an error.

## Check your work

The PR contains drawings, definitions, and repeated end-pose evidence. Explain why
a correct curve can still have a wrong heading. Continue to
[4.5](../05-tuning-with-evidence/README.md).

## Reflect

Which test best separated geometry from heading interpolation?
