# Level 3 Learning Path — Robot Systems and TeleOp

> **WORK IN PROGRESS — DO NOT ATTEMPT THESE LESSONS YET.** The guided lessons are
> ready for curriculum review, but mentors must validate the robot configuration,
> mechanism meaning, safe training limits, test procedure, and integration branch
> on the team's current hardware before student use.

In Level 2, you initialized and tested individual devices. In Level 3, you will
combine those ideas into a responsive two-driver TeleOp while keeping a traceable
path from gamepad input to the final hardware command.

This level uses complete, guided examples. Most code is shown and explained in
small additions before the assembled version appears. The open-ended work is
limited to physical facts only the team can supply: configuration names, verified
directions, safe values, sensor meaning, and adaptation to one team mechanism.

## Before you begin

Show that you can complete the
[Level 2 readiness checkpoint](02-hardware-lab.md#your-next-checkpoint), then have
a mentor confirm:

- the team's current FTC SDK and Android Studio project build successfully;
- the robot has a reviewed front, wheel layout, wiring record, and active Driver
  Station configuration;
- each mechanism used in Level 3 has already passed an isolated Level 2-style
  hardware test;
- the team has approved drive and mechanism training limits;
- the drivetrain can be raised or the robot can be safely secured for first
  motion tests; and
- the integration and emergency-stop procedure is understood by both drivers.

Students continue in their cumulative `student/<name>` branch and create one
feature branch per lesson. Level 3 files use the
`org.firstinspires.ftc.teamcode.level3` package and its `hardware` and
`subsystems` child packages.

## What you will build

1. [Map the robot and verify one drive motor at a time](../level-3/01-robot-contract-and-direction/README.md).
   You will connect the physical corners, configured names, Java fields, and
   observed directions through a written hardware contract.
2. [Build reduced-power robot-centric mecanum drive](../level-3/02-robot-centric-mecanum-drive/README.md).
   You will calculate four wheel commands, preserve their ratios through
   normalization, and test pure motions before combining them.
3. [Turn raw gamepad values into documented driver intent](../level-3/03-driver-intent/README.md).
   You will measure stick drift, apply a precise deadband rule, and add a held
   precision mode without changing the drive mixer.
4. [Move one tested mechanism behind a reusable subsystem](../level-3/04-first-subsystem/README.md).
   You will preserve the Level 2 feeder behavior while replacing direct servo
   commands with `feed()`, `reverse()`, and `stop()` operations.
5. [Add operator priority and a physical limit](../level-3/05-mechanism-controls-and-limits/README.md).
   You will select one command per loop, make button conflicts explicit, and
   distinguish a requested action from an output blocked by the limit sensor.
6. [Integrate drive and mechanism in one TeleOp](../level-3/06-teleop-integration-challenge/README.md).
   You will assemble the tested pieces, verify them in layers, and demonstrate
   simultaneous two-driver operation and complete Stop behavior.

## SDK examples you will use

The installed FTC SDK contains working examples that provide API syntax and common
patterns. The lessons point to these files rather than treating the course code as
the only correct source:

| SDK example | Course connection |
|---|---|
| `BasicOmniOpMode_Linear` | four-motor mapping, direction diagnostic, robot-centric mecanum mix, normalization |
| `RobotHardware` and `ConceptExternalHardwareClass` | private hardware fields and reusable operations outside an OpMode |
| `ConceptGamepadEdgeDetection` | optional rising-edge behavior when a written control contract requires a toggle |

The SDK examples cannot know the team's wiring, configuration, safe power, sensor
meaning, or preferred controls. Students copy API patterns only after separating
those sample assumptions from robot-specific facts.

## The architecture you will grow

```text
IntegratedTeleOp
├── reads gamepad 1 and selects drive intent
├── calculates four wheel commands
├── calls DriveHardware
├── reads gamepad 2 and selects one feeder command
├── calls FeederSubsystem
└── reports both decisions and outputs
```

`DriveHardware` owns drive-device mapping and safe stopping. `FeederSubsystem`
owns its device, limit sensor, power rule, and named behavior. The OpMode owns the
FTC lifecycle, gamepad policy, coordination, and Driver Station telemetry.

This is one understandable milestone, not a final competition framework. Add
another abstraction only after repeated code or a real integration boundary makes
its value visible.

## How you will verify changes

Each lesson follows the Level 2 rhythm:

1. record the current working behavior or physical contract;
2. make a prediction;
3. add one small area of code;
4. build before connecting hardware;
5. test decisions with powered outputs disabled when practical;
6. test isolated hardware at conservative values;
7. record telemetry and physical observations; and
8. review and merge the feature branch into the student's cumulative branch.

A successful build proves only that the code is accepted by the compiler. It does
not prove motor identity, direction, physical safety, responsiveness, or combined
behavior.

Begin with robot-centric driving. Field-centric driving is a useful later
extension only after the team can verify heading and explain the drivetrain
behavior underneath it.

## Your next checkpoint

You are ready for Level 4 when you can:

- identify and safely stop every powered device used by TeleOp;
- calculate and explain the four wheel commands for pure and combined inputs;
- distinguish raw input, selected intent, safety evidence, and applied output;
- drive and operate a mechanism during the same interval;
- trace one drive command and one mechanism command from gamepad to hardware;
- explain why the outer loop contains no long sleep or inner waiting loop;
- integrate through a partner's public subsystem operations instead of private
  hardware fields; and
- reproduce the combined-operation, limit, conflict, release, and Stop evidence.

The next level will add localization and Pedro Pathing only after this TeleOp
foundation is repeatable and understandable.
