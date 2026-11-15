#!/usr/bin/env bash
# Run the test suite. Requires ./scripts/build.sh first.
set -euo pipefail
cd "$(dirname "$0")/.."
ctest --test-dir build --output-on-failure
