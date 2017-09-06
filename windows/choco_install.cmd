REM install dependencies through chocolatey
REM cmake (already installed)
REM choco install cmake --installargs 'ADD_CMAKE_TO_PATH=""User""' -y
cmake --version
REM pandoc
choco install pandoc
