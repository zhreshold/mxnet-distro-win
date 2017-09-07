git clone --recursive https://github.com/apache/incubator-mxnet mxnet-build
cd .\mxnet-build
FOR /F "delims=" %%i IN ('git rev-parse HEAD') DO echo %%i > python/mxnet/COMMIT_HASH
mkdir build
cd .\build
set OpenBLAS_HOME=c:\deps\openblas
set OpenCV_DIR=c:\deps\opencv\build\install
cmake .. -DOPENCV_DIR=%OpenCV_DIR% -DUSE_PROFILER=1 -DUSE_CUDA=0 -DUSE_CUDNN=0 -DUSE_NVRTC=0 -DUSE_OPENCV=1 -DUSE_OPENMP=1 -DUSE_BLAS=open -DUSE_LAPACK=1 -DUSE_DIST_KVSTORE=0 -DCMAKE_BUILD_TYPE=Release -G "%BUILD_TARGET_PLATFORM%"
