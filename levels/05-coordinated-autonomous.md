# Level 5 Preview — Coordinated Autonomous Actions

> **Coming later:** You will begin this level after paths and mechanisms work
> reliably on their own.

In Level 5, you will make the drivetrain and mechanisms work together. The robot
must continue updating its path, localization, mechanisms, safety conditions, and
telemetry instead of freezing inside a long sequence of waits.

## What you will learn

1. Explain why long sleeps break responsive robot control.
2. Define mechanism states, commands, completion conditions, and timeouts.
3. Update the follower and mechanisms in the same loop.
4. Use Pedro Pathing progress- and pose-based callbacks.
5. Pause and resume movement when an action requires it.
6. Handle conflicting actions, safety priority, and cancellation.
7. Report the current path, state, target, and failure reason through telemetry.
8. Build a final routine that drives, acquires or scores, recovers, and parks.

## Ask these questions about every action

- When may it start?
- What does it command while it runs?
- How do you know it completed?
- What stops or cancels it?
- What happens if it never completes?

You will use the same subsystem operations in TeleOp and autonomous. Autonomous
code should coordinate existing capabilities instead of bypassing them to command
devices directly.

## Your final checkpoint

You will demonstrate normal, delayed, failed, and stopped behavior; show that
localization and mechanisms keep updating together; and explain every timeout and
priority decision.

## Learn more

- [Pedro Pathing path callbacks](https://pedropathing.com/docs/pathing/reference/callbacks)
