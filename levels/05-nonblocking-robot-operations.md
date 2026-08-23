# Level 5 Learning Path — Nonblocking Robot Operations

> **WORK IN PROGRESS — DO NOT ATTEMPT THESE LESSONS YET.** Mentors must validate
> the intake hardware, power and direction, gamepad contract, isolated test OpMode,
> combined TeleOp, and Stop behavior on the current robot.

In Level 5, you will add the intake as a subsystem, verify it independently, and
operate it while driving without freezing either behavior. Work happens in the
Season Repository on `feature/intake-subsystem`; the merged result becomes `v0.3`.

“Nonblocking” means each outer-loop pass performs a small amount of drivetrain and
intake work and returns promptly. It does not mean adding Java threads or futures.

## Level 5 lessons

- [5.1: Plan the intake contract](../level-5/01-intake-contract/README.md).
- [5.2: Implement the intake subsystem](../level-5/02-intake-subsystem/README.md).
- [5.3: Build a standalone intake test OpMode](../level-5/03-intake-test-opmode/README.md).
- [5.4: Drive and operate the intake together](../level-5/04-drive-and-intake/README.md).
- [5.5: Prove responsiveness and safe shutdown](../level-5/05-responsiveness-and-safety/README.md).
- [5.6: Review, merge, and mark the `v0.3` milestone](../level-5/06-review-and-release/README.md).

## Your next checkpoint

You are ready for Level 6 when you can run and diagnose the intake independently,
drive while starting, stopping, and reversing it, explain why the loop remains
responsive, trace both subsystems to their owned outputs, and stop the complete
robot safely from every tested combination.
