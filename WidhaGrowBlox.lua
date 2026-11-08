
--==================================================
-- WIDHA GROWBLOX V2
-- Created by Widha Gaming
-- Modern Dark Blue GUI
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer

-- Remove old GUI
pcall(function()
    local parent = CoreGui
    if gethui then
        parent = gethui()
    end
    local old = parent:FindFirstChild("WidhaGrowBloxV2")
    if old then old:Destroy() end
end)

local GUI = Instance.new("ScreenGui")
GUI.Name = "WidhaGrowBloxV2"
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parent = CoreGui
pcall(function()
    if gethui then parent = gethui() end
end)
GUI.Parent = parent

local Blue = Color3.fromRGB(0, 115, 255)
local Dark = Color3.fromRGB(12, 19, 37)
local Panel = Color3.fromRGB(21, 31, 54)
local White = Color3.fromRGB(240, 245, 255)
local Green = Color3.fromRGB(25, 190, 110)
local Gray = Color3.fromRGB(65, 75, 95)

local enabled = {
    ["Auto Break"] = false,
    ["Auto Plant"] = false,
    ["Auto Harvest"] = false,
    ["Auto Clear"] = false
}

local speed = 1
local elapsed = 0

-- Main Window
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(340, 430)
Main.Position = UDim2.new(0.5, -170, 0.5, -215)
Main.BackgroundColor3 = Dark
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 14)

local Stroke = Instance.new("UIStroke")
Stroke.Color = Blue
Stroke.Thickness = 2
Stroke.Parent = Main

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 0, 48)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "👑 WIDHA GROWBLOX V2"
Title.TextColor3 = White
Title.TextSize = 19
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35, 35)
Close.Position = UDim2.new(1, -42, 0, 7)
Close.BackgroundColor3 = Color3.fromRGB(170, 45, 55)
Close.Text = "×"
Close.TextColor3 = White
Close.TextSize = 24
Close.Font = Enum.Font.GothamBold
Close.Parent = Main
Instance.new("UICorner", Close).CornerRadius =
    UDim.new(0, 8)

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, -20, 0, 25)
Subtitle.Position = UDim2.fromOffset(10, 48)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "AUTO FARM CONTROL PANEL"
Subtitle.TextColor3 = Color3.fromRGB(100, 175, 255)
Subtitle.Font = Enum.Font.GothamBold
Subtitle.TextSize = 12
Subtitle.Parent = Main

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -24, 0, 34)
Status.Position = UDim2.fromOffset(12, 78)
Status.BackgroundColor3 = Panel
Status.Text = "● GUI READY"
Status.TextColor3 = Green
Status.Font = Enum.Font.GothamBold
Status.TextSize = 13
Status.Parent = Main
Instance.new("UICorner", Status).CornerRadius =
    UDim.new(0, 8)

-- Feature buttons
local function makeButton(name, y)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -24, 0, 43)
    Button.Position = UDim2.fromOffset(12, y)
    Button.BackgroundColor3 = Panel
    Button.Text = ""
    Button.Parent = Main

    Instance.new("UICorner", Button).CornerRadius =
        UDim.new(0, 9)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.Position = UDim2.fromOffset(12, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = White
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button

    local Toggle = Instance.new("TextLabel")
    Toggle.Size = UDim2.fromOffset(65, 27)
    Toggle.Position = UDim2.new(1, -76, 0.5, -13)
    Toggle.BackgroundColor3 = Gray
    Toggle.Text = "OFF"
    Toggle.TextColor3 = White
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 12
    Toggle.Parent = Button

    Instance.new("UICorner", Toggle).CornerRadius =
        UDim.new(1, 0)

    Button.MouseButton1Click:Connect(function()
        enabled[name] = not enabled[name]

        Toggle.Text = enabled[name] and "ON" or "OFF"
        Toggle.BackgroundColor3 =
            enabled[name] and Green or Gray

        Status.Text = "● " .. name ..
            (enabled[name] and " ENABLED" or " DISABLED")
        Status.TextColor3 =
            enabled[name] and Green or White
    end)

    return Button
end

makeButton("Auto Break", 125)
makeButton("Auto Plant", 174)
makeButton("Auto Harvest", 223)
makeButton("Auto Clear", 272)

-- Speed controls
local SpeedPanel = Instance.new("Frame")
SpeedPanel.Size = UDim2.new(1, -24, 0, 42)
SpeedPanel.Position = UDim2.fromOffset(12, 323)
SpeedPanel.BackgroundColor3 = Panel
SpeedPanel.Parent = Main
Instance.new("UICorner", SpeedPanel).CornerRadius =
    UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5, 0, 1, 0)
