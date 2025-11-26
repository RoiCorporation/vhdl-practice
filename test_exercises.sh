#!/bin/bash

set -e  # Stop if any command fails.

# Change current directory to the repository's root path.
cd "$(dirname "$0")"

# Remove the work folder if it was left over from previous tests.
rm -rf work

echo "🧪 Running tests for all exercises"

# Iterate through each exercise folder and test the design file
# inside using the existing testbench.
for d in */; do
    folder_name=${d%/}
    nvc -a "$d"/*.vhd
    tb=$(basename "$d")_tb

    # Find the testbench file (the one ending with _tb.vhd).
    tbfile=$(ls "$d"/*_tb.vhd | head -n 1)
    tbname=$(basename "$tbfile" .vhd)
    nvc -e "$tbname"
    nvc -r "$tbname" --exit-severity=error
    echo "✅ $folder_name passed"
done

# Remove the work folder created on cleanup.
rm -rf work

echo "✅ All tests passed!"
