# Lesson 9: Integrated Hardware Challenge

You will combine the motor, encoder, positional servo, continuous-rotation servo,
color sensor, touch sensor, and magnetic limit switch into one interruptible
automation. The optional LED can display the automation state.

This is a requirements challenge. You will design the state transitions and write
the implementation using the reusable hardware class from Lesson 8.

## Your mission

| | |
|---|---|
| **Time** | 120–180 minutes |
| **FTC focus** | state machine, coordination, timeouts, fault handling |
| **Git focus** | complete feature workflow with meaningful review evidence |
| **AI tutor** | review requirements, transitions, and failure paths |

## Your goal

By the end of this challenge, you can:

- coordinate several devices without blocking Stop handling;
- represent automation as explicit states and transitions;
- apply a timeout to every state that can wait on hardware;
- place all powered outputs into a safe state on completion or fault; and
- defend the design with transition and hardware test evidence.

## Get ready

Update your personal branch and create:

```text
feature/<your-name>/integrated-challenge
```

Create `IntegratedHardwareOpMode.java`. Begin with the tested
`TestBenchHardware` class; do not remap all devices directly in the new OpMode.

## Why use a state machine?

A blocking sequence finishes one long step before the OpMode can reconsider
anything else. That can delay telemetry, Stop handling, sensor checks, or a fault
response.

A state machine performs a small amount of work on each pass through one outer
`while (opModeIsActive())` loop:

```text
IDLE → HOMING → MOVING_TO_WORK → POSITIONING → FEEDING → COMPLETE
          ↘             ↘             ↘           ↘
                         FAULT
```

Use an enum so every state has a clear name:

```java
private enum State {
    IDLE,
    HOMING,
    MOVING_TO_WORK,
    POSITIONING,
    FEEDING,
    COMPLETE,
    FAULT
}
```

Reset a state timer only when entering a new state, not on every loop.

## Required behavior

Implement this sequence:

1. **IDLE** — all powered outputs are stopped. A deliberate gamepad button starts
   the automation.
2. **HOMING** — run the DC motor slowly toward `magnetic_limit`. Stop and zero the
   encoder when the limit activates. Fault if it does not activate before the
   timeout.
3. **MOVING_TO_WORK** — use the encoder to move to a small tested work position.
   Continue when the target is reached. Fault on timeout.
4. **POSITIONING** — command the positional servo to its tested active position.
   Use elapsed time to allow movement without calling a long `sleep()`.
5. **FEEDING** — run the CR servo at tested limited power until the desired color
   is classified. Fault on timeout or ambiguous sensor behavior that exceeds your
   defined limit.
6. **COMPLETE** — stop powered outputs, return the positional servo to its tested
   home position, and report success.
7. **FAULT** — stop powered outputs, report the fault reason, and wait safely for
   Stop or a deliberate reset action.

At any active state, an activated touch sensor acts as an interlock and sends the
automation to `FAULT`. Driver Station Stop must still end the outer loop
immediately.

If a simple digital LED is installed and configured as `status_led`, use it as an
optional extension. Define and document what off/on means; do not assume the
electrical polarity. Telemetry remains required even when the LED is present.

## Design before coding

Complete this transition table first:

| Current state | Output commands | Successful transition | Fault transition | Timeout |
|---|---|---|---|---:|
| IDLE | | | | |
| HOMING | | | | |
| MOVING_TO_WORK | | | | |
| POSITIONING | | | | |
| FEEDING | | | | |
| COMPLETE | | | | |
| FAULT | | | | |

Treat the completed table as your prediction of the automation. Revise it when a
hardware test provides evidence that the model is incomplete or incorrect.

For each transition, name the sensor reading, encoder condition, button edge, or
elapsed-time condition that causes it. Avoid transitions based on comments such as
“when ready” without a value the program can observe.

## Implementation constraints

- Use one outer `while (opModeIsActive())` loop.
- Do not put an unbounded `while`, long `sleep`, or busy wait inside a state.
- Apply outputs explicitly in every state; do not depend on forgotten commands
  from a previous state.
- Give every hardware-waiting state a timeout.
- Store the current fault reason and show it in telemetry.
- Report current state, state elapsed time, relevant sensor values, encoder target
  and position, and active output commands.
- Call `stopAll()` after the outer loop as a final safe action.

## Test in layers

Do not test the entire automation first.

1. Run with motor and servo powers forced to zero; verify button, sensor, state,
   and timeout transitions through telemetry.
2. Enable HOMING at low power and verify the magnetic limit and timeout separately.
3. Enable the small encoder movement and verify target and timeout.
4. Enable positional-servo movement using previously tested constants.
5. Enable CR-servo feeding and color completion.
6. Activate the touch interlock during each powered state.
7. Press Driver Station Stop during each powered state.
8. Run the complete success path at conservative values.

Record every test result. Correct one failed requirement at a time.

## Git checkpoint

Inspect the entire feature diff against your personal branch:

```text
git status
git diff student/<your-name>...HEAD
git log --oneline student/<your-name>..HEAD
```

Use meaningful commits—for example, state model, safe transitions, then hardware
integration—rather than one unexplained final checkpoint. In the pull request:

- include the completed transition table;
- list success, timeout, interlock, and Stop tests;
- identify reusable code and known limitations; and
- request review of both safety behavior and clarity.

Merge only after review feedback is resolved and the tests are repeated when a
change affects behavior.

## Ask your AI tutor

> Review my integrated state machine against the seven required states and the
> implementation constraints. Do not edit. For every state, list its outputs,
> success transition, timeout, interlock behavior, and Stop behavior. Identify any
> output inherited accidentally from a previous state and propose a test that
> exposes it.

## Check your work

You are finished when:

- the complete success sequence runs without blocking Stop;
- every hardware-waiting state has a demonstrated timeout;
- the touch interlock reaches `FAULT` from every powered state;
- `COMPLETE`, `FAULT`, and Driver Station Stop all stop powered outputs;
- telemetry explains state, evidence, outputs, and fault reason;
- the automation uses the reusable hardware class; and
- the reviewed pull request is merged into your personal branch.

## Reflect

Which parts of this solution should move into a future competition mechanism
class, and which parts should remain specific to this training test bench?

Return to the
[Level 2 readiness checkpoint](../../levels/02-hardware-lab.md#your-next-checkpoint).
