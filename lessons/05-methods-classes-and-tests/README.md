# 1.5: Hardware-Independent Methods and Tests

Robot code often mixes three kinds of work: reading hardware, making a decision,
and commanding hardware. The decision is usually the easiest part to test, but
only if it is separated from the motor, sensor, or gamepad.

Today you will implement one small hardware-independent method and use executable
checks to prove that it follows its requirement.

## Your mission

| | |
|---|---|
| **Time** | 75–90 minutes |
| **Java focus** | methods, parameters, return values, classes, and tests |
| **FTC connection** | separating motor-power rules from motor hardware |
| **AI tutor** | suggest test cases without implementing the method |

> **Expected first result:** all five starter checks will run. Three will pass, two
> will fail, and the program will then report a test failure. This is the starting
> evidence for the exercise, not an environment problem.

## Your goal

By the end of this lesson, you can:

- explain why calculation and decision logic should be separated from hardware;
- write a method with a parameter and return value;
- describe how the lesson's `check` method evaluates a test case; and
- use several test cases to verify normal, boundary, and outside-range behavior.

## Get ready

Complete [1.4](../04-loops-and-autonomous/README.md). Open both files in your
local clone:

```text
lessons/05-methods-classes-and-tests/src/org/ftc/training/lesson05/DriveMath.java
lessons/05-methods-classes-and-tests/src/org/ftc/training/lesson05/DriveMathTest.java
```

## Separate the decision from the hardware

Later, FTC drive code might follow this general sequence:

```java
double requestedPower = joystick * speedScale;
double safePower = DriveMath.limitPower(requestedPower);
motor.setPower(safePower);
```

Reading the joystick and commanding the motor require FTC hardware. Limiting a
number to an allowed range does not. We can place that calculation in `DriveMath`
and give it ordinary `double` values during a test. No robot, configured motor, or
FTC SDK is needed.

This is **hardware-independent logic**: it receives the information it needs as
parameters, returns a result, and does not directly read or command a device. The
robot code can call the same method later.

## Understand the method

`DriveMath.java` contains this method:

```java
public static double limitPower(double power) {
    // You will implement this method.
}
```

- `public` allows code in another class to call it.
- `static` means this small calculation belongs to the `DriveMath` class itself;
  the test does not need to create a `DriveMath` object first.
- The first `double` is the type of value the method returns.
- `power` is a parameter containing the input provided by the caller.

## Requirement

`limitPower` must return a value in the inclusive range `-1.0` through `1.0`.
Values already in the range must be returned unchanged.

## Understand a test case

Each line below is one test case:

```java
check("zero", 0.0, DriveMath.limitPower(0.0));
```

It contains:

1. A name that identifies the behavior being tested.
2. The **expected** result from the written requirement.
3. The **actual** result returned by the method.

A test passes only when the actual result matches the expected result. Test code
does not prove that every possible input is correct, so choose examples that cover
different kinds of behavior.

## Understand the `check` method

This lesson uses a small test harness instead of adding the JUnit library. Its
`check` method receives the test name, expected value, and actual value:

```java
private static void check(String name, double expected, double actual)
```

- `private` means only `DriveMathTest` uses this helper.
- `static` lets `main` call it directly.
- `void` means it reports a result instead of returning one.

The method compares the absolute difference between `expected` and `actual` with a
small tolerance. A tolerance is used because decimal calculations stored as
`double` values are not always represented exactly.

For each call, `check` prints `PASS` or `FAIL` and updates a counter. It does not
throw immediately when one check fails. After every check has run, `main` prints a
summary and throws one `AssertionError` if any failures were recorded. JUnit uses a
more capable test runner, but it follows the same important idea: run independent
tests, report their individual results, and make the overall run fail when a test
did not meet its expectation.

## Make a prediction

Read all five calls to `check` in `DriveMathTest.java`. Before running, predict
`PASS` or `FAIL` for every named check. Remember that the starter method currently
returns its input unchanged.

Run the tests:

macOS or Linux:

```text
./scripts/run-lesson.sh 05
```

Windows:

```text
scripts\run-lesson.cmd 05
```

Compare every reported result with your prediction. Then read the final summary
and `AssertionError`.

## Student Task

1. Implement `DriveMath.limitPower` without changing the existing checks.
2. Run the tests after each small change.
3. Confirm that all five original checks pass.
4. Add one check for exactly `-1.0` and one check for exactly `1.0`.
5. Run the complete set again and confirm that all seven checks pass.

Never weaken or remove a check merely to make the run appear successful.

## Ask your AI tutor

> Suggest five test inputs for `limitPower`, including boundaries and values outside
> the allowed range. Explain why each matters. Do not implement the method or edit
> any files.

Compare the suggestions with the checks already present before adding anything.

## Check your work

You are finished when:

- all five original checks print `PASS`;
- the two exact-boundary checks you added also pass;
- below-range and above-range values are limited correctly;
- in-range values remain unchanged;
- you can explain each parameter of the `check` method; and
- deliberately changing one expected value still allows every check to run before
  the final summary reports failure, after which you restore the expected value.

## Connect it to FTC

Motor APIs expect bounded power, but testing a method that directly controls a
motor would require the SDK, a configured robot, and safe physical access. Keeping
the numerical rule in a hardware-independent method makes it fast to test on a
laptop. Later, hardware-facing code can use the tested result when it commands the
motor.

## Continue

Continue to [1.6: Virtual Intake Controller](../06-virtual-intake-project/README.md).
