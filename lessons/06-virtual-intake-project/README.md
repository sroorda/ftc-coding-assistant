# Lesson 6: Virtual Intake Controller

This is your Level 1 project. You will combine inputs, decisions, methods, objects,
and tests in one small program that models an FTC intake without using robot
hardware.

Before you receive the requirements, you will walk through the starter program and
learn how its pieces work together.

## Your mission

| | |
|---|---|
| **Time** | 90–120 minutes |
| **Java focus** | objects, method calls, boolean inputs, returned results, and rule priority |
| **FTC connection** | hardware-independent intake decision logic |
| **AI tutor** | review your implementation against numbered requirements |

## Your goal

By the end of this project, you can:

- trace inputs through a controller and explain the returned output;
- turn written requirements into ordered `if` statements;
- resolve conflicting inputs using a deliberate priority order;
- add scenarios to an existing test harness; and
- defend an AI-assisted change with test evidence.

## Get ready

Complete [Lesson 5](../05-methods-classes-and-tests/README.md). Open these four
files in your local clone:

```text
lessons/06-virtual-intake-project/src/org/ftc/training/lesson06/VirtualIntakeDemo.java
lessons/06-virtual-intake-project/src/org/ftc/training/lesson06/VirtualIntakeController.java
lessons/06-virtual-intake-project/src/org/ftc/training/lesson06/IntakeOutput.java
lessons/06-virtual-intake-project/src/org/ftc/training/lesson06/VirtualIntakeControllerTest.java
```

## What are we modeling?

An intake is a robot mechanism that moves game pieces into or out of the robot. A
driver may request normal intake or reverse. A sensor might report that an object
is already present. The robot also needs a way to stop the mechanism.

This lesson does not read a real gamepad, sensor, or motor. It represents those
hardware values with ordinary Java booleans and returns a motor-power number. That
keeps the decision logic fast and safe to run on your computer.

The program follows this flow:

```text
button and sensor values
          ↓
VirtualIntakeController.update(...)
          ↓
IntakeOutput: motor power + status message
          ↓
demo display or test check
```

## Meet the starter files

Each file has one job.

### `VirtualIntakeDemo.java` — supplies example inputs

The demo creates a controller and calls it with several combinations of `true` and
`false`. Its `show` method prints the returned result. It is an example of how
other robot code could use the controller.

### `VirtualIntakeController.java` — makes the decision

The `update` method receives four inputs:

| Parameter | What `true` represents |
|---|---|
| `intakePressed` | The driver is requesting normal intake. |
| `reversePressed` | The driver is requesting reverse. |
| `objectDetected` | A sensor reports an object in the intake. |
| `emergencyStop` | The intake must stop. |

The starter method does not make a real decision yet. It always returns zero power
and the status `Not implemented`. This is the method you will complete.

### `IntakeOutput.java` — carries two results together

The controller needs to return both a motor-power number and a status message. A
Java method returns one value, so `IntakeOutput` groups those two pieces into one
object.

Its constructor stores `motorPower` and `status`. The fields are `final`, which
means an output does not change after it is created. The getter methods allow the
test to read each value. Its `toString` method controls how the complete output is
displayed by the demo.

You do not need to modify `IntakeOutput` for this project.

### `VirtualIntakeControllerTest.java` — checks scenarios

This supplied test harness is based on Lesson 5. Each call to `check` sends one
combination of inputs to the controller and compares the returned power and status
with the expected result.

The harness runs every scenario before printing its summary and failing the overall
run. Your job is to use it and add scenarios, not design a new testing framework.

## Trace one starter scenario

Read this line from `VirtualIntakeDemo.java`:

```java
show("intake requested", controller.update(true, false, false, false));
```

Trace it from the inside out:

1. `controller.update(...)` calls the controller object.
2. The four values mean intake is pressed; reverse, object detection, and emergency
   stop are false.
3. The starter `update` method creates `new IntakeOutput(0.0, "Not implemented")`.
4. That `IntakeOutput` object returns to the demo.
5. `show` prints the scenario name and the object's `toString` representation.

