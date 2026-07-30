# Program Design Notes

> **Audience: adult mentors and curriculum maintainers.** These are planning notes,
> not student instructions.

## Delivery sequence

- Level 1 contains no FTC SDK, hardware setup, or Git instruction.
- Run the Team Workflow Bootcamp between Levels 1 and 2.
- Introduce hardware one device at a time in a controlled Level 2 environment.
- Require reliable TeleOp subsystems before autonomous pathing.
- Require reliable pathing and mechanisms independently before coordinating them.

Students advance by demonstrated understanding, not title or prior experience.
Adults may adjust pace and accommodations, but should not waive hardware safety or
understanding checks.

## Later-level status

Levels 2–5 currently define outcomes and constraints; they are not student-ready
curricula. Do not remove a **Coming later** label until the lessons
have been tested with:

- the team's current FTC SDK and Android Studio environment;
- the team's actual hardware and configuration;
- the adult-approved safety and emergency-stop procedure;
- both Windows and macOS development paths used by the team; and
- a beginner who was not involved in writing the lesson.

## Hardware lab recommendation

Prefer a benchtop Level 2 rig: Control Hub, approved battery and switch, one secured
motor, one servo with a safe range, one simple sensor, and a gamepad. If the robot
must be used, isolate mechanisms and raise drive wheels when appropriate.

## Computer preparation

Test on the same managed Windows and macOS environments students will use. Personal
machines often have permissions and developer tools that school machines do not.
Confirm that students can extract or clone the repository, open a terminal, run the
environment check, edit a Java file, and rerun Lesson 1 without administrator
access.

## Git and collaboration

Git is a team practice, not a Level 1 programming objective. After the bootcamp,
increase the collaboration challenge gradually:

| Level | Team practice |
|---|---|
| 2 | one small branch and pull request per device exercise |
| 3 | pairs own different subsystems and review integration points |
| 4 | review paths, poses, constants, and tuning evidence separately |
| 5 | coordinate changes across autonomous and mechanism code |

Do not assign permanent student leads before the team has evidence that someone can
review, recover, communicate, and protect other students' learning.
