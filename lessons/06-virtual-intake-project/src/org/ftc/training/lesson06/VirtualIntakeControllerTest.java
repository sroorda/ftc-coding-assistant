package org.ftc.training.lesson06;

public class VirtualIntakeControllerTest {
    private static int passed = 0;
    private static int failed = 0;

    public static void main(String[] args) {
        VirtualIntakeController controller = new VirtualIntakeController();

        check("idle", 0.0, "Idle",
                controller.update(false, false, false, false));
        check("intake requested", 1.0, "Intaking",
                controller.update(true, false, false, false));
        check("object prevents intake", 0.0, "Object detected",
                controller.update(true, false, true, false));
        check("reverse wins over intake", -1.0, "Reversing",
                controller.update(true, true, false, false));
        check("emergency stop wins", 0.0, "Emergency stop",
                controller.update(true, true, false, true));

        System.out.println();
        System.out.println(passed + " passed, " + failed + " failed.");

        if (failed > 0) {
            throw new AssertionError(failed + " scenarios failed.");
        }
    }

    private static void check(
            String name,
            double expectedPower,
            String expectedStatus,
            IntakeOutput actual) {
        boolean powerMatches =
                Math.abs(expectedPower - actual.getMotorPower()) <= 0.000001;
        boolean statusMatches = expectedStatus.equals(actual.getStatus());

        if (!powerMatches || !statusMatches) {
            failed++;
            System.out.println(
                    "FAIL: " + name
                            + ": expected power=" + expectedPower
                            + ", status=" + expectedStatus
                            + " but was " + actual);
            return;
        }

        passed++;
        System.out.println("PASS: " + name);
    }
}
