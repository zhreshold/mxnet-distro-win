@echo off
set OPENBLAS_VERSION=0.2.20
set OPENBLAS_URL="https://github.com/xianyi/OpenBLAS/archive/v%OPENBLAS_VERSION%.zip"

REM we use pre-built version of openblas for now
IF EXIST C:\deps\openblas\ GOTO SKIPFILE
cd C:\
mkdir deps
cd deps
powershell "& ""%APPVEYOR_BUILD_FOLDER%\windows\download_openblas.ps1"""
dir
cd %APPVEYOR_BUILD_FOLDER%
:SKIPFILE
