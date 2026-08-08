# Level 2 Learning Path — Hardware Lab

> **Draft for hardware validation:** The nine lessons are available for review,
> but their device types, configuration names, safe ranges, sensor polarity, and
> integrated sequence must be verified on the physical test bench before students
> use them independently.

In Level 2, your Java code will leave the laptop and control real FTC hardware for
the first time. You will work with one device at a time so you can clearly connect
each line of code to what you observe.

## What you will learn

1. [Write and run a hardware OpMode](../level-2/01-first-hardware-opmode/README.md)
   and understand its lifecycle.
2. [Use telemetry and logging](../level-2/02-telemetry-and-logging/README.md) to
   observe what the robot is doing.
3. [Convert encoder ticks into measured wheel movement](../level-2/03-motors-and-encoders/README.md)
   and command a calculated wheel-rim distance.
4. [Move a positional servo](../level-2/04-positional-servos/README.md) through
   named, mechanically safe positions.
5. [Control and reliably stop a continuous-rotation servo](../level-2/05-continuous-rotation-servos/README.md).
6. [Read touch and magnetic limit switches](../level-2/06-digital-sensors-and-limits/README.md)
   and use them to stop motion safely.
7. [Calibrate a color sensor](../level-2/07-color-sensing/README.md) and turn raw
   readings into a useful decision.
8. [Move repeated hardware setup into reusable code](../level-2/08-reusable-hardware-code/README.md).
9. [Coordinate several devices with a non-blocking state machine](../level-2/09-integrated-hardware-challenge/README.md).

Your first hardware environment will be a small benchtop rig. Before running code,
verify the wiring, test area, expected motion, power limits, and stop procedure.

## Start Level 2

Complete [Level 2 Setup](../docs/level-2-setup.md) before beginning Lesson 1. You
will prepare Android Studio, clone and build the hardware-lab project, and create
your personal branch. [Lesson 1](../level-2/01-first-hardware-opmode/README.md)
introduces feature branches and connects to the Control Hub after your first
OpMode builds successfully.

## Your next checkpoint

You will be ready for Level 3 when you can:

- explain initialization, start, repeated update, and stop behavior;
- retrieve a configured device by its exact name;
- command and stop a motor or servo within an approved range;
- use telemetry as evidence;
- organize repeated hardware setup behind clear reusable methods;
- coordinate multiple devices without blocking Stop handling;
- describe the expected physical movement before pressing Run; and
- recover your work through the team's Git workflow.

## Learn more

- [FIRST Tech Challenge: creating and running an Android Studio OpMode](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/creating_op_modes/Creating-and-Running-an-Op-Mode-%28Android-Studio%29.html)
- [FIRST Tech Challenge programming resources](https://ftc-docs.firstinspires.org/)
