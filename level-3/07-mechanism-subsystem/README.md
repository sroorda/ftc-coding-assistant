# 3.7: Add a Safe Mechanism Subsystem

A match TeleOp controls more than the drivetrain. This lesson adds one complete
mechanism example without placing hardware details or safety rules in the main
OpMode.

The learning example is a motorized arm with a lower touch limit. It combines
the motor, touch-sensor, and reusable-hardware patterns from Level 2. Adapt its
names, directions, and limits only after the team has tested the real mechanism
independently.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | subsystem boundary, motor command, limit switch, explicit state |
| **Git focus** | add and verify the subsystem before changing the main TeleOp |
| **AI tutor** | trace safety decisions from request to hardware output |

## Your goal

By the end of this lesson, you can:

- define a small public interface for one mechanism;
- keep hardware fields and configuration names private;
- apply an approved power limit;
- prevent motion farther into an active limit switch;
- report requested and applied behavior separately; and
- stop the mechanism through one explicit operation.

## Get ready

Select one mentor-approved mechanism that has already passed its Level 2-style
device tests. The example assumes:

| Example name | Device |
|---|---|
| `arm_motor` | DC motor |
| `arm_lower_limit` | REV Touch Sensor or compatible `TouchSensor` |

If the robot uses different names, replace both strings. If its safe direction,
power, or limit behavior differs, record and test those facts before adapting
the example.

Disconnect the arm from load or support it according to the team's safety
procedure. Start with a maximum magnitude of 25% or a lower approved value.

## Write the mechanism contract

Complete the team-value column:

| Behavior | Learning example | Team value |
|---|---|---|
| Positive power | Raises arm | |
| Negative power | Lowers arm | |
| Lower limit pressed | Block negative power | |
| No operator request | Zero power | |
| Driver Station Stop | Zero power | |
| Maximum magnitude | 0.25 | |

The subsystem will enforce these hardware rules. The OpMode will decide which
button means raise or lower.

## Create the subsystem state

Create:

```text
org.firstinspires.ftc.teamcode.level3.subsystems.ArmSubsystem
```

Begin with an enum that describes what the subsystem actually did:

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.hardware.TouchSensor;
import com.qualcomm.robotcore.util.Range;

public final class ArmSubsystem {
    public enum State {
        STOPPED,
        RAISING,
        LOWERING,
        BLOCKED_AT_LOWER_LIMIT
    }

    private static final String MOTOR_NAME = "arm_motor";
    private static final String LOWER_LIMIT_NAME = "arm_lower_limit";
    private static final double MAX_POWER = 0.25;

    private DcMotor armMotor;
    private TouchSensor lowerLimit;
    private State state = State.STOPPED;
    private double requestedPower;
    private double appliedPower;
}
```

`requestedPower` records operator intent. `appliedPower` records the safe command
that reached the motor. They may differ when a limit blocks motion.

## Initialize to a safe state

Add:

```java
public void initialize(HardwareMap hardwareMap) {
    armMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
    lowerLimit = hardwareMap.get(TouchSensor.class, LOWER_LIMIT_NAME);

    armMotor.setDirection(DcMotor.Direction.FORWARD);
    armMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
    armMotor.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
    stop();
}
```

The example uses `RUN_WITHOUT_ENCODER` because the touch switch, not a target
encoder position, stops downward manual motion. If the team's mechanism uses
encoder position control, teach and test that contract instead of changing modes
casually.

Confirm the direction value at low power with the mechanism supported.

## Convert a request into safe output

Add:

```java
public void command(double newRequestedPower) {
    requestedPower = Range.clip(newRequestedPower, -MAX_POWER, MAX_POWER);

    if (requestedPower < 0.0 && lowerLimit.isPressed()) {
        appliedPower = 0.0;
        state = State.BLOCKED_AT_LOWER_LIMIT;
    } else if (requestedPower > 0.0) {
        appliedPower = requestedPower;
        state = State.RAISING;
    } else if (requestedPower < 0.0) {
        appliedPower = requestedPower;
        state = State.LOWERING;
    } else {
        appliedPower = 0.0;
        state = State.STOPPED;
    }

    armMotor.setPower(appliedPower);
}
```

The highest-priority rule appears first: an active lower limit blocks additional
downward power. Raising remains allowed so the operator can move away from the
switch.

The method writes motor power exactly once. That makes it impossible for a later
independent `if` statement to undo the limit decision during the same call.

## Add stop and telemetry getters

```java
public void stop() {
    requestedPower = 0.0;
    appliedPower = 0.0;
    state = State.STOPPED;

    if (armMotor != null) {
        armMotor.setPower(0.0);
    }
}

public boolean isLowerLimitPressed() {
    return lowerLimit.isPressed();
}

public double getRequestedPower() {
    return requestedPower;
}

public double getAppliedPower() {
    return appliedPower;
}

public State getState() {
    return state;
}
```

The OpMode can now report evidence without reaching into private hardware fields.

## Check the complete subsystem

```java
package org.firstinspires.ftc.teamcode.level3.subsystems;

import com.qualcomm.robotcore.hardware.DcMotor;
import com.qualcomm.robotcore.hardware.HardwareMap;
import com.qualcomm.robotcore.hardware.TouchSensor;
import com.qualcomm.robotcore.util.Range;

public final class ArmSubsystem {
    public enum State {
        STOPPED,
        RAISING,
        LOWERING,
        BLOCKED_AT_LOWER_LIMIT
    }

