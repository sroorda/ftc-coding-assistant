# Team Workflow Bootcamp

Complete this workshop after Level 1 and before students begin FTC hardware work.
It introduces the team's delivery process without mixing Git concepts into the
first Java lessons.

## Outcome

Each student can move one small change from a local branch to a reviewed pull
request and explain what changed. The goal is safe recovery and visible teamwork,
not memorizing Git commands.

## Before you begin

Students should have completed the
[Level 1 readiness check](levels/01-java-foundations.md#readiness-check). Use this training
repository or another disposable practice repository—not active competition code.
An adult mentor should control repository permissions and protect the default
branch.

## One-workshop path

Use a tiny documentation or completed Level 1 change.

1. Clone the repository and identify the default branch.
2. Create a short-lived branch named for the intended change.
3. Make one small change.
4. Inspect `git status` and `git diff` before staging.
5. Commit with a message that describes the outcome.
6. Push the branch and open a pull request.
7. Explain the diff to a peer or adult reviewer.
8. Respond to one review comment and update the branch if needed.
9. Merge only with adult approval, then update the local default branch.

## Definition of done

- The pull request has one clear purpose.
- The author can explain every changed line.
- Generated files, credentials, and unrelated changes are absent.
- The relevant verification command and result are recorded.
- Review comments distinguish required corrections from optional suggestions.
- The student knows how to ask for help instead of using destructive recovery
  commands.

## Collaboration progression

Git continues after the bootcamp, but the collaboration challenge grows gradually:

| Level | Team practice |
|---|---|
| 2 — Hardware Lab | one student branch and one small pull request per device exercise |
| 3 — Robot Systems | pairs own different subsystems and review their integration points |
| 4 — Autonomous Motion | review paths, poses, constants, and tuning evidence separately |
| 5 — Coordinated Autonomous | coordinate changes across autonomous and mechanism code |

Students do not need permanent lead titles. Adults can give temporary ownership of
a subsystem, test, or pull request when a student is ready. An optional emerging
maintainer role can be added later for students who consistently demonstrate sound
review and recovery skills.

## AI boundaries

AI may explain a command, summarize a diff, or suggest review questions. It should
not push, merge, change permissions, resolve destructive Git problems, or approve
its own generated code. A human author and human reviewer remain accountable.
