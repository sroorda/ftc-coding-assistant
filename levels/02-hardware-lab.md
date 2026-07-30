# Level 2 — Hardware Lab

> **Status: Planned.** This page defines the curriculum target. Student-ready
> lessons still need to be written and tested with the team's chosen hardware.

## Outcome

Students safely configure, observe, command, and stop one FTC device at a time.
They connect the Java ideas from Level 1 to the FTC SDK without yet managing a full
robot.

## Recommended lab

Use a benchtop rig when possible: Control Hub, approved battery and switch, one
motor secured against movement, one servo with a safe range, one simple sensor, and
a gamepad. A robot can substitute when mechanisms are made safe and drive wheels
are raised as appropriate.

An adult mentor must approve wiring, configuration, test area, power, and emergency
stop procedure before students run hardware code.

## Planned modules

1. FTC project tour, build, deploy, and OpMode lifecycle
2. Hardware configuration and `hardwareMap`
3. Telemetry and observable experiments
4. Safe DC motor power, direction, encoders, and stop behavior
5. Servo position, mechanical limits, and safe ranges
6. Reading a sensor and converting it into a decision
7. Mini-project: one sensor safely controls one output

After Level 1, students complete the [Team Workflow Bootcamp](../team-workflow.md)
before using the FTC project. Each hardware exercise then uses a small branch and
reviewed pull request.

## Architecture introduced here

Create only the first hardware boundary: one obvious place for configured device
names and initialization, plus small hardware-independent calculations where they
help. See [Robot Code Architecture](../docs/robot-code-architecture.md).

## Readiness for Level 3

Students can:

- explain `init`, start, repeated update, and stop behavior;
- find a device in the robot configuration and retrieve it by its exact name;
- command and stop a motor or servo within an adult-approved range;
- use telemetry to support a claim about program behavior;
- explain what physical movement will occur before pressing Run; and
- recover their own work through the team's Git workflow.

## Planning references

- [FIRST Tech Challenge: creating and running an Android Studio OpMode](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/creating_op_modes/Creating-and-Running-an-Op-Mode-%28Android-Studio%29.html)
- [FIRST Tech Challenge programming and control-system resources](https://ftc-docs.firstinspires.org/)
