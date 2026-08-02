# Prepare Android Studio for FTC

FIRST maintains the installation and FTC SDK documentation. This course links to
those instructions instead of copying steps that can become outdated.

## Team-approved versions

An adult mentor must fill in these values before students begin:

```text
FTC SDK version: <FTC_SDK_VERSION>
Hardware-lab repository: <HARDWARE_LAB_REPOSITORY_URL>
```

Use the versions supplied by the mentor even if Android Studio offers a newer
Android Gradle Plugin, Gradle version, SDK component, or Java configuration.

## Install Android Studio

Follow FIRST's
[Android Studio Programming Tutorial](https://ftc-docs.firstinspires.org/en/latest/programming_resources/android_studio_java/Android-Studio-Tutorial.html)
through the Android Studio installation and required Android SDK preparation.

Read FIRST's
[Downloading the Android Studio Project Folder](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/downloading_as_project_folder/Downloading-the-Android-Studio-Project-Folder.html)
page for its explanation of importing and trusting an FTC project. Do not download
the ZIP for Level 2; you will clone the team hardware-lab repository instead.

## Open the team project

After following [Your Level 2 Git Workflow](level-2-git-workflow.md) to clone the
repository:

1. Start Android Studio.
2. Select **Open**.
3. Choose the cloned `ftc-hardware-lab` folder containing the Gradle project.
4. Trust the project when Android Studio asks.
5. Allow Gradle sync to finish before editing or running anything.
6. Build the project once without making changes.

Do not open only the `TeamCode` directory. Android Studio must open the complete
FTC project.

## Understand the project boundary

Student code belongs under the `TeamCode` module in the
`org.firstinspires.ftc.teamcode` package. Do not modify the `FtcRobotController`
module or its included sample files. FIRST's
[Creating and Running an OpMode](https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/creating_op_modes/Creating-and-Running-an-Op-Mode-%28Android-Studio%29.html)
page explains this module boundary and where the official samples live.

## Stop and ask a mentor when

- Gradle sync proposes changing project versions;
- Android Studio asks to upgrade the Android Gradle Plugin;
- the approved FTC SDK version does not match the project;
- a build error mentions signing, SDK components, Gradle, or Java compatibility;
- you are tempted to edit `FtcRobotController`; or
- Android Studio requests administrator access or an unfamiliar credential.

Continue to
[Connect Android Studio to the Control Hub](control-hub-connection.md) only with
an adult mentor and an approved test bench.
