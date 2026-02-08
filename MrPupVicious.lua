if game.PlaceId == 1537690962 then

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "MrPup Vicious", HidePremium = false, IntroEnabled = false, SaveConfig = true, ConfigFolder = "VicMrpup"})

function autoNight()
    local timeString = game.Lighting.TimeOfDay
    local hour = tonumber(string.sub(timeString, 1, 2))
    
    if hour >= 0 and hour < 8 then
        return true
    else
        return false
    end
end

local VicTab = Window:MakeTab({
	Name = "Vic",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local VicSection = VicTab:AddSection({
	Name = "NightDetect: " .. tostring(autoNight())
    task.wait(2)
})

end

OrionLib:Init()