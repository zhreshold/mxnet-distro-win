@echo off
REM we use pre-built version of openblas for now
cd C:\
mkdir deps
cd deps
powershell "& "".\download_openblas.ps1"""
cd %APPVEYOR_BUILD_FOLDER%
