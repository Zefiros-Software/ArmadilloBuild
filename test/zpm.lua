
workspace "Armadillo"
    configurations { "Test" }
    architecture "x86"
    startproject "Armadillo"

    project "Armadillo"
        kind "ConsoleApp"
        files "main.cpp"

        zpm.uses {
            "Zefiros-Software/GoogleTest",
            "Zefiros-Software/Armadillo"
        }