#!/bin/sh

echo "Line Count: (-l)"
echo "wc output"
wc -l test.txt
echo "-------------------------"
echo "Lua script output"
lua main.lua -l test.txt
echo "-------------------------"

echo "Word Count: (-w)"
echo "wc output"
wc -w test.txt
echo "-------------------------"
echo "Lua script output"
lua main.lua -w test.txt
echo "-------------------------"

echo "Byte Count: (-c)"
echo "wc output"
wc -c test.txt
echo "-------------------------"
echo "Lua script output"
lua main.lua -c test.txt
echo "-------------------------"

echo "Character Count: (-m)"
echo "wc output"
wc -m test.txt
echo "-------------------------"
echo "Lua script output"
lua main.lua -m test.txt
echo "-------------------------"

echo "Piping filename:" 
echo "wc output"
cat test.txt | wc
echo "-------------------------"
echo "Lua script output"
cat test.txt | lua main.lua 
echo "-------------------------"
