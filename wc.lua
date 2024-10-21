-- Simulates wc -c flag (counts bytes)
local function countBytes(fileContent)
    return #fileContent
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

-- Simulates wc -m flag (counts characters)
local function countChars(s)
    local count = 0
    for _, _ in utf8.codes(s) do
        count = count + 1
    end
    return count
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
