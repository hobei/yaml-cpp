#!/usr/bin/env bash
# Configure and build yaml-cpp and its tests in ./build (Debug + ASan/UBSan by default).
# Set SANITIZE=OFF to build without sanitizers.
set -euo pipefail
cd "$(dirname "$0")/.."
flags=""
if [[ "${SANITIZE:-ON}" == "ON" ]]; then
  flags="-fsanitize=address,undefined -fno-omit-frame-pointer"
fi
cmake -S . -B build \
  -DCMAKE_BUILD_TYPE="${BUILD_TYPE:-Debug}" \
  -DYAML_CPP_BUILD_TESTS=ON \
  -DYAML_CPP_BUILD_TOOLS=OFF \
  -DYAML_CPP_FORMAT_SOURCE=OFF \
  -DCMAKE_CXX_FLAGS="$flags" \
  -DCMAKE_EXE_LINKER_FLAGS="$flags" \
  -DCMAKE_SHARED_LINKER_FLAGS="$flags"
cmake --build build --parallel
