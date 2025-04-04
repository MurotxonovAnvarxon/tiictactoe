import java.util.Properties
import java.io.FileInputStream

// key.properties faylini yuklash (Kotlin DSL uslubida)
val keystoreProperties = Properties().apply {
    val keystorePropertiesFile = rootProject.file("key.properties")
    if (keystorePropertiesFile.exists()) {
        load(FileInputStream(keystorePropertiesFile))
    }
}

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.triada.tiictactoe"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.triada.tiictactoe"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as? String ?: error("keyAlias topilmadi")
            keyPassword = keystoreProperties["keyPassword"] as? String ?: error("keyPassword topilmadi")
            storeFile = file(keystoreProperties["storeFile"] as? String ?: error("storeFile topilmadi"))
            storePassword = keystoreProperties["storePassword"] as? String ?: error("storePassword topilmadi")

        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            // Boshqa release build sozlamalari (minifyEnabled, shrinkResources, va hokazo) shu yerga qoʻshishingiz mumkin.
        }
    }
}

flutter {
    source = "../.."
}
