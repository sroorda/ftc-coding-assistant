# 5.1: Plan the Intake Contract

Add the first mechanism to the Season Repository only after the drivetrain and
Pedro Pathing milestones work. Plan ownership, safety, controls, and verification
before writing hardware code.

## Your mission

| | |
|---|---|
| **Time** | 60–90 minutes |
| **FTC focus** | intake requirements, states, hardware and control contract |
| **Git focus** | `feature/intake-subsystem`, reviewed plan before code |
| **AI tutor** | expose ambiguous rules and unsafe outputs |

Start from the latest reviewed integration branch and create:

```text
feature/intake-subsystem
```

## Inspect and record the hardware

With a coach, record the motor or servo type, port, Driver Station name, direction,
safe power, current limit when available, physical hazards, and emergency-stop
procedure. Secure or isolate the mechanism for its first powered test.

## Define the behavior

The intake must support three clear operations:

| Operation | Driver request | Output | State | Stop condition |
|---|---|---:|---|---|
| Start intake | | | `INTAKING` | |
| Reverse/eject | | | `REVERSING` | |
| Stop | | `0.0` | `STOPPED` | immediate |

Decide what happens when both direction buttons are pressed. Choose and document a
safe rule; do not let statement order decide accidentally.

Plan these boundaries:

```text
gamepad buttons -> Intake Test OpMode -> IntakeSubsystem -> intake hardware
```

The subsystem owns hardware, direction, limits, state, and safe outputs. The OpMode
owns button meaning, lifecycle, and telemetry.

## Review the plan

Update the Season Repository's `docs/architecture.md` with the proposed intake
ownership and public operations. A coach approves the hardware contract, control
rule, power limit, and test sequence before implementation.

## Ask your AI tutor

> Review my intake contract without writing code. Find ambiguous button
> combinations, outputs without owners, missing power or Stop rules, unobservable
> requirements, and hardware assumptions that need inspection.

## Check your work

The feature branch is current and the intake contract is approved. Continue to
[5.2](../02-intake-subsystem/README.md).

## Reflect

Why should the subsystem own the power limit instead of each OpMode?
