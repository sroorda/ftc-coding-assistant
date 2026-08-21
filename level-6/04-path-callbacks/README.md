# 6.4: Trigger Actions Along a Path

Pedro callbacks can request work while a path is active. Read the pinned version's
[callback reference](https://pedropathing.com/docs/pathing/reference/callbacks)
before using its API.

Start with one parametric callback because it is tied to distance progress rather
than elapsed time. The callback requests an intake action and returns quickly; it
must not wait for the action to finish. Keep `follower.update()` and the action's
`update()` running in the outer loop.

Predict callback count and order. Report callback-requested state, path busy state,
intake-action state, pose, and failure reason. Verify:

| Scenario | Evidence |
|---|---|
| Normal path | Callback fires once after the expected progress. |
| Slower repeat | Progress trigger remains spatially meaningful. |
| Follow the chain again | Reset behavior matches the pinned documentation. |
| Action still running at path end | Coordinator applies the documented rule. |
| Stop | Path and intake cancel safely. |

Temporal callbacks are an optional comparison, not a substitute for spatial or
sensor evidence; speed changes can make the same time occur at a different pose.

## Ask your AI tutor

> Review my callback without editing. Confirm it returns immediately, fires the
> expected number of times, does not bypass subsystem safety, and has a defined
> result when path and action finish in either order.

## Check your work

Commit two-speed and callback-count evidence. Continue to
[6.5](../05-recovery-and-cancellation/README.md).

## Reflect

Why does a progress trigger remain meaningful when speed changes?
