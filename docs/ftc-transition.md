# Transitioning to FTC Robot Code

These lessons simulate robot decisions but intentionally avoid the FTC SDK. This
keeps the first learning loop fast and makes logic testable on any development
computer.

## Concept mapping

| Training concept | Later FTC use |
|---|---|
| `System.out.println` | telemetry during an OpMode |
| `main` program | FTC-controlled OpMode lifecycle methods |
| joystick value | `gamepad` input |
| calculated motor power | command sent to a configured motor |
| virtual sensor boolean | value read from a hardware sensor |
| small controller class | subsystem or mechanism logic |
| scenario test | desktop test of decision logic |

## Important difference

An FTC OpMode is managed by the Robot Controller; students normally do not add a
`main` method to robot code. Long loops and blocking waits can prevent the control
loop from responding. Hardware names must match the Robot Controller configuration,
and actuator tests can move real mechanisms unexpectedly.

For that reason, migrate pure decision logic first. Keep hardware access at the
edge: read gamepad/sensor values, pass ordinary Java values to a small class, then
apply the returned output to hardware. This makes the important logic easier to
review and test away from the robot.

## Readiness gate

Before students enter the FTC SDK project, they should complete the
[Level 1 readiness check](../levels/01-java-foundations.md#readiness-check) and the
[Team Workflow Bootcamp](../team-workflow.md). The team should then teach its exact
SDK version, project structure, hardware configuration, deployment procedure, and
safety rules through supervised [Level 2 hardware labs](../levels/02-hardware-lab.md).

Do not move directly from desktop Java to unsupervised competition robot changes.
Students first need a controlled way to configure, command, observe, and stop one
physical device at a time.
