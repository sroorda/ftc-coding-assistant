# Contributing and Publishing

GitHub is the source of truth for this course. GitBook synchronizes the Markdown
from `main` and provides the published reading experience. Make content changes in
a local branch or on GitHub; do not create or edit repository-managed pages in the
GitBook editor.

## Publishing workflow

1. Pull `main` and create a short-lived branch.
2. Change Markdown, Java, or scripts locally.
3. Run the relevant lesson and documentation checks.
4. Review the diff and open a GitHub pull request when working with the team.
5. Merge to `main` after review.
6. Confirm that GitBook imported the commit and inspect its preview.

`SUMMARY.md` controls the GitBook navigation. `.gitbook.yaml` identifies the
homepage and summary file. Files omitted from `SUMMARY.md`, including `CLAUDE.md`,
remain in the repository but are not part of the published course navigation.

## Repository map

```text
.
├── README.md                 GitBook homepage
├── GETTING_STARTED.md        First-time student setup
├── SUMMARY.md                Published navigation
├── CURRICULUM.md             Course sequence and outcomes
├── PROGRAM_ROADMAP.md        Five-level student progression and readiness gates
├── CLAUDE.md                 AI tutoring and safety behavior
├── docs/                     Setup, workflow, and FTC transition references
├── levels/                   Level 1 path and planned Level 2–5 outcomes
├── mentors/                  Adult preparation and coaching guidance
├── team-workflow.md          Post-Level-1 Git and collaboration workshop
├── instructor/               Facilitation notes and answer guidance
├── lessons/                  Six Java exercises and their source code
└── scripts/                  Cross-platform environment and lesson runners
```

## Validate a change

Check the environment and run the affected lesson:

```text
./scripts/check-environment.sh
./scripts/run-lesson.sh 01
```

On Windows use `scripts\check-environment.cmd` and
`scripts\run-lesson.cmd 01`.

Lessons 1–4 and 6 should compile and run from their starter state. Lesson 5 is
deliberately expected to fail its first assertion until the student implements the
exercise.

## Add or revise a Level 1 lesson

Use the existing lesson structure:

1. Session at a glance
2. Learning outcomes
3. Before you begin
4. Requirement, when applicable
5. Predict
6. Implement
7. Ask the assistant
8. Verify
9. Explain
10. Next lesson

Keep source code hardware-independent and target the Java 8 language/API boundary.
Add new lesson mappings to both `scripts/run-lesson.sh` and
`scripts/run-lesson.ps1`. Add the lesson to `SUMMARY.md`, then test its instructions
on Windows and a Unix-like system.

For Levels 2–5, do not remove the **Planned** label until the material has been
tested with the team's actual FTC SDK version, hardware, safety procedure, and
Windows development environment. Update the readiness gate in `PROGRAM_ROADMAP.md`
when a level becomes available.
