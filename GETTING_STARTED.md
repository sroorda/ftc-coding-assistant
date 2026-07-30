# Start Here

This guide gets a new student from a fresh computer to a running Java lesson.
Complete the steps in order. Ask a mentor whenever a command or security prompt is
unclear.

## 1. Get the exercises

The course repository is
[sroorda/ftc-coding-assistant](https://github.com/sroorda/ftc-coding-assistant).

If Git is already installed and an adult mentor has asked you to use it, clone the
repository:

```text
git clone https://github.com/sroorda/ftc-coding-assistant.git
cd ftc-coding-assistant
```

If Git is not installed yet, use GitHub's **Code → Download ZIP** option, extract
the ZIP, and open a terminal in the extracted folder. Git is not a Level 1 learning
objective. Students learn the team workflow after completing the Java lessons.

## 2. Install Java

The course requires a full **JDK 17 or newer**, not only a Java runtime.

- [Windows setup](docs/windows-setup.md)
- [macOS setup](docs/macos-setup.md)

Linux students should install OpenJDK 17 or newer using the method approved for
their distribution or school-managed computer.

## 3. Check the computer

Run the appropriate command from the repository root—the folder containing this
file and `README.md`.

macOS or Linux:

```text
./scripts/check-environment.sh
```

Windows Command Prompt or PowerShell:

```text
scripts\check-environment.cmd
```

Continue only when the output shows both `java` and `javac` at version 17 or newer.

## 4. Run Lesson 1

macOS or Linux:

```text
./scripts/run-lesson.sh 01
```

Windows Command Prompt or PowerShell:

```text
scripts\run-lesson.cmd 01
```

You should see:

```text
Robot initialized
```

That output confirms the starter program compiled and ran. It does not prove that
future changes meet their requirements—that is why every lesson includes explicit
verification.

## 5. Open your learning path

- Students continue to [Level 1 — Java Foundations](levels/01-java-foundations.md).
- Adults prepare with the [Adult Mentor Guide](mentors/adult-mentor-guide.md).
- The complete sequence is in the [Program Roadmap](PROGRAM_ROADMAP.md).

Before using an AI assistant, read [Predict, Ask, Verify](docs/student-workflow.md).

## Get help before continuing when

- `java` or `javac` is not found;
- a command asks for administrator access unexpectedly;
- the repository contains credentials or personal student information;
- a command would push to a shared branch; or
- work would deploy code or move real robot hardware.
