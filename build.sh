#!/bin/bash
set -euo pipefail
LLVM_ROOT=$(dirname `realpath -L .`)
echo $LLVM_ROOT
LLVM_BUILD_DIR=${LLVM_ROOT}/build

CC=/usr/bin/clang-22
CXX=/usr/bin/clang++-22
BUILD_DIR="build"
BUILD_TYPE="Debug"

cmake -S . -B $BUILD_DIR -G "Ninja"               \
    -DLLVM_DIR=${LLVM_BUILD_DIR}/lib/cmake/llvm   \
    -DMLIR_DIR=${LLVM_BUILD_DIR}/lib/cmake/mlir   \
    -DMLIR_ENABLE_BINDINGS_PYTHON=ON \
    -DPython3_FIND_VIRTUALENV=FIRST \
    -DLLVM_ENABLE_LLD=On \
    -DLLVM_BUILD_LLVM_DYLIB=ON \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -Wno-dev \
    -DCMAKE_C_COMPILER=$CC                        \
    -DCMAKE_CXX_COMPILER=$CXX                     \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON            \
    -DCMAKE_VERBOSE_MAKEFILE=ON            \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    --debug-output 2>&1 | tee _cmake.config.log

#ninja -C build -d explain -v check-listproject 2>&1 | tee _cmake.build.log

    # -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld -Wl,--ld-path=$(command -v ld.lld-22)" \
    # -DCMAKE_SHARED_LINKER_FLAGS="-fuse-ld=lld -Wl,--ld-path=$(command -v ld.lld-22)" \
    # -DCMAKE_MODULE_LINKER_FLAGS="-fuse-ld=lld -Wl,--ld-path=$(command -v ld.lld-22)"
