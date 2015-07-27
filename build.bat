@echo off

echo HS
ghc -O2 --make -no-hs-main -shared -o ffi.dll hs/ffi.hs
:: -dynamic

echo .NET
if not "%VS120COMNTOOLS%"=="" (
  set "VCVARSALL=%VS120COMNTOOLS%..\..\VC\vcvarsall.bat"
  goto HaveVCVARSALL
)
for /F "usebackq skip=2 tokens=1,2*" %%A IN (`REG QUERY "%HKLMSoftwareFor32BitApps%\Microsoft\VisualStudio\12.0\Setup\VC" /v ProductDir 2^>nul`) DO (
  set "VCVARSALL=%%Cvcvarsall.bat"
)
if not "%VCVARSALL%"=="" (
  goto HaveVCVARSALL
)
if exist "%ProgramFilesFor32BitApps%\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" (
  set "VCVARSALL=%ProgramFilesFor32BitApps%\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"
  goto HaveVCVARSALL
)

echo Visual Studio not found
goto End

:HaveVCVARSALL
call "%VCVARSALL%" %VCVARSALLBitsOption%
pushd .net
C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe -unsafe hs.cs
popd
set LD_LIBRARY_PATH=. && ".net/hs.exe"

echo RKT
raco exe tight.rkt

echo Done

:End
