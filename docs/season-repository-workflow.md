# Season Repository Workflow

Beginning with Lesson 3.7, the course repository provides instructions while the
team's Season Repository contains the robot code students change and deploy.

## Choose one integration model

The coach names the target before students create branches:

| Repository model | Pull-request target | Milestone tags |
|---|---|---|
| One repository dedicated to the current season | `main` | `v0.1`, `v0.2`, ... |
| One long-lived repository containing several seasons | `season/YYYY-YYYY` | `YYYY-YYYY-v0.1`, `YYYY-YYYY-v0.2`, ... |

Do not use `master`, `main`, and “season branch” interchangeably. The pull-request
target is the protected branch explicitly named by the coach.

## Student access gate

Before Lesson 3.7, every student must be able to:

1. accept the GitHub repository or organization invitation;
2. open the Season Repository on GitHub;
3. clone it and identify its `origin` remote;
4. check out and pull the reviewed integration branch;
5. build the unchanged project; and
6. run the existing TeleOp with an approved test procedure.

Record baseline failures before creating a feature branch. A new lesson must not
be blamed for a failure that already existed on the target branch.

## Feature and review flow

Each milestone uses a short-lived branch created from the latest integration
branch:

```text
integration branch
  -> feature/<milestone-name>
       -> focused commits
       -> push
       -> pull request
       -> coach review
       -> coach merge
       -> integration verification
       -> annotated milestone tag
```

The planned branches are:

| Milestone | Feature branch | Expected tag |
|---|---|---|
| Drivetrain framework | `feature/drive-subsystem` | `v0.1` |
| Pedro Pathing | `feature/pedro-pathing` | `v0.2` |
| Intake and integrated TeleOp | `feature/intake-subsystem` | `v0.3` |
| Nonblocking autonomous | `feature/nonblocking-auto` | `v0.4` |
| Vision | `feature/vision` | `v0.5` |

Use season-qualified tags when the repository contains more than one season.

## Pull-request evidence

Every student pull request includes:

- requirement and architecture links;
- exact base and compare branches;
- build result;
- hardware, firmware, dependency, and configuration versions that matter;
- expected and observed behavior;
- Stop, timeout, or safe-failure evidence appropriate to the change;
- known limitations; and
- confirmation that no credential, generated build output, or unrelated change is
  included.

Students update the same pull request when review finds a problem. They do not open
a replacement pull request for each correction and do not merge their own work.

## Coach repository controls

Before student access, the coach should:

- protect the integration branch from direct pushes and force pushes;
- require at least one accountable review;
- require the available build checks;
- keep repository and tag permissions appropriate for student accounts;
- add a pull-request template for the evidence above;
- record the supported FTC SDK, Pedro Pathing, dashboard, and hardware versions;
  and
- keep `docs/architecture.md` current with the actual robot contract.

The coach creates the milestone tag only after the merged integration commit passes
the relevant regression and hardware checks.
