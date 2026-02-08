if game.PlaceId == 1537690962 then

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "MrPup Vicious", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

function autoNight()
    local timeString = game.Lighting.TimeOfDay
    local hour = tonumber(string.sub(timeString, 1, 2))
    
    if hour >= 0 and hour < 8 then
        return true
    else
        return false
    end
end

task.spawn(function()
    while true do
        TabNight.Name = "NightDetect: " .. tostring(autoNight())
        task.wait(2)
    end
end)

else
    return
end

OrionLib:Init()