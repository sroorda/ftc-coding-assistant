# Level 3 Learning Path — Robot Systems and TeleOp

> **Published draft for robot validation:** Mentors must verify the team's current
> FTC SDK, robot configuration, Control Hub orientation, training-power limits,
> safety procedure, Season Repository access, and integration branch before
> students operate the robot independently.

In Level 3, you will combine the devices tested in Level 2 into a responsive
TeleOp robot. The first six lessons use short sections of a mecanum-drive video:
watch one idea, pause, enter and explain the code, and test it before continuing.
You will not watch the entire video and then try to recreate it from memory.

The last two lessons move the verified drivetrain into the team's Season Repository.
Students review the architecture, plan the smallest useful framework with a coach,
implement a drivetrain subsystem, and deliver it through a reviewed pull request.
The merged result becomes the `v0.1` season-code milestone.

## Video-guided learning rhythm

The drivetrain lessons use
[How To Program Drivetrains: Mecanum Drive](https://www.youtube.com/watch?v=sFCO4du5IZk&list=PLRHdgFNRLyaPiZ5rvINwMmGMHEIL9usla&index=18)
by Brogan Pratt:

| Video section | Student work before continuing |
|---|---|
| 0:00–5:10 | Compare robot-relative and field-relative coordinates and record the robot contract. |
| 5:10–10:45 | Build, configure, and direction-test a reusable four-motor class. |
| 10:45–13:03 | Initialize the IMU and verify heading without driving. |
| 13:03–19:31 | Add wheel mixing, pause for normalization, then test robot-relative drive. |
| 19:31–23:03 | Transform the driver's field request and reuse robot-relative drive. |
| 23:03–end | Build the thin driver-facing TeleOp and verify its controls. |

The Java follows FIRST's `RobotTeleopMecanumFieldRelativeDrive` SDK sample, then
separates hardware behavior into reusable classes so students can trace every
input through the system.

## Level 3 lessons

- [3.1: Compare robot-relative and field-relative driving](../level-3/01-robot-and-field-relative/README.md)
  and verify the robot contract before applying power.
- [3.2: Build a reusable mecanum-drive class](../level-3/02-reusable-mecanum-drive/README.md)
  and confirm all four wheel directions at reduced power.
- [3.3: Initialize and verify the IMU](../level-3/03-imu-orientation-and-heading/README.md)
  using the Control Hub's actual physical orientation.
- [3.4: Build robot-relative mecanum drive](../level-3/04-robot-relative-mecanum-drive/README.md)
  through wheel mixing, normalization, and staged hardware tests.
- [3.5: Add field-relative drive](../level-3/05-field-relative-mecanum-drive/README.md)
  as a coordinate transformation that reuses the tested drivetrain method.
- [3.6: Assemble driver controls and TeleOp](../level-3/06-driver-controls-and-teleop/README.md)
  with deadband, precision mode, yaw reset, and diagnostic mode.
- [3.7: Plan the architecture and enter the Season Repository](../level-3/07-architecture-and-season-repository/README.md)
  after verifying access, build, and the unchanged TeleOp baseline.
- [3.8: Deliver the drivetrain framework](../level-3/08-drive-subsystem-delivery/README.md)
  through a coach-reviewed pull request and the `v0.1` milestone.

## Source examples

- [FIRST FTC SDK: field-relative mecanum sample](https://github.com/FIRST-Tech-Challenge/FtcRobotController/blob/master/FtcRobotController/src/main/java/org/firstinspires/ftc/robotcontroller/external/samples/RobotTeleopMecanumFieldRelativeDrive.java)
- [FIRST documentation: Universal IMU interface](https://ftc-docs.firstinspires.org/en/latest/programming_resources/imu/imu.html)

## Your next checkpoint

You are ready for Level 4 when you can:

- explain robot-relative and field-relative commands;
- verify motor direction and IMU orientation independently;
- trace a drive request through coordinate transformation, wheel mixing,
  normalization, and motor output;
- explain why the outer OpMode loop must remain responsive;
- trace the thin TeleOp through public drivetrain operations rather than private
  hardware;
- use telemetry to isolate gamepad, drivetrain, and heading problems;
- pass the Season Repository's unchanged build and TeleOp baseline;
- explain the approved drivetrain architecture and its ownership boundaries;
- deliver reviewed changes through the team's feature-branch workflow; and
- stop every powered subsystem through the Driver Station and code lifecycle.
