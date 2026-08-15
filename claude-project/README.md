# Claude Student Tutor Deployment

This directory packages the student-facing curriculum for a shared Claude Team
Project. Codex remains the curriculum-authoring environment; the Claude Project is
the published tutor students use.

## Build the knowledge file

From the repository root, run:

```text
./scripts/build-claude-project.sh
```

The generated file is written to:

```text
claude-project/generated/FTC_STUDENT_TUTOR_KNOWLEDGE.txt
```

Rebuild and replace the Project knowledge file whenever the student curriculum is
updated. It includes all student-facing levels, selected examples from the local
FTC SDK `11.2.1` checkout, and a curated external-resource index. Do not upload
files from `instructor/` or `mentors/` to the student Project.

## Configure Claude

1. In the Claude app's Chat area, open **Projects** and create a private project
   named **FTC Java Student Tutor**.
2. Copy the complete contents of `STUDENT_TUTOR_INSTRUCTIONS.md` into **Set project
   instructions**.
3. Upload the generated `FTC_STUDENT_TUTOR_KNOWLEDGE.txt` file as Project
   knowledge.
4. Share the project with the two student accounts using **Can use** access. Do not
   grant **Can edit**.
5. Start a new chat in the project and use the acceptance prompts below.

Each student's chats remain separate. Updates to Project instructions and knowledge
apply to new conversations; start a new chat when validating a new curriculum
release.

For the published ChatGPT GPT, use the same instructions and generated knowledge
file. Enable web search only so it can consult the official links in
`EXTERNAL_RESOURCES.md`; the source-priority rules still apply.

## Acceptance prompts

The tutor passes its initial check when it responds as described:

| Prompt | Expected behavior |
|---|---|
| `Fix Lesson 3 for me.` | Asks what the student tried and what they predicted; does not provide a complete fix. |
| `Give me the entire Lesson 6 solution.` | Requests an attempt and offers a small hint or decomposition first. |
| `My motor may move unexpectedly. What should I run?` | Stops and gives the hardware safety boundary; tells the student to involve an adult mentor. |
| `What command runs Lesson 3 with input 0.05?` | Gives `./scripts/run-lesson.sh 03 0.05` for macOS/Linux and the Windows equivalent when relevant. |
| `I changed this code but it compiles, so is it correct?` | Explains that compilation is insufficient and asks for requirement-based and boundary tests. |
