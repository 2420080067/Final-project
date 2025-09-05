#!/usr/bin/env bash
# simple-interest.sh: Compute Simple Interest = (P * R * T) / 100
# Usage: ./simple-interest.sh <principal> <rate%> <time>

set -euo pipefail

if [[ ${#} -ne 3 ]]; then
  echo "Usage: $0 <principal> <rate%> <time>" >&2
  exit 1
fi

P="$1"
R="$2"
T="$3"

# Validate numeric inputs (integer or decimal)
re='^[0-9]+([.][0-9]+)?$'
for v in "$P" "$R" "$T"; do
  if ! [[ $v =~ $re ]]; then
    echo "Error: all inputs must be numeric (got '$v')." >&2
    exit 2
  fi
done

# Use bc for floating point calculation
SI=$(echo "scale=4; ($P * $R * $T) / 100" | bc -l)
echo "Principal: $P"
echo "Rate (%):  $R"
echo "Time:      $T"
echo "Simple Interest: $SI"
