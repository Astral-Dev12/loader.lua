local PlaceId = game.PlaceId
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- simple notification
local function notify(title, msg, time)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = msg,
        Duration = time or 5
    })
end

-- game list
local games = {
    [142823291] = {"Murder Mystery 2", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/mm2.lua"},
    [79546208627805] = {"99 Nights", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/99nights.lua"},
    [76558904092080] = {"Forge", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua"},
    [129009554587176] = {"Forge", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua"},
    [2753915549] = {"Blox Fruits", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"},
    [4442272183] = {"Blox Fruits", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"},
    [7449423635] = {"Blox Fruits", "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"}
}

-- check if we support this game
local gameData = games[PlaceId]

if not gameData then
    notify("Astral Studios", "Game not supported :(", 5)
    warn("[Astral] Unsupported PlaceId:", PlaceId)
    return
end

local gameName = gameData[1]
local scriptUrl = gameData[2]

-- show loading message
notify("Astral Studios", "Loading " .. gameName .. "...", 3)
print("[Astral] Loading script for:", gameName)

-- try to load the script
task.wait(0.5) -- small delay so notification shows

local worked, err = pcall(function()
    local scriptCode = game:HttpGet(scriptUrl)
    
    if not scriptCode or scriptCode == "" then
        error("Script URL returned empty")
    end
    
    local loadedFunc, loadErr = loadstring(scriptCode)
    
    if not loadedFunc then
        error("Failed to compile: " .. tostring(loadErr))
    end
    
    -- run it
    loadedFunc()
end)

if worked then
    notify("Astral Studios", gameName .. " loaded!", 3)
    print("[Astral] Successfully loaded:", gameName)
else
    notify("Astral Studios", "Error loading script", 5)
    warn("[Astral] Load failed:", err)
end
