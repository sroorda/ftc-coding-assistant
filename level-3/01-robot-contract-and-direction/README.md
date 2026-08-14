# 3.1: Map the Robot Before Moving It

You will turn the team's wiring and Driver Station configuration into a reviewed
software contract, then verify one drivetrain motor at a time at low power.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | configuration contract, motor identity, direction, safe stop |
| **Git focus** | one documentation commit and one verified code commit |
| **AI tutor** | find inconsistencies without inventing hardware facts |

## Your goal

You can identify every drive motor from robot corner to Java field, explain every
direction choice, and stop all four motors from one method.

## Get ready

Work in the team's robot repository from its reviewed integration branch. Create
`feature/<your-name>/drive-contract`. A mentor must approve the test area, wheel
support, maximum test power, configuration names, and emergency-stop procedure.

Create or update a robot hardware contract with one row per drive motor:

| Robot corner | Hub and port | Driver Station name | Java field | Direction | Verified? |
|---|---|---|---|---|---|
| Front left | | | | | |
| Front right | | | | | |
| Back left | | | | | |
| Back right | | | | | |

Do not copy names from this lesson. Read them from the active configuration and
trace the wires on the physical robot.

## Predict, build, verify

1. Draw the robot from above and mark its front.
2. Predict which wheel will turn and which way for a small positive command.
3. In the team's drivetrain hardware class, map the four names from the contract,
   set explicit zero-power behavior, and command zero during initialization.
4. Add `stop()` so every drive motor receives zero power.
5. Create a temporary test OpMode that can select only one motor at a time and
   limits power to the mentor-approved value.

Before every run, raise or otherwise secure the wheels, clear the robot, keep Stop
available, and announce the selected motor. Never correct an unexpected direction
by changing several motors at once.

| Test | Evidence |
|---|---|
| INIT | All four power commands are zero. |
| Select each corner | Only the named physical wheel moves. |
| Request positive power | Observed direction matches the drawing or the contract is corrected. |
| Driver Station Stop | Every wheel stops. |

## Ask your AI tutor

> Review my hardware contract and drivetrain initialization without editing.
> Cross-check each configuration name, field, direction, safe initial command,
> and stop command. Mark physical facts as needing human verification.

## Check your work

Commit the contract separately from code. Your pull request must include the
four one-motor results and the Stop result. You are finished when another person
can trace every row from wheel to code without guessing.

Continue to [3.2](../02-robot-centric-mecanum-drive/README.md).

## Reflect

Which observation distinguishes a wrong configuration name from a wrong direction?
