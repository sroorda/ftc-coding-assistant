package org.ftc.training.lesson03;

public class JoystickControl {
    public static void main(String[] args) {
        double joystick = 0.08;
        double motorPower;

        // The behavior does not yet match the 0.10 deadband requirement.
        if (Math.abs(joystick) < 0.01) {
            motorPower = 0.0;
        } else {
            motorPower = joystick;
        }

        System.out.println("Motor power: " + motorPower);
    }
}

