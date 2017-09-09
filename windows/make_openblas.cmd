@echo off
SET OPENBLAS_VERSION=0.2.20
SET OPENBLAS_FILE="%DEPENDENCIES_DIR%\openblas\openblas.zip"
SET OpenBLAS_HOME="%DEPENDENCIES_DIR%\openblas-install"
IF %TARGET_ARCH% == 32 (
  echo "Fetching 32 bit mingw openblas"
  SET OPENBLAS_URL="http://mxnet-files.s3.amazonaws.com/openblas/openblas-%OPENBLAS_VERSION%-x86-install.zip"
)
IF %TARGET_ARCH% == 64 (
  echo "Setting build target 64bit"
  SET OPENBLAS_URL="http://mxnet-files.s3.amazonaws.com/openblas/openblas-%OPENBLAS_VERSION%-x64-install.zip")
)

REM we use pre-built version of openblas for now due to performance issue
IF EXIST %OpenBLAS_HOME% {
  echo "Openblas exists, skip downloading..."
}
IF NOT EXIST %OpenBLAS_HOME% (
  echo "Downloading openblas from %OPENBLAS_URL%"
  IF NOT EXIST "%OPENBLAS_FILE%" (
    appveyor DownloadFile %OPENBLAS_URL% -FileName %OPENBLAS_FILE% -Timeout 1200000
  )
  7z x %OPENBLAS_FILE% -y -o%OpenBLAS_HOME%
)
dir %OpenBLAS_HOME%
