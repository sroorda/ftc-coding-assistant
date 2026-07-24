package org.ftc.training.lesson06;

public class IntakeOutput {
    private final double motorPower;
    private final String status;

    public IntakeOutput(double motorPower, String status) {
        this.motorPower = motorPower;
        this.status = status;
    }

    public double getMotorPower() {
        return motorPower;
    }

    public String getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "power=" + motorPower + ", status=" + status;
    }
}

