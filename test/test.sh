#!/bin/bash

try () {
  expected="$1"
  input="$2"
  actual=$( ./bin/sbas "$input" )

    echo "$input"
    cat $input
  if [ "$actual" = "$expected" ]; then
    echo "=> $actual OK!"
  else
    echo "=> $expected expected, but got $actual ERROR!"
    exit 1
  fi
}

try 0 ./test/sample0.sbas
try 3 ./test/sample1.sbas
try "Syntax error" ./test/sample2.sbas
try -9 ./test/sample3.sbas
try 5.5 ./test/sample4.sbas
try 524287 ./test/sample5.sbas
try "Overflow" ./test/sample6.sbas

echo "ALL TEST PASSED!!"
