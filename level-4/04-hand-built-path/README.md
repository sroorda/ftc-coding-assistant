# 4.4: Build Your First Pedro Paths

In this lesson you will create your first Autonomous OpMode, follow a straight
path, and then build a path with a curved turn.

## Create an Autonomous OpMode

An Autonomous OpMode has a simple lifecycle:

`initialize -> wait for Start -> begin the path once -> update until complete or stopped`

Create a Java class in `TeamCode`. Use your project's package name and import the
`Constants` class created in Lesson 4.2.

```java
import com.pedropathing.follower.Follower;
import com.pedropathing.geometry.BezierLine;
import com.pedropathing.geometry.Pose;
import com.pedropathing.paths.PathChain;
import com.qualcomm.robotcore.eventloop.opmode.Autonomous;
import com.qualcomm.robotcore.eventloop.opmode.LinearOpMode;

// Makes this OpMode appear on the Driver Station.
@Autonomous(name = "First Pedro Auto", group = "Learning")
public class FirstPedroAuto extends LinearOpMode {

    private final Pose startPose =
            new Pose(24, 24, Math.toRadians(0));

    private final Pose endPose =
            new Pose(72, 24, Math.toRadians(0));

    private Follower follower;
    private PathChain path;

    private void buildPath() {
        // Describes the movement but does not move the robot.
        path = follower.pathBuilder()
                .addPath(new BezierLine(startPose, endPose))
                .setConstantHeadingInterpolation(startPose.getHeading())
                .build();
    }

    @Override
    public void runOpMode() {
        // Connect Pedro to the robot configured in the earlier lessons.
        follower = Constants.createFollower(hardwareMap);

        // Build paths before the match starts.
        buildPath();

        // This must match where the robot is physically placed.
        follower.setStartingPose(startPose);

        telemetry.addLine("Ready");
        telemetry.update();

        waitForStart();

        if (isStopRequested()) {
            return;
        }

        // Start the path exactly once.
        follower.followPath(path);

        // isBusy() is true while Pedro is still following the path.
        while (opModeIsActive() && follower.isBusy()) {
            // Performs the path-following work and must run continuously.
            follower.update();

            telemetry.addData("x", follower.getPose().getX());
            telemetry.addData("y", follower.getPose().getY());
            telemetry.addData("heading", follower.getPose().getHeading());
            telemetry.update();
        }
    }
}
```

- `@Autonomous` makes the OpMode appear on the Driver Station.
- `Constants.createFollower()` connects Pedro to the configured robot.
- `buildPath()` describes the movement but does not move the robot.
- `setStartingPose()` must match where the robot is physically placed.
- `followPath()` starts the movement.
- `follower.update()` performs the path-following work.
- `follower.isBusy()` reports whether Pedro is still following the path.

Build and deploy before running the path. Confirm that **First Pedro Auto** appears
on the Driver Station.

## Follow the straight path

Read Pedro's [Coordinates](https://pedropathing.com/docs/pathing/reference/coordinates)
and [Path Builder](https://pedropathing.com/docs/pathing/reference/path-builder)
pages.

The example path should:

- start at `(24, 24)`;
- travel 48 inches in a straight line;
- maintain a heading of 0 degrees; and
- finish near `(72, 24)`.

Adjust the coordinates if the example does not fit your test area.

- [ ] Place the robot at the starting pose.
- [ ] Run the OpMode and verify the robot travels in the expected direction.
- [ ] Verify the robot maintains its heading and finishes near the end pose.
- [ ] Repeat the path successfully.
- [ ] Commit and push the working straight path.

## Understand paths and headings

- A `Pose` contains X, Y, and heading.
- A `BezierLine` travels directly between two poses.
- A `BezierCurve` uses one or more control points to shape a turn.
- A control point pulls the curve toward it; it is not usually a point the robot
  passes through.
- Path geometry controls where the robot moves.
- [Heading interpolation](https://pedropathing.com/docs/pathing/reference/interpolation)
  controls where the robot faces.
- Pedro headings use radians. Use `Math.toRadians()` when thinking in degrees.

## Build a path with a turn

Keep the same OpMode lifecycle. Replace the poses and `buildPath()` method with
the following three-segment path:

```java
private final Pose startPose =
        new Pose(24, 24, Math.toRadians(0));

private final Pose straightEnd =
        new Pose(60, 24, Math.toRadians(0));

private final Pose turnControl =
        new Pose(84, 24);

private final Pose turnEnd =
        new Pose(84, 48, Math.toRadians(90));

private final Pose finishPose =
        new Pose(84, 84, Math.toRadians(90));

private void buildPath() {
    path = follower.pathBuilder()
            .addPath(new BezierLine(startPose, straightEnd))
            .setConstantHeadingInterpolation(startPose.getHeading())

            .addPath(new BezierCurve(
                    straightEnd,
                    turnControl,
                    turnEnd))
            .setLinearHeadingInterpolation(
                    straightEnd.getHeading(),
                    turnEnd.getHeading())

            .addPath(new BezierLine(turnEnd, finishPose))
            .setConstantHeadingInterpolation(finishPose.getHeading())

            .build();
}
```

Add the `BezierCurve` import:

```java
import com.pedropathing.geometry.BezierCurve;
```

This path should:

1. travel east while facing east;
2. curve around the corner while turning from 0 to 90 degrees; and
3. travel north while facing north.

Each heading interpolation applies to the path immediately before it.

- [ ] The robot follows all three segments continuously.
- [ ] The robot turns smoothly during the curve.
- [ ] The robot finishes near `finishPose` facing 90 degrees.
- [ ] The path works repeatedly from the same starting position.
- [ ] Driver Station Stop works while the robot is moving.

## Troubleshooting

| Symptom | First things to check |
|---|---|
| Robot travels in the wrong direction | Pose coordinates and Lesson 4.2 localization |
| Robot turns before it begins moving | Starting heading does not match the path's constant heading |
| Robot faces the wrong direction | Degrees were used instead of radians, or the wrong heading interpolation was selected |
| Curve bends the wrong way | Move the control point to the other side of the start/end line |
| Curve is too sharp | Move the control point farther away to create a larger turn radius |
| Robot cuts inside the expected turn | Remember that a control point shapes the curve; it is not a waypoint |
| Robot jerks at a segment transition | Check that adjacent segment endpoints match and the curve joins them smoothly |
| Path keeps restarting | `followPath()` is being called inside the active loop |
| Robot does not move | Verify `followPath()` is called and `follower.update()` runs continuously |
| Robot reaches the end but stays busy | Check final pose accuracy and tuning before loosening path-completion constraints |
| Entire path is offset | Physical starting position does not match `setStartingPose()` |

## You are done with this section when

- [ ] The straight path works consistently.
- [ ] The three-segment turning path works consistently.
- [ ] You can explain every pose and control point.
- [ ] You understand that movement geometry and robot heading are independent.
- [ ] The working paths are committed and pushed.

Continue to [4.5: Build a Second Path with the Pedro Visualizer](../05-visualizer-path/README.md).
