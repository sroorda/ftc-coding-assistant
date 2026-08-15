# 3.8: Integrate and Test the Complete TeleOp

The drivetrain and arm now work independently. You will combine them without
adding a second loop, waiting for either subsystem, or reaching into private
hardware fields.

This is a guided integration, not a blank-page challenge. The small final
extension asks you to adapt one reviewed control choice after the complete system
works.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | simultaneous subsystem control, nonblocking loop, safe shutdown |
| **Git focus** | integrate two verified components and record regression evidence |
| **AI tutor** | trace both command paths and locate competing or blocking work |

## Your goal

By the end of this lesson, you can:

- initialize multiple subsystems from one OpMode;
- read driver and operator controls once per loop;
- command drive and mechanism during the same loop;
- distinguish intent, subsystem state, and applied output in telemetry;
- stop every powered subsystem explicitly; and
- demonstrate that integration preserved the separate behaviors.

## Get ready

Begin from the versions that passed 3.6 and 3.7. Do not refactor either
subsystem during integration. Confirm:

- the combined test area is clear for both drivetrain and mechanism motion;
- Driver 1 and Operator 2 can each describe their controls;
- the mechanism is supported or guarded as required by the team procedure;
- the Driver Station Stop operator is identified; and
- the integration branch contains the reviewed subsystem commits.

## The loop contract

Every `loop()` call follows the same order:

```text
read driver and operator inputs
→ choose drive and arm intent
→ command both subsystems
→ report heading, state, limits, and outputs
→ return to the FTC runtime
```

There is no inner `while` loop, `sleep()`, `isBusy()` wait, or mechanism method
that holds control until motion finishes.

## Create the integrated OpMode

Create `IntegratedTeleOp.java`:

```java
package org.firstinspires.ftc.teamcode.level3;

import com.qualcomm.robotcore.eventloop.opmode.OpMode;
import com.qualcomm.robotcore.eventloop.opmode.TeleOp;

import org.firstinspires.ftc.teamcode.level3.subsystems.ArmSubsystem;
import org.firstinspires.ftc.teamcode.level3.subsystems.MecanumDrive;

@TeleOp(name = "L3 Integrated TeleOp", group = "Level 3")
public final class IntegratedTeleOp extends OpMode {
    private static final double JOYSTICK_DEADBAND = 0.05;
    private static final double ARM_RAISE_POWER = 0.25;
    private static final double ARM_LOWER_POWER = -0.20;

    private final MecanumDrive drive = new MecanumDrive();
    private final ArmSubsystem arm = new ArmSubsystem();

    @Override
    public void init() {
        drive.initialize(hardwareMap);
        arm.initialize(hardwareMap);

        telemetry.addData("Status", "Initialized");
        telemetry.addData("Driver Cross (X)", "Reset field heading");
        telemetry.addData("Driver left bumper", "Robot-relative diagnostic");
        telemetry.addData("Driver right bumper", "Precision drive");
        telemetry.addData("Operator Triangle", "Raise arm");
        telemetry.addData("Operator Cross (X)", "Lower arm");
        telemetry.update();
    }

    @Override
    public void loop() {
        double rawForward = -gamepad1.left_stick_y;
        double rawRight = gamepad1.left_stick_x;
        double rawRotate = gamepad1.right_stick_x;

        double driveScale = gamepad1.right_bumper ? 0.50 : 1.0;
        double forward = applyDeadband(rawForward) * driveScale;
        double right = applyDeadband(rawRight) * driveScale;
        double rotate = applyDeadband(rawRotate) * driveScale;

        if (gamepad1.crossWasPressed()) {
            drive.resetHeading();
        }

        boolean robotRelative = gamepad1.left_bumper;
        if (robotRelative) {
            drive.driveRobotRelative(forward, right, rotate);
        } else {
            drive.driveFieldRelative(forward, right, rotate);
        }

        boolean raiseRequested = gamepad2.triangle;
        boolean lowerRequested = gamepad2.cross;
        double requestedArmPower = 0.0;
        String armIntent = "Stop";

        if (raiseRequested && !lowerRequested) {
            requestedArmPower = ARM_RAISE_POWER;
            armIntent = "Raise";
        } else if (lowerRequested && !raiseRequested) {
            requestedArmPower = ARM_LOWER_POWER;
            armIntent = "Lower";
        } else if (raiseRequested) {
            armIntent = "Conflict: stop";
        }

        arm.command(requestedArmPower);

        telemetry.addData("Drive mode",
                robotRelative ? "Robot relative" : "Field relative");
        telemetry.addData("Heading degrees", "%.1f", drive.getHeadingDegrees());
        telemetry.addData("Forward command", "%.2f", forward);
        telemetry.addData("Right command", "%.2f", right);
        telemetry.addData("Rotate command", "%.2f", rotate);
        telemetry.addData("Drive scale", "%.2f", driveScale);
        telemetry.addData("Arm intent", armIntent);
        telemetry.addData("Arm state", arm.getState());
        telemetry.addData("Lower limit", arm.isLowerLimitPressed());
        telemetry.addData("Arm requested", "%.2f", arm.getRequestedPower());
        telemetry.addData("Arm applied", "%.2f", arm.getAppliedPower());
        telemetry.update();
    }

    @Override
    public void stop() {
        drive.stop();
        arm.stop();
    }

    private double applyDeadband(double value) {
        return Math.abs(value) < JOYSTICK_DEADBAND ? 0.0 : value;
    }
}
```

