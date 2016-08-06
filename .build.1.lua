
project "Armadillo"

    kind "Utility"

    files {        
        "include/**.hpp",
        "include/armadillo" 
    }

    zpm.export [[
        includedirs "include/"
    ]]

    if zpm.option( "Cpp11" ) == true then
        print("export c++11")
        zpm.export [[
            flags "C++11"
            defines {
                "ARMA_SURPRESS_CXX11_WARNING",
                "ARMA_USE_CXX11",
            }
        ]]
    else
        print("export c++11 failed")
        zpm.export [[
            defines "ARMA_DONT_USE_CXX11"
        ]]
    end