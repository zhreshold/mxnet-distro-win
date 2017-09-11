REM "Init environment"

REM "32/64 bit visual studio"
IF %TARGET_ARCH% == 32 (
  echo "Setting build target 32bit"
  REM call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86
  set CMAKE_BUILD_PLATFORM="Visual Studio 14 2015"
  set PYTHON_DIR=C:\%PYTHON%
  set PYTHON_EXE=C:\%PYTHON%\python
  set PIP_EXE=C:\%PYTHON%\Scripts\pip
)
IF %TARGET_ARCH% == 64 (
  echo "Setting build target 64bit"
  REM call "C:\Program Files\Microsoft SDKs\Windows\v7.0\Bin\SetEnv.cmd" /x64
  REM call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86_amd64
  set CMAKE_BUILD_PLATFORM="Visual Studio 14 2015 Win64"
  set PYTHON_DIR=C:\%PYTHON%-x64
  set PYTHON_EXE=C:\%PYTHON%-x64\python
  set PIP_EXE=C:\%PYTHON%-x64\Scripts\pip
)

REM "Check python and pip"
call %PYTHON_EXE% --version
call %PIP_EXE% --version
REM "Check supported wheels"
call %PYTHON_EXE% -c "import pip; print(pip.pep425tags.get_supported())"

REM "Write secure password to pypirc"
echo [distutils] # this tells distutils what package indexes you can push to > %USERPROFILE%\.pypirc
echo index-servers = >> %USERPROFILE%\.pypirc
echo     pypi >> %USERPROFILE%\.pypirc
echo     pypitest >> %USERPROFILE%\.pypirc
echo     legacy >> %USERPROFILE%\.pypirc
echo   >> %USERPROFILE%\.pypirc
echo [pypi] >> %USERPROFILE%\.pypirc
echo repository: https://pypi.python.org/pypi >> %USERPROFILE%\.pypirc
echo username: %PYPI_USERNAME% >> %USERPROFILE%\.pypirc
echo password: %PYPI_PASSWORD% >> %USERPROFILE%\.pypirc
echo   >> %USERPROFILE%\.pypirc
echo [pypitest] >> %USERPROFILE%\.pypirc
echo repository: https://pypi.python.org/pypi >> %USERPROFILE%\.pypirc
echo username: %PYPI_USERNAME% >> %USERPROFILE%\.pypirc
echo password: %PYPI_PASSWORD% >> %USERPROFILE%\.pypirc
echo   >> %USERPROFILE%\.pypirc
echo [test] >> %USERPROFILE%\.pypirc
echo repository: https://pypi.python.org/pypi >> %USERPROFILE%\.pypirc
echo username: %PYPI_USERNAME% >> %USERPROFILE%\.pypirc
echo password: %PYPI_PASSWORD% >> %USERPROFILE%\.pypirc
echo   >> %USERPROFILE%\.pypirc
echo [server-login] >> %USERPROFILE%\.pypirc
echo repository: https://pypi.python.org/pypi >> %USERPROFILE%\.pypirc
echo username: %PYPI_USERNAME% >> %USERPROFILE%\.pypirc
echo password: %PYPI_PASSWORD% >> %USERPROFILE%\.pypirc
dir %USERPROFILE%
