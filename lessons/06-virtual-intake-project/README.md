# Lesson 6: Virtual Intake Controller

## Session at a glance

| | |
|---|---|
| **Time** | 90–120 minutes |
| **Java focus** | requirements, decomposition, precedence, integration |
| **FTC connection** | intake subsystem decision logic |
| **AI role** | review implementation against numbered requirements |

## Learning outcomes

By the end of this project, you can:

- turn written requirements into a decision table;
- implement conflicting rules in a deliberate priority order;
- separate decision logic from hardware access;
- design scenarios that expose missing behavior; and
- defend an AI-assisted change with evidence.

## Before you begin

Complete [Lesson 5](../05-methods-classes-and-tests/README.md). Open both files in
your local clone:

```text
lessons/06-virtual-intake-project/src/org/ftc/training/lesson06/VirtualIntakeController.java
lessons/06-virtual-intake-project/src/org/ftc/training/lesson06/VirtualIntakeDemo.java
```

The starter compiles but deliberately does not meet the requirements.

## Requirements

Rules are listed from highest to lowest priority:

1. Emergency stop always produces power `0.0`.
2. Reverse produces power `-1.0`, even if intake is also pressed.
3. An object detected prevents normal intake and produces power `0.0`.
4. Intake pressed produces power `1.0`.
5. Otherwise, power is `0.0`.

Every output needs a short status message explaining the chosen state.

## Predict and plan

Create a decision table with columns for intake, reverse, object detected,
emergency stop, expected power, and expected status. Include conflicting inputs,
not only the easy cases. Show the table to another pair before coding.

Run the starter from the repository root.

macOS or Linux:

```text
./scripts/run-lesson.sh 06
```

Windows:

```text
scripts\run-lesson.cmd 06
```

## Implement

1. Implement `VirtualIntakeController.update` in requirement-priority order.
2. Use the demo to exercise each row in your decision table.
3. Move scenario checks into small methods or create a separate test class.
4. Add at least one scenario where three inputs are simultaneously true.
5. Improve status wording without changing decision behavior.
6. Pair-review the code; both partners must explain every branch.

## Ask the assistant

After your first implementation:

> Review `VirtualIntakeController.java` against the five numbered requirements. Do
> not edit. For each problem, name the violated requirement, explain the Java logic,
> and suggest one scenario that demonstrates it. Avoid advanced design patterns.

After writing your own scenarios:

> Look for a missing conflicting-input scenario in my tests. Suggest the input and
> expected result, but let me write the test.

## Verify

Demonstrate at least these scenarios:

| Intake | Reverse | Object | E-stop | Expected power |
|---:|---:|---:|---:|---:|
| false | false | false | false | 0.0 |
| true | false | false | false | 1.0 |
| true | false | true | false | 0.0 |
| true | true | false | false | -1.0 |
| true | true | false | true | 0.0 |

You are finished when:

- every numbered requirement has at least one scenario;
- conflicting inputs demonstrate the priority order;
- status messages agree with motor power;
- your three-input scenario produces the predicted result; and
- both partners can explain the implementation without the assistant.

## Explain

Demonstrate the project to an adult mentor. State the expected result before each
run and identify the requirement that controls it.

Exit question: **Which rule wins when inputs conflict, and which test proves it?**

## FTC connection

This controller could sit between gamepad/sensor readings and an FTC motor. It does
not know hardware names or call motor APIs, so its important logic remains fast to
test away from the robot.

## Course completion

Return to the [Student Readiness Check](../../levels/01-java-foundations.md#readiness-check),
then complete the [Team Workflow Bootcamp](../../team-workflow.md) before beginning
supervised [Level 2 hardware work](../../levels/02-hardware-lab.md).
