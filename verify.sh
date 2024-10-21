#!/bin/sh

compare_outputs() {
    metric=$1
    wc_command=$2
    lua_command=$3

    echo "$metric Count: ($wc_command)"
    echo "wc output:"
    wc_output=$(eval "$wc_command")
    echo "$wc_output"
    echo "-------------------------"
    echo "Lua script output:"
    lua_output=$(eval "$lua_command")
    echo "$lua_output"
    echo "-------------------------"

    if [ "$wc_output" = "$lua_output" ]; then
        echo -e "\e[32m$metric test passed\e[0m"
    else
        echo -e "\e[31m$metric test failed: wc output '$wc_output' does not match lua output '$lua_output'\e[0m"
        exit 1
    fi
}

# Line Count
compare_outputs "Line" "wc -l test.txt" "lua main.lua -l test.txt"

# Word Count
compare_outputs "Word" "wc -w test.txt" "lua main.lua -w test.txt"

# Byte Count
compare_outputs "Byte" "wc -c test.txt" "lua main.lua -c test.txt"

# Character Count
compare_outputs "Character" "wc -m test.txt" "lua main.lua -m test.txt"
