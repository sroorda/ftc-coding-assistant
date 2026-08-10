# Lesson 5: Mechanism Controls, Limits, and Priority

You will connect the second gamepad to the subsystem while making conflicts and
safety limits explicit.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | operator intent, edge detection, limits, precedence |
| **Git focus** | requirement table as review evidence |
| **AI tutor** | search for conflicting commands and unsafe retained output |

Define each control in a table before code. Include normal action, reverse/manual
override if approved, limit-sensor behavior, release behavior, and Driver Station
Stop. Order the rules from highest to lowest priority.

Inside one loop, read inputs and sensors once, select one intent, call one
subsystem command, call `update()`, and report the decision. Do not let separate
`if` statements issue contradictory commands later in the same loop.

Test with powered outputs disabled first, then with conservative values:

| Scenario | Verify |
|---|---|
| No buttons | Mechanism is stopped or holding its documented safe state. |
| Primary action | Expected command begins and remains responsive. |
| Conflicting buttons | The documented priority wins. |
| Active limit | Motion farther into the limit is prevented. |
| Move away from limit | Only the approved recovery direction is allowed. |
| Stop | Powered outputs stop immediately. |

## Ask your AI tutor

> Review my decision table and TeleOp control block without editing. For each
> input combination, name the winning rule, resulting subsystem call, limit
> behavior, and test that proves it.

## Check your work

The PR includes normal, conflict, limit, recovery, and Stop evidence. Explain why
the safety rule is visible in both code order and tests. Continue to
[Lesson 6](../06-teleop-integration-challenge/README.md).

## Reflect

Which conflict test gives the strongest evidence that safety priority works?
