@echo off
setlocal enabledelayedexpansion

REM set 3rd party libraries
set PATH=%PATH%;C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin
set BUILD_TARGET_PLATFORM="Visual Studio 15 2017 Win64"
set OpenCV_DIR=.\opencv\build\install
set PATH=%PATH%;C:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2017.4.210\windows\mkl

REM run cmake to generate solution
cmake -G %BUILD_TARGET_PLATFORM% ^
      -D USE_OPENCV=ON ^
      -D MKL_USE_STATIC_LIBS=ON ^
      -D USE_CUDA=OFF ..
