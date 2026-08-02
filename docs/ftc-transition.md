# Transitioning to FTC Robot Code

Your Level 1 lessons simulate robot decisions but intentionally avoid the FTC SDK.
That gives you a fast learning loop and lets you test logic on any development
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

An FTC OpMode is managed by the Robot Controller, so you normally do not add a
`main` method to robot code. Long loops and blocking waits can prevent the control
loop from responding. Hardware names must match the Robot Controller configuration,
and actuator tests can move real mechanisms unexpectedly.

For that reason, migrate pure decision logic first. Keep hardware access at the
edge: read gamepad/sensor values, pass ordinary Java values to a small class, then
apply the returned output to hardware. This makes the important logic easier to
review and test away from the robot.

## Your next step

Before you enter the FTC SDK project, complete the
[Level 1 readiness check](../levels/01-java-foundations.md#level-1-readiness-check),
then follow [Level 2 Setup](level-2-setup.md) for the team's SDK version, Android
Studio project, Git repository, and Control Hub connection.

Do not move directly from desktop Java to competition robot changes. First use the
[Level 2 hardware labs](../levels/02-hardware-lab.md) to configure, command,
observe, and stop one physical device at a time.
