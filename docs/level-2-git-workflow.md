# Your Level 2 Git Workflow

Level 2 uses two kinds of student branches:

- `student/<your-name>` is your cumulative Level 2 work.
- `lesson/<your-name>/<short-description>` is temporary work prepared for review.

For example, Alex might use:

```text
student/alex
lesson/alex/motor-telemetry
```

Lesson pull requests target the author's personal branch. They do not target
`main`, another student's branch, or the official FIRST repository.

## Clone the team repository

Choose a folder where you keep programming projects, then run:

```text
git clone <HARDWARE_LAB_REPOSITORY_URL>
cd ftc-hardware-lab
git remote -v
```

Both `origin` entries must point to the team hardware-lab repository. Stop if they
point directly to `FIRST-Tech-Challenge/FtcRobotController` or somewhere you do
not recognize.

## Create your personal branch once

Replace `<your-name>` with the short name assigned by the mentor:

```text
git switch main
git pull --ff-only origin main
git switch -c student/<your-name>
git push -u origin student/<your-name>
```

Run these checks:

```text
git branch --show-current
git status
```

Do not commit directly to `main`. Do not work on another student's branch.

## Start a piece of reviewed work

Begin from your up-to-date personal branch:

```text
git switch student/<your-name>
git pull --ff-only origin student/<your-name>
git switch -c lesson/<your-name>/<short-description>
```

Before editing, verify the branch:

```text
git branch --show-current
git status
```

## Inspect and commit your work

After the code behaves as required, inspect the change before staging it:

```text
git status
git diff
```

Stage only the files that belong to the change. Avoid `git add .` until you can
confidently explain every file in `git status`.

```text
git add <specific-file>
git diff --staged
git commit -m "Describe the working outcome"
git push -u origin lesson/<your-name>/<short-description>
```

A good commit message describes the result, such as:

```text
Report motor power and encoder position
```

## Open the pull request

On GitHub, select:

- **base repository:** the team hardware-lab repository
- **base branch:** `student/<your-name>`
- **compare branch:** `lesson/<your-name>/<short-description>`

Before requesting review, confirm that the pull request shows only your intended
files and commits. Include:

- what changed;
- how you tested it;
- what physical behavior you observed, when hardware was involved; and
- any limitation or concern the reviewer should examine.

If the GitHub CLI is installed, the equivalent command is:

```text
gh pr create --base student/<your-name> --head lesson/<your-name>/<short-description>
```

Using the GitHub website is equally acceptable.

## Review another student's work

Reviewers comment through the pull request. They do not push commits to the
author's branch or edit the author's files.

Check:

- Does the code satisfy the stated requirement?
- Is the expected hardware motion documented?
- Are power, position, time, and sensor limits safe?
- Does the code stop the device in every relevant path?
- Does the evidence support the author's conclusion?
- Can you identify one normal case and one failure or boundary case?

Mark an issue as required only when the requirement, safety, or correctness
demands it. Label optional improvements as suggestions.

## Merge and continue

After review and mentor approval, merge the lesson pull request into your personal
branch. Then update your local copy:

```text
git switch student/<your-name>
git pull --ff-only origin student/<your-name>
git branch -d lesson/<your-name>/<short-description>
git status
```

The mentor will announce when your branch needs an update from `main`. Do not
merge, rebase, force-push, reset, or discard files to resolve a confusing Git state
without help. Preserving work is more important than repairing it quickly.
