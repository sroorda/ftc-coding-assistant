# Set Up Your Computer

By the end of this guide, you will have the course files, a working Java
installation, and Visual Studio Code. Complete the steps in order.

If a command or security prompt surprises you, stop and ask an adult mentor before
continuing.

## 1. Get the exercises

Open the course repository:
[sroorda/ftc-coding-assistant](https://github.com/sroorda/ftc-coding-assistant).

For Level 1, the simplest choice is **Code → Download ZIP**. Extract the ZIP to a
folder you can find again.

If an adult mentor has asked you to use Git instead, clone the repository:

```text
git clone https://github.com/sroorda/ftc-coding-assistant.git
cd ftc-coding-assistant
```

Git is not part of the first Java lessons. You will learn the team Git process after
Level 1.

## 2. Install Java

You need a full **JDK 17 or newer**, not only a Java runtime.

- [Install Java on Windows](docs/windows-setup.md)
- [Install Java on macOS](docs/macos-setup.md)

On Linux, install OpenJDK 17 or newer using the method approved for your computer.

## 3. Install your editor

Follow [Install Visual Studio Code](docs/vscode-setup.md). Install Microsoft's
**Extension Pack for Java**, then open the entire `ftc-coding-assistant` folder in
VS Code.

Use **Terminal → New Terminal** for every command in the lessons. Do not use the
Java **Run** button during Level 1; the lesson scripts apply the course's FTC-compatible
Java settings.

## 4. Check your setup

Run the command in VS Code's terminal. The terminal should be in the course
folder—the folder containing `README.md`.

macOS or Linux:

```text
./scripts/check-environment.sh
```

Windows Command Prompt or PowerShell:

```text
scripts\check-environment.cmd
```

You are ready when the output shows both `java` and `javac` at version 17 or newer.

## 5. Start learning

Read [How the Lessons Work](docs/student-workflow.md), then open
[Level 1 — Java Foundations](levels/01-java-foundations.md). Lesson 1 will ask you
to predict your first program's output before you run it.

## Stop and ask an adult when

- `java` or `javac` is not found;
- a command unexpectedly asks for administrator access;
- you see a password, API key, credential, or personal information;
- a command would push to a shared branch; or
- code could deploy to or move real robot hardware.
