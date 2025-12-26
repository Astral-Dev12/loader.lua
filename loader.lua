
-- ASTRAL STUDIOS - SIMPLE LOADER

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

local url = games[game.PlaceId]

if url then
    loadstring(game:HttpGet(url))()
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Astral Studios",
        Text = "Game not supported",
        Duration = 5
    })
end
