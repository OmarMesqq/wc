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

local function countOption(option, content)
    local countFunctions = {
        ["-c"] = countBytes,
        ["-l"] = countLines,
        ["-w"] = countWords,
        ["-m"] = countChars,
    }
    return countFunctions[option](content)
end

if filename then
    local f = assert(io.open(filename, "rb"))
    fileContent = f:read("*a")
    f:close()
else
    fileContent = io.stdin:read("*a")
end


if option and countOption(option, fileContent) then
    local count = countOption(option, fileContent)
    print(count .. " " .. filename)
else
    local lines = countLines(fileContent)
    local words = countWords(fileContent)
    local bytes = countBytes(fileContent)
    print(string.format("%7d %7d %7d", lines, words, bytes))
end
