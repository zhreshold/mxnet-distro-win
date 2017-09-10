REM "Install necessary packages/softwares"

REM chocolatey packages
choco install -y pandoc
pandoc --version

REM pip install
call %PIP_EXE% install pypandoc nose wheel
call %PYTHON_EXE% -c "import pypandoc"
SET NOSE_EXE=%PYTHON_DIR%\Scripts\nosetests
call %NOSE_EXE% --version
