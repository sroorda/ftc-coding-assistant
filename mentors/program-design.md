# Program Design Notes

> **Audience: adult mentors and curriculum maintainers.** These are planning notes,
> not student instructions.

## Delivery sequence

- Level 1 contains no FTC SDK, hardware setup, or Git instruction.
- Introduce Git and Android Studio during Level 2 setup.
- Teach the feature-branch and pull-request workflow inside the first hardware
  exercise, when students have a real change to review.
- Introduce hardware one device at a time in a controlled Level 2 environment.
- Require reliable TeleOp subsystems before autonomous pathing.
- Require reliable pathing and mechanisms independently before coordinating them.

Students advance by demonstrated understanding, not title or prior experience.
Adults may adjust pace and accommodations, but should not waive hardware safety or
understanding checks.

## Hardware-level validation status

Levels 2–5 contain student lesson drafts, but they are not independently
student-ready until the relevant level has been tested with:

- the team's current FTC SDK and Android Studio environment;
- the team's actual hardware and configuration;
- the tested safety and emergency-stop procedure;
- both Windows and macOS development paths used by the team; and
- a beginner who was not involved in writing the lesson.

For Level 3, also validate the team's robot hardware contract, drivetrain encoder
wiring and run mode, Control Hub logo/USB orientation, heading-reset procedure,
training power, mechanism direction and limit behavior, and integration workflow.
Compare the code with the FTC SDK version installed in the team's Robot
Controller project. For Levels 4–5, pin the Pedro Pathing version and verify every
API example against that version. Level 5 additionally requires safe injected
failure tests; never create failures by jamming a mechanism or obstructing a
moving robot.

## Level 3 video facilitation

Do not assign the 25-minute mecanum video as one uninterrupted prerequisite.
Use the timestamped segments in the Level 3 path:

1. play one conceptual or code section;
2. pause at the named code boundary;
3. have students predict or enter the next small block;
4. build or test immediately; and
5. resume only after students can explain the current behavior.

The robot-relative chapter has additional pauses after wheel mixing and
normalization. The field-relative chapter begins only after both robot-relative
drive and IMU heading pass independently. Students may replay a segment while
coding; memorizing the video is not an objective.

## Hardware lab recommendation

Prefer a benchtop Level 2 rig: Control Hub, approved battery and switch, one secured
motor, one servo with a safe range, one simple sensor, and a gamepad. If the robot
must be used, isolate mechanisms and raise drive wheels when appropriate.

## Computer preparation

Test on the same managed Windows and macOS environments students will use. Personal
machines often have permissions and developer tools that school machines do not.
Confirm that students can extract or clone the repository, open a terminal, run the
environment check, edit a Java file, and rerun 1.1 without administrator
access.

## Git and collaboration

Git is a team practice, not a Level 1 programming objective. Level 2 setup creates
a personal branch for each student. The first hardware exercise teaches a feature
branch, commit, push, pull request, review, and merge back into that personal
branch. Increase the collaboration challenge gradually:

| Level | Team practice |
|---|---|
| 2 | personal cumulative branches with selected feature branches and pull requests |
| 3 | pairs own different subsystems and review integration points |
| 4 | review paths, poses, constants, and tuning evidence separately |
| 5 | coordinate changes across autonomous and mechanism code |

Do not assign permanent student leads before the team has evidence that someone can
review, recover, communicate, and protect other students' learning.
