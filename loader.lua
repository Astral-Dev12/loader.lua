-- ============================================================================
-- ASTRAL | STUDIOS - UNIVERSAL LOADER (FIXED)
-- ============================================================================

local PlaceId = game.PlaceId
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ============================================================================
-- NOTIFICATION SYSTEM
-- ============================================================================

local function notify(title, msg, duration)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = msg,
            Duration = duration or 5,
            Icon = "rbxassetid://6031075938"
        })
    end)
end

-- ============================================================================
-- LOGGING SYSTEM
-- ============================================================================

local function log(msg, isError)
    local prefix = "[Astral Studios]"
    if isError then
        warn(prefix, "❌", msg)
    else
        print(prefix, "✅", msg)
    end
end

-- ============================================================================
-- SUPPORTED GAMES
-- ============================================================================

local SupportedGames = {
    -- Murder Mystery 2
    [142823291] = {
        Name = "Murder Mystery 2",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/mm2.lua"
    },
    
    -- 99 Nights
    [79546208627805] = {
        Name = "99 Nights",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/99nights.lua"
    },
    
    -- Forge (World 1)
    [76558904092080] = {
        Name = "Forge",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua"
    },
    
    -- Forge (World 2)
    [129009554587176] = {
        Name = "Forge",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua"
    },
    
    -- Blox Fruits (Sea 1)
    [2753915549] = {
        Name = "Blox Fruits",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
    },
    
    -- Blox Fruits (Sea 2)
    [4442272183] = {
        Name = "Blox Fruits",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
    },
    
    -- Blox Fruits (Sea 3)
    [7449423635] = {
        Name = "Blox Fruits",
        URL = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
    }
}

-- ============================================================================
-- MAIN LOADER
-- ============================================================================

log("Loader started")
log("PlaceId: " .. tostring(PlaceId))

-- Check if game is supported
local gameData = SupportedGames[PlaceId]

if not gameData then
    notify("Astral Studios", "❌ Game not supported", 5)
    log("Unsupported game: " .. tostring(PlaceId), true)
    log("Supported games: MM2, 99 Nights, Forge, Blox Fruits", false)
    return
end

log("Game detected: " .. gameData.Name)
notify("Astral Studios", "Loading " .. gameData.Name .. "...", 3)

-- Wait for character
if not player.Character then
    log("Waiting for character to load...")
    local success = pcall(function()
        player.CharacterAdded:Wait()
    end)
    if not success then
        log("Character loading failed", true)
    end
end

-- Small delay for stability
task.wait(0.5)

-- Fetch script from GitHub
log("Fetching script from: " .. gameData.URL)

local fetchSuccess, scriptCode = pcall(function()
    return game:HttpGet(gameData.URL, true)
end)

if not fetchSuccess then
    notify("Astral Studios", "❌ Failed to fetch script", 5)
    log("Fetch error: " .. tostring(scriptCode), true)
    log("Check your internet connection or GitHub status", true)
    return
end

-- Validate script content
if not scriptCode or scriptCode == "" or #scriptCode < 100 then
    notify("Astral Studios", "❌ Invalid script content", 5)
    log("Script is empty or too short (" .. #scriptCode .. " chars)", true)
    return
end

log("Script fetched successfully (" .. #scriptCode .. " characters)")

-- Compile the script
log("Compiling script...")

local compileSuccess, compiledFunction = pcall(function()
    return loadstring(scriptCode)
end)

if not compileSuccess or type(compiledFunction) ~= "function" then
    notify("Astral Studios", "❌ Compilation failed", 5)
    log("Compile error: " .. tostring(compiledFunction), true)
    return
end

log("Script compiled successfully")

-- Execute the script
log("Executing " .. gameData.Name .. " script...")

local executeSuccess, executeError = pcall(compiledFunction)

if executeSuccess then
    notify("Astral Studios", "✅ " .. gameData.Name .. " loaded!", 3)
    log(gameData.Name .. " executed successfully")
else
    notify("Astral Studios", "❌ Execution error", 5)
    log("Execution error: " .. tostring(executeError), true)
end

-- ============================================================================
-- END OF LOADER
-- ============================================================================

log("Loader finished")
