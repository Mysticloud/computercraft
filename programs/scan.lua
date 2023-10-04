local function load(name)
    local file = fs.open(name, "r")
    local data = file.readAll()
    file.close()
    return textutils.unserialise(data)
end

local function save(t, name)
    local file = fs.open(name, "w")
    file.write(textutils.serialise(t))
    file.close()
end

local function c(t, x)
    f = false
    for i, v in pairs(t) do
        if v == x then
            f = true
        end
    end
    return f
end

function len(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

local function compareBySubtableLength(vein1, vein2)
    return #vein1 > #vein2
end

local function short(ore)
    local shortName = ore:gsub(".*:", "")
    shortName = shortName:gsub("_ore$", "")
    shortName = shortName:gsub("deepslate_", ""):gsub("nether_", "")
    return string.sub(shortName, 1, 3)
end

local function direction(block)
    local dir = ""
    if block.z ~= 0 then
        if block.z > 0 then
            dir = dir .. block.z .. "S "
        else
            dir = dir .. math.abs(block.z) .. "N "
        end
    else
        dir = dir .. "0N "
    end
    if block.x ~= 0 then
        if block.x > 0 then
            dir = dir .. block.x .. "E "
        else
            dir = dir .. math.abs(block.x) .. "W "
        end
    else
        dir = dir .. "0E "
    end
    if block.y ~= 0 then
        if block.y > 0 then
            dir = dir .. block.y .. "U "
        else
            dir = dir .. math.abs(block.y) .. "D "
        end
    else
        dir = dir .. "0U "
    end
    return dir
end

local function isOreType(blockType)
    blockType = string.match(blockType, ":(.*)")
    for _, ore in ipairs(ores) do
        if ore == blockType then
            return true
        end
    end
    return false
end

local function areAdjacent(block1, block2)
    if block1.name ~= block2.name then
        return false
    end

    local dx = math.abs(block1.x - block2.x)
    local dy = math.abs(block1.y - block2.y)
    local dz = math.abs(block1.z - block2.z)
    return dx + dy + dz == 1
end

local function findConnectedComponent(block, visited, component)
    visited[block] = true
    table.insert(component, block)

    for _, neighbor in ipairs(blocks) do
        if not visited[neighbor] and areAdjacent(block, neighbor) then
            findConnectedComponent(neighbor, visited, component)
        end
    end
end

ores = {"diamond_ore", "deepslate_diamond_ore"}
if not fs.exists("ores") then save(ores, "ores") else ores = load("ores") end
if ores == nil then
    print("error in ores file")
    return
end

local geo = peripheral.find("geoScanner")
while true do
    term.clear()
    term.setCursorPos(1,1)
    local scan = geo.scan(8)
    if scan == nil then
        return
    end
    blocks = {}
    for _, block in ipairs(scan) do
        if(isOreType(block.name)) then
            table.insert(blocks, block)
        end
    end
    local veins = {}

    local visited = {}
    for _, block in ipairs(blocks) do
        block.tags = nil
        if not visited[block] then
            local component = {}
            findConnectedComponent(block, visited, component)
            table.insert(veins, component)
        end
    end

    --#save(veins, "veins")
    table.sort(veins, compareBySubtableLength)
    for _, b in ipairs(veins) do
        local size = len(b)
        if size < 10 then
            size = " " .. size
        end
        print(short(b[1].name), size, direction(b[1]))
    end
    sleep(3)
end