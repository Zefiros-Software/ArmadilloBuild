-- [[
-- @cond ___LICENSE___
--
-- Copyright (c) 2016-2018 Zefiros Software.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
-- @endcond
-- ]]
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
                local includes = path.join(icpp, "mkl/include/")
                defines "ARMA_USE_MKL_ALLOC"
                includedirs(includes)
                
                local mkl = path.join(icpp, "mkl/lib/intel64/")
                filter "architecture:not x86"
                    links {            
                        mkl .. "/mkl_blas95_lp64.lib",
                        mkl .. "/mkl_core.lib",
                        mkl .. "/mkl_intel_lp64.lib",
                        mkl .. "/mkl_lapack95_lp64.lib",
                        mkl .. "/mkl_sequential.lib"
                        --mkl .. "/mkl_tbb_thread.lib"
                    }                 

                local mkl = path.join(icpp, "mkl/lib/ia32/")
                filter "architecture:x86"
                    links {            
                        mkl .. "/mkl_blas95.lib",
                        mkl .. "/mkl_core.lib",
                        mkl .. "/mkl_intel_c.lib",
                        mkl .. "/mkl_lapack95.lib",
                        mkl .. "/mkl_sequential.lib"
                        --mkl .. "/mkl_tbb_thread.lib"
                    }

                filter "*Release"
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
