# Lesson 6: TeleOp Integration Challenge

Build a TeleOp in which one driver can move while one operator uses the mechanism,
without either capability starving the control loop.

## Required loop

```text
read gamepads and sensors
→ choose drivetrain and mechanism intent
→ command subsystems
→ update every subsystem
→ report telemetry
→ repeat until Stop
```

## Requirements

- Robot-centric drive supports deadband and a reduced-speed mode.
- The mechanism follows the reviewed priority and limit rules.
- No long `sleep`, inner waiting loop, or busy wait appears in active control.
- Drive and mechanism can operate simultaneously.
- Every powered subsystem has an explicit Stop path.
- Telemetry distinguishes raw input, selected intent, subsystem state, command,
  sensor/limit evidence, and fault reason.

Pair with another programmer. Integrate through the public subsystem operations;
do not reach into a partner's private hardware fields. Before moving hardware,
walk through four scenarios: drive only, mechanism only, both together, and Stop
during both.

| Demonstration | Evidence |
|---|---|
| Drive while operating mechanism | Both respond during the same interval. |
| Hold mechanism at a limit while driving | Drive remains responsive; unsafe mechanism motion is blocked. |
| Create conflicting operator input | Documented priority wins. |
| Stop during combined operation | Every powered output stops. |
| Mentor-approved fault simulation | Telemetry explains the safe result. |

## Ask your AI tutor

> Review my TeleOp without editing. Trace one drive command and one mechanism
> command from input to hardware, find blocking work or competing output writes,
> and propose a combined-operation test that could fail even if separate tests pass.

## Finish Level 3

Your PR includes the interface agreement, partner review, scenario evidence, and
known limitations. Reflect: which facts belong to hardware, subsystem behavior,
and TeleOp policy? Return to the [Level 3 checkpoint](../../levels/03-robot-systems-and-teleop.md#your-next-checkpoint).

## Reflect

What problem was invisible while drive and mechanism were tested separately?
