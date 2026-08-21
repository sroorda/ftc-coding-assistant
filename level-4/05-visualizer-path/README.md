# 4.5: Build a Second Path with the Pedro Visualizer

Use the [Pedro Pathing Visualizer](https://visualizer.pedropathing.com/) to design a
different path, export it, integrate the generated result into `TeamCode`, and
verify that the visual plan matches the robot's behavior.

## Build and review the visual plan

Use the same coordinate contract and robot reference point established in 4.2.
Create a path that is meaningfully different from the hand-built path: change the
route, heading behavior, or curve geometry rather than renaming the same points.

Before exporting, record:

| Item | Decision |
|---|---|
| Start pose | |
| End pose | |
| Segment geometry | |
| Heading behavior | |
| Clearance assumptions | |
| Expected duration and completion condition | |

## Export and integrate

Export using the visualizer's format for the pinned Pedro version. Add the result
to the Season Repository's `TeamCode` module using the team's package and naming
conventions.

Generated code is still team code. Review every pose, unit, heading, control point,
constraint, callback, and import. Remove unused generated content and do not accept
an API mismatch because the visual preview looked correct.

## Test and compare

Use the same layered checks as 4.4. Compare the visualizer preview with the observed
route and record at least three repeated final poses.

| Run | Preview agreement | Final pose error | Outcome |
|---:|---|---:|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |

Fix and retest until the result is repeatable, then commit and push the exported
path and evidence.

## Ask your AI tutor

> Review the exported path against my visual plan and pinned Pedro version. Check
> units, headings, package names, API compatibility, unused generated content,
> lifecycle integration, and whether my tests prove the preview matches reality.

## Check your work

You can explain the generated path and reproduce it from the documented starting
placement. Continue to [4.6](../06-review-and-release/README.md).

## Reflect

Which generated detail required the most careful human review?
