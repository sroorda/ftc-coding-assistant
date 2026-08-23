# 6.5: Pause, Recover, and Cancel Safely

Define what happens when an action cannot safely overlap motion or when a component
fails.

Use the pinned Pedro documentation for pausing and resuming path following. Pause
only for a documented action requirement. While paused, continue calling both
update methods and telemetry. Resume only after observable success; timeout enters
`FAULT` instead.

Create a failure policy table:

| Event | Drive result | Intake result | Next state | Operator evidence |
|---|---|---|---|---|
| Action timeout | | | | |
| Routine timeout | | | | |
| Limit/interlock | | | | |
| Driver Station Stop | | | | |
| Approved retry | | | | |

Do not test recovery by physically jamming or obstructing a moving mechanism.
Inject a safe short timeout or simulated decision input approved by a coach.

## Ask your AI tutor

> Review my pause, resume, fault, retry, and cancellation paths without editing.
> Check that updates continue while paused, retry begins from a known state, and
> every failure repeatedly commands safe outputs.

## Check your work

Demonstrate pause/resume success, timeout without resume, cancellation, and a
reviewed retry if the team permits one. Continue to
[6.6](../06-nonblocking-auto-release/README.md).

## Reflect

What must be re-established before retry is safer than remaining in `FAULT`?
