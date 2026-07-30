# Level 5 — Coordinated Autonomous Actions

> **Status: Planned.** Implement this level only after the team's Level 4 paths and
> Level 3 subsystems are reliable independently.

## Outcome

Students coordinate mechanisms with Pedro Pathing without blocking the control
loop. They can reason about action readiness, precedence, completion, timeout, and
recovery.

## Planned modules

1. Why sequential sleeps break responsive robot control
2. Mechanism states, commands, completion conditions, and timeouts
3. Updating the follower and mechanisms in the same loop
4. Pedro Pathing parametric and pose-based callbacks
5. Pausing and resuming movement when an action requires it
6. Conflicting actions, safety precedence, and cancellation
7. Telemetry for current path, state, target, and failure reason
8. Final project: drive, acquire or score, recover, and park

Prefer progress- or pose-based triggers when they express the requirement. A
time-based trigger is appropriate only when elapsed time is genuinely the condition,
not as a substitute for observing mechanism or path progress.

## Architecture milestone

Use the same subsystem operations in TeleOp and autonomous. Autonomous code should
coordinate existing capabilities rather than reach around a subsystem to command
its devices directly.

Each action should make these questions answerable:

- When may it start?
- What is commanded while it runs?
- How do we know it completed?
- What stops or cancels it?
- What happens if it never completes?

## Completion evidence

Students can:

- trace an action from a path condition to a subsystem and hardware output;
- show that localization and mechanisms continue updating together;
- demonstrate normal, delayed, failed, and stopped behavior;
- explain every timeout and precedence decision;
- review an integration pull request with evidence from telemetry and tests; and
- run the complete routine repeatedly under adult supervision.

## Planning reference

- [Pedro Pathing path callbacks](https://pedropathing.com/docs/pathing/reference/callbacks)
