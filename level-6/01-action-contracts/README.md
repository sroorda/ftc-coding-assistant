# 6.1: Define Actions Before Coordinating Them

An autonomous action needs more than a method that starts a motor. Define when it
may start, what it commands, how completion is observed, how it times out, and how
it stops before integrating it with a path.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | action contract, completion, timeout, cancellation |
| **Git focus** | `feature/nonblocking-auto`, requirements before code |
| **AI tutor** | expose missing and unobservable conditions |

Start from the latest Season Repository integration branch and create:

```text
feature/nonblocking-auto
```

Choose one verified Level 5 intake operation and complete:

| Action | May start when | Command while active | Success evidence | Timeout | Cancel/stop result |
|---|---|---|---|---:|---|
| | | | | | |

Distinguish a command from evidence. A stored target is not proof that a mechanism
arrived. If there is no sensor, use a conservative measured time allowance and
label that limitation honestly.

Create hardware-independent tests for action-state decisions where practical.
Cover not started, running, success, timeout, cancel, and repeated update after a
terminal result.

## Ask your AI tutor

> Review my action contract and tests without editing. Find commands mistaken for
> completion evidence, missing timeouts, ambiguous terminal states, and any cancel
> path that can leave a powered output active.

## Check your work

The feature branch contains the approved table and decision tests. Explain the
difference between starting, updating, completing, timing out, and cancelling.
Continue to [6.2](../02-nonblocking-mechanism-actions/README.md).

## Reflect

Which completion claim was hardest to make observable?
