local hasMKL = zpm.has "Zefiros-Software/MKL"

project "Armadillo"

    kind "StaticLib"

    files {
        "include/**.hpp",
        "include/armadillo"
    }

    zpm.export(function()
            
        includedirs "include/"
        
        cppdialect "C++14"
        defines {
            "ARMA_DONT_PRINT_CXX11_WARNING",
            "ARMA_USE_CXX11",
        }
        
        if hasMKL then
            defines "ARMA_USE_MKL_ALLOC"
        else
            defines "ARMA_DONT_USE_BLAS"
        end

        filter "*Release"
            defines "ARMA_NO_DEBUG"

        filter {}
    end)

    if not zpm.uses "Zefiros-Software/MKL" then
        warningf("No BLAS implementation linked, not all features may work!")
    end
