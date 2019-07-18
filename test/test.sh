#!/bin/bash

try () {
  expected="$1"
  input="$2"
  actual=$( ./bin/sbas "$input" )

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual OK!"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

try 0 ./test/sample0.sbas
try 3 ./test/sample1.sbas
try "SyntaxError" ./test/sample2.sbas
try -9 ./test/sample3.sbas

echo "ALL TEST PASSED!!"
