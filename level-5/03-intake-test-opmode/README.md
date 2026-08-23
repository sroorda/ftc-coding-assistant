# 5.3: Build a Standalone Intake Test OpMode

Create an OpMode that tests the intake by itself before combining it with driving.

## Requirements

The test OpMode:

- constructs the current `Robot` or intake through the approved architecture;
- maps the approved buttons to intake, reverse, and stop;
- applies the documented both-buttons rule;
- commands a safe stop when neither direction is requested;
- reports raw buttons, requested operation, subsystem state, and applied output;
- contains no inner loop, sleep, or busy wait; and
- stops the entire robot through the normal lifecycle.

## Predict before running

Complete the expected result before applying power:

| Intake button | Reverse button | Expected state | Expected output |
|---|---|---|---:|
| false | false | | |
| true | false | | |
| false | true | | |
| true | true | | |

## Hardware verification

Test at approved power with the drivetrain disabled or wheels safely supported.
Verify every row, button release, repeated presses, OpMode stop, and Driver Station
Stop. Record direction and output rather than saying only “it worked.”

Fix discrepancies at the owning layer: button interpretation in the OpMode,
hardware behavior and limits in the subsystem, and configuration names in the
Season Repository contract.

## Git checkpoint

Commit and push the standalone test OpMode and evidence after all rows pass.

## Ask your AI tutor

> Review my standalone intake test without editing. Enumerate all button
> combinations, compare them with the contract, trace Stop, and identify any test
> whose observation does not prove the requirement.

## Check your work

The intake works independently and the test evidence identifies the applied state
and output. Continue to [5.4](../04-drive-and-intake/README.md).

## Reflect

Why is an independent mechanism OpMode useful after integration also works?
