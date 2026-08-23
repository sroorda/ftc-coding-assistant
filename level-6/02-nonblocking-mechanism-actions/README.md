# 6.2: Make the Intake Action Nonblocking

Implement the approved action contract so one quick `update()` advances it during
each outer-loop pass.

Use explicit states such as `IDLE`, `RUNNING`, `SUCCEEDED`, `TIMED_OUT`, and
`CANCELLED`. A start operation records the target and resets the timer. `update()`
reads current evidence, commands the current state, and performs at most one small
step—no sleep, inner waiting loop, busy wait, worker thread, or future.

Every terminal state applies its documented safe output. Starting an action while
another is running follows an explicit rule: reject, replace safely, or queue. Do
not let accidental call order decide.

## Layered verification

1. Test state transitions with fake or separated decision inputs.
2. Run on hardware with the drive disabled.
3. Demonstrate normal completion.
4. Demonstrate delayed completion without blocking telemetry.
5. Demonstrate timeout and cancellation.
6. Press Driver Station Stop while the action is running.

Telemetry reports state, target, observed value, elapsed time, command, and terminal
reason.

## Ask your AI tutor

> Review my action implementation without editing. For every state, list output,
> transition conditions, timer behavior, repeated-update behavior, and cancellation
> result. Flag retained outputs and timer resets inside the loop.

## Check your work

Commit the transition tests and all six hardware results. Continue to
[6.3](../03-coordinate-with-states/README.md).

## Reflect

What must one `update()` call deliberately not wait for?
