# 4.3: Tune Pedro Pathing

Complete [4.2: Establish Constants and Trustworthy Localization](../02-constants-and-localization/README.md)
before starting this lesson. If the robot's reported position is wrong, fix
localization before tuning.

Keep the official [Pedro tuning guide](https://pedropathing.com/docs/pathing/tuning)
open. Follow Pedro's instructions and use the checks below to verify each section.

## Velocity tuners

Follow Pedro's [Velocity Tuners](https://pedropathing.com/docs/pathing/tuning/velocity).

- [ ] Complete the Forward Velocity Tuner.
- [ ] Save the measured X velocity in the drivetrain constants.
- [ ] Complete the Lateral Velocity Tuner.
- [ ] Save the measured Y velocity in the drivetrain constants.
- [ ] Rebuild and deploy.

## Heading

Follow Pedro's [Heading Tuning](https://pedropathing.com/docs/pathing/tuning/heading).

- [ ] The robot corrects toward its original heading.
- [ ] The correction is reasonably quick without continually oscillating.
- [ ] Copy the final Panels values into `Constants.java`.
- [ ] Rebuild and deploy.

## Predictive Braking

Follow Pedro's [Predictive Braking Configuration](https://pedropathing.com/docs/pathing/tuning/drive-algorithm/predictive/configuration).

Use Predictive Braking for your first robot because it is simpler to configure
and tune. You might revisit PIDF later if the robot needs finer control over
acceleration, braking, or its response to large and small errors.

- [ ] Run the automatic Predictive Braking tuner.
- [ ] Save `kLinear` and `kQuadratic` in the robot's constants.
- [ ] Run the Line Test and adjust `kP`.
- [ ] The robot stops accurately without jittering.
- [ ] Save all final values in code, then rebuild and deploy.

## Final tests

Follow Pedro's [Tests](https://pedropathing.com/docs/pathing/tuning/tests). For
this course, complete all three tests:

- [ ] Line Test
- [ ] Triangle Test
- [ ] Circle Test

Each test should repeat consistently without large position errors, excessive
oscillation, or unstable movement. These tests loop until you press Stop.

## Troubleshooting

| Symptom | First things to check |
|---|---|
| Robot moves in the wrong direction | Motor directions, encoder directions, and Pinpoint X/Y connections |
| Reported pose moves incorrectly | Return to Lesson 4.2; fix localization before tuning |
| Robot turns 180 degrees or corrects the wrong way | Heading sign, localizer orientation, and encoder directions |
| Robot corrects too slowly | Increase P gradually |
| Robot oscillates around the target | Reduce P, then check localization noise and mechanical play |
| Robot jitters while stopping | Reduce Predictive Braking `kP` to the last stable value |
| Velocity test never stops | Stop manually and verify localization direction, distance measurement, and encoder operation |
| Robot does not move | Check hardware names, motor power, drivetrain configuration, and selected tuner |
| Values work until restart | Copy the Panels values into `Constants.java`, rebuild, and deploy |
| Results vary between runs | Check battery condition, wheel slip, loose odometry pods, drivetrain binding, and starting pose |
| A final test works once but later fails | Keep troubleshooting; one successful run is not repeatable tuning |
| Test continues indefinitely | This is expected; the final tests loop until Stop is pressed |

## You are done with this section when

- [ ] Forward and lateral velocity values are saved in code.
- [ ] Heading correction is stable.
- [ ] Predictive Braking is configured and saved.
- [ ] Line, Triangle, and Circle Tests work consistently.
- [ ] The project has been rebuilt using the saved constants.
- [ ] Changes are committed and pushed.

Continue to [4.4: Build a Path by Hand](../04-hand-built-path/README.md).
