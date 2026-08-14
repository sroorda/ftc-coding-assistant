# 5.1: Define Actions Before Coordinating Them

An autonomous action needs more than a method that starts a motor. You must define
when it may start, what it commands, how completion is observed, how it times out,
and how it stops.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | action contract, completion, timeout, cancellation |
| **Git focus** | requirements before implementation |
| **AI tutor** | expose missing and unobservable conditions |

Choose one Level 3 subsystem operation. Complete this table:

| Action | May start when | Command while active | Success evidence | Timeout | Cancel/stop result |
|---|---|---|---|---:|---|
| | | | | | |

Distinguish a command from evidence. A servo's stored target is not proof that the
mechanism arrived. If there is no sensor, use a conservative, measured time
allowance and label that limitation honestly.

Create hardware-independent tests for action-state decisions where practical.
Cover not started, running, success, timeout, cancel, and repeated update after a
terminal result.

## Ask your AI tutor

> Review my action contract and tests without editing. Find commands mistaken for
> completion evidence, missing timeouts, ambiguous terminal states, and any cancel
> path that can leave a powered output active.

## Check your work

The PR contains the table and decision tests. Explain the difference between
starting, updating, completing, timing out, and cancelling. Continue to
[5.2](../02-nonblocking-mechanism-actions/README.md).

## Reflect

Which completion claim was hardest to make observable?
