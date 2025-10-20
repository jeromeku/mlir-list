#!/bin/bash

set -euo pipefail

BUILD_DIR=$(realpath -L .)
MODULE_NAME=mlir_listproject
PYTHON_PACKAGE_DIR=${BUILD_DIR}/build/python_packages/listproject
PYTHONPATH=${PYTHON_PACKAGE_DIR}
SO_DIR=${PYTHON_PACKAGE_DIR}/${MODULE_NAME}/_mlir_libs
EXT_NAME="_listprojectDialectsNanobind"
CORE_LIB="libListProjectPythonCAPI.so"


nm -D --defined-only ${SO_DIR}/${CORE_LIB} | c++filt | grep libMLIRList  # adjust symbol name/prefix
#strings ${SO_DIR}/${CORE_LIB} | grep -E 'List|Dialect|register'

readelf -dC ${SO_DIR}/${CORE_LIB}
# readelf -d ${SO_DIR}/${EXT_NAME}*.so