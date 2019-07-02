#!/bin/bash

try () {
  expected="$1"
  input="$2"
  actual=$( ./bin/sbas "$input" )

  if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
  else
    echo "$input => $expected expected, but got $actual"
    exit 1
  fi
}

try 1+4-5 ./test/sample0.sbas
try -1+7-3 ./test/sample1.sbas

echo "OK"
