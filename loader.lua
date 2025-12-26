-- ASTRAL STUDIOS - UNIVERSAL LOADER (ALL EXECUTORS)

-- Executor compatibility
local request = (syn and syn.request) or request or http_request or (http and http.request)
local httpget = game.HttpGet
local loadstr = loadstring or load

-- Games list
local games = {
    -- Murder Mystery 2
    [142823291] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/mm2.lua",
    
    -- 99 Nights
    [79546208627805] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/99nights.lua",
    
    -- Forge World 1
    [76558904092080] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua",
    
    -- Forge World 2
    [129009554587176] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua",
    
    -- Blox Fruits World 1
    [2753915549] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua",
    
    -- Blox Fruits World 2
    [79091703265657] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua",
    
    -- Blox Fruits World 3
    [100117331123089] = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
}

-- Get script URL
local url = games[game.PlaceId]

if not url then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Astral Studios",
            Text = "Game not supported",
            Duration = 5
        })
    end)
    return
end

-- Fetch script with fallback methods
local script_code
local success = false

-- Method 1: game:HttpGet (most common)
if not success then
    success = pcall(function()
        script_code = game:HttpGet(url, true)
    end)
end

-- Method 2: request function (for some executors)
if not success and request then
    success = pcall(function()
        local response = request({
            Url = url,
            Method = "GET"
        })
        if response.StatusCode == 200 then
            script_code = response.Body
        end
    end)
end

-- Check if we got the script
if not success or not script_code or script_code == "" then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Astral Studios",
            Text = "Failed to load script",
            Duration = 5
        })
    end)
    return
end

-- Load and execute with fallback
local func, err = loadstr(script_code)

if func then
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Astral Studios",
            Text = "Script loaded!",
            Duration = 3
        })
    end)
    
    local exec_success, exec_err = pcall(func)
    
    if not exec_success then
        warn("[Astral] Execution error:", exec_err)
    end
else
    warn("[Astral] Load error:", err)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Astral Studios",
            Text = "Script error",
            Duration = 5
        })
    end)
end
