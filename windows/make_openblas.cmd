@echo off
REM we use pre-built version of openblas for now
cd C:\
mkdir deps
cd deps
powershell "& ""%APPVEYOR_BUILD_FOLDER%\windows\download_openblas.ps1"""
dir
cd %APPVEYOR_BUILD_FOLDER%
