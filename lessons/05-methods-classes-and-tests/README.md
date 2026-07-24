# Lesson 5: Methods, Classes, and Tests

## Goals

- Write a method with a parameter and return value.
- Keep reusable logic separate from display code.
- Use examples as executable tests.
- Ask the assistant for test design rather than implementation.

## Requirement

`limitPower` must return a value in the inclusive range `-1.0` through `1.0`.
Values already in the range must be returned unchanged.

## Predict and run

Read `DriveMathTest.java`. Predict which test fails first, then run:

```text
./scripts/run-lesson.sh 05
```

On Windows use `scripts\run-lesson.cmd 05`.

The first run is expected to fail. Read the entire failure message.

## Exercise

1. Implement `DriveMath.limitPower` without changing the tests.
2. Run the tests after each small change.
3. Add a test for one boundary value.
4. Add a test for one ordinary value you chose.
5. Explain why the method is `static` in this small example.

## Ask the assistant

> Suggest five test inputs for `limitPower`, including boundaries and values outside
> the allowed range. Explain why each matters. Do not implement the method or edit
> any files.

## Verify

All tests print `PASS`, including your two added cases. Deliberately introduce one
wrong expected value, observe a useful failure, then restore it.

## FTC connection

Motor APIs expect bounded power. Keeping math in a hardware-independent method
makes it quick to test and safe to reason about on a laptop.

## Reflection

What does the test suite tell you, and what possible mistakes might it still miss?
