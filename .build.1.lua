
project "Armadillo"

    kind "StaticLib"

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
        local icpp = os.getenv("ICPP_COMPILER16")

        if icpp ~= nil then

            zpm.export [[
                defines "ARMA_USE_MKL_ALLOC"
                includedirs {
                    "%ICPP_COMPILER16%/mkl/include"
                }	
            ]]        
            
            zpm.export(function()
                
                local mkl = "%ICPP_COMPILER16%/mkl/lib/intel64/"
                filter "architecture:x86_64"
                    links {            
                        mkl .. "mkl_blas95_lp64.lib",
                        mkl .. "mkl_core.lib",
                        mkl .. "mkl_intel_lp64.lib",
                        mkl .. "mkl_lapack95_lp64.lib",
                        mkl .. "mkl_rt.lib",
                        mkl .. "mkl_sequential.lib",
                        mkl .. "mkl_tbb_thread.lib"
                    }                    

                local mkl = "%ICPP_COMPILER16%/mkl/lib/ia32/"
                filter "architecture:x86"
                    links {            
                        mkl .. "mkl_blas95.lib",
                        mkl .. "mkl_core.lib",
                        mkl .. "mkl_intel_c.lib",
                        mkl .. "mkl_lapack95.lib",
                        mkl .. "mkl_rt.lib",
                        mkl .. "mkl_sequential.lib",
                        mkl .. "mkl_tbb_thread.lib"
                    }

                filter {}
                
            end)

        end
    end
