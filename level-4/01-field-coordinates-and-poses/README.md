# 4.1: Field Coordinates and Poses

Before the robot follows a path, you must be able to describe where it is. Pedro
Pathing represents a pose as `x`, `y`, and heading; distance is normally inches
and heading is radians.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | coordinate frame, pose, units, start placement |
| **Git focus** | review field facts separately from path code |
| **AI tutor** | check conversions and assumptions against a field drawing |

Read the current [Pedro coordinate reference](https://pedropathing.com/docs/pathing/reference/coordinates).
Create a team field diagram showing the origin, positive axes, zero heading, and
positive rotation. Mark the robot center used by localization—not its bumper.

Choose a clear practice area and measure three named poses: `START`, `TARGET`, and
`PARK`. Store headings with `Math.toRadians(...)` so the reviewed degree value is
visible. Do not copy season coordinates from an example autonomous.

## Predict and verify without path following

1. Place the robot at `START` using repeatable physical references.
2. Predict how reported `x`, `y`, and heading change for forward, left, and a
   counterclockwise rotation.
3. Push the unpowered robot through those motions while viewing localization.
4. Compare the sign and units, not just whether numbers changed.

| Motion | Expected change | Observed change | Pass? |
|---|---|---|---|
| Forward at zero heading | | | |
| Left strafe | | | |
| Counterclockwise turn | | | |

## Ask your AI tutor

> Review my coordinate diagram and pose constants without editing. Check origin,
> axes, units, robot reference point, radians, and whether each claim needs a
> physical measurement.

## Check your work

Your PR includes the diagram and signed-motion evidence. Explain why the same
physical spot can be described differently in two coordinate systems. Continue
to [4.2](../02-localization-evidence/README.md).

## Reflect

Which placement error could look like a localizer error?
