package org.ftc.training.lesson04;

public class AutoSequence {
    public static void main(String[] args) {
        // The requirement says three segments, but this condition has a boundary bug.
        for (int step = 1; step <= 4; step++) {
            System.out.println("Driving segment " + step);
        }

        System.out.println("Complete");
    }
}

