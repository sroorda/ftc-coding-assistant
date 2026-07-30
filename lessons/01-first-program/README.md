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
- identify a Java class and explain the parts of the `main` method;
- compile and run a Java program;
- change simple output messages; and
- explain the difference between source code and a running program.

## Get ready

Complete [Set Up Your Computer](../../GETTING_STARTED.md). In VS Code's Explorer,
open this file:

```text
lessons/01-first-program/src/org/ftc/training/lesson01/RobotStatus.java
```

## Part 1 — Files, classes, and packages

In Part 1, you will identify how Java organizes this program, predict its output,
and make your first code changes.

### Understand the file and class

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

### Understand the package

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

### Make a prediction

Before running, write down the exact output you expect.

### Run the starter

Now run the starter from the repository root.

macOS or Linux:

```text
./scripts/run-lesson.sh 01
```

Windows:

```text
scripts\run-lesson.cmd 01
```

Compare the actual output with your prediction.

### Student task 1 — Change the output

Make these changes yourself before asking an AI assistant:

1. Change the initialization message to wording you prefer.
2. Add a second output line saying whether the virtual robot is ready.
3. Run the lesson again.
4. Locate the package declaration, class declaration, and line where execution
   begins.

## Part 2 — `main`, `static`, and arguments

In Part 2, you will examine how Java starts the program and then pass information
into it when it runs.

### Understand `main`, `static`, and arguments

Inside the class, this line declares the `main` **method**:

```java
public static void main(String[] args) {
```

A method is a named block of instructions. When you launch this program, Java looks
for the `main` method as the place to begin.

Read the declaration one part at a time:

| Part | Meaning in this program |
|---|---|
| `public` | Java is allowed to call this method from outside the class. |
| `static` | The method belongs to the class itself. Java can call it without first creating a `RobotStatus` object. |
| `void` | The method finishes without returning a value. |
| `main` | This is the name Java recognizes as the program's starting point. |
| `String[] args` | This method can receive an array—a list—of text values supplied when the program starts. |

An **object** is one created instance of a class. You will work with objects in a
later lesson. For now, the important point is that `static` lets Java start `main`
before any `RobotStatus` object exists.

`String[] args` is the method's **parameter**. `String` means text, the square
brackets `[]` mean an array, and `args` is the variable name. The values placed in
that array are called **arguments**.

The opening `{` begins the method body. Java runs the statements inside that body
in order, from top to bottom.

### Student task 2 — Use an argument

Add this line inside `main`:

```java
System.out.println("Team: " + args[0]);
```

`args[0]` means “the first argument.” Java begins counting array positions at zero.
The `+` joins the label `Team: ` with the argument text.

Before running, predict all three output lines. Then pass your team name as the
first argument.

macOS or Linux:

```text
./scripts/run-lesson.sh 01 Creekside
```

Windows:

```text
scripts\run-lesson.cmd 01 Creekside
```

Try a different team name. If the name contains spaces, put quotation marks around
it:

```text
./scripts/run-lesson.sh 01 "Creekside Robotics"
```

```text
scripts\run-lesson.cmd 01 "Creekside Robotics"
```

After you add `args[0]`, the program expects at least one argument. Without one,
there is no item at position zero.

## Ask your AI tutor

Use the assistant as an explainer, not an editor:

> Explain how the file, package, class, and `main` method in `RobotStatus.java` fit
> together. Include why `main` is `static` and what `String[] args` can contain. Do
> not edit any files. Correct my explanation, then ask me one
> check-for-understanding question.

## Check your work

You are finished when:

- the program compiles without errors;
- it prints three intentional lines, including the team name passed as the first
  argument;
- the filename matches the public class name;
- you can identify the package declaration;
- you can identify the `main` method;
- you can explain why Java can call a `static` method without creating an object;
  and
- you can explain why `args[0]` selects the first argument.

Compilation proves that Java accepted the program. It does not prove that the
messages are useful or that future robot behavior is correct.

## Connect it to FTC

FTC programs normally use telemetry instead of `System.out.println` for
Driver Station status. In both environments, a useful message should tell the
operator what the software actually knows.

## Continue

Continue to [Lesson 2: Variables and Robot Math](../02-variables-and-math/README.md).
