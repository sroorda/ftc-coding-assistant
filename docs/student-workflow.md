# How the Lessons Work: Predict, Ask, Verify

Use this guide whenever you are unsure what to try next. A good programmer does
not need to know every answer; a good programmer knows how to gather evidence.

## Know which repository you are changing

- Levels 1–3.6 use the course and hardware-lab repositories named in their setup
  instructions.
- Beginning with Lesson 3.7, read lessons here but make every robot-code change in
  the team's Season Repository.
- Before editing, say the repository name, current branch, pull-request target, and
  expected milestone aloud or show them to a teammate.

Follow the [Season Repository Workflow](season-repository-workflow.md). If you
cannot access the repository or cannot build its target branch unchanged, stop and
record the baseline problem before creating a feature branch.

## Before asking your AI tutor

Write down three things:

1. What you expected
2. What actually happened
3. The smallest part you do not understand

Run the lesson once and read the full error message. Do not paste credentials,
student information, or unrelated repository contents into a prompt.

## Ask a focused question

For an explanation:

> Explain this method line by line for a beginning Java student. Do not edit files.
> Afterward, ask me one question to check my understanding.

For a hint:

> I expected ____, but observed ____. Give me one hint about where to look. Do not
> provide the corrected line yet.

For a review:

> Review only the code I changed. Identify logic errors, unclear names, and missing
> edge cases. Do not edit. Tie each suggestion to a requirement.

For tests:

> Suggest three inputs that could expose mistakes in this method. Explain why each
> matters. Do not implement the method.

## Check a suggestion before using it

Before accepting advice, ask:

- Does it match the requirement?
- Can I explain every changed line?
- Is it simpler than the code I had?
- What input proves it works?
- What input might prove it wrong?

An assistant can produce confident, compilable, incorrect code. Verification is a
programming skill, not a final checkbox.

## Stop and get an adult mentor

Stop and ask a mentor before changing robot hardware configuration, deploying to a
device, moving an actuator, modifying credentials, pushing shared branches, or
running a command you cannot explain.
