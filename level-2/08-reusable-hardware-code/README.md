# Lesson 8: Building Reusable Hardware Code

You have now repeated configuration names, hardware mapping, safe defaults, and
sensor interpretation across several OpModes. You will refactor that duplication
into a small hardware class without changing observed behavior.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | hardware abstraction, initialization, safe defaults |
| **Git focus** | separate structural and behavioral commits |
| **AI tutor** | detect hidden behavior changes and overgrown classes |

## Your goal

By the end of this lesson, you can:

- separate OpMode control flow from hardware access;
- centralize configuration names and device initialization;
- expose intention-revealing operations instead of public hardware fields; and
- prove that a refactor preserved behavior.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/reusable-hardware
```

Inspect the previous OpModes and list every repeated configuration string, mapping
statement, direction choice, safe default, sensor-polarity conversion, and stop
operation. Refactor because the duplication now exists—not because every robot
needs a large framework.

Before editing, predict which lines will disappear from the two OpModes you plan
to refactor and which behavior must remain visible in their hardware tests.

## Choose responsibilities

Create this package and class:

```text
org.firstinspires.ftc.teamcode.level2.hardware.TestBenchHardware
```

`TestBenchHardware` should:

- receive a `HardwareMap` during initialization;
- map the test-bench devices by one set of named constants;
- configure digital channels as inputs;
- apply documented motor direction and zero-power behavior;
- initialize motor and CR-servo power to zero;
- initialize the positional servo to a tested safe position;
- translate raw switch polarity behind named methods; and
- provide `stopAll()` for powered outputs.

It should not:

- extend `LinearOpMode`;
- read `gamepad1` or `gamepad2`;
- own the OpMode lifecycle;
- contain a long autonomous sequence;
- expose every hardware object as a public field; or
- invent a generic framework for hardware not on this bench.

## Start with a small class boundary

### 1. Centralize configuration names and SDK devices

Use this as structural guidance, not a completed solution:

```java
public final class TestBenchHardware {
    private static final String MOTOR_NAME = "bench_motor";
    private static final String POSITION_SERVO_NAME = "position_servo";
    private static final String CONTINUOUS_SERVO_NAME = "continuous_servo";
    private static final String TOUCH_SENSOR_NAME = "touch_sensor";
    private static final String MAGNETIC_LIMIT_NAME = "magnetic_limit";
    private static final String COLOR_SENSOR_NAME = "color_sensor";

    private DcMotor benchMotor;
    private Servo positionServo;
    private CRServo continuousServo;
    private DigitalChannel touchSensor;
    private DigitalChannel magneticLimit;
    private ColorSensor colorSensor;

    public void initialize(HardwareMap hardwareMap) {
        // Map devices, configure modes, and apply safe defaults.
    }

    public void setMotorPower(double requestedPower) {
        // Clip or otherwise enforce the documented limit.
    }

    public boolean isMagneticLimitReached() {
        // Return mechanism meaning, not raw electrical state.
    }

    public void stopAll() {
        // Stop the DC motor and CR servo.
    }
}
```

The constants are the Java side of the
[Hardware Lab Contract](../../docs/hardware-lab-contract.md). The private fields
prevent an OpMode from bypassing the operations this class will provide.

### 2. Move mapping and safe defaults into initialization

Start by moving tested code—not rewriting it from memory:

```java
public void initialize(HardwareMap hardwareMap) {
    benchMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
    positionServo = hardwareMap.get(Servo.class, POSITION_SERVO_NAME);
    continuousServo = hardwareMap.get(CRServo.class, CONTINUOUS_SERVO_NAME);
    touchSensor = hardwareMap.get(DigitalChannel.class, TOUCH_SENSOR_NAME);
    magneticLimit = hardwareMap.get(DigitalChannel.class, MAGNETIC_LIMIT_NAME);
    colorSensor = hardwareMap.get(ColorSensor.class, COLOR_SENSOR_NAME);

    touchSensor.setMode(DigitalChannel.Mode.INPUT);
    magneticLimit.setMode(DigitalChannel.Mode.INPUT);

    benchMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
    benchMotor.setPower(0.0);
    continuousServo.setPower(0.0);
    positionServo.setPosition(HOME_POSITION);
}
```

`HOME_POSITION` must be a named value proven safe in Lesson 3. Apply the tested
motor direction, run mode, and sensor polarity decisions from earlier lessons as
well. If a configured device is missing, initialization should fail visibly; do
not silently continue with a partly initialized required bench.

### 3. Expose operations that protect intent

For a powered output, keep the safety limit in one place:

```java
public void setMotorPower(double requestedPower) {
    double appliedPower = Range.clip(requestedPower, -0.25, 0.25);
    benchMotor.setPower(appliedPower);
}