    private static final String MOTOR_NAME = "arm_motor";
    private static final String LOWER_LIMIT_NAME = "arm_lower_limit";
    private static final double MAX_POWER = 0.25;

    private DcMotor armMotor;
    private TouchSensor lowerLimit;
    private State state = State.STOPPED;
    private double requestedPower;
    private double appliedPower;

    public void initialize(HardwareMap hardwareMap) {
        armMotor = hardwareMap.get(DcMotor.class, MOTOR_NAME);
        lowerLimit = hardwareMap.get(TouchSensor.class, LOWER_LIMIT_NAME);

        armMotor.setDirection(DcMotor.Direction.FORWARD);
        armMotor.setZeroPowerBehavior(DcMotor.ZeroPowerBehavior.BRAKE);
        armMotor.setMode(DcMotor.RunMode.RUN_WITHOUT_ENCODER);
        stop();
    }

    public void command(double newRequestedPower) {
        requestedPower = Range.clip(newRequestedPower, -MAX_POWER, MAX_POWER);

        if (requestedPower < 0.0 && lowerLimit.isPressed()) {
            appliedPower = 0.0;
            state = State.BLOCKED_AT_LOWER_LIMIT;
        } else if (requestedPower > 0.0) {
            appliedPower = requestedPower;
            state = State.RAISING;
        } else if (requestedPower < 0.0) {
            appliedPower = requestedPower;
            state = State.LOWERING;
        } else {
            appliedPower = 0.0;
            state = State.STOPPED;
        }

        armMotor.setPower(appliedPower);
    }

    public void stop() {
        requestedPower = 0.0;
        appliedPower = 0.0;
        state = State.STOPPED;

        if (armMotor != null) {
            armMotor.setPower(0.0);
        }
    }

    public boolean isLowerLimitPressed() {
        return lowerLimit.isPressed();
    }

    public double getRequestedPower() {
        return requestedPower;
    }

    public double getAppliedPower() {
        return appliedPower;
    }

    public State getState() {
        return state;
    }
}
```

## Create the subsystem-test OpMode

Create `ArmSubsystemTestOpMode.java`:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.OpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.ArmSubsystem;

@TeleOp(name = "L3 Arm Subsystem Test", group = "Level 3")
public final class ArmSubsystemTestOpMode extends OpMode {
    private static final double RAISE_POWER = 0.25;
    private static final double LOWER_POWER = -0.20;

    private final ArmSubsystem arm = new ArmSubsystem();

    @Override
    public void init() {
        arm.initialize(hardwareMap);
        telemetry.addData("Triangle", "Raise");
        telemetry.addData("Cross (X)", "Lower");
        telemetry.update();
    }

    @Override
    public void loop() {
        boolean raiseRequested = gamepad1.triangle;
        boolean lowerRequested = gamepad1.cross;

        double requestedPower = 0.0;
        String intent = "Stop";

        if (raiseRequested && !lowerRequested) {
            requestedPower = RAISE_POWER;
            intent = "Raise";
        } else if (lowerRequested && !raiseRequested) {
            requestedPower = LOWER_POWER;
            intent = "Lower";
        } else if (raiseRequested) {
            intent = "Conflict: stop";
        }

        arm.command(requestedPower);

        telemetry.addData("Operator intent", intent);
        telemetry.addData("Subsystem state", arm.getState());
        telemetry.addData("Lower limit", arm.isLowerLimitPressed());
        telemetry.addData("Requested power", "%.2f", arm.getRequestedPower());
        telemetry.addData("Applied power", "%.2f", arm.getAppliedPower());
        telemetry.update();
    }

    @Override
    public void stop() {
        arm.stop();
    }
}
```

Both buttons together produce a stopped conflict state. A single call to
`arm.command(...)` then applies the mechanism's limit rule.

## Test in layers

First test input and telemetry with powered motion disabled according to the
team procedure. Then enable the approved low-power physical test:

| Scenario | Verify |
|---|---|
| No buttons | State is `STOPPED` and applied power is zero. |
| Triangle only | State is `RAISING` and power is positive. |
| Cross only, limit clear | State is `LOWERING` and power is negative. |
| Both buttons | Intent reports conflict and applied power is zero. |
| Cross while lower limit is pressed | Requested power is negative, applied power is zero, and state is `BLOCKED_AT_LOWER_LIMIT`. |
| Triangle while lower limit is pressed | Raising is allowed so the mechanism can leave the switch. |
| Driver Station Stop | Motor power becomes zero. |

Never test a limit by intentionally jamming or crashing a mechanism.

## Git checkpoint — Verified mechanism

```text
Add safe arm subsystem example
```

## Ask your AI tutor

> Trace every input combination in my arm test OpMode through operator intent,
> requested power, limit evaluation, subsystem state, and applied power. Identify
> any path that can command downward motion while the lower limit is pressed.

## Check your work

- [ ] The subsystem owns hardware names, limits, state, and final output.
- [ ] The OpMode owns gamepad choices and telemetry.
- [ ] Conflicting controls stop the mechanism.
- [ ] The lower limit blocks only unsafe motion farther into the limit.
- [ ] Stop commands zero power.

Continue to [3.8](../08-integrated-teleop/README.md) to run drive and mechanism
control during the same nonblocking loop.

## Reflect

Why should the lower-limit rule remain in the subsystem even if the TeleOp also
avoids requesting unsafe motion?
