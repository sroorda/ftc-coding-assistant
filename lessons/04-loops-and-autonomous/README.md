# Lesson 4: Writing `for` and `while` Loops

Robot programs repeat work: read controls, update telemetry, follow a path, or
continue an action until a condition changes. Today you will learn two Java loop
structures and write one of each yourself.

## Your mission

| | |
|---|---|
| **Time** | 60–75 minutes |
| **Java focus** | `for`, `while`, counters, conditions, and updates |
| **FTC connection** | repetition, autonomous progress, and responsive robot code |
| **AI tutor** | explain loop behavior without writing the loop for you |

## Your goal

By the end of this lesson, you can:

- write a `for` loop when you know how many times work should repeat;
- write a `while` loop when repetition depends on a condition;
- identify what changes so each loop eventually stops; and
- explain the difference between blocking and non-blocking robot behavior.

## Get ready

Complete [Lesson 3](../03-decisions-and-deadbands/README.md), then open this file in
your local clone:

```text
lessons/04-loops-and-autonomous/src/org/ftc/training/lesson04/AutoSequence.java
```

The starter compiles, but the two repeated sequences are intentionally missing.
You will write them.

## Understand a `for` loop

Use a `for` loop when you know the number of repetitions before the loop begins.
A `for` loop puts three important parts in one header:

```java
for (int check = 1; check <= 3; check++) {
    System.out.println("Inspection " + check);
}
```

Read the header from left to right:

1. `int check = 1` — **initialize** the counter once before the loop begins.
2. `check <= 3` — **continue** while this condition is true.
3. `check++` — **update** the counter after each iteration.

The statements between `{` and `}` are the loop body. One trip through that body
is called an **iteration**.

## Student Activity 1 — Write a `for` loop

The first part of `AutoSequence.java` contains `totalSegments`. Beneath its TODO:

1. Write a `for` loop with a counter named `segment`.
2. Begin the counter at `1`.
3. Continue through `totalSegments`.
4. Increase the counter by one after every iteration.
5. In the loop body, print `Driving segment ` followed by the counter.

Before running, predict the complete output for this activity. You should expect
three numbered segment lines followed by `For-loop sequence complete`.

Run the lesson:

macOS or Linux:

```text
./scripts/run-lesson.sh 04
```

Windows:

```text
scripts\run-lesson.cmd 04
```

Compare the output with your prediction. Then change only `totalSegments` to `5`
and confirm that the loop follows the variable rather than a number hidden in its
header. Return it to `3` before continuing.

## Understand a `while` loop

Use a `while` loop when repetition should continue until a condition changes. You
may not know the number of repetitions when the program begins.

```java
int chargePercent = 0;

while (chargePercent < 100) {
    chargePercent = chargePercent + 25;
    System.out.println("Charge: " + chargePercent);
}
```

Before every iteration, Java checks `chargePercent < 100`. The loop body changes
`chargePercent`, so the condition eventually becomes false. If nothing relevant
changes inside a `while` loop, it may run forever.

## Student Activity 2 — Write a `while` loop

The second part of `AutoSequence.java` simulates distance reported during an
autonomous movement. Beneath its TODO:

1. Write a `while` loop that continues while `distanceTraveled` is less than
   `targetDistance`.
2. Inside the loop, add `distancePerUpdate` to `distanceTraveled`.
3. Print `Distance traveled: ` followed by the new distance.

Before running, predict:

- each distance the loop will print;
- how many iterations it will perform; and
- whether `Other robot work can run now` appears before, during, or after those
  distance lines.

Run the lesson and compare the output with all three predictions. Explain which
statement changes the loop condition and why the loop stops.

## Blocking and non-blocking robot thinking

In this desktop program, the `while` loop is **blocking**: `main` cannot continue
to `Other robot work can run now` until the loop finishes. That is acceptable for
small calculations, but long blocking actions are risky in robot code. While one
action owns the program, controls, localization, telemetry, stop checks, or another
mechanism may not get updated.

Non-blocking robot code advances an action a small amount during each pass through
the robot's main control loop, then allows other work to run. The idea looks like
this:

```java
if (distanceTraveled < targetDistance) {
    distanceTraveled = distanceTraveled + distancePerUpdate;
}

System.out.println("Update controls, telemetry, and other mechanisms");
```

The FTC runtime would call the surrounding control code repeatedly. The `if`
performs at most one movement update per pass instead of holding control in an
inner `while` loop. Later lessons will use methods, states, and actions to organize
this pattern; this lesson only asks you to recognize the difference.

## Ask your AI tutor

> I wrote the `for` and `while` loops in Lesson 4. Ask me to explain when each
> loop stops and which value changes. If I am wrong, give one hint. Do not write a
> replacement loop for me. Then ask me why the `while` activity is blocking.

## Check your work

You are finished when:

- your `for` loop prints segments `1` through `totalSegments`;
- changing `totalSegments` changes the number of iterations;
- your `while` loop prints `3`, `6`, `9`, and `12` as traveled distances;
- `Other robot work can run now` appears only after the `while` loop finishes;
- you can explain why both loops terminate; and
- you can describe when you would choose `for` instead of `while`.

Do not intentionally run an infinite loop on a shared computer.

## Connect it to FTC

A `for` loop is useful when an operation has a known count, such as processing four
wheel measurements. A `while` loop expresses condition-driven repetition, but a
long inner `while` loop can make a robot unresponsive. FTC control code generally
needs to keep cycling so it can update every active system and respond to stop
requests. You will apply that non-blocking idea to autonomous actions in later
levels.

## Continue

Continue to [Lesson 5: Methods, Classes, and Tests](../05-methods-classes-and-tests/README.md).
