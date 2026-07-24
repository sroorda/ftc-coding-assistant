# Track B — Team Leads

## Outcome

Build a lightweight delivery system in which beginners can contribute safely. A
lead coordinates work and makes decisions visible; a lead does not become the only
person who can understand or modify the robot.

Use a practice clone or disposable training branch for these workshops. Never run
destructive Git commands merely to make an exercise easier.

## Workshop 1 — Small branches and useful commits

Practice with a completed change from Lessons 2 or 3.

- Create a short-lived branch named for one outcome, not one person.
- Inspect `git status` and `git diff` before staging.
- Keep generated files and credentials out of the commit.
- Write a commit message that says what behavior changed and why.
- Have the author reconstruct the change from the diff in plain language.

Evidence: another teammate can identify the intent and affected lesson from the
branch, diff, and commit message without being told verbally.

## Workshop 2 — Evidence-based code review

Review a Lesson 3 boundary fix or the initial failing Lesson 5 implementation.

Review in this order:

1. requirement and safety;
2. demonstrated behavior and missing cases;
3. clarity and maintainability; then
4. optional style improvements.

Label feedback as **blocking**, **question**, or **suggestion**. A useful comment
states the observation, why it matters, and what evidence would resolve it. Do not
rewrite the code in a comment when a question can expose the author's reasoning.

Evidence: the author can act on every blocking comment without a private explanation.

## Workshop 3 — Project structure and ownership

Map the training repository, then map a practice FTC repository:

- entry points and lifecycle;
- domain logic that can run without hardware;
- hardware adapters and configuration boundaries;
- tests and verification commands; and
- subsystem ownership and likely change impact.

Look for dependencies pointing from reusable logic toward hardware APIs. Discuss
how extracting plain Java decision logic can make testing easier, but do not create
layers that have no current requirement.

Evidence: a new programmer can answer “where should this change go?” and “how can I
test it?” using the map.

## Workshop 4 — Architecture as recorded tradeoffs

Use the virtual intake precedence rules for a short design discussion. Compare at
least two reasonable designs, such as direct conditionals and an explicit state.
Record a one-page decision:

```text
Decision:
Context and constraints:
Options considered:
Why this option now:
Consequences and when to revisit:
Verification strategy:
```

Prefer the simplest design that makes current safety rules and tests obvious.
Architecture is not a vocabulary contest, and Claude's preference is not a team
decision.

Evidence: a teammate can challenge the choice using the recorded constraints, and
the team can identify a condition that would justify revisiting it.

## Lead review checklist

- Is the change small enough to review reliably?
- Does it meet the named requirement without unrelated cleanup?
- What command or observation supports the claim that it works?
- Are boundary, failure, and conflicting inputs covered?
- Can the author explain accepted AI-generated material?
- Does it alter hardware behavior, configuration, secrets, or deployment?
- Is every blocking comment truly required before integration?
