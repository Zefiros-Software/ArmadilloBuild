cd test/
zpm install-package --allow-install --allow-module  || exit /b 1
zpm vs2015 || exit /b 1

msbuild Armadillo.sln /property:Configuration=Test /property:Platform=Win32 || exit /b 1

.\bin\Test\Armadillo.exe || exit /b 1