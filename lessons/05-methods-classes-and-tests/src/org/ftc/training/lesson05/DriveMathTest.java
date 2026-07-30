package org.ftc.training.lesson05;

public class DriveMathTest {
    private static int passed = 0;
    private static int failed = 0;

    public static void main(String[] args) {
        check("below minimum", -1.0, DriveMath.limitPower(-1.4));
        check("negative in range", -0.4, DriveMath.limitPower(-0.4));
        check("zero", 0.0, DriveMath.limitPower(0.0));
        check("positive in range", 0.6, DriveMath.limitPower(0.6));
        check("above maximum", 1.0, DriveMath.limitPower(1.4));

        System.out.println();
        System.out.println(passed + " passed, " + failed + " failed.");

        if (failed > 0) {
            throw new AssertionError(failed + " checks failed.");
        }
    }

    private static void check(String name, double expected, double actual) {
        if (Math.abs(expected - actual) > 0.000001) {
            failed++;
            System.out.println(
                    "FAIL: " + name + ": expected " + expected + " but was " + actual);
            return;
        }

        passed++;
        System.out.println("PASS: " + name);
    }
}
