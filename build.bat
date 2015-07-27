@echo off

echo HS
ghc -O2 --make -no-hs-main -shared -o ffi.dll hs/ffi.hs
:: -dynamic

echo .NET
rm -rf .net/hs.exe

pushd .net
set scs="C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe"
::%scs% -unsafe hs.cs"
set fsc="C:\Program Files (x86)\Microsoft SDKs\F#\3.1\Framework\v4.0\fsc.exe"
%fsc% hs.fs
popd

set LD_LIBRARY_PATH=. && ".net/hs.exe"

echo RKT
::raco exe tight.rkt

echo Done

:End
