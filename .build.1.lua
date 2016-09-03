
project "Armadillo"

    kind "Utility"

    files {        
        "include/**.hpp",
        "include/armadillo" 
    }

    zpm.export [[
        includedirs "include/"
    ]]

    if zpm.option( "Cpp11" ) then
        zpm.export [[
            flags "C++11"
            defines {
                "ARMA_DONT_PRINT_CXX11_WARNING",
                "ARMA_USE_CXX11",
            }
        ]]
    else
        zpm.export [[
            defines "ARMA_DONT_USE_CXX11"
        ]]
    end

    if zpm.setting( "Lapack" ) == "Auto" then

        filter "architecture:x86_64"
            local mkl = os.getenv("ICPP_COMPILER16") .. "/mkl/lib/intel64/"

            zpm.export [[
                includedirs {
                    os.getenv("ICPP_COMPILER16") .. "/mkl/include"
                }	

                links {            
                    mkl .. "mkl_blas95_lp64.lib",
                    mkl .. "mkl_core.lib",
                    mkl .. "mkl_intel_lp64.lib",
                    mkl .. "mkl_lapack95_lp64.lib",
                    mkl .. "mkl_rt.lib",
                    mkl .. "mkl_sequential.lib",
                    mkl .. "mkl_tbb_thread.lib"
                }
            ]]

        filter "architecture:x86"
            local mkl = os.getenv("ICPP_COMPILER16") .. "/mkl/lib/ia32/"

            zpm.export [[
                includedirs {
                    os.getenv("ICPP_COMPILER16") .. "/mkl/include"
                }	

                links {            
                    mkl .. "mkl_blas95.lib",
                    mkl .. "mkl_core.lib",
                    mkl .. "mkl_intel_c.lib",
                    mkl .. "mkl_lapack95.lib",
                    mkl .. "mkl_rt.lib",
                    mkl .. "mkl_sequential.lib",
                    mkl .. "mkl_tbb_thread.lib"
                }
            ]]

        filter {}
    end