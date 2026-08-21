# Level 6 Learning Path — Nonblocking Autonomous

> **WORK IN PROGRESS — NOT YET IN STUDENT NAVIGATION.** Mentors must validate the
> action interfaces, Pedro APIs, timing evidence, fault injection, and complete
> integrated behavior on the current robot before publishing these lessons.

In Level 6, you will coordinate the tuned drivetrain with the verified intake
without freezing localization, safety checks, telemetry, or Driver Station Stop.
Work in `feature/nonblocking-auto` in the Season Repository. The merged result
becomes the `v0.4` season-code milestone.

## Level 6 lessons

- [6.1: Define observable action contracts](../level-6/01-action-contracts/README.md).
- [6.2: Implement one nonblocking mechanism action](../level-6/02-nonblocking-mechanism-actions/README.md).
- [6.3: Coordinate Pedro paths and actions with explicit states](../level-6/03-coordinate-with-states/README.md).
- [6.4: Request actions from path callbacks](../level-6/04-path-callbacks/README.md).
- [6.5: Pause, recover, time out, and cancel safely](../level-6/05-recovery-and-cancellation/README.md).
- [6.6: Complete, review, and release a nonblocking autonomous](../level-6/06-nonblocking-auto-release/README.md).

## Ask these questions about every action

- When may it start?
- What does it command while running?
- What observable evidence means it completed?
- What stops or cancels it?
- What happens if it never completes?

## Your next checkpoint

You are ready for vision work when you can demonstrate normal, delayed, failed,
timed-out, cancelled, and stopped behavior; show follower and mechanism updates
occurring together; trace decisions to hardware; and defend every timeout and
safety-priority choice with evidence.
