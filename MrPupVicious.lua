if game.PlaceId == 1537690962 then

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "MrPup Vicious", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

else
    return
end

OrionLib:Init()