# Connect Android Studio to the Control Hub

Use this guide when the first Level 2 lesson directs you here, after your first
OpMode builds successfully without a connected robot. Do not complete this during
initial setup: writing code first makes the connection and deployment steps part
of a real development cycle.

Confirm that the test bench is wired, powered safely, clear of loose objects, and
positioned so you can stop it easily.

FIRST's maintained reference is
[Managing a Control Hub](https://ftc-docs.firstinspires.org/en/latest/programming_resources/shared/managing_control_hub/Managing-a-Control-Hub.html).
The steps below summarize the repeatable checks used by this course.

## Connect over the Program & Manage network

1. Turn on the Control Hub and wait for it to finish starting.
2. Connect the programming computer to the Control Hub's **Program & Manage**
   Wi-Fi network.
3. Open `http://192.168.43.1:8080` in a browser.
4. Continue when the Robot Controller Connection Info page appears.

The computer may temporarily lose normal internet access while connected to the
Control Hub. Do not store the Control Hub Wi-Fi password in Git, documentation,
source code, screenshots, or AI prompts.

## Connect Android Debug Bridge

Android Studio includes Android SDK Platform Tools, which contains `adb`. In the
Android Studio terminal, run:

```text
adb connect 192.168.43.1:5555
adb devices
```

The device list should contain `192.168.43.1:5555` with the state `device`.
Android Studio should then show the Control Hub as an available deployment target.

## Before pressing Run

Independently verify:

- you selected the intended OpMode;
- you know which hardware can move;
- the programmed power, position, or duration is reasonable;
- the test bench is clear; and
- you can stop the OpMode immediately if the behavior is unexpected.

When those checks are complete, run the code and observe what actually happens.

## Troubleshooting

| Observation | Check next |
|---|---|
| `192.168.43.1:8080` does not open | Verify the Control Hub is powered and the computer is connected to its Program & Manage network. Do not troubleshoot Android Studio yet. |
| `adb` is not recognized | Confirm Android SDK Platform Tools is installed and locate it through Android Studio's SDK settings. |
| `adb connect` fails | Recheck the browser connection page, then confirm the IP address and port exactly. |
| `adb devices` shows `offline` | Disconnect and reconnect the wireless ADB session. If it remains offline, restart the ADB server. |
| More than one Android device appears | Select the Control Hub explicitly in Android Studio before running. |
| Gradle builds but installation fails | Read the complete error before changing anything. An existing Robot Controller app may use a different signing key. Do not uninstall it as an experiment. |
| Driver Station disconnects during installation | A brief disconnect is expected while the Robot Controller app is replaced and restarted. Wait for it to reconnect. |
| Driver Station does not reconnect | Verify that the Robot Controller and Driver Station versions match and that the computer is still on the correct network. |
| The OpMode does not appear | Confirm the new build was installed, the class is in `TeamCode`, the OpMode annotation is present, and the class is not disabled. |

If the connection remains confusing, capture the exact command and complete error
message before asking for help. Do not use forceful reset, uninstall, firmware
update, factory reset, or credential-changing procedures as experiments.
