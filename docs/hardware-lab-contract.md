# Hardware Lab Contract

This page defines the shared boundary between the physical test bench, the Driver
Station configuration, and student Java code. The Level 2 lessons explain each
device and API when it is introduced.

## FTC SDK project boundary

Student code belongs in the `TeamCode` module under this package:

```java
package org.firstinspires.ftc.teamcode.level2;
```

Do not edit `FtcRobotController`, SDK samples, Gradle versions, signing settings,
or Android manifests for a lesson unless the curriculum explicitly says to do so.

## Configuration names

The Level 2 lessons use the following names:

| Test-bench device | FTC SDK type used by the lessons | Configuration name |
|---|---|---|
| DC motor with encoder | `DcMotor` | `bench_motor` |
| Positional servo | `Servo` | `position_servo` |
| Continuous-rotation servo | `CRServo` | `continuous_servo` |
| Color sensor | `ColorSensor` | `color_sensor` |
| Touch sensor | `DigitalChannel` | `touch_sensor` |
| Magnetic limit switch | `DigitalChannel` | `magnetic_limit` |
| Optional simple digital LED | `DigitalChannel` | `status_led` |

The string passed to `hardwareMap.get(...)` must match the active Driver Station
configuration exactly, including capitalization. For example:

```java
DcMotor benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
```

The Java variable name can be different; the quoted configuration name is the
shared contract. If the physical test bench cannot use one of these names, update
this page and the curriculum together before students begin.

## Branches

Each student creates a cumulative branch from `main`:

```text
student/<chosen-name>
```

Each lesson is completed in a feature branch created from that personal branch:

```text
feature/<chosen-name>/<lesson-name>
```

The pull request for a lesson targets the student's own `student/<chosen-name>`
branch. It does not target `main`, another student's branch, or the official FIRST
repository.

## Hardware test rules

Before running code that can move hardware:

1. Predict which device will move, in which direction, and when it will stop.
2. Inspect the active branch and the power, position, target, and timeout values.
3. Clear the test bench and keep the Driver Station Stop control available.
4. Begin with the smallest useful movement and conservative values.
5. Observe the hardware and telemetry; a successful build is not a behavior test.

Students may deploy and run their own code when these checks are complete. A mentor
or peer review is required before merging a lesson pull request, not before every
hardware run.
