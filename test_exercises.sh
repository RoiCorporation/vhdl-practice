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
    if [ $folder_name != "register_8_bit_exercise" ] && [ $folder_name != "d_flip_flop_exercise" ]; then
        nvc -a "$d"/*.vhd || { 
            echo "❌ Analysis failed in $folder_name"
            rm -rf work
            exit 1
        }
        shopt -s nullglob

        tbfiles=( "$d"/*_tb.vhd )
        if (( ${#tbfiles[@]} == 0 )); then
            echo "❌ No testbench found in $folder_name"
            rm -rf work
            exit 1
        fi

        tbname=$(basename "${tbfiles[0]}" .vhd)
        nvc -e "$tbname" || { 
            echo "❌ Elaboration failed for $tbname in $folder_name"
            rm -rf work
            exit 1 
        }
        nvc -r "$tbname" --exit-severity=error || {
            echo "❌ Simulation failed for $tbname in $folder_name"
            rm -rf work
            exit 1
        }
        echo "✅ $folder_name passed"
    fi
done

# Remove the work folder created on cleanup.
rm -rf work

echo "✅ All tests passed!"
