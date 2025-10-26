// Top-level build file for configuration common to all sub-projects/modules

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Only declare classpaths here, do NOT apply plugins in root
        classpath("com.android.tools.build:gradle:8.2.1")
        classpath("com.google.gms:google-services:4.3.15")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.10")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: Custom build directory configuration
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// ❌ NO plugins block here!
// ❌ Do not apply `com.android.application`, `kotlin-android`, or `google-services` here