SpeedLabel.Position = UDim2.fromOffset(10, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed: x1.0"
SpeedLabel.TextColor3 = White
SpeedLabel.TextSize = 13
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Parent = SpeedPanel

local Minus = Instance.new("TextButton")
Minus.Size = UDim2.fromOffset(32, 28)
Minus.Position = UDim2.new(1, -76, 0.5, -14)
Minus.Text = "-"
Minus.Parent = SpeedPanel
Minus.BackgroundColor3 = Gray
Minus.TextColor3 = White
Minus.TextSize = 20
Instance.new("UICorner", Minus).CornerRadius =
    UDim.new(0, 6)

local Plus = Instance.new("TextButton")
Plus.Size = UDim2.fromOffset(32, 28)
Plus.Position = UDim2.new(1, -38, 0.5, -14)
Plus.Text = "+"
Plus.Parent = SpeedPanel
Plus.BackgroundColor3 = Blue
Plus.TextColor3 = White
Plus.TextSize = 20
Instance.new("UICorner", Plus).CornerRadius =
    UDim.new(0, 6)

local function updateSpeed()
    SpeedLabel.Text = "Speed: x" ..
        string.format("%.1f", speed)
end

Minus.MouseButton1Click:Connect(function()
    speed = math.max(0.5, speed - 0.5)
    updateSpeed()
end)

Plus.MouseButton1Click:Connect(function()
    speed = math.min(5, speed + 0.5)
    updateSpeed()
end)

-- Start All
local Start = Instance.new("TextButton")
Start.Size = UDim2.new(0.46, 0, 0, 36)
Start.Position = UDim2.fromOffset(12, 374)
Start.BackgroundColor3 = Green
Start.Text = "START ALL"
Start.TextColor3 = White
Start.Font = Enum.Font.GothamBold
Start.TextSize = 13
Start.Parent = Main
Instance.new("UICorner", Start).CornerRadius =
    UDim.new(0, 8)

Start.MouseButton1Click:Connect(function()
    for name in pairs(enabled) do
        enabled[name] = true
        for _, obj in ipairs(Main:GetDescendants()) do
            if obj:IsA("TextButton") and obj.Text == name then
                -- Reserved for future controls
            end
        end
    end
    Status.Text = "● ALL CONTROLS ENABLED"
    Status.TextColor3 = Green
end)

-- Stop All
local Stop = Instance.new("TextButton")
Stop.Size = UDim2.new(0.46, 0, 0, 36)
Stop.Position = UDim2.new(0.52, 0, 0, 374)
Stop.BackgroundColor3 = Color3.fromRGB(175, 50, 60)
Stop.Text = "STOP ALL"
Stop.TextColor3 = White
Stop.Font = Enum.Font.GothamBold
Stop.TextSize = 13
Stop.Parent = Main
Instance.new("UICorner", Stop).CornerRadius =
    UDim.new(0, 8)

Stop.MouseButton1Click:Connect(function()
    for name in pairs(enabled) do
        enabled[name] = false
    end
    Status.Text = "● ALL CONTROLS DISABLED"
    Status.TextColor3 = White
end)

-- Floating open menu
local Open = Instance.new("TextButton")
Open.Size = UDim2.fromOffset(110, 38)
Open.Position = UDim2.new(0, 15, 0.5, 0)
Open.BackgroundColor3 = Blue
Open.Text = "OPEN MENU"
Open.TextColor3 = White
Open.Font = Enum.Font.GothamBold
Open.TextSize = 12
Open.Visible = false
Open.Parent = GUI
Instance.new("UICorner", Open).CornerRadius =
    UDim.new(0, 9)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
    Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
    Main.Visible = true
    Open.Visible = false
end)

-- Drag window
local dragging = false
local dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("Widha GrowBlox V2 GUI Loaded!")
print("Created by Widha Gaming")
