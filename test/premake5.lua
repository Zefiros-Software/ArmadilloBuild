
workspace "Armadillo"
   configurations { "Test" }

   startproject "Armadillo"

    project "Armadillo"
        kind "ConsoleApp"
        files "main.cpp"

        zpm.uses {
            "Zefiros-Software/GoogleTest",
            "Zefiros-Software/Armadillo"
        }

    project "ArmadilloExt"
        kind "ConsoleApp"
        files "main.cpp"

        zpm.uses {
            "Zefiros-Software/GoogleTest",
            "Zefiros-Software/ArmadilloExt"
        }