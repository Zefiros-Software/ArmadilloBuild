function getICCVersion()
    versions = {"ICPP_COMPILER17", "ICPP_COMPILER16", "ICPP_COMPILER15"}
    for _, version in pairs(versions) do
        if os.getenv(version) ~= "" then
            return os.getenv(version)
        end
    end
    
    return nil
end

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
    end)

    if zpm.configuration("lapack", "mkl"):lower() == "mkl" then

        zpm.uses "Zefiros-Software/MKL"
    end
