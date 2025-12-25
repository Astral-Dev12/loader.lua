local PlaceId = game.PlaceId
local player = game:GetService("Players").LocalPlayer

-- notification
local function notify(title, msg, time)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = msg,
            Duration = time or 5
        })
    end)
end

-- print everything for debugging
local function log(msg)
    print("[Astral]", msg)
    warn("[Astral]", msg) -- shows in yellow
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

log("Loader started")
log("Current PlaceId: " .. tostring(PlaceId))

-- check if game is supported
local gameData = games[PlaceId]

if not gameData then
    notify("Astral Studios", "Game not supported", 5)
    log("UNSUPPORTED GAME - PlaceId: " .. tostring(PlaceId))
    return
end

local gameName = gameData[1]
local scriptUrl = gameData[2]

log("Game detected: " .. gameName)
log("Script URL: " .. scriptUrl)

notify("Astral Studios", "Loading " .. gameName .. "...", 3)

-- wait for character to load
if not player.Character then
    log("Waiting for character...")
    player.CharacterAdded:Wait()
end

task.wait(1) -- give it a second

-- load the script
log("Fetching script from GitHub...")

local worked, scriptCode = pcall(function()
    return game:HttpGet(scriptUrl, true)
end)

if not worked then
    notify("Astral Studios", "Failed to fetch script", 5)
    log("ERROR fetching: " .. tostring(scriptCode))
    return
end

log("Script fetched, length: " .. #scriptCode .. " characters")

if not scriptCode or scriptCode == "" or #scriptCode < 100 then
    notify("Astral Studios", "Script is empty or too short", 5)
    log("ERROR: Script content invalid")
    log("Content: " .. tostring(scriptCode))
    return
end

-- compile the script
log("Compiling script...")

local loadSuccess, loadedFunc = pcall(function()
    return loadstring(scriptCode)
end)

if not loadSuccess or not loadedFunc then
    notify("Astral Studios", "Failed to compile script", 5)
    log("ERROR compiling: " .. tostring(loadedFunc))
    return
end

log("Script compiled successfully")
log("Executing script...")

-- execute it
local execSuccess, execError = pcall(loadedFunc)

if execSuccess then
    notify("Astral Studios", gameName .. " loaded!", 3)
    log("SUCCESS: Script executed")
else
    notify("Astral Studios", "Script execution error", 5)
    log("ERROR executing: " .. tostring(execError))
end
