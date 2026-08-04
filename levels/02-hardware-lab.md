# Level 2 Learning Path — Hardware Lab

> **Coming later:** These are the skills you will learn after Level 1. The student
> lessons are still being built and tested.

In Level 2, your Java code will leave the laptop and control real FTC hardware for
the first time. You will work with one device at a time so you can clearly connect
each line of code to what you observe.

## What you will learn

1. Write and run a hardware OpMode and understand its lifecycle.
2. Use telemetry and logging to observe what the robot is doing.
3. Control a DC motor with encoders, stop checks, and timeouts.
4. Move a positional servo through named, mechanically safe positions.
5. Control and reliably stop a continuous-rotation servo.
6. Read touch and magnetic limit switches and use them to stop motion safely.
7. Calibrate a color sensor and turn raw readings into a useful decision.
8. Move repeated hardware setup into reusable robot code.
9. Coordinate several devices with a non-blocking state machine.

Your first hardware environment will be a small benchtop rig. Before running code,
verify the wiring, test area, expected motion, power limits, and stop procedure.

## Start Level 2

Complete [Level 2 Setup](../docs/level-2-setup.md) before beginning Lesson 1. You
will prepare Android Studio, clone and build the hardware-lab project, and create
your personal branch. Lesson 1 introduces feature branches and connects to the
Control Hub after your first OpMode builds successfully.

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
