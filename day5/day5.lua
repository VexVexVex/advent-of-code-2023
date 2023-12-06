local lineDelimiter = "[^\n]+"
local spaceDelimiter = "[^%s]+"

local function readFile(file)
    local inFile = io.open(file, "r")
    local input = inFile:read("*a")
    inFile:close()
    return input
end

local function splitString(str, del) -- String, Delimiter
    local t = {}
    for value in str:gmatch(del) do
        table.insert(t, value)
    end
    return t
end

local maps = {}
local steps = {}
local seeds = {}

local function getLocation(seed)
    for _, step in ipairs(steps) do
        for _, list in ipairs(maps[step]) do
            if seed >= list.source and seed < list.source + list.range then
                seed = seed - list.source + list.destination
                break
            end
        end
    end
    return seed
end

local function initMaps()
    local input = readFile("input.txt")
    local lines = splitString(input, lineDelimiter)
    local lineTable = {}
    local actualMap = ""
    seeds = splitString(lines[1], spaceDelimiter)
    for _, line in ipairs(lines) do
        lineTable = splitString(line, spaceDelimiter)
        if #lineTable == 2 then -- step
            actualMap = lineTable[1]
            maps[actualMap] = {}
            table.insert(steps, actualMap)
        elseif #lineTable == 3 then -- list
            table.insert(maps[actualMap], {
                source = tonumber(lineTable[2]), -- Source Range Start
                destination = tonumber(lineTable[1]), -- Destination Range Start
                range = tonumber(lineTable[3]) -- Range length
            })
        end
    end
end

local function answer1()
    local bestLocation = 999999999999
    local location = 0
    for i = 2, #seeds do
        location = getLocation(tonumber(seeds[i]))
        if bestLocation > location then
            bestLocation = location
        end
    end
    return bestLocation
end

local function answer2()
    local bestLocation = 999999999999
    local location = 0
    local i = 2
    local seed = 0
    local interval = 65536
    local actualSeed = 0
    local leftInterval = 0
    local rightInterval = 0
    local maxLength = 0
    while i < #seeds do
        interval = 262144 -- tested with 131072, 65536, 4096, 2048, 1024
        seed = tonumber(seeds[i])
        actualSeed = seed
        maxLength = seed + tonumber(seeds[i + 1])
        leftInterval = 0
        rightInterval = 0
        while true do
            if actualSeed >= maxLength then
                interval = math.floor(interval / 2)
                if interval == 0 or (leftInterval == 0 and rightInterval == 0) then
                    break
                end
                actualSeed = leftInterval
                maxLength = rightInterval
            else
                location = getLocation(actualSeed)
                if bestLocation > location then
                    bestLocation = location
                    leftInterval = actualSeed - interval
                    rightInterval = actualSeed
                end
                actualSeed = actualSeed + interval
            end

        end
        i = i + 2
    end
    return bestLocation
end

initMaps()
print("Part 1:", answer1())
print("Part 2:", answer2())
