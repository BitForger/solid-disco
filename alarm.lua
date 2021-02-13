local modem
local rsSides = {"front", "back", "left", "right"}
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

local function activate_alarms(  )
    for _, side in pairs(rsSides) do
        redstone.setOutput(side, true)
    end
end

local function stop_alarms(  )
    for _, side in pairs(rsSides) do
        redstone.setOutput(side, false);
    end
end

local function startup()
    modem.open(52)
    while true do
        local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
        if message == "alarm" then
            activate_alarms()
        end
        if message == 'stop' then
            stop_alarms()
        end
    end
end

startup()