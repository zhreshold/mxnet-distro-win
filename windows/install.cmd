REM "Install necessary packages/softwares"

REM chocolatey packages
REM choco install -y pandoc
REM pandoc --version

REM pip install
call %PIP_EXE% install pypandoc nose wheel
REM call %PYTHON_EXE% -c "import pypandoc"
SET NOSE_EXE=C:\%PYTHON%\Scripts\nosetests
REM call %NOSE_EXE% --version
