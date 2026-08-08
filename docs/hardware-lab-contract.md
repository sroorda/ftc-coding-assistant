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

The Level 2 hardware bench uses the following connections and names:

| Test-bench device | Control Hub port or channel | Driver Station configuration type | FTC SDK type used by the lessons | Configuration name |
|---|---|---|---|---|
| goBILDA Yellow Jacket motor | Motor 0 | `GoBILDA 5202/3/4 series` | `DcMotor` | `bench_motor` |
| Positional servo | Servo 1 | `Servo` | `Servo` | `position_servo` |
| Continuous-rotation servo | Servo 0 | `Continuous Rotation Servo` | `CRServo` | `continuous_servo` |
| REV Color Sensor V3 | I2C Bus 1 | `REV Color/Range Sensor` | `ColorSensor` | `color_sensor` |
| REV Touch Sensor | Digital channel 3 (connector 2–3) | `Digital Device` | `DigitalChannel` | `touch_sensor` |
| Magnetic limit switch | Digital channel TBD | `Digital Device` | `DigitalChannel` | `magnetic_limit` |
| Optional simple digital LED | Digital channel TBD | `Digital Device` | `DigitalChannel` | `status_led` |

The configured port or channel must match the device's physical Control Hub
connection. `TBD` means that device is not installed yet; update this contract
when its connection is chosen.

The touch sensor and magnetic limit switch are intentionally configured as
`Digital Device`. Lesson 6 uses `DigitalChannel` to inspect their raw electrical
states before translating those states into useful names.

The string passed to `hardwareMap.get(...)` must match the active Driver Station
configuration exactly, including capitalization. For example:

```java
DcMotor benchMotor = hardwareMap.get(DcMotor.class, "bench_motor");
```

The Java variable name can be different; the quoted configuration name is the
shared contract. If the physical test bench uses a different port, device type,
or name, update this page and the curriculum together before students begin.

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
