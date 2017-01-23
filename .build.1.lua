function getICCVersion()
    versions = {"ICPP_COMPILER17", "ICPP_COMPILER16", "ICPP_COMPILER15"}
    for _, version in pairs(versions) do
        if os.getenv(version) then
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

        if zpm.option( "Cpp11" ) then
            flags "C++11"
            defines {
                "ARMA_DONT_PRINT_CXX11_WARNING",
                "ARMA_USE_CXX11",
            }
        else
            defines "ARMA_DONT_USE_CXX11"
        end
    end)

    if zpm.setting( "Lapack" ) == "Auto" then
        local icpp = getICCVersion()

        if icpp ~= nil then

            zpm.export(function()
                defines "ARMA_USE_MKL_ALLOC"
                includedirs {
                    path.join(icpp, "/mkl/include/")
                }	
            end)
            
            zpm.export(function()
                
                local mkl = path.join(icpp, "/mkl/lib/intel64/")
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

                local mkl = path.join(icpp, "/mkl/lib/ia32/")
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

                filter "configuration:*Release"
                    defines "ARMA_NO_DEBUG"

                filter {}
                
            end)

        else
            defines {
                "ARMA_USE_SUPERLU",
                "ARMA_USE_BLAS",
                "ARMA_USE_ARPACK"
            }
        end
    end
