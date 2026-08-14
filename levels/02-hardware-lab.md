# Level 2 Learning Path — Hardware Lab

> **Draft for hardware validation:** The eight lessons are available for review,
> but their device types, configuration names, safe ranges, sensor polarity, and
> expected behavior must be verified on the physical test bench before students
> use them independently.

In Level 2, your Java code will leave the laptop and control real FTC hardware for
the first time. You will work with one device at a time so you can clearly connect
each line of code to what you observe.

## Level 2 Lessons

- [2.1: Write and run a hardware OpMode](../level-2/01-first-hardware-opmode/README.md)
   and understand its lifecycle.
- [2.2: Use telemetry and logging](../level-2/02-telemetry-and-logging/README.md) to
   observe what the robot is doing.
- [2.3: Move a positional servo](../level-2/03-positional-servos/README.md) through
   named, mechanically safe positions.
- [2.4: Control and reliably stop a continuous-rotation servo](../level-2/04-continuous-rotation-servos/README.md).
- [2.5: Read a touch sensor](../level-2/05-touch-sensor/README.md) and
   turn its Boolean value into readable telemetry.
- [2.6: Read a color sensor](../level-2/06-color-sensing/README.md) and turn RGB
   values into a simple color decision.
- [2.7: Convert encoder ticks into measured wheel movement](../level-2/07-motors-and-encoders/README.md)
   and command a calculated wheel-rim distance.
- [2.8: Control several devices, then move their repeated setup into reusable
  code](../level-2/08-reusable-hardware-code/README.md).

Your first hardware environment will be a small benchtop rig. Before running code,
verify the wiring, test area, expected motion, power limits, and stop procedure.

## Start Level 2

Complete [Level 2 Setup](../docs/level-2-setup.md) before beginning 2.1. You
will prepare Android Studio, clone and build the hardware-lab project, and create
your personal branch. [2.1](../level-2/01-first-hardware-opmode/README.md)
introduces feature branches and connects to the Control Hub after your first
OpMode builds successfully.

## Your next checkpoint

You will be ready for Level 3 when you can:

- explain initialization, start, repeated update, and stop behavior;
- retrieve a configured device by its exact name;
- command and stop a motor or servo within an approved range;
- use telemetry as evidence;
- organize repeated hardware setup behind clear reusable methods;
- control multiple devices in one active OpMode loop;
- describe the expected physical movement before pressing Run; and
- recover your work through the team's Git workflow.

## Learn more

- [FIRST Tech Challenge: creating and running an Android Studio OpMode](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/creating_op_modes/Creating-and-Running-an-Op-Mode-%28Android-Studio%29.html)
- [FIRST Tech Challenge programming resources](https://ftc-docs.firstinspires.org/)
