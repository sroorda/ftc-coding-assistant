# 4.3: Follow One Straight Path

You will build a short `PathChain`, start it once, and keep the follower updating
until it reports completion.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **FTC focus** | follower lifecycle, `BezierLine`, completion, stop |
| **Git focus** | path definition and run evidence |
| **AI tutor** | trace lifecycle and identify repeated-start bugs |

Use the pinned version's generated `Constants.createFollower(hardwareMap)`. Build
one conservative line from the measured `START` to a nearby `TARGET`:

```java
PathChain toTarget = follower.pathBuilder()
        .addPath(new BezierLine(START, TARGET))
        .setConstantHeadingInterpolation(START.getHeading())
        .build();
```

During initialization, create the follower and path and set the starting pose.
After Start, call `followPath(toTarget)` exactly once. Inside the one active loop,
call `follower.update()` every pass and report pose, busy state, and elapsed time.
`followPath(...)` starts work; it does not block until the motion finishes.

Test first with drive power disabled or wheels supported, then in a cleared area.
Verify start placement, direction, heading, completion, final pose error, timeout
behavior, and Driver Station Stop. Do not loosen constraints just to hide a wrong
start pose or localization error.

## Ask your AI tutor

> Review my first-path OpMode without editing. Confirm the path starts once,
> `follower.update()` runs every active loop, completion uses observable evidence,
> and Stop cannot be trapped behind another loop.

## Check your work

Record expected and observed final poses for at least three identical runs and
explain what `isBusy()` does and does not prove. Continue to
[4.4](../04-heading-curves-and-chains/README.md).

## Reflect

Why does `followPath(...)` run once while `follower.update()` runs repeatedly?
