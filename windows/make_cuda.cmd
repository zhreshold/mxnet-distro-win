@echo off
cd C:\
mkdir deps
cd deps
echo Downloading CUDA toolkit 8
appveyor DownloadFile  https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_windows-exe -FileName cuda_8.0.44_windows.exe
echo Installing CUDA toolkit 8
cuda_8.0.44_windows.exe -s compiler_8.0 ^
                           cublas_8.0 ^
                           cublas_dev_8.0 ^
                           cudart_8.0 ^
                           curand_8.0 ^
                           curand_dev_8.0
echo Downloading cuDNN
appveyor DownloadFile https://developer.nvidia.com/compute/machine-learning/cudnn/secure/v5.1/prod/8.0/cudnn-8.0-windows7-x64-v7.0-zip -FileName cudnn-8.0-windows7-x64-v5.1.zip
7z x cudnn-8.0-windows7-x64-v7.0.zip -ocudnn
dir cudnn
dir cudnn\cuda\bin
dir cudnn\cuda\lib
dir cudnn\cuda\include

dir .

dir "%ProgramFiles%"
dir "C:\Program Files"
dir "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA"
dir "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0"
dir "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v8.0\bin"

if NOT EXIST "%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v8.0\bin\cudart64_80.dll" (
echo "Failed to install CUDA"
exit /B 1
)

set PATH=%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v8.0\bin;%ProgramFiles%\NVIDIA GPU Computing Toolkit\CUDA\v8.0\libnvvp;%PATH%

nvcc -V
cd %APPVEYOR_BUILD_FOLDER%

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
