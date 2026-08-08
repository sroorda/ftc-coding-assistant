# Lesson 5: Continuous-Rotation Servos

A continuous-rotation servo uses a servo port and looks like a positional servo,
but its command represents direction and speed rather than position. You will make
that difference visible and establish a reliable software stop.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **FTC focus** | `CRServo`, power, direction, neutral behavior |
| **Git focus** | update from the personal branch before starting work |
| **AI tutor** | catch positional-servo assumptions applied to a CR servo |

## Your goal

By the end of this lesson, you can:

- explain why `CRServo` uses power instead of position;
- command both directions at a conservative speed;
- stop the device during initialization, neutral input, and OpMode Stop; and
- identify mechanical neutral calibration separately from Java logic.

## Get ready

Switch to `student/<your-name>`, pull the latest merge, and confirm the working
tree is clean before creating:

```text
feature/<your-name>/continuous-servo
```

Create `ContinuousServoOpMode.java`. Confirm the device is configured as
`continuous_servo` and has room to rotate without winding a cable or striking the
bench.

## Position versus power

Compare the two interfaces:

| Device | Java type | Command | Meaning |
|---|---|---|---|
| Positional servo | `Servo` | `setPosition(0.0–1.0)` | move toward a logical position |
| Continuous servo | `CRServo` | `setPower(-1.0–1.0)` | rotate with direction and speed |

A CR servo normally has no position feedback through this interface. Time and
power do not create a reliable position because load, voltage, friction, and
neutral calibration affect motion.

## Complete one area at a time

### 1. Map the correct device type and start at zero

Map the device with:

```java
CRServo continuousServo =
        hardwareMap.get(CRServo.class, "continuous_servo");
continuousServo.setPower(0.0);
```

`CRServo.class` must agree with the Driver Station configuration type. Mapping the
same port as a positional `Servo` would give the code the wrong command model.
The zero-power command makes INIT request no rotation.

### 2. Name the input limits

```java
private static final double MAX_TEST_POWER = 0.50;
private static final double STICK_DEADBAND = 0.05;
```

The maximum limits the first test speed. The deadband defines a small region near
the stick center that the program deliberately treats as zero.

### 3. Convert stick input into applied power

Inside the active loop:

```java
double rawStickY = -gamepad1.right_stick_y;
double requestedPower = Math.abs(rawStickY) < STICK_DEADBAND
        ? 0.0
        : rawStickY;
double appliedPower = requestedPower * MAX_TEST_POWER;

continuousServo.setPower(appliedPower);
```

The leading minus makes pushing the stick forward produce a positive request.
The conditional operator chooses zero inside the deadband. Multiplying by `0.50`
keeps full stick travel at half power. The expected results are:

| Stick condition | Requested result |
|---|---|
| Centered or slight noise | `0.0` power; servo stopped |
| Forward | Positive power, no greater than `0.50` |
| Backward | Negative power, no less than `-0.50` |

### 4. Display what was requested and applied

```java
telemetry.addData("Raw stick Y", "%.2f", rawStickY);
telemetry.addData("Requested power", "%.2f", requestedPower);
telemetry.addData("Applied power", "%.2f", continuousServo.getPower());
telemetry.update();
```

`getPower()` reports the logical command, not measured rotation speed. A servo
that physically creeps while this value is zero needs neutral calibration, not a
telemetry-label change.

### 5. Stop after the active loop

```java
continuousServo.setPower(0.0);
```

No separate early-Stop check is needed here. If STOP is pressed while waiting,
the active loop is skipped and this zero-power cleanup still runs.

## Student task

Implement an OpMode that:

1. Sets power to `0.0` during initialization.
2. Waits for Start and loops only while `opModeIsActive()`.
3. Uses `-gamepad1.right_stick_y` as requested power.
4. Applies a maximum magnitude of `0.50` for testing.
5. Uses a small deadband so stick noise commands zero power.
6. Reports raw input, requested power, and applied power.
7. Sets power to `0.0` after the active loop.

Predict direction before running. Test zero, slow positive, zero again, and slow
negative. Do not begin at full power.

If a `0.0` command still produces motion, stop the OpMode and use the servo's
supported mechanical or programmer-based neutral calibration procedure. Do not
hide a badly calibrated neutral by scattering a mystery software offset through
lesson code.

As an extension, choose two buttons for fixed, named actions such as
`INTAKE_POWER` and `EJECT_POWER`, with neutral as the default when neither is
pressed. Define what happens if both buttons are pressed.

## Git checkpoint

Run `git status` and `git diff`. The diff should contain only the new CR-servo
exercise and intentional supporting changes. Commit, push, obtain review through a
pull request into `student/<your-name>`, merge, and update the personal branch.

## Ask your AI tutor

> Review my CR-servo OpMode without editing it. Find any place where I treat power
> as position, any input combination without a defined result, and any exit path
> that can leave nonzero power. Ask me what I observed at a zero command.

## Check your work

You are finished when:

- initialization commands zero power;
- both directions work at limited speed;
- neutral input reliably stops rotation;
- Stop results in zero commanded power;
- telemetry distinguishes input from applied power; and
- you can explain why timing a CR servo is not position control.

## Reflect

What additional sensor would be needed if a mechanism driven by a CR servo had to
reach and hold a repeatable physical position?

Continue to
[Lesson 6: Digital Sensors and Limits](../06-digital-sensors-and-limits/README.md).
