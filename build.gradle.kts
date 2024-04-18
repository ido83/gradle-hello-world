import com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar

plugins {
    kotlin("jvm") version "1.6.20"
    id("application")
    id("java")
    id("idea")
    id("org.graalvm.buildtools.native") version "0.9.11"
    id("com.github.johnrengelman.shadow") version "7.1.2"
}

version = "1.0.0"
group = "com.ido"
description = "HelloWorld"

application {
    mainClass.set("com.ido.HelloWorld")
}

repositories {
    mavenCentral()
}

tasks.withType<ShadowJar> {
    manifest {
        attributes("Main-Class" to "com.ido.HelloWorld")
    }
}

graalvmNative {
    binaries {
        named("main") {
            imageName.set("helloworld")
            mainClass.set("com.ido.HelloWorld")
            fallback.set(false)
            sharedLibrary.set(false)
            useFatJar.set(true)
            javaLauncher.set(javaToolchains.launcherFor {
                languageVersion.set(JavaLanguageVersion.of(17))
                vendor.set(JvmVendorSpec.matching("GraalVM Community"))
            })
        }
    }
}
