$env:MXNET_OPENBLAS_FILE=openblas.7z
$env:MXNET_OPENBLAS_DIR=openblas
$env:MXNET_OPENBLAS_PKG=https://github.com/hjk41/MiscFiles/blob/master/openblas.7z?raw=true
if (!(Test-Path ${env:MXNET_OPENBLAS_FILE})) {
    echo "Downloading openblas from ${env:MXNET_OPENBLAS_PKG} ..."
    appveyor DownloadFile "${env:MXNET_OPENBLAS_PKG}" -FileName ${env:MXNET_OPENBLAS_FILE} -Timeout 1200000
}
7z x %MXNET_OPENBLAS_FILE% -y -o"%APPVEYOR_BUILD_FOLDER%" >NUL
