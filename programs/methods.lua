local expect, field = require("cc.expect").expect, require("cc.expect").field
local args = { ... }

--Print program specific Usage
local function printUsage(err)
    expect(1, err, "string", "nil")

    print("Usage:")
    print("methods <".. table.concat(rs.getSides(), ", ") ..">")

    if err then
        error(err, 3)
    end
end

--Custom function to Parse Arguments
local function parseArgs(arg1)
    expect(1, arg1, "string")
    local sides, side

    --Check if input side is a valid side
    sides = rs.getSides()
    for _, v in pairs(sides) do
        if arg1:lower() == v then
            side = v
        end
    end

    if side then
        return side
    else
        printUsage("'"..arg1.."' is not a valid side.")
    end
end

local function main()
    local side = parseArgs(args[1])

    local p = peripheral.wrap(side)
    name = peripheral.getName(p)
    methods = peripheral.getMethods(name)

    textutils.pagedTabulate(methods)
end

local function init()
    if type(args) == "table" and #args > 0 then
        main()
    else
        printUsage()
        return
    end
end



init()