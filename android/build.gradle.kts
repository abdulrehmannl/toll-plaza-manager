allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// --- THIS IS THE FIXED SECTION (KOTLIN SYNTAX) ---
subprojects {
    configurations.all {
        resolutionStrategy {
            force("androidx.activity:activity:1.10.0")
            force("androidx.activity:activity-ktx:1.10.0")
        }
    }
}