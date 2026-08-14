# Adult Mentor Guide

## Outcome

Use AI coding assistants to improve preparation, questioning, review, and
verification while keeping programming decisions and explanations with students.

AI supports mentoring but is not an accountable mentor. Adults remain responsible
for student supervision, hardware safety, privacy, repository permissions, and final
technical decisions.

The test is not whether the group finishes faster. The test is whether students can
make the next comparable change with less help.

## Before the course

1. Run every lesson, including the intentionally failing starting state in 1.5.
2. Identify the Java concept and evidence of learning for each exercise.
3. Agree on account, privacy, repository, deployment, and hardware boundaries.
4. Configure Claude Code using the repository's [CLAUDE.md](../CLAUDE.md), or apply
   the same boundaries to the team's chosen AI assistant.
5. Rehearse one weak prompt (“fix this”) and one bounded prompt from the
   [student workflow](../docs/student-workflow.md).

## The help ladder

Move down only as far as the learner needs:

1. Ask for the prediction and observed result.
2. Ask the student to locate the relevant message, method, or requirement.
3. Name the Java concept involved.
4. Offer a small hint or question.
5. Ask for pseudocode or a decision table.
6. Show a tiny unrelated example.
7. Pair on one line or one test, then return control.

Providing the full implementation is appropriate only when implementation is not
the learning objective, time or accessibility requires it, or a safety issue must
be corrected immediately. Say why you are crossing that line.

## Good uses of AI

- Generate alternate explanations at an identified experience level.
- Suggest questions that reveal misconceptions without revealing the answer.
- Review an exercise for ambiguity before students see it.
- Propose edge cases for a mentor to validate against the requirement.
- Compare a diff with a stated requirement and verification evidence.
- Summarize repeated confusion after removing student-identifying information.

## Uses that weaken learning

- Implementing the exercise before the student attempts it.
- Accepting a large edit because tests pass.
- Asking Claude to infer the requirement from existing code.
- Replacing student explanations with generated summaries.
- Treating an architecture recommendation as authority.
- Pasting credentials, student data, or unrelated private repository content.

## AI-assisted review protocol

When an AI assistant reviews student code, provide the written requirement and
constrain the scope to the student's diff. Ask it to separate correctness, missing
tests, clarity, and optional ideas. Then require a human reviewer to:

1. reproduce each material claim in the actual code;
2. discard comments unrelated to the requirement or learning objective;
3. convert answer-shaped feedback into questions when practical; and
4. choose the exact verification students will run.

AI can widen attention; it cannot certify safety or understanding.

## Ten-minute mentor debrief

After each session, record only:

- the concept students could explain;
- the misconception that recurred;
- which rung of the help ladder was usually enough;
- whether AI increased understanding or merely output; and
- one adjustment for the next session.

Escalate immediately when work touches robot motion, hardware configuration,
deployment, credentials, personal data, or a command the student cannot explain.
