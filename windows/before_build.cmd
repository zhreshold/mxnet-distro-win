REM "Prepare build prerequisites"

REM "openblas"
call .\windows\make_openblas.cmd

REM "opencv"
REM call .\windows\make_opencv.cmd

git clone --recursive https://github.com/apache/incubator-mxnet mxnet-build
pushd .\mxnet-build
FOR /F "delims=" %%i IN ('git rev-parse HEAD') DO echo %%i > python/mxnet/COMMIT_HASH
mkdir build && pushd build
set OpenBLAS_HOME=C:\deps\openblas-install
set OpenCV_DIR=C:\deps\opencv-install
cmake .. ^
    -DUSE_PROFILER=1 ^
    -DUSE_CUDA=%USE_CUDA% ^
    -DUSE_CUDNN=%USE_CUDNN% ^
    -DUSE_NVRTC=0 ^
    -DUSE_OPENCV=1 ^
    -DUSE_OPENMP=1 ^
    -DUSE_BLAS=open ^
    -DUSE_LAPACK=1 ^
    -DUSE_DIST_KVSTORE=0 ^
    -DCMAKE_BUILD_TYPE=Release ^
    -G %CMAKE_BUILD_PLATFORM%
