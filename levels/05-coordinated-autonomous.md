# Level 5 Learning Path — Coordinated Autonomous Actions

> **WORK IN PROGRESS — DO NOT ATTEMPT THESE LESSONS YET.** These integrated
> procedures have not been validated on the team robot. Drivetrain paths and
> mechanism operations must also pass their independent tests first.

In Level 5, you will coordinate path following with mechanism work without
freezing localization, safety checks, telemetry, or Stop handling.

## What you will learn

1. [Define observable action contracts](../level-5/01-action-contracts/README.md).
2. [Implement one nonblocking mechanism action](../level-5/02-nonblocking-mechanism-actions/README.md).
3. [Coordinate paths and actions with explicit states](../level-5/03-coordinate-with-states/README.md).
4. [Request actions from path callbacks](../level-5/04-path-callbacks/README.md).
5. [Pause, recover, time out, and cancel safely](../level-5/05-recovery-and-cancellation/README.md).
6. [Complete the coordinated autonomous challenge](../level-5/06-final-autonomous-challenge/README.md).

## Ask these questions about every action

- When may it start?
- What does it command while running?
- What observable evidence means it completed?
- What stops or cancels it?
- What happens if it never completes?

## Your final checkpoint

You have completed the pathway when you can demonstrate normal, delayed, failed,
timed-out, and stopped behavior; show follower and mechanism updates occurring
together; trace decisions to hardware; and defend every timeout and safety-priority
choice with evidence.
