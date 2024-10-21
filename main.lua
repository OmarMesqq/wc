-- Simulates wc -c flag (counts bytes)
local function countBytes(fileContent)
    local count = 0
    for _ in string.gmatch(fileContent, ".") do
        count = count + 1
    end
    return count
end

-- Simulates wc -l flag (counts lines)
local function countLines(fileContent)
    local count = 0
    for _ in string.gmatch(fileContent, "[^\n]*\n?") do
        count = count + 1
    end
    return count
end

-- Simulates wc -w flag (counts words)
local function countWords(fileContent)
    local count = 0
    for _ in string.gmatch(fileContent, "%S+") do
        count = count + 1
    end
    return count
end

local function utf8charbytes(s, i)
    -- Lua counts bytes instead of chars by default
    -- Returns the number of bytes used by the UTF-8 character at byte i in s
    -- Also based on valid UTF-8 encoding
    local c = string.byte(s, i)

    if c > 0 and c <= 127 then
        -- UTF8-1
        return 1
    elseif c >= 194 and c <= 223 then
        -- UTF8-2
        return 2
    elseif c >= 224 and c <= 239 then
        -- UTF8-3
        return 3
    elseif c >= 240 and c <= 244 then
        -- UTF8-4
        return 4
    end
end

-- Simulates wc -m flag (counts characters)
local function countChars(s)
    local pos = 1
    local length = 0
    local strlen = string.len(s)

    while pos <= strlen do
        local bytes = utf8charbytes(s, pos)
        pos = pos + bytes
        length = length + 1
    end

    return length
end


-- Main loop
local option = arg[1]
local filename = arg[2]
local fileContent = ""

if filename then
    local f = assert(io.open(filename, "rb"))
    fileContent = f:read("*a")
    f:close()
else
    fileContent = io.stdin:read("*a")
end


if option == "-c" or option == "-l" or option == "-w" or option == "-m" then
    local count = 0
    if option == "-c" then
        count = countBytes(fileContent)
    elseif option == "-l" then
        count = countLines(fileContent)
    elseif option == "-w" then
        count = countWords(fileContent)
    elseif option == "-m" then
        count = countChars(fileContent)
    end
    print(count .. " " .. filename)
else    
    local count = 0
    local lines = countLines(fileContent)
    local words = countWords(fileContent)
    local bytes = countBytes(fileContent)
    print(string.format("%7d %7d %7d", lines, words, bytes))
end
