if game.PlaceId == 1537690962 then

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "MrPup Vicious",
    HidePremium = false,
    IntroEnabled = false,
    SaveConfig = true,
    ConfigFolder = "VicMrpup"
})

local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local WEBHOOK_URL = "https://discord.com/api/webhooks/1470184318507946065/gN0C-iwWuv9239zvreuAFg7vO70_Zxa__Qg4GFH0CIubYpJsTDpaE2EGJ-uVNA_nXz47"

local serverLink = ""
local servervictype = ""
local serverpollen = ""
local testField = ""
local serverlocate = ""
local serverID = game.JobId

local function sendMessage(pollen, victype, link)
    local data = {
        ["content"] = "Vic detected!\n" ..
            "Pollen: " .. pollen .. "\n" ..
            "Type: " .. victype .. "\n" ..
            "Server(Private): " .. link .. "\n" ..
            "Server ID: " .. serverID .. "\n"
    }
    local json = game:GetService("HttpService"):JSONEncode(data)
    local req = request or http_request or syn.request
    if req then
        req({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = json
        })
    end
end

local function getServerRegion()
    local response = game:HttpGet("https://ipapi.co/json/")
    local data = HttpService:JSONDecode(response)

    serverlocate = data.country_name .. " - " .. data.city
end

getServerRegion()

local function isNight()
    local hour = Lighting.ClockTime
    return hour >= 0 and hour < 8
end

local VicTab = Window:MakeTab({
    Name = "Vic",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

VicTab:AddTextbox({
    Name = "Server Link",
    Default = "",
    TextDisappear = false,
    Callback = function(value)
        serverLink = value
    end
})

VicTab:AddTextbox({
    Name = "test field",
    Default = "",
    TextDisappear = false,
    Callback = function(value)
        testField = value
    end
})

VicTab:AddLabel("Server: " .. serverlocate)


local function getFieldFromPosition(pos)
    for _, field in pairs(game.Workspace.FlowerZones:GetChildren()) do
        if field.Name:find("Field") or field.Name:find("Patch") or field.Name:find("Forest") then
            local size = field.Size
            local cf = field.CFrame

            local relative = cf:PointToObjectSpace(pos)

            if math.abs(relative.X) <= size.X/2
            and math.abs(relative.Z) <= size.Z/2 then
                return field.Name
            end
        end
    end
    return "Єто шо за поле нах"
end

local lastState = false

task.spawn(function()
    while true do
        local night = isNight()

        if night and not lastState then

            for _, v in pairs(game.Workspace.Monsters:GetChildren()) do
                if v:IsA("Model") then
                    local nameLower = v.Name:lower()
                    if nameLower:find("vicious") then

                        if nameLower:find("gifted") then
                            servervictype = "Gifted"
                        else
                            servervictype = "Normal"
                        end

                        local hrp = v:FindFirstChild("HumanoidRootPart")

                        if hrp then    
                            serverpollen = getFieldFromPosition(hrp.Position)
                        end

                        sendMessage(
                            serverpollen,
                            servervictype,
                            serverLink
                        )
                    end
                end
            end

            lastState = true

        elseif not night then
            lastState = false
        end

        task.wait(5)
    end
end)

getServerRegion()

local function testmessage()
    sendMessage(
        testField,
        "Gifted",
        serverLink
    ) 
end

VicTab:AddButton({
	Name = "test message",
	Callback = function()
      	testmessage()
  	end    
})

end

OrionLib:Init()
