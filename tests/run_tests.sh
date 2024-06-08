#!/bin/bash
# Builds the library and runs tests.

# The path to the test directory.
curr_dir="$(dirname "$0")"
export LD_LIBRARY_PATH="${curr_dir}"

# Build the libarrcalc.s as a shared library libarrcalc.so.
gcc "${curr_dir}/../libarrcalc.s" -pie -shared -o "${curr_dir}/libarrcalc.so"

# Build the test program that uses the libarrcalc.so.
g++ "${curr_dir}/test_libarrcalc.cpp" -pie -rdynamic -L "${curr_dir}" -larrcalc -o "${curr_dir}/test_libarrcalc"

# Run the test executable.
"${curr_dir}/test_libarrcalc"

# Print the exit code.
echo "Exit code: ${?}"
