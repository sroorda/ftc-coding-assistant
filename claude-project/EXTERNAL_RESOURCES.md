# Curated External Resources

These resources supplement the repository curriculum. They do not replace lesson
requirements, mentor decisions, or hardware safety checks.

## Source priority

When sources disagree, use this order:

1. The curriculum and its stated version/status constraints.
2. The FTC SDK `11.2.1` examples copied from the team's pinned hardware-lab
   repository into the generated knowledge bundle.
3. Current official documentation, after checking that it matches the team's
   pinned dependency version.
4. Curated videos as explanations and demonstrations, not as exact API authority.

Always identify a version mismatch or uncertain claim instead of silently
combining examples from different releases.

## FTC SDK examples

- [Official FTC SDK sample directory](https://github.com/FIRST-Tech-Challenge/FtcRobotController/tree/master/FtcRobotController/src/main/java/org/firstinspires/ftc/robotcontroller/external/samples)
- [Official FTC documentation](https://ftc-docs.firstinspires.org/)

The generated tutor bundle includes these examples from the local SDK `11.2.1`
checkout:

- `readme.md` and `sample_conventions.md`: how FIRST organizes and names samples.
- `BasicOpMode_Linear.java` and `BasicOpMode_Iterative.java`: OpMode lifecycle.
- `BasicOmniOpMode_Linear.java`: basic mecanum/omnidirectional TeleOp.
- `ConceptTelemetry.java`: telemetry patterns.
- `ConceptGamepadEdgeDetection.java`: button edge detection and state changes.
- `SensorTouch.java` and `SensorColor.java`: simple sensor access.
- `RobotAutoDriveByEncoder_Linear.java`: encoder-based autonomous movement.
- `RobotTeleopMecanumFieldRelativeDrive.java`: field-relative mecanum control.
- `externalhardware/RobotHardware.java`: reusable hardware abstraction.

Treat these files as reference code. Do not tell a student to edit the SDK sample
directory; adapt the smallest relevant idea inside team code and preserve the
team's hardware names, safety limits, and architecture.

## Pedro Pathing

Primary documentation:

- [Introduction and prerequisites](https://pedropathing.com/docs/pathing)
- [Installation](https://pedropathing.com/docs/pathing/installation)
- [Constants](https://pedropathing.com/docs/pathing/constants)
- [Tuning](https://pedropathing.com/docs/pathing/tuning)
- [Troubleshooting](https://pedropathing.com/docs/pathing/troubleshooting)
- [Coordinates](https://pedropathing.com/docs/pathing/reference/coordinates)
- [Path Builder](https://pedropathing.com/docs/pathing/reference/path-builder)
- [Detecting path completion](https://pedropathing.com/docs/pathing/reference/pathcomplete)
- [Bezier curves](https://pedropathing.com/docs/pathing/reference/beziercurves)
- [Path callbacks](https://pedropathing.com/docs/pathing/reference/callbacks)

Pedro requires Android Studio, an omnidirectional drivetrain, localization, and
robot-specific tuning. Levels 4 and 5 remain drafts until a mentor pins the Pedro
version and validates the procedures on the current robot. Never infer that a
current website example matches the team's installed version without checking.

## Brogan Pratt video supplements

Channel: [Brogan Pratt](https://www.youtube.com/@BroganMPratt)

Relevant playlists:

- [Learn Java for FTC: Complete Robotics Programming Course](https://www.youtube.com/playlist?list=PLRHdgFNRLyaPiZ5rvINwMmGMHEIL9usla)
- [PedroPathing Tutorials: FTC Autonomous Pathing Routines](https://www.youtube.com/playlist?list=PLRHdgFNRLyaMYGJtBMSFEpxNdMvuJOai6)
- [Learn GitHub Desktop](https://www.youtube.com/playlist?list=PLRHdgFNRLyaNeaKKlv81SodtPzXH20z6f)

Selected curriculum-aligned videos:

- [Your First Java Program](https://www.youtube.com/watch?v=F24X8Ut83os)
- [Java Variables](https://www.youtube.com/watch?v=3fhqLpsW7BE)
- [Programming a Gamepad](https://www.youtube.com/watch?v=gXegsVvXLd0)
- [Selection Statements](https://www.youtube.com/watch?v=7yzEMGYVPO8)
- [Programming DC Motors](https://www.youtube.com/watch?v=Wv5v8p3Iqi8)
- [Programming Servos](https://www.youtube.com/watch?v=K9x85yBHjpk)
- [REV Touch Sensors](https://www.youtube.com/watch?v=RKJhRtbpAeU)
- [REV Color Sensors](https://www.youtube.com/watch?v=pyIeknIcT8M)
- [PedroPathing Setup](https://www.youtube.com/watch?v=6v7QgzRhOwA)
- [Writing FTC Auto with PedroPathing](https://www.youtube.com/watch?v=gdkefs_VL-w)
- [Multitasking in FTC Auto with Pedro Pathing](https://www.youtube.com/watch?v=p6g8CbNj0eM)
- [PedroPathing PIDF Tuning](https://www.youtube.com/watch?v=vihb2LPtSK0)

Use a video to reinforce a concept or give the student a visual demonstration.
Before recommending one, state the lesson connection and remind the student that
the repository's pinned versions and safety rules take priority. Do not treat
comments, sponsorships, or season-specific claims as curriculum facts.
