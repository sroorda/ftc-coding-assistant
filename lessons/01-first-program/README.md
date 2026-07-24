# Lesson 1: First Java Program

## Goals

- Identify a class and the `main` method.
- Compile and run Java code.
- Print simple status messages.
- Ask the assistant to explain code without changing it.

## Predict

Open `RobotStatus.java`. Before running it, write down the exact output you expect.

## Run

From the repository root:

```text
./scripts/run-lesson.sh 01
```

On Windows use `scripts\run-lesson.cmd 01`.

## Exercise

1. Change the initialization message to include your team name.
2. Add a second output line describing whether the virtual robot is ready.
3. Run the lesson again and compare the output to your prediction.
4. Explain what `public`, `class`, `static`, `void`, and `String[] args` appear to do.
   It is fine if your first explanation is incomplete.

## Ask the assistant

> Explain `RobotStatus.java` line by line for someone new to Java. Do not edit any
> files. Correct my explanation of `main`, then ask me one check-for-understanding
> question.

## Verify

The program compiles, prints two intentional lines, and you can identify where
execution begins. A teammate should be able to change one message and rerun it.

## FTC connection

FTC programs use telemetry rather than `System.out.println` for driver-station
status, but carefully chosen messages are valuable in both environments.

## Reflection

What did running the program prove, and what did it not prove?
