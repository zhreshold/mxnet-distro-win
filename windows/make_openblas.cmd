@echo off
set OPENBLAS_VERSION=0.2.20
set OPENBLAS_URL="https://github.com/xianyi/OpenBLAS/archive/v%OPENBLAS_VERSION%.zip"

REM we use pre-built version of openblas for now
IF EXIST C:\deps\openblas\ GOTO SKIPFILE
cd C:\
mkdir deps
cd deps
REM powershell "& ""%APPVEYOR_BUILD_FOLDER%\windows\download_openblas.ps1"""
appveyor DownloadFile %OPENBLAS_URL% -FileName openblas.zip
7z x openblas.zip -y -oopenblas >NUL
cd openblas
make
dir
cd %APPVEYOR_BUILD_FOLDER%
:SKIPFILE
