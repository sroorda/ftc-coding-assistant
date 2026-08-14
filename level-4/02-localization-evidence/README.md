# 4.2: Make Localization Trustworthy

You will configure the team's actual localizer using the matching current Pedro
tuning guide, then measure error instead of declaring that the pose “looks right.”

## Get ready

A mentor must pin and record the Pedro Pathing version, prepare the current
Quickstart or approved dependency integration, and identify the installed
localizer. Follow only the matching official guide under
[Pedro localization tuning](https://pedropathing.com/docs/pathing/tuning/localization).
Do not combine constants from another Pedro version or another robot.

Record hardware names, encoder directions, pod or sensor offsets, units, firmware
requirements, and the source of every initial value. Build before connecting.

## Test loop

For each trial, reset to the same measured pose, move the robot through a known
translation or rotation, return it to the reference, and record:

| Trial | Expected pose | Reported pose | X error | Y error | Heading error |
|---|---|---|---:|---:|---:|
| Forward and return | | | | | |
| Strafe and return | | | | | |
| Rotate and return | | | | | |
| Combined motion | | | | | |

Change only one reviewed constant between trials. A repeatable bias suggests a
different problem than random variation; preserve the raw evidence either way.

## Ask your AI tutor

> Analyze my localization table without changing constants. Separate sign or
> geometry mistakes from scale error and run-to-run variation, then recommend the
> single next measurement that would best distinguish them.

## Check your work

The PR records version, configuration, measurements, changes, and repeated results.
You are not finished merely because the field display moves. Continue to
[4.3](../03-first-pedro-path/README.md).

## Reflect

Did the evidence show bias, random variation, or both, and why does that matter?
