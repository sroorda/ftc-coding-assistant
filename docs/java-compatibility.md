# Java and FTC SDK Compatibility

Two Java versions matter, and they serve different purposes.

## Required installation: JDK 17 or newer

Use **JDK 17 as the minimum installed JDK** for this course. FTC SDK 11.2 uses
Android Gradle Plugin 8.13.2, and Android's compatibility table specifies JDK 17 as
the minimum for AGP 8.13. FTC 11.2 also uses Gradle 9.1, whose daemon requires Java
17 or newer.

Installing JDK 17 prepares the computer for both these plain-Java lessons and the
later transition to the FTC Android Studio project. Android Studio may bundle a
newer JDK; that is also acceptable when the FTC project selects it correctly.

## Student code target: Java 8

The FTC Robot Controller project keeps `sourceCompatibility` and
`targetCompatibility` at Java 8 because OnBot Java supports Java 8. This means a
newer JDK runs the tools, but TeamCode should not depend on newer Java language
features or JDK APIs.

The lesson runners therefore invoke `javac --release 8`. A student who accidentally
uses a newer feature, such as a record or text block, receives a compiler error
before carrying that code into the robot project.

## Verified course boundary

All starter sources compile using the Java 8 release target. Some could compile on
older Java versions, but those versions are not the course minimum because they do
not satisfy the current FTC Android build-tool requirement.

## Authoritative references

- [FTC Robot Controller repository and 11.2 requirements](https://github.com/FIRST-Tech-Challenge/FtcRobotController)
- [Current FTC Java 8 compatibility setting](https://github.com/FIRST-Tech-Challenge/FtcRobotController/blob/master/build.common.gradle)
- [Android Gradle Plugin 8.13 compatibility](https://developer.android.com/build/releases/agp-8-13-0-release-notes)
- [Gradle 9 Java runtime requirement](https://docs.gradle.org/9.1.0/userguide/upgrading_major_version_9.html#minimum_daemon_jvm_version)
