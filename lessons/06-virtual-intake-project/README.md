# Lesson 6: Virtual Intake Controller

## Project

Build the decision-making part of an FTC intake without connecting to hardware.
The controller receives ordinary Java values and returns an `IntakeOutput` containing
motor power and a status message.

## Requirements

Rules are listed from highest to lowest priority:

1. Emergency stop always produces power `0.0`.
2. Reverse produces power `-1.0`, even if intake is also pressed.
3. An object detected prevents normal intake and produces power `0.0`.
4. Intake pressed produces power `1.0`.
5. Otherwise, power is `0.0`.

Every output needs a short status message that explains the chosen state.

## Plan before coding

Create a decision table with columns for intake, reverse, object detected, emergency
stop, expected power, and expected status. Include conflicting inputs, not only the
easy cases. Show the table to another pair before implementation.

## Run

```text
./scripts/run-lesson.sh 06
```

On Windows use `scripts\run-lesson.cmd 06`.

The starter compiles but does not meet the requirements.

## Exercise

1. Implement `VirtualIntakeController.update` in priority order.
2. Use the demo to try each row in your decision table.
3. Move scenario checks into small methods or create a separate test class.
4. Add at least one scenario where three inputs are simultaneously true.
5. Improve status wording without changing its decision logic.
6. Pair-review the code; both partners must explain every branch.

## Ask the assistant

> Review `VirtualIntakeController.java` against the five numbered requirements. Do
> not edit. For each problem, name the violated requirement, explain the Java logic,
> and suggest one scenario that demonstrates it. Avoid advanced design patterns.

After making your own changes:

> Look for a missing conflicting-input scenario in my tests. Suggest the input and
> expected result, but let me write the test.

## Verify

Demonstrate the five scenarios in the instructor guide plus your three-input case.
For each, state the expected result before running. “It compiles” is not sufficient.

## FTC connection

This controller could later sit between `gamepad`/sensor readings and an FTC motor.
The class itself does not know hardware names or call motor APIs, which keeps its
decision logic fast to test away from the robot.

## Reflection

Why does the order of the `if` statements matter? Which test best proves that your
priority order is correct?
