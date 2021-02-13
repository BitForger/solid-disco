local modem
local sendIndex = 0
local filePath = 'var/db.json'
local function find_modem()
    local sides = {"top", "front", "back", "left", "right", "bottom"}
    for _, side in pairs(sides) do
        if peripheral.isPresent(side) then
            -- Find first peripheral, wrap it, and break out
            modem = peripheral.wrap(side)
            break
        end
    end
end

local function create_db()
    if fs.exists(filePath) then
        return
    end

    local file = fs.open(filePath, 'w')
    file.write()
    file.close()
end

local function update_db(value)
    local file = fs.open(filePath, "w")
    file.write(value)
    file.close()
end

local function startup(  )
    find_modem()
    modem.open(52);
    while true do
        local cmd = read()
        if cmd == 'alarm' then
            modem.transmit(52, 52, 'alarm')
        end
    end
end

startup()