Read the active loop as two independent command paths:

```text
gamepad1 → drive intent → coordinate frame → MecanumDrive → four motors
gamepad2 → arm intent → limit rule → ArmSubsystem → arm motor
```

Both paths complete once per runtime loop. Neither path waits for the other.

## Review responsibilities

| Responsibility | Owner |
|---|---|
| Read gamepads | `IntegratedTeleOp` |
| Select robot- or field-relative mode | `IntegratedTeleOp` |
| Choose raise, lower, stop, or conflict | `IntegratedTeleOp` |
| Map and configure drive hardware | `MecanumDrive` |
| Transform field coordinates and mix wheel powers | `MecanumDrive` |
| Map arm hardware and enforce lower limit | `ArmSubsystem` |
| Stop all outputs when OpMode stops | All three through explicit `stop()` calls |

If the OpMode accesses a motor or touch sensor directly, move that responsibility
back behind the appropriate subsystem interface.

## Test the integrated system

Repeat the separate drivetrain and arm tests first. Then perform:

| Scenario | Verify |
|---|---|
| Drive only | Field-relative drive matches 3.6 and arm remains stopped. |
| Arm only | Arm matches 3.7 and drivetrain remains stopped. |
| Drive while raising | Both respond during the same interval. |
| Drive while lowering | Both respond; field-relative heading still updates. |
| Hold lower command at the lower limit while driving | Drive remains responsive; arm reports `BLOCKED_AT_LOWER_LIMIT` with zero applied power. |
| Press both arm buttons while driving | Drive continues; arm reports conflict and stops. |
| Hold precision drive while operating arm | Drive commands scale down; arm behavior is unchanged. |
| Press Driver Station Stop during combined motion | Four drive motors and the arm motor stop. |

Record the Driver Station telemetry or mentor observation for every row.

## Minimal extension — Make one team choice

After every required test passes, choose only one reviewed change:

- change the precision-drive scale;
- move the heading-reset control;
- rename the example arm controls in team language; or
- add one telemetry value already exposed by a subsystem.

Write the requirement first, change the smallest amount of code, and repeat the
affected test row. Do not add an untested mechanism or autonomous behavior here.

## Git checkpoints

Commit the working integration:

```text
Integrate drivetrain and arm TeleOp
```

Commit the small team-specific extension separately:

```text
Apply reviewed Level 3 driver control
```

Open a pull request into the team's integration branch. Include:

- the robot-contract values used;
- raised-wheel, heading, drivetrain, mechanism, and combined-test evidence;
- the SDK version used for comparison;
- the approved training limits; and
- any known robot-specific adaptation still required.

## Ask your AI tutor

> Review this TeleOp without editing it. Trace one drive command and one arm
> command from gamepad input to final motor power. Find any blocking work,
> competing output writes, direct hardware access from the OpMode, or Stop path
> that fails to command zero.

## Finish Level 3

- [ ] Robot-relative drive passes independently.
- [ ] IMU heading and reset pass independently.
- [ ] Field-relative drive passes at several headings.
- [ ] The mechanism limit and conflict rules pass independently.
- [ ] Drive and mechanism operate simultaneously.
- [ ] Driver Station Stop stops every powered subsystem.
- [ ] Another programmer or mentor reviewed the public subsystem boundaries.

Return to the
[Level 3 checkpoint](../../levels/03-robot-systems-and-teleop.md#your-next-checkpoint).

## Reflect

Which integrated test exposed behavior that the separate subsystem tests could
not reveal?
