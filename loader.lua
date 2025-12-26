-- ============================================================================
-- PLACEID TRACKER - Tracks ALL PlaceIds you visit
-- ============================================================================

-- Storage for all PlaceIds
if not getgenv().AllPlaceIds then
    getgenv().AllPlaceIds = {}
end

local CurrentPlaceId = game.PlaceId
local CurrentGameId = game.GameId

-- Add current PlaceId to list
if not table.find(getgenv().AllPlaceIds, CurrentPlaceId) then
    table.insert(getgenv().AllPlaceIds, CurrentPlaceId)
end

-- Function to copy all PlaceIds
local function CopyAllPlaceIds()
    local placeIdString = "["
    for i, id in ipairs(getgenv().AllPlaceIds) do
        placeIdString = placeIdString .. id
        if i < #getgenv().AllPlaceIds then
            placeIdString = placeIdString .. ", "
        end
    end
    placeIdString = placeIdString .. "]"
    
    if setclipboard then
        setclipboard(placeIdString)
    end
    return placeIdString
end

-- Print current info
print("=" .. string.rep("=", 70))
print("PLACEID TRACKER")
print("=" .. string.rep("=", 70))
print("Current PlaceId: " .. CurrentPlaceId)
print("Current GameId: " .. CurrentGameId)
print("Game Name: " .. game:GetService("MarketplaceService"):GetProductInfo(CurrentPlaceId).Name)
print("")
print("ALL PlaceIds visited this session:")
for i, id in ipairs(getgenv().AllPlaceIds) do
    print(i .. ". " .. id)
end
print("=" .. string.rep("=", 70))

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "PlaceIdTracker"

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 400)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Title.Text = "PLACEID TRACKER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Current PlaceId
local CurrentLabel = Instance.new("TextLabel")
CurrentLabel.Size = UDim2.new(1, -20, 0, 30)
CurrentLabel.Position = UDim2.new(0, 10, 0, 55)
CurrentLabel.BackgroundTransparency = 1
CurrentLabel.Text = "Current PlaceId: " .. CurrentPlaceId
CurrentLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
CurrentLabel.TextSize = 16
CurrentLabel.Font = Enum.Font.GothamBold
CurrentLabel.TextXAlignment = Enum.TextXAlignment.Left
CurrentLabel.Parent = MainFrame

-- GameId
local GameIdLabel = Instance.new("TextLabel")
GameIdLabel.Size = UDim2.new(1, -20, 0, 25)
GameIdLabel.Position = UDim2.new(0, 10, 0, 85)
GameIdLabel.BackgroundTransparency = 1
GameIdLabel.Text = "GameId: " .. CurrentGameId
GameIdLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
GameIdLabel.TextSize = 14
GameIdLabel.Font = Enum.Font.Gotham
GameIdLabel.TextXAlignment = Enum.TextXAlignment.Left
GameIdLabel.Parent = MainFrame

-- Separator
local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, -20, 0, 2)
Line.Position = UDim2.new(0, 10, 0, 115)
Line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- Label for all PlaceIds
local AllLabel = Instance.new("TextLabel")
AllLabel.Size = UDim2.new(1, -20, 0, 25)
AllLabel.Position = UDim2.new(0, 10, 0, 125)
AllLabel.BackgroundTransparency = 1
AllLabel.Text = "All PlaceIds Visited (" .. #getgenv().AllPlaceIds .. "):"
AllLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
AllLabel.TextSize = 16
AllLabel.Font = Enum.Font.GothamBold
AllLabel.TextXAlignment = Enum.TextXAlignment.Left
AllLabel.Parent = MainFrame

-- Scrolling frame for PlaceIds
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0, 150)
ScrollFrame.Position = UDim2.new(0, 10, 0, 155)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScrollFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
ScrollFrame.BorderSizePixel = 1
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.Parent = MainFrame

local function UpdateList()
    -- Clear existing
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    -- Add all PlaceIds
    for i, id in ipairs(getgenv().AllPlaceIds) do
        local PlaceLabel = Instance.new("TextLabel")
        PlaceLabel.Size = UDim2.new(1, -10, 0, 25)
        PlaceLabel.Position = UDim2.new(0, 5, 0, (i - 1) * 27)
        PlaceLabel.BackgroundColor3 = i % 2 == 0 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(35, 35, 35)
        PlaceLabel.Text = i .. ". " .. id .. (id == CurrentPlaceId and " (CURRENT)" or "")
        PlaceLabel.TextColor3 = id == CurrentPlaceId and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
        PlaceLabel.TextSize = 14
        PlaceLabel.Font = Enum.Font.Gotham
        PlaceLabel.TextXAlignment = Enum.TextXAlignment.Left
        PlaceLabel.Parent = ScrollFrame
    end
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #getgenv().AllPlaceIds * 27)
    AllLabel.Text = "All PlaceIds Visited (" .. #getgenv().AllPlaceIds .. "):"
end

UpdateList()

-- Copy button
local CopyButton = Instance.new("TextButton")
CopyButton.Size = UDim2.new(0, 200, 0, 35)
CopyButton.Position = UDim2.new(0.5, -205, 1, -45)
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
CopyButton.Text = "📋 COPY ALL"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 16
CopyButton.Font = Enum.Font.GothamBold
CopyButton.Parent = MainFrame

CopyButton.MouseButton1Click:Connect(function()
    local copied = CopyAllPlaceIds()
    CopyButton.Text = "✅ COPIED!"
    CopyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    print("Copied to clipboard: " .. copied)
    task.wait(2)
    CopyButton.Text = "📋 COPY ALL"
    CopyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
end)

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 190, 0, 35)
CloseButton.Position = UDim2.new(0.5, 5, 1, -45)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Text = "CLOSE"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Refresh button (top right)
local RefreshButton = Instance.new("TextButton")
RefreshButton.Size = UDim2.new(0, 80, 0, 30)
RefreshButton.Position = UDim2.new(1, -90, 0, 7.5)
RefreshButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
RefreshButton.Text = "🔄 REFRESH"
RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshButton.TextSize = 12
RefreshButton.Font = Enum.Font.GothamBold
RefreshButton.Parent = MainFrame

RefreshButton.MouseButton1Click:Connect(function()
    -- Add current PlaceId if new
    if not table.find(getgenv().AllPlaceIds, game.PlaceId) then
        table.insert(getgenv().AllPlaceIds, game.PlaceId)
        print("New PlaceId detected: " .. game.PlaceId)
    end
    UpdateList()
    CurrentLabel.Text = "Current PlaceId: " .. game.PlaceId
    RefreshButton.Text = "✅"
    task.wait(1)
    RefreshButton.Text = "🔄 REFRESH"
end)

-- Make draggable
local dragging
local dragInput
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "PlaceId Tracker",
    Text = "Tracking PlaceIds! Teleport to all worlds then click COPY ALL",
    Duration = 5
})

print("✅ PlaceId Tracker loaded!")
print("🔄 Teleport to different worlds/areas")
print("📋 Click COPY ALL when done to get all PlaceIds!")
