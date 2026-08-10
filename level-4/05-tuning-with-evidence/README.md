# Lesson 5: Tune with Evidence

Tuning is a controlled experiment. Follow the current official
[Pedro tuning sequence](https://pedropathing.com/docs/pathing/tuning) for the
pinned version; do not paste constants from another robot.

## Experiment rule

For every change, record the test, constant, old value, new value, reason,
quantitative result, and whether the change was kept. Change one category at a
time. Preserve a known-good commit so recovery does not depend on memory.

Measure repeatability, not one impressive run:

| Run | X error | Y error | Heading error | Completion time | Oscillation/overshoot |
|---:|---:|---:|---:|---:|---|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |
| 4 | | | | | |
| 5 | | | | | |

Test at the approved training power and battery conditions. If results drift,
inspect mechanical looseness, wheel traction, start placement, and localization
before changing follower gains.

## Ask your AI tutor

> Analyze this tuning log without proposing several simultaneous changes. State
> what the data supports, what remains ambiguous, and one next experiment with a
> predicted result that would falsify the hypothesis.

## Check your work

Your PR contains a readable experiment history and the retained constants. Explain
why faster is not the same as more reliable. Continue to
[Lesson 6](../06-autonomous-motion-challenge/README.md).

## Reflect

Which tempting tuning change did the evidence not justify?
