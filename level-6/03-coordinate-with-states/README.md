# 6.3: Coordinate Paths and Actions with States

Run Pedro Pathing and the intake action from the same outer loop.

## Required loop shape

```java
while (opModeIsActive()) {
    follower.update();
    intakeAction.update();
    updateRoutineState();
    updateTelemetry();
}
```

Create a small routine with explicit states such as `START_PATH`, `WAIT_FOR_PATH`,
`START_ACTION`, `WAIT_FOR_ACTION`, `PARK`, `COMPLETE`, and `FAULT`. A start state
issues a command once and immediately advances. A wait state observes completion;
it does not call the start operation again.

Document each state:

| State | Path command | Action command | Success transition | Fault/timeout |
|---|---|---|---|---|
| | | | | |

If either component fails, record the specific reason, cancel both safely, and
enter `FAULT`. `COMPLETE` and `FAULT` remain safe on every later loop.

## Ask your AI tutor

> Review my coordinator without editing. Find repeated start calls, states without
> exits, transitions based only on time when sensor evidence exists, and failure
> paths that stop one component but not the other.

## Check your work

Demonstrate success, intake timeout, routine timeout, and Stop. Telemetry must
continue changing while either component runs. Commit the evidence and continue to
[6.4](../04-path-callbacks/README.md).

## Reflect

What bug appears when a start state is also used as its waiting state?
