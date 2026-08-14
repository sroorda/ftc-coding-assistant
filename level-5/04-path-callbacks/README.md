# 5.4: Trigger Actions Along a Path

Pedro callbacks can request work while a path is active. Read the pinned version's
[callback reference](https://pedropathing.com/docs/pathing/reference/callbacks)
before using the API.

Start with one parametric callback because it is tied to distance progress rather
than elapsed time. The callback should request a subsystem action and return
quickly; it must not wait for that action to finish. Keep `follower.update()` and
`mechanism.update()` running in the outer loop.

Predict callback count and order. Report callback-requested state, path busy state,
mechanism state, pose, and failure reason. Verify:

| Scenario | Evidence |
|---|---|
| Normal path | Callback fires once after the expected progress. |
| Slower repeat | Progress trigger remains spatially meaningful. |
| Follow the chain again | Reset behavior matches the pinned documentation. |
| Mechanism still running at path end | Coordinator applies the documented rule. |
| Stop | Path and mechanism cancel safely. |

Temporal callbacks are an optional comparison, not a substitute for spatial or
sensor evidence; speed changes can make the same time occur at a different pose.

## Ask your AI tutor

> Review my callback without editing. Confirm it returns immediately, fires the
> expected number of times, does not bypass subsystem safety, and has a defined
> result when path and action finish in either order.

## Check your work

The PR includes two-speed evidence and callback-count evidence. Continue to
[5.5](../05-recovery-and-cancellation/README.md).

## Reflect

Why does a progress trigger remain meaningful when speed changes?
