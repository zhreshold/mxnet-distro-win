REM "Init environment"

REM "32/64 bit visual studio"
IF %TARGET_ARCH% == 32 (
  echo "Setting build target 32bit"
  call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86
  set CMAKE_BUILD_PLATFORM="Visual Studio 12 2013"
  set PYTHON_EXE=C:\%PYTHON%\python
  set PIP_EXE=C:\%PYTHON%\Scripts\pip
)
IF %TARGET_ARCH% == 64 (
  echo "Setting build target 64bit"
  call "C:\Program Files\Microsoft SDKs\Windows\v7.0\Bin\SetEnv.cmd" /x64
  call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86_amd64
  set CMAKE_BUILD_PLATFORM="Visual Studio 12 2013 Win64"
  set PYTHON_EXE=C:\%PYTHON%-x64\python
  set PIP_EXE=C:\%PYTHON%-x64\Scripts\pip
)

REM "Check python and pip"
call %PYTHON_EXE% --version
call %PIP_EXE% --version
REM "Check supported wheels"
call %PYTHON_EXE% -c "import pip; print(pip.pep425tags.get_supported())"
