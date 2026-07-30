# Lesson 1: First Java Program

Today you will take control of your first Java program. You will predict its output,
change what it says, run it again, and identify where Java begins executing your
code.

## Your mission

| | |
|---|---|
| **Time** | 75–90 minutes, with extra time for initial setup |
| **Java focus** | file, package, class, `main`, output, compile, run |
| **FTC connection** | initialization and telemetry messages |
| **AI tutor** | explain existing code without editing it |

## Your goal

By the end of this lesson, you can:

- explain the relationship between a Java file, class, and package;
- identify a Java class and the `main` method;
- compile and run a Java program;
- change simple output messages; and
- explain the difference between source code and a running program.

## Get ready

Complete [Set Up Your Computer](../../GETTING_STARTED.md). In VS Code's Explorer,
open this file:

```text
lessons/01-first-program/src/org/ftc/training/lesson01/RobotStatus.java
```

## Understand the file and class

A **file** is a named piece of information stored on your computer. Java source
files are text files whose names end in `.java`. You can open and change them in an
editor such as VS Code.

The file you just opened is named:

```text
RobotStatus.java
```

Inside it, this line declares a **class**:

```java
public class RobotStatus {
```

A class groups related information and behavior under one name. In this small
program, `RobotStatus` is the container for the `main` method and the instruction
that prints a message. Later, classes can represent robot ideas such as a motor,
intake, drivetrain, or sensor reading.

Java requires a `public` class and its file to have the same name, including
capitalization:

```text
Class: RobotStatus
File:  RobotStatus.java
```

The opening `{` begins the class body, and its matching `}` ends the class body.
Everything between those braces belongs to the class.

## Understand the package

The first line places the class in a **package**:

```java
package org.ftc.training.lesson01;
```

A package is an address for a group of related Java classes. It keeps code
organized and prevents unrelated classes with the same short name from being
confused with one another.

Package names use periods, while folders use slashes. After the `src` folder, this
course mirrors each part of the package with a folder:

```text
Package: org.ftc.training.lesson01
Folders: org/ftc/training/lesson01
File:    org/ftc/training/lesson01/RobotStatus.java
```

Reading the package from left to right:

- `org.ftc.training` identifies this training code;
- `lesson01` groups the code for Lesson 1; and
- `RobotStatus` is the class inside that package.

Together, the package and class form the class's full name:

```text
org.ftc.training.lesson01.RobotStatus
```

For now, keep the package line and folder structure unchanged. FTC projects use
packages the same way to organize OpModes, subsystems, and other robot code.

## Run the starter

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
4. Locate the package declaration, class declaration, and line where execution
   begins.

## Ask your AI tutor

Use the assistant as an explainer, not an editor:

> Explain how the file, package, class, and `main` method in `RobotStatus.java` fit
> together. Do not edit any files. Correct my explanation, then ask me one
> check-for-understanding question.

## Check your work

You are finished when:

- the program compiles without errors;
- it prints two intentional lines;
- the filename matches the public class name;
- you can identify the package declaration;
- you can identify the `main` method; and
- a teammate can change one message and rerun it.

Compilation proves that Java accepted the program. It does not prove that the
messages are useful or that future robot behavior is correct.

## Teach it back

Point to the file, package declaration, class declaration, and `main` method. Explain
how each one helps Java find and run this program. Then tell a teammate what
`public`, `static`, `void`, and `String[] args` appear to do. An incomplete first
explanation is fine.

Exit question: **What did running the program prove, and what did it not prove?**

## Connect it to FTC

FTC programs normally use telemetry instead of `System.out.println` for
Driver Station status. In both environments, a useful message should tell the
operator what the software actually knows.

## Continue

Continue to [Lesson 2: Variables and Robot Math](../02-variables-and-math/README.md).