public void setContinuousServoPower(double requestedPower) {
    double appliedPower = Range.clip(requestedPower, -0.50, 0.50);
    continuousServo.setPower(appliedPower);
}

public int getMotorPosition() {
    return benchMotor.getCurrentPosition();
}
```

Import `Range` from `com.qualcomm.robotcore.util.Range`. The caller requests an
operation; the hardware class enforces the bench's allowed range. If the motor
limit behavior from Lesson 5 is part of an OpMode you refactor, preserve that
behavior here or behind a more specific method such as
`setLimitProtectedMotorPower(...)`.

For sensors, return mechanism meaning:

```java
public boolean isTouchPressed() {
    return !touchSensor.getState(); // Use the polarity verified in Lesson 5.
}

public boolean isMagneticLimitReached() {
    return !magneticLimit.getState(); // Use the verified polarity.
}
```

The comments are reminders to use measured polarity, not permission to assume both
devices are active-low.

### 4. Give every powered output one shared stop

```java
public void stopAll() {
    benchMotor.setPower(0.0);
    continuousServo.setPower(0.0);
}
```

A positional servo holds its last commanded position, so it is not assigned a
made-up “zero.” A separate named operation can return it to a tested home position
when the mechanism requires that behavior.

### 5. Replace hardware details in an OpMode

An OpMode should now read like control flow:

```java
private final TestBenchHardware bench = new TestBenchHardware();

@Override
public void runOpMode() {
    bench.initialize(hardwareMap);
    waitForStart();

    while (opModeIsActive()) {
        double requestedPower = -gamepad1.left_stick_y * 0.25;
        bench.setMotorPower(requestedPower);
        telemetry.addData("Motor position", bench.getMotorPosition());
        telemetry.update();
    }

    bench.stopAll();
}
```

The OpMode still owns the gamepad, lifecycle, and telemetry. The hardware class
owns how the bench is mapped and commanded. `final` means the `bench` reference is
not replaced; the object is still initialized and used normally.

Prefer private device fields and small operations such as:

- `setMotorPower(...)`;
- `getMotorPosition()`;
- `movePositionServoHome()`;
- `setContinuousServoPower(...)`;
- `isTouchPressed()`;
- `isMagneticLimitReached()`; and
- `classifyColor()`.

Do not add a method merely to wrap every SDK getter. Expose operations or
information that makes the calling OpMode clearer.

## Student task

Complete the refactor in two stages.

### Stage 1 — Add the hardware class

1. Add configuration-name constants and private device fields.
2. Implement initialization and safe defaults.
3. Implement only the operations required by existing lessons.
4. Build the project before changing an OpMode.
5. Commit with a message such as `Add reusable test bench hardware`.

### Stage 2 — Refactor existing behavior

1. Choose at least two prior OpModes.
2. Replace direct `hardwareMap` calls and repeated setup with
   `TestBenchHardware`.
3. Keep gamepad decisions, telemetry, timers, and lifecycle in the OpModes.
4. Run the same hardware tests used before the refactor.
5. Compare observations and telemetry with the earlier results.
6. Commit with a separate message such as `Use hardware class in lab OpModes`.

If you discover a behavior change, do not call it “just refactoring.” Either
restore the original behavior or document and review the behavioral change in a
separate commit.

Use a small comparison table while testing:

| Behavior | Before refactor | After refactor | Preserved? |
|---|---|---|---|
| INIT output state | | | |
| Gamepad command | | | |
| Sensor interpretation | | | |
| Driver Station Stop | | | |

## Git checkpoint

Before pushing, run:

```text
git log --oneline -5
git diff student/<your-name>...HEAD
```

The pull request should show at least one structural commit and one consumer
refactor commit. Describe the before-and-after hardware tests that prove behavior
was preserved. Obtain review, merge, and update your personal branch.

## Ask your AI tutor

> Review my hardware-class refactor without editing it. Separate structural
> changes from behavioral changes, identify any public field that leaks an SDK
> device unnecessarily, and find lifecycle or gamepad logic that does not belong
> in the hardware class. Ask for before-and-after test evidence.

## Check your work

You are finished when:

- configuration names have one authoritative location;
- initialization applies safe defaults;
- raw digital polarity is hidden behind named meaning;
- `stopAll()` stops every powered output;
- at least two OpModes use the class with unchanged observed behavior;
- structural and behavioral changes are distinguishable in Git; and
- you can identify which code might be reusable in a competition repository.

## Reflect

What is one responsibility that would make `TestBenchHardware` too large if added
to it, and where should that responsibility live instead?

Continue to the
[Lesson 9 Integrated Hardware Challenge](../09-integrated-hardware-challenge/README.md).
