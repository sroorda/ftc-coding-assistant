# Lesson 4: Build One Reusable Mechanism Subsystem

You will move one already-tested mechanism behind operations named in team
language so TeleOp and autonomous can use the same safe behavior.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | subsystem boundary, commands, state, safe output |
| **Git focus** | behavior-preserving refactor |
| **AI tutor** | compare behavior before and after the move |

Choose one intake, arm, lift, or servo mechanism that already works independently.
Write its contract before coding:

| Operation | Inputs | Output command | Completion evidence | Stop behavior |
|---|---|---|---|---|
| initialize | | | | |
| primary action | | | | |
| reverse/return | | | | |
| stop | | | | |
| update | | | | |

Create a subsystem only for behavior that exists now. Keep hardware fields private
and expose operations such as `intake()`, `eject()`, `moveTo(...)`, `stop()`, and
query methods needed for telemetry. The subsystem must not read gamepads, call
`waitForStart()`, or own Driver Station telemetry.

Refactor one operation at a time. After each move, rerun its Level 2 hardware test
and record whether behavior was preserved. If the mechanism needs ongoing work,
give it a quick `update()` method that is called once per outer loop.

## Ask your AI tutor

> Review this refactor without editing. Trace each old hardware call to the new
> subsystem operation, identify behavior changes, and flag lifecycle, gamepad, or
> telemetry responsibilities that crossed the boundary.

## Check your work

The PR shows a clear extraction commit followed by a consumer change and includes
before/after evidence. Explain one command from OpMode decision to final hardware
call. Continue to [Lesson 5](../05-mechanism-controls-and-limits/README.md).

## Reflect

Which boundary became clearer, and which further abstraction is still premature?
