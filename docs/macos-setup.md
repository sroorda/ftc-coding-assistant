# macOS Setup

The course requires a full JDK version 17 or newer. A JRE alone is not enough
because the lessons use the `javac` compiler.

## Option 1 — Installer

1. Open the [Eclipse Temurin 17 JDK downloads](https://adoptium.net/temurin/releases/?version=17).
2. Select macOS and package type JDK.
3. Select `aarch64` for an Apple silicon Mac or `x64` for an Intel Mac. **About This
   Mac** identifies the processor or chip when you are unsure.
4. Download and run the `.pkg` installer.
5. Close and reopen Terminal.

## Option 2 — Homebrew

If Homebrew is already approved and installed:

```text
brew install --cask temurin@17
```

Do not install Homebrew solely for this course on a school-managed Mac without the
school's approval.

## Verify and run

Change directory to the repository root—the folder containing `README.md`—and run:

```text
./scripts/check-environment.sh
./scripts/run-lesson.sh 01
```

The environment check must show both `java` and `javac` at version 17 or newer. The
course compiles student programs as Java 8-compatible code so they transfer to the
FTC SDK; see [Java and FTC compatibility](java-compatibility.md).

## Common problems

### “command not found: java” or “command not found: javac”

Close and reopen Terminal after installation. Then list the JDKs macOS recognizes:

```text
/usr/libexec/java_home -V
```

If JDK 17 appears but is not selected, set it for the current Terminal session:

```text
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"
```

Ask a mentor before making that change permanent on a school-managed machine.

### “Permission denied” when running a script

From the repository root, run:

```text
chmod +x scripts/*.sh
```

Then rerun the environment check. Do not use `sudo` for the lesson scripts.

### The wrong Java version still appears

Multiple JDKs may be installed. Run `/usr/libexec/java_home -V`, select version 17
as shown above, and rerun the check in the same Terminal window.