In Lesson 5, `DriveMath.limitPower` was `static`, so you called it through the class
name. Here the demo first creates an object:

```java
VirtualIntakeController controller = new VirtualIntakeController();
```

It then calls the non-static `update` method through that object. This resembles how
a future robot program can create one controller or subsystem object and call it
many times.

## Run the starter checks

Before running, predict why every starter scenario will fail even though some
expected motor powers are `0.0`.

macOS or Linux:

```text
./scripts/run-lesson.sh 06
```

Windows:

```text
scripts\run-lesson.cmd 06
```

Read all five results and the final summary. The program is working as designed:
the tests are exposing that the controller is still a placeholder.

## Understand conflicting inputs

Inputs do not always arrive one at a time. A driver can press intake and reverse
together, or an object can be detected while intake is still pressed. The program
cannot command forward and reverse power at the same time, so it needs an explicit
rule for which request wins.

That rule is called **priority** or **precedence**. In an `if`/`else if` chain, Java
uses the first true branch and skips the remaining branches. The order of the code
therefore becomes part of the robot's behavior.

A decision table helps you reason about combinations before writing code:

| Intake | Reverse | Object | E-stop | Expected power | Expected status |
|---:|---:|---:|---:|---:|---|
| false | false | false | false | | |
| true | false | false | false | | |
| true | true | false | false | | |

You will complete and expand this table after reading the requirements.

## Requirements

Rules are listed from highest to lowest priority:

1. Emergency stop always returns power `0.0` and status `Emergency stop`.
2. Reverse returns power `-1.0` and status `Reversing`, even if intake is pressed
   or an object is detected.
3. An object detected prevents normal intake and returns power `0.0` and status
   `Object detected`.
4. Intake pressed returns power `1.0` and status `Intaking`.
5. Otherwise, return power `0.0` and status `Idle`.

## Predict and plan

Copy the decision table into your notes and add enough rows to cover all five
requirements. Include conflicting inputs, not only cases with one true value.

For every row:

1. Find the highest-priority true rule.
2. Record the power and status from that rule.
3. Compare your answer with the other rows before coding.

## Student Task

1. Implement `VirtualIntakeController.update` in requirement-priority order.
2. Run the supplied tests after each small change.
3. Confirm that all five supplied scenarios pass.
4. Add a scenario with intake, reverse, and object detection all true while
   emergency stop is false.
5. Add a scenario with all four inputs true.
6. Predict both results before running, then confirm that all seven scenarios pass.
7. Review the completed method and make sure you can explain every branch.

Do not change an expected result merely to make a failing scenario pass. Compare
the implementation and the numbered requirements first.

## Ask your AI tutor

After your first implementation:

> Review `VirtualIntakeController.java` against the five numbered requirements. Do
> not edit. For each problem, name the violated requirement, explain the Java logic,
> and suggest one scenario that demonstrates it. Avoid advanced design patterns.

After adding your scenarios:

> Look for a missing conflicting-input scenario in my tests. Suggest the inputs and
> expected result, but let me write the `check` call.

## Check your work

You are finished when:

- all five supplied scenarios pass;
- the two scenarios you added pass;
- every numbered requirement is demonstrated by at least one scenario;
- conflicting inputs demonstrate the priority order;
- status messages agree with motor power; and
- you can trace one test from its boolean inputs to the returned `IntakeOutput`
  without the assistant.

## Connect it to FTC

This controller could sit between gamepad and sensor readings and an FTC motor. It
does not know hardware names or call motor APIs, so its important logic remains
fast to test away from the robot. Hardware-facing code would read the real inputs,
call `update`, and apply the returned motor power.

## Continue

Return to the [Level 1 Readiness Check](../../levels/01-java-foundations.md#level-1-readiness-check),
then complete the [Team Workflow Bootcamp](../../team-workflow.md) before beginning
supervised [Level 2 hardware work](../../levels/02-hardware-lab.md).
