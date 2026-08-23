# Level 7 Planning Draft — Vision

> **MENTOR PLANNING ONLY — NOT A STUDENT LESSON.** Keep this page out of
> `SUMMARY.md` until the team selects the current-season vision goal, hardware,
> processor, and fallback behavior and validates them on the robot.

Level 7 will add a vision observation to the verified nonblocking autonomous
without allowing camera work to command hardware directly. Planned work happens in
`feature/vision`; the reviewed milestone is expected to become `v0.5`.

## Decisions required before authoring student lessons

| Decision | Examples, not defaults |
|---|---|
| Season objective | detect a field element, locate an AprilTag, choose an auto branch |
| Camera and mounting | webcam or approved integrated camera, measured pose and view |
| Vision processor | current FTC VisionPortal processor or reviewed team processor |
| Observable output | detection, confidence, image position, or estimated field pose |
| Consumer | TeleOp telemetry, pre-Start selection, or autonomous coordinator |
| Invalid/stale result | ignore, retry, select a conservative fallback, or fault |
| Test evidence | lighting range, distance range, false positives, latency, disconnect |

## Proposed lesson spine

1. Configure the camera and prove a stable image stream.
2. Detect and report one approved target without moving the robot.
3. Convert the observation into a small, testable decision interface.
4. Integrate that decision into the existing autonomous state machine.
5. Test no-target, stale-result, bad-lighting, and camera-failure fallbacks.
6. Review, merge, retest, and mark the `v0.5` milestone.

Vision code should observe and report. The coordinator decides what the robot does,
and existing subsystems continue owning all hardware outputs and safety rules.
