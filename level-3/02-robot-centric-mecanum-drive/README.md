# 3.2: Robot-Centric Mecanum Drive

You will translate forward, strafe, and turn intent into four wheel commands,
normalize the result, and drive at reduced power.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | mecanum mixing, normalization, robot-centric control |
| **Git focus** | calculation and hardware integration as separate commits |
| **AI tutor** | test the math and signs, not write the complete OpMode |

## Predict the wheel commands

Use the team's verified wheel order. For the common convention below, first
calculate raw commands:

```java
double frontLeft = forward + strafe + turn;
double frontRight = forward - strafe - turn;
double backLeft = forward - strafe + turn;
double backRight = forward + strafe - turn;
```

Your motor direction contract may change the observed signs. Complete a table for
pure forward, pure strafe, pure turn, and a combined input before running code.

Normalize without changing the ratio between wheels:

```java
double denominator = Math.max(
        Math.abs(forward) + Math.abs(strafe) + Math.abs(turn), 1.0);
```

Divide each raw command by `denominator`, then apply one reviewed training scale.
Keep this calculation in a hardware-independent method so it can be checked with
ordinary Java tests.

## Build and test in layers

1. Add tests proving every output remains in `[-1.0, 1.0]` and pure inputs have
   the expected sign pattern.
2. Have the OpMode read sticks and call one drivetrain `drive(...)` operation.
3. Report forward, strafe, turn, scale, and all four applied powers.
4. Test wheels raised before placing the robot on the floor.

| Floor test | Verify |
|---|---|
| Forward only | Robot translates without a strong turn or strafe. |
| Strafe only | Robot moves sideways in the predicted direction. |
| Turn only | Robot rotates in place. |
| Combined input | No command exceeds the approved scale. |
| Stop | All four commands return to zero. |

Change one sign or direction at a time and repeat the pure-input tests after each
change.

## Ask your AI tutor

> Review my mecanum calculation and tests without editing. Check pure forward,
> strafe, turn, combined saturation, zero input, and preservation of wheel-power
> ratios during normalization.

## Check your work

Your PR includes the prediction table, automated test output, and five hardware
results. Explain why clipping each wheel independently is not equivalent to
normalization. Continue to [3.3](../03-driver-intent/README.md).

## Reflect

What would show correct mixing math but an incorrect motor direction?
