# Connect Android Studio to the Control Hub

Use this guide only after the FTC project builds successfully without a connected
robot. An adult mentor must approve the wiring, power, expected motion, test area,
and stop procedure before deployment.

FIRST's maintained reference is
[Managing a Control Hub](https://ftc-docs.firstinspires.org/en/latest/programming_resources/shared/managing_control_hub/Managing-a-Control-Hub.html).
The steps below summarize the repeatable checks used by this course.

## Connect over the Program & Manage network

1. Turn on the Control Hub and wait for it to finish starting.
2. Connect the programming computer to the Control Hub's **Program & Manage**
   Wi-Fi network.
3. Open `http://192.168.43.1:8080` in a browser.
4. Continue only when the Robot Controller Connection Info page appears.

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

Seeing a device does not mean it is safe to deploy. Before pressing Run, state:

- which OpMode will be installed;
- what hardware could move;
- the maximum expected power, position, or duration;
- how the device will stop; and
- who will remove power if behavior is unexpected.

## Troubleshooting

| Observation | Check next |
|---|---|
| `192.168.43.1:8080` does not open | Verify the Control Hub is powered and the computer is connected to its Program & Manage network. Do not troubleshoot Android Studio yet. |
| `adb` is not recognized | Confirm Android SDK Platform Tools is installed and locate it through Android Studio's SDK settings. Ask a mentor before changing system paths. |
| `adb connect` fails | Recheck the browser connection page, then confirm the IP address and port exactly. |
| `adb devices` shows `offline` | Disconnect and reconnect the wireless ADB session. If it remains offline, restart the ADB server with mentor help. |
| More than one Android device appears | Select the Control Hub explicitly in Android Studio before running. |
| Gradle builds but installation fails | Stop and show the complete error to a mentor. An existing Robot Controller app may use a different signing key. Do not uninstall it without approval. |
| Driver Station disconnects during installation | A brief disconnect is expected while the Robot Controller app is replaced and restarted. Wait for it to reconnect. |
| Driver Station does not reconnect | Verify that the Robot Controller and Driver Station versions match and that the computer is still on the correct network. |
| The OpMode does not appear | Confirm the new build was installed, the class is in `TeamCode`, the OpMode annotation is present, and the class is not disabled. |

If the connection becomes confusing, capture the exact command and complete error
message, stop changing settings, and ask a mentor. Do not use forceful reset,
uninstall, firmware update, factory reset, or credential-changing procedures as
experiments.
