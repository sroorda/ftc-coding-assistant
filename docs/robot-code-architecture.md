# Robot Code Architecture

The base robot framework should grow from real needs across Levels 2–5. Beginners
should not be asked to design it from a blank project, and the team should not add
layers merely because another team or an AI assistant recommends them.

## Target shape

```text
TeamCode/src/main/java/org/firstinspires/ftc/teamcode/
├── opmodes/       TeleOp and autonomous entry points
├── hardware/      configured device names and initialization
├── subsystems/    drive, intake, arm, and other mechanisms
├── autonomous/    poses, paths, and autonomous sequencing
└── logic/         hardware-independent decisions and calculations
```

This is a direction, not a requirement to create empty packages. Add a package when
the team has code that clearly belongs there.

## How the framework grows

### Level 1 — Pure logic

Keep robot-like decisions in ordinary Java classes. Students learn that important
logic can be tested without deploying to hardware.

### Level 2 — Hardware boundary

Introduce a small hardware class that owns configured names and device
initialization. An OpMode reads inputs, calls understandable logic, applies outputs,
and reports telemetry. Avoid hiding the FTC lifecycle from beginners.

### Level 3 — Reusable subsystems

Create a subsystem only when a mechanism has behavior used from more than one
place. Each subsystem owns its devices and exposes actions in team vocabulary such
as `intake()`, `stop()`, or `moveToScorePosition()`.

Keep TeleOp focused on coordination:

```text
read gamepads → choose intent → call subsystems → update telemetry
```

The same subsystem behavior should be callable later from autonomous code.

### Level 4 — Autonomous motion

Add localization, named field poses, path definitions, and tuning constants without
mixing mechanism logic into path construction. Keep season-specific coordinates
easy to find and review.

### Level 5 — Coordinated actions

Add a small nonblocking action or state model so mechanisms and path following can
progress together. The control loop must continue updating localization, the
follower, mechanisms, stop conditions, and telemetry.

## Design rules

- Keep OpModes thin enough to read as a sequence of team intentions.
- Keep hardware configuration names in one obvious place.
- Separate calculations and decisions from FTC hardware APIs when practical.
- Use the same subsystem operations from TeleOp and autonomous code.
- Prefer explicit states and small methods over timing-dependent chains of sleeps.
- Make stop behavior and safety precedence visible.
- Add an abstraction only when it removes current duplication or clarifies a real
  boundary.
- Record important tradeoffs in a short decision note rather than relying on memory
  or AI-generated authority.

## Architecture milestone

At the end of Level 3, ask each student to trace one behavior from a gamepad button
through the OpMode and subsystem to the hardware command. At the end of Level 5,
repeat the trace from an autonomous condition. If the path cannot be explained,
the framework is too complicated or insufficiently documented.
