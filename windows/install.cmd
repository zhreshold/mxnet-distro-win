REM "Install necessary packages/softwares"

REM chocolatey packages
REM choco install -y pandoc
REM pandoc --version

REM pip install
call %PIP_EXE% install pypandoc nose wheel
REM call %PYTHON_EXE% -c "import pypandoc"
SET NOSE_EXE=C:\%PYTHON%\Scripts\nosetests
REM call %NOSE_EXE% --version

REM "CUDA installation"
echo.%mxnet_variant% | findstr /C:"CU80">nul && (
  echo "Installing CUDA 8.0"
  echo "Dummy install"
  SET USE_CUDA=1
  SET USE_CUDNN=1
) || (
  echo "Not a CUDA 8.0 build."
)

echo.%mxnet_variant% | findstr /C:"CU75">nul && (
  echo "Installing CUDA 7.5"
  echo "Dummy install"
  SET USE_CUDA=1
  SET USE_CUDNN=1
) || (
  echo "Not a CUDA 7.5 build."
)

REM "MKL"
echo.%mxnet_variant% | findstr /C:"MKL">nul && (
  echo "Installing MKL_DNN"
  echo "Dummy install"
) || (
  echo "Not a MKL build."
)

echo "end of install"
