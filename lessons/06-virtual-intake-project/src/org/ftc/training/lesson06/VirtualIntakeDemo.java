package org.ftc.training.lesson06;

public class VirtualIntakeDemo {
    public static void main(String[] args) {
        VirtualIntakeController controller = new VirtualIntakeController();

        show("idle", controller.update(false, false, false, false));
        show("intake requested", controller.update(true, false, false, false));
        show("object detected", controller.update(true, false, true, false));
        show("reverse wins", controller.update(true, true, false, false));
        show("emergency stop wins", controller.update(true, true, false, true));
    }

    private static void show(String scenario, IntakeOutput output) {
        System.out.println(scenario + ": " + output);
    }
}

