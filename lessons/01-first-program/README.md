# Lesson 1: First Java Program

Today you will take control of your first Java program. You will predict its output,
change what it says, run it again, and identify where Java begins executing your
code.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes, with extra time for initial setup |
| **Java focus** | class, `main`, output, compile, run |
| **FTC connection** | initialization and telemetry messages |
| **AI tutor** | explain existing code without editing it |

## Your goal

By the end of this lesson, you can:

- identify a Java class and the `main` method;
- compile and run a Java program;
- change simple output messages; and
- explain the difference between source code and a running program.

## Get ready

Complete [Start Here](../../GETTING_STARTED.md), then open this file in your local
clone:

```text
lessons/01-first-program/src/org/ftc/training/lesson01/RobotStatus.java
```

Run the starter from the repository root.

macOS or Linux:

```text
./scripts/run-lesson.sh 01
```

Windows:

```text
scripts\run-lesson.cmd 01
```

## Make a prediction

Before running, write down the exact output you expect. After running, compare the
actual output with your prediction.

## Build it

Make these changes yourself before asking an AI assistant:

1. Change the initialization message to include your team name.
2. Add a second output line saying whether the virtual robot is ready.
3. Run the lesson again.
4. Locate the line where execution begins.

## Ask your AI tutor

Use the assistant as an explainer, not an editor:

> Explain `RobotStatus.java` line by line for someone new to Java. Do not edit any
> files. Correct my explanation of `main`, then ask me one check-for-understanding
> question.

## Check your work

You are finished when:

- the program compiles without errors;
- it prints two intentional lines;
- you can identify the `main` method; and
- a teammate can change one message and rerun it.

Compilation proves that Java accepted the program. It does not prove that the
messages are useful or that future robot behavior is correct.

## Teach it back

Tell a teammate what `public`, `class`, `static`, `void`, and `String[] args` appear
to do. An incomplete first explanation is fine.

Exit question: **What did running the program prove, and what did it not prove?**

## Connect it to FTC

FTC programs normally use telemetry instead of `System.out.println` for
Driver Station status. In both environments, a useful message should tell the
operator what the software actually knows.

## Continue

Continue to [Lesson 2: Variables and Robot Math](../02-variables-and-math/README.md).
