pluginManagement {
    val flutterSdkPath =
        run {
            val localPropsFile = file("local.properties")
            val flutterFromLocal = if (localPropsFile.exists()) {
                val properties = java.util.Properties()
                localPropsFile.inputStream().use { properties.load(it) }
                properties.getProperty("flutter.sdk")
            } else null

            val flutterFromEnv = System.getenv("FLUTTER_SDK")

            val resolved = flutterFromLocal ?: flutterFromEnv
            require(resolved != null) {
                "flutter.sdk not set. Provide it in android/local.properties or set FLUTTER_SDK env var"
            }
            resolved
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.9.1" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
