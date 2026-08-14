# 2.9: Integrated Hardware Challenge

You will combine the motor, encoder, positional servo, continuous-rotation servo,
color sensor, and touch sensor into one interruptible automation. The optional
LED can display the automation state.

This is a requirements challenge. You will design the state transitions and write
the implementation using the reusable hardware class from 2.8.

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
IDLE → MOVING_TO_WORK → POSITIONING → FEEDING → COMPLETE
              ↘             ↘           ↘
                            FAULT
```

Use an enum so every state has a clear name:

```java
private enum State {
    IDLE,
    MOVING_TO_WORK,
    POSITIONING,
    FEEDING,
    COMPLETE,
    FAULT
}
```

Reset a state timer only when entering a new state, not on every loop.

## Build the state-machine frame first

The final challenge is not a blank page. Build and test the control structure
before enabling hardware motion.

### 1. Store the current state, timer, and fault evidence

```java
private State currentState = State.IDLE;
private final ElapsedTime stateTimer = new ElapsedTime();
private String faultReason = "None";
```

`currentState` tells the loop which small piece of behavior to run. `stateTimer`
measures only time spent in that state. `faultReason` preserves why the automation
stopped instead of showing only the generic word `FAULT`.

### 2. Change states through one method

```java
private void transitionTo(State nextState) {
    currentState = nextState;
    stateTimer.reset();
}

private void enterFault(String reason) {
    bench.stopAll();
    faultReason = reason;
    transitionTo(State.FAULT);
}
```

Calling one transition method prevents a forgotten timer reset. Do not call
`transitionTo(currentState)` on every loop; that would keep elapsed time near zero
and defeat every timeout. `enterFault(...)` stops powered outputs before recording
the reason and changing state.

### 3. Create one outer lifecycle loop

```java
bench.initialize(hardwareMap);
telemetry.addData("Status", "Initialized");
telemetry.update();

waitForStart();
transitionTo(State.IDLE);

while (opModeIsActive()) {
    // Check the interlock, run one state, and report telemetry.
}

bench.stopAll();
```

If STOP is pressed before Start, the loop is skipped and `stopAll()` still runs.
If STOP is pressed during any state, the loop condition becomes false without
waiting for the current automation sequence to finish.

### 4. Add the switch with outputs disabled

Start with a switch that changes states but requests zero powered output:

```java
switch (currentState) {
    case IDLE:
        bench.stopAll();
        // gamepad1.crossWasPressed() may transition to MOVING_TO_WORK.
        break;

    case MOVING_TO_WORK:
        bench.stopAll(); // Keep this disabled during the transition-only test.
        // Add the encoder target condition when motion is enabled.
        if (stateTimer.seconds() >= MOVE_TIMEOUT_SECONDS) {
            enterFault("Movement timeout");
        }
        break;

    // Add one explicit case for every remaining state.
}
```

There is no inner `while`. One case performs a small decision and returns control
to the outer loop, which keeps Stop, telemetry, and interlocks responsive.

### 5. Apply the interlock before powered-state logic

Define which states can command motion, then check the touch sensor before their
normal switch behavior:

```java
boolean poweredState = currentState == State.MOVING_TO_WORK
        || currentState == State.POSITIONING
        || currentState == State.FEEDING;

if (poweredState && bench.isTouchPressed()) {
    enterFault("Touch interlock");
} else {
    // Run the switch for the current state.
}
```

`enterFault(...)` stops outputs before changing state. The `FAULT` case must also
call `stopAll()` on every later loop rather than relying on the previous command.

### 6. Report the decision on every outer loop

```java
telemetry.addData("State", currentState);
telemetry.addData("State time", "%.1f s", stateTimer.seconds());
telemetry.addData("Fault", faultReason);
// Add the sensor values, targets, positions, and commands relevant to the state.
telemetry.update();
```

During the first test, state and timer telemetry should change even though all
outputs remain zero. Only then enable one hardware state at a time.

## Required behavior

Implement this sequence:

1. **IDLE** — all powered outputs are stopped. A press of the PlayStation Cross
   (✕) button starts the automation.
2. **MOVING_TO_WORK** — use the encoder to move from its initialized zero to a
   small tested work position.
   Continue when the target is reached. Fault on timeout.
3. **POSITIONING** — command the positional servo to its tested active position.
   Use elapsed time to allow movement without calling a long `sleep()`.
4. **FEEDING** — run the CR servo at tested limited power until the desired color
   is classified. Fault on timeout or ambiguous sensor behavior that exceeds your
   defined limit.
5. **COMPLETE** — stop powered outputs, return the positional servo to its tested
   home position, and report success.
6. **FAULT** — stop powered outputs, report the fault reason, and wait safely for
   Stop or a deliberate reset action.

At any active state, an activated touch sensor acts as an interlock and sends the
automation to `FAULT`. Driver Station Stop must still end the outer loop
immediately.

The positional servo does not report physical arrival. In `POSITIONING`, the
elapsed time is a documented allowance based on prior testing—not sensor proof
that the mechanism reached the commanded position.

If a simple digital LED is installed and configured as `status_led`, use it as an
optional extension. Define and document what off/on means; do not assume the
electrical polarity. Telemetry remains required even when the LED is present.

## Design before coding

Complete this transition table first:

| Current state | Output commands | Successful transition | Fault transition | Timeout |
|---|---|---|---|---:|
| IDLE | | | | |
| MOVING_TO_WORK | | | | |
| POSITIONING | | | | |
| FEEDING | | | | |
| COMPLETE | | | | |
| FAULT | | | | |

Treat the completed table as your prediction of the automation. Revise it when a
hardware test provides evidence that the model is incomplete or incorrect.

For each transition, name the sensor reading, encoder condition, Cross-button
edge, or elapsed-time condition that causes it. Avoid transitions based on
comments such as “when ready” without a value the program can observe.

Before writing a case, read one row aloud as:

> While in this state, command these outputs. If this observable success condition
> occurs, enter this next state. If this fault or timeout occurs, stop outputs and
> enter `FAULT`.

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

1. Run with motor and servo powers forced to zero; verify the Cross button,
   sensor, state, and timeout transitions through telemetry.
2. Enable the small encoder movement and verify target and timeout.
3. Enable positional-servo movement using previously tested constants.
4. Enable CR-servo feeding and color completion.
5. Activate the touch interlock during each powered state.
6. Press Driver Station Stop during each powered state.
7. Run the complete success path at conservative values.

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

> Review my integrated state machine against the six required states and the
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
