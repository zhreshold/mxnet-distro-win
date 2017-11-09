REM "Prepare build prerequisites"

REM "openblas"
call .\windows\make_openblas.cmd

REM "opencv"
call .\windows\make_opencv.cmd

git clone --recursive https://github.com/apache/incubator-mxnet mxnet-build %GIT_ADDITIONAL_FLAGS%
pushd .\mxnet-build
FOR /F "delims=" %%i IN ('git rev-parse HEAD') DO echo %%i > python/mxnet/COMMIT_HASH
mkdir build && pushd build
echo %OpenBLAS_HOME%
echo %OpenCV_DIR%
cmake .. ^
    -DUSE_PROFILER=1 ^
    -DUSE_SIGNAL_HANDLER = 1 ^
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
