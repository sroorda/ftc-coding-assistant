# Windows Setup

The course runs natively on Windows 10 or 11. WSL and Git Bash are not required.
Use either Windows Terminal, PowerShell, or Command Prompt.

## One-time setup

1. Download the [Eclipse Temurin 17 JDK](https://adoptium.net/temurin/releases/?version=17).
2. Select Windows, the machine's architecture (normally x64), package type JDK,
   and the `.msi` installer. Do not select a JRE.
3. Run the installer. Enable its options to set `JAVA_HOME` and add Java to `PATH`
   if they are offered. A school-managed machine may require an administrator.
4. Close and reopen the terminal so it receives the updated environment.
5. Change directory to the repository root—the folder containing `README.md`.
6. Run:

   ```text
   scripts\check-environment.cmd
   ```

The output should show both a Java runtime and compiler at version 17 or newer.
The course intentionally compiles student programs as Java 8-compatible code; see
[Java and FTC compatibility](java-compatibility.md).

## Install the editor

Continue to [Install Visual Studio Code](vscode-setup.md). Use VS Code's built-in
terminal for the commands below; Windows PowerShell is a supported default.

## Run a lesson

From the repository root in VS Code's terminal:

```text
scripts\run-lesson.cmd 01
```

Replace `01` with `02` through `06` as the course progresses. 1.5 is expected
to report a failed assertion on its first run; repairing that behavior is the
exercise.

The `.cmd` files are small launchers for the PowerShell implementations. They use a
process-only execution-policy bypass, so they do not permanently change the
computer's PowerShell policy.

## Common problems

### “java” or “javac” is not recognized

Install a full JDK, reopen the terminal, and rerun the environment check. If `java`
works but `javac` does not, a JRE may have been installed instead of a JDK, or the
JDK's `bin` directory may not be on `PATH`.

### The script cannot find lesson files

Run the command from the repository root, not from inside `scripts` or a lesson
folder. The scripts handle spaces in the repository path.

### PowerShell says script execution is disabled

Use the `.cmd` command shown above rather than invoking the `.ps1` file directly.
The wrapper changes policy only for that one process and does not require an
administrator account.

### A school-managed computer blocks PowerShell

Do not work around school security policy. Ask the team's technical contact to
approve the scripts or use a managed development environment. The Java source can
also be compiled from an approved IDE, but ask an adult mentor to show you the
team's exact project setup.
