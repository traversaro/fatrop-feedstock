#!/bin/sh

rm -rf build
mkdir build
cd build

cmake ${CMAKE_ARGS} -GNinja .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_TESTING:BOOL=ON \
      -DBUILD_SHARED_LIBS:BOOL=ON \
      -DBUILD_WITH_BLASFEO:BOOL=OFF \
      -DMARCH_NATIVE:BOOL=OFF

cmake --build . --config Release
cmake --build . --config Release --target install

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
  ctest --output-on-failure -C Release
fi
