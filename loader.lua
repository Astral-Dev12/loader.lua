
local PlaceId = game.PlaceId
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Notification function
local function Notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- Game ID to Script URL mapping
local Games = {
    -- Murder Mystery 2
    [142823291] = {
        Name = "Murder Mystery 2",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/mm2.lua"
    },
    
    -- 99 Nights
    [79546208627805] = {
        Name = "99 Nights",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/99nights.lua"
    },
    
    -- Forge (wordl1)
    [76558904092080] = {
        Name = "Forge",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua"
    }

   -- Forge (wordl2)
    [129009554587176] = {
        Name = "Forge",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/forge.lua"
    }

    -- Blox Fruits - Sea 1 (First Sea)
    [2753915549] = {
        Name = "Blox Fruits",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
    },
    
    -- Blox Fruits - Sea 2 (Second Sea)
    [4442272183] = {
        Name = "Blox Fruits",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
    },
    
    -- Blox Fruits - Sea 3 (Third Sea)
    [7449423635] = {
        Name = "Blox Fruits",
        ScriptUrl = "https://raw.githubusercontent.com/Astral-Dev12/loader.lua/main/bloxfruits.lua"
    }
}

-- Check if current game is supported
if Games[PlaceId] then
    local gameInfo = Games[PlaceId]
    
    Notify("ASTRAL | STUDIOS", "Loading " .. gameInfo.Name .. " script...", 3)
    
   -- load the script
    local success, result = pcall(function()
        return loadstring(game:HttpGet(gameInfo.ScriptUrl))()
    end)
    
    if success then
        Notify("ASTRAL | STUDIOS", gameInfo.Name .. " script loaded!", 3)
    else
        Notify("ASTRAL | STUDIOS", "Failed to load script: " .. tostring(result), 5)
        warn("Astral Loader Error:", result)
    end
else
   
    Notify("ASTRAL | STUDIOS", "This game is not supported yet!", 5)
    warn("Astral Loader: Unsupported game - PlaceId:", PlaceId)
end
