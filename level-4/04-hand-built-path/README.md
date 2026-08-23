# 4.4: Design and Build a Four-Segment Path

Plan a motion-only path on an empty field, write it with the pinned Pedro API, and
verify the follower lifecycle before adding mechanisms.

## Plan before coding

Draw a path containing at least four meaningful segments. Mark:

- measured start, intermediate, and end poses;
- line or curve geometry for each segment;
- heading behavior independently from geometry;
- the robot's reference point and required clearances; and
- the success, timeout, and Stop conditions.

Ask a coach to approve the test area and conservative constraints.

## Implement the path

Follow the pinned [Path Builder reference](https://pedropathing.com/docs/pathing/reference/path-builder).
Construct paths before Start, set the measured starting pose, start each path or
chain exactly once, and call `follower.update()` on every active-loop pass.

Telemetry reports routine state, active segment or chain, pose, busy state,
elapsed time, and failure reason. Do not use an inner waiting loop or restart a path
on every pass.

## Test in layers

1. Trace states with drive output disabled or wheels safely supported.
2. Test each segment independently.
3. Test segment transitions.
4. Run the complete path at approved power.
5. Repeat from the same physical placement at least three times.
6. Press Driver Station Stop during motion.

Record expected and observed end poses and fix geometry, heading, localization,
tuning, or lifecycle problems according to the evidence.

## Git checkpoint

Commit and push the working hand-built path, drawing, repeated results, and known
limitations.

## Ask your AI tutor

> Review my four-segment path without editing. Separate geometry from heading,
> trace each start and completion transition, confirm follower updates remain
> continuous, and identify missing timeout, Stop, or repeatability evidence.

## Check your work

The path completes repeatably from the documented start and its code can be
explained segment by segment. Continue to [4.5](../05-visualizer-path/README.md).

## Reflect

Which failure was caused by path definition rather than tuning?
