# 4.2: Establish Constants and Trustworthy Localization

Configure the actual drivetrain and localizer, then measure pose behavior before
tuning path following.

## Get ready

Use the pinned version's official [Constants](https://pedropathing.com/docs/pathing/constants)
and [Tuning](https://pedropathing.com/docs/pathing/tuning) pages. Do not combine
constants from another robot, Pedro version, dashboard, or localizer.

Record the source of every initial value:

| Category | Record |
|---|---|
| Drivetrain | motor names, directions, wheel dimensions, gearing |
| Localizer | device type, hardware name, encoder directions, offsets, units |
| Follower | initial values and the tuner that will determine each value |
| Constraints | conservative starting limits and completion conditions |

## Draw the coordinate contract

Create a team field diagram showing the origin, positive axes, zero heading,
positive rotation, and robot reference point. Use named measured poses rather than
copying coordinates from an example autonomous.

## Verify localization without following a path

Place the robot repeatably, then push it by hand through known translations and
rotations while viewing the reported pose:

| Motion | Expected change | Observed change | Pass? |
|---|---|---|---|
| Forward at zero heading | | | |
| Left strafe | | | |
| Counterclockwise turn | | | |
| Forward and return | | | |
| Rotate and return | | | |

Correct sign, unit, offset, or configuration errors before follower tuning. Change
one reviewed value at a time and preserve the evidence.

## Git checkpoint

Commit and push when the constants are traceable and the localization contract
passes. Include the diagram and measurement table in the Season Repository.

## Ask your AI tutor

> Analyze my constants and localization evidence without changing values. Separate
> sign, unit, geometry, scale, and repeatability risks, then recommend the single
> next measurement that best distinguishes them.

## Check your work

You can explain every constant's source and predict the sign of each pose change.
Continue to [4.3](../03-tuning-tests/README.md).

## Reflect

Which placement error could be mistaken for a localizer error?
