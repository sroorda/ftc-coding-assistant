# Install Visual Studio Code

Visual Studio Code is the Level 1 editor. You will use it to open the course folder,
change Java files, and run lesson commands in its built-in terminal.

Do not create a new Java project. The course repository already contains the files
and folder structure you need.

## 1. Install VS Code

Download the current stable version from the
[official Visual Studio Code download page](https://code.visualstudio.com/Download).

### Windows

1. Choose the **User Installer** for your machine, normally Windows x64.
2. Run the downloaded installer.
3. Keep the default options. If offered, enable **Add to PATH** and
   **Open with Code**.
4. Start Visual Studio Code.

A school-managed computer may require an approved installation. Do not work around
school security settings.

### macOS

1. Download the macOS build offered for your Mac.
2. Open the download and move **Visual Studio Code** into **Applications**.
3. Start Visual Studio Code from Applications.

## 2. Add Java support

1. Open the **Extensions** view using the blocks icon on the left.
2. Search for **Extension Pack for Java**.
3. Choose the extension published by **Microsoft**.
4. Select **Install**.

You already installed JDK 17 using the Windows or macOS Java setup guide. Do not
install the separate **Coding Pack for Java**, because it can add another JDK and
make it harder to tell which Java installation the lessons are using.

No AI extension is required for Level 1.

## 3. Open the course folder

1. In VS Code, select **File → Open Folder**.
2. Choose the extracted or cloned `ftc-coding-assistant` folder.
3. Confirm that the Explorer shows `README.md`, `lessons`, and `scripts`.
4. If Workspace Trust appears, trust the folder only if it came from the team's
   official repository. Ask an adult when you are unsure.

Always open the whole course folder rather than opening one Java file by itself.
This gives VS Code and the terminal the correct starting location.

## 4. Open the built-in terminal

Select **Terminal → New Terminal**. The terminal should open at the bottom of VS
Code in the course folder.

Run the environment check.

macOS or Linux:

```text
./scripts/check-environment.sh
```

Windows:

```text
scripts\check-environment.cmd
```

## 5. Use the lesson scripts

You may see a **Run** link above a Java `main` method. Do not use that button during
Level 1. Run the provided lesson command in the terminal instead.

The lesson scripts:

- compile the same way on every student's computer;
- enforce the FTC-compatible Java language boundary;
- run the correct source files for each lesson; and
- preserve intentional behavior such as Lesson 5's starting test failure.

For example:

```text
./scripts/run-lesson.sh 01
```

or on Windows:

```text
scripts\run-lesson.cmd 01
```

You are ready when you can edit `RobotStatus.java`, save it, run the Lesson 1
command, and see your changed output.
