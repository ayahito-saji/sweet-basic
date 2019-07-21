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

try "" ./test/sample0.sbas
try "" ./test/sample1.sbas
try "Syntax error" ./test/sample2.sbas
try "" ./test/sample3.sbas
try "" ./test/sample4.sbas
try "" ./test/sample5.sbas
#try "Overflow" ./test/sample6.sbas
try "" ./test/sample7.sbas

echo "ALL TEST PASSED!!"
