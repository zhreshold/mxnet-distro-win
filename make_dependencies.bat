@echo off
setlocal enabledelayedexpansion

REM set path
set PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin
set BUILD_TARGET_PLATFORM="Visual Studio 15 2017 Win64"
set OPENCV_VERSION=3.3.0

REM build 3rd party dependencies
REM download opencv
set OPENCV_URL="https://github.com/opencv/opencv/archive/%OPENCV_VERSION%.zip"
REM powershell -Command "(New-Object Net.WebClient).DownloadFile('%OPENCV_URL%', 'opencv.zip')"
REM extract zip
REM powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('opencv.zip', 'opencv'); }"
cd opencv
mkdir build
cd build
set OPENCV_SOURCE_DIR=../opencv-%OPENCV_VERSION%
echo %OPENCV_SOURCE_DIR%
cmake ^
      -G %BUILD_TARGET_PLATFORM% ^
      -D BUILD_SHARED_LIBS=OFF ^
      -D BUILD
      -D CMAKE_BUILD_TYPE=RELEASE %OPENCV_SOURCE_DIR%
msbuild OpenCV.sln /t:build /p:Configuration=Release /p:Platform=x64 /fl /flp:logfile=OpenCVOutput.log;verbosity=diagnostic
cd ../..
