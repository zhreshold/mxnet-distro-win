IF %TARGET_ARCH% == 32 (
  cmake --build . --config Release --target ALL_BUILD
)
IF %TARGET_ARCH% == 64 (
 C:\Program Files (x86)\Microsoft Visual Studio\2015\Community\MSBuild\14.0\Bin\amd64\MSBuild.exe" /m:2 /p:CL_MPCount=1 /p:Configuration=Release /p:Platform=x64 /p:PreferredToolArchitecture=x64 ALL_BUILD.vcxproj
)
