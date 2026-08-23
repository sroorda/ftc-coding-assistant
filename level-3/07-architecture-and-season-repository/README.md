# 3.7: Plan the Architecture and Enter the Season Repository

From this lesson forward, all robot-code changes happen in the team's Season
Repository. The course repository remains your instruction and reference source.

Do not begin implementation until you can access the Season Repository, build its
current target branch unchanged, and explain the architecture you plan to add.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | robot architecture, subsystem ownership, behavior preservation |
| **Git focus** | repository handoff, baseline verification, feature branch |
| **AI tutor** | challenge boundaries and assumptions without writing the design |

## 1. Pass the repository-access gate

Follow the [Season Repository Workflow](../../docs/season-repository-workflow.md).
Show a coach that you can:

- open the repository on GitHub;
- clone or open the correct local repository;
- identify the branch named by the coach;
- pull its current state;
- build it without changing files;

If any baseline check fails, stop. Do not hide an existing failure inside the
drivetrain architecture change.

## 2. Read both architecture documents

Read the course's [Thin, Domain-Oriented Robot Architecture](../../docs/robot-code-architecture.md).
Then read `docs/architecture.md` in the Season Repository. The course page explains
the general design rules; the Season Repository document records the team's actual
packages, hardware, names, limits, and decisions.

If the Season Repository does not yet contain `docs/architecture.md`, the coach
must create or approve its initial version before this lesson continues.

## 3. Plan the smallest useful framework

Plan only the structure needed for the existing drivetrain:

```text
OpMode
  -> Robot
       -> DrivetrainSubsystem
            -> four drive motors and drive-specific configuration
```

Your plan must answer:

| Question | Decision |
|---|---|
| Which class owns each drive motor? | |
| Which class owns motor directions and power limits? | |
| Which public operations will TeleOp call? | |
| How will `Robot.stop()` stop the drivetrain? | |
| Which existing behavior must remain unchanged? | |
| Which code can be copied, and which code must be adapted? | |
| What evidence will show the refactor did not break TeleOp? | |

Do not add empty packages or speculative abstractions for future mechanisms.

## 4. Review the plan with a coach

Walk through one complete command path:

```text
gamepad input -> TeleOp intent -> DrivetrainSubsystem -> motor commands
```

The coach approves the ownership boundaries, public operations, shutdown behavior,
and test plan.

## 5. Create the feature branch

Return to the reviewed integration branch, pull its latest state, and create:

```text
feature/drive-subsystem
```

Confirm the current branch before editing. Do not create the branch from a stale
student branch or from the course repository.

## Ask your AI tutor

> Review my drivetrain architecture plan without writing code. Check device
> ownership, lifecycle responsibility, shutdown behavior, public operations,
> behavior-preservation evidence, and any abstraction that is not yet justified.

## Check your work

You are ready for 3.8 when the baseline passes, the coach has approved the plan,
the decisions are recorded, and `feature/drive-subsystem` is current.

Continue to [3.8](../08-drive-subsystem-delivery/README.md).

## Reflect

Which design decision prevents two parts of the program from commanding the same
motor?
