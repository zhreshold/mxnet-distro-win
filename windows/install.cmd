REM "Install necessary packages/softwares"

REM chocolatey packages
choco install -y pandoc
pandoc --version

REM pip install
call %PIP_EXE% install pypandoc nose wheel twine
call %PYTHON_EXE% -c "import pypandoc"
SET NOSE_EXE=%PYTHON_DIR%\Scripts\nosetests
SET TWINE_EXE=%PYTHON_DIR%\Scripts\twine
dir %PYTHON_DIR%\Scripts\
call %NOSE_EXE% --version
call %TWINE_EXE% --version
