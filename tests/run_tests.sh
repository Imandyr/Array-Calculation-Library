#!/bin/bash
# Builds the library and runs tests.

# The path to the test directory.
curr_dir="$(dirname "$0")"
export LD_LIBRARY_PATH="${curr_dir}/bin"

# Create the directory for binaries.
mkdir -p "${curr_dir}/bin"

# Build the libarrcalc.s as the shared library libarrcalc.so.
gcc "${curr_dir}/../libarrcalc.s" -pie -shared -o "${curr_dir}/bin/libarrcalc.so"

# Build the test program that uses the libarrcalc.so.
g++ "${curr_dir}/test_libarrcalc.cpp" -pie -rdynamic -L "${curr_dir}/bin" -larrcalc -Og -o "${curr_dir}/bin/test_libarrcalc"

# Run the test executable.
"${curr_dir}/bin/test_libarrcalc"

# Print the exit code.
echo "Exit code: ${?}"
