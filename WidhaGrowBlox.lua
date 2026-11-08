
--========================================
-- WIDHA GROWBLOX V3
-- SUGAR CANE EDITION
-- Created by Widha Gaming
-- GUI CONTROL PANEL
--========================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local parent = CoreGui
pcall(function()
    if gethui then parent = gethui() end
end)

pcall(function()
    local old = parent:FindFirstChild("WidhaGrowBloxV3")
    if old then old:Destroy() end
end)

local GUI = Instance.new("ScreenGui")
GUI.Name = "WidhaGrowBloxV3"
GUI.ResetOnSpawn = false
GUI.Parent = parent

local BLUE = Color3.fromRGB(0,130,255)
local DARK = Color3.fromRGB(10,18,35)
local PANEL = Color3.fromRGB(22,34,57)
local GREEN = Color3.fromRGB(25,200,110)
local GRAY = Color3.fromRGB(65,75,95)
local WHITE = Color3.fromRGB(245,250,255)

local features = {
    "Auto Plant",
    "Auto Harvest",
    "Auto Break",
    "Auto Clear"
}

local enabled = {}
for _,name in ipairs(features) do
    enabled[name] = false
end

local speed = 1

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(340,440)
Main.Position = UDim2.new(.5,-170,.5,-220)
Main.BackgroundColor3 = DARK
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner",Main).CornerRadius =
    UDim.new(0,14)

local stroke = Instance.new("UIStroke",Main)
stroke.Color = BLUE
stroke.Thickness = 2

local function label(parent,text,size,pos,font,color)
    local obj = Instance.new("TextLabel")
    obj.BackgroundTransparency = 1
    obj.Text = text
    obj.TextSize = size
    obj.Position = pos
    obj.Size = UDim2.new(1,-20,0,30)
    obj.Font = font or Enum.Font.GothamBold
    obj.TextColor3 = color or WHITE
    obj.TextXAlignment = Enum.TextXAlignment.Left
    obj.Parent = parent
    return obj
end

label(Main,"👑 WIDHA GROWBLOX V3",19,
    UDim2.fromOffset(12,8))

label(Main,"SUGAR CANE AUTO FARM PANEL",11,
    UDim2.fromOffset(12,38),nil,BLUE)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,-24,0,32)
Status.Position = UDim2.fromOffset(12,72)
Status.BackgroundColor3 = PANEL
Status.Text = "● GUI READY"
Status.TextColor3 = GREEN
Status.Font = Enum.Font.GothamBold
Status.TextSize = 13
Status.Parent = Main

Instance.new("UICorner",Status).CornerRadius =
    UDim.new(0,8)

local controls = {}

local function updateStatus()
    local count = 0
    for _,v in pairs(enabled) do
        if v then count += 1 end
    end

    Status.Text = "● "..count.."/4 CONTROLS ENABLED"
end

local function makeToggle(name,y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-24,0,45)
    button.Position = UDim2.fromOffset(12,y)
    button.BackgroundColor3 = PANEL
    button.Text = ""
    button.Parent = Main

    Instance.new("UICorner",button).CornerRadius =
        UDim.new(0,9)

    local txt = label(button,name,14,
        UDim2.fromOffset(12,7))

    txt.Size = UDim2.new(.65,0,0,30)

    local toggle = Instance.new("TextLabel")
    toggle.Size = UDim2.fromOffset(58,27)
    toggle.Position = UDim2.new(1,-70,.5,-13)
    toggle.BackgroundColor3 = GRAY
    toggle.Text = "OFF"
    toggle.TextColor3 = WHITE
    toggle.TextSize = 12
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = button

    Instance.new("UICorner",toggle).CornerRadius =
        UDim.new(1,0)

    local function refresh()
        toggle.Text = enabled[name] and "ON" or "OFF"
        toggle.BackgroundColor3 =
            enabled[name] and GREEN or GRAY
    end

    button.MouseButton1Click:Connect(function()
        enabled[name] = not enabled[name]
        refresh()
        updateStatus()
    end)

    controls[name] = refresh
end

for i,name in ipairs(features) do
    makeToggle(name,115+(i-1)*50)
end

-- Speed control
local speedPanel = Instance.new("Frame")
speedPanel.Size = UDim2.new(1,-24,0,42)
speedPanel.Position = UDim2.fromOffset(12,320)
speedPanel.BackgroundColor3 = PANEL
speedPanel.Parent = Main

Instance.new("UICorner",speedPanel).CornerRadius =
    UDim.new(0,8)

local speedLabel = label(speedPanel,"Speed: x1.0",13,
    UDim2.fromOffset(10,6))

local function speedButton(symbol,x,callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(35,28)
    b.Position = UDim2.new(1,x,0.5,-14)
    b.BackgroundColor3 = BLUE
    b.Text = symbol
    b.TextColor3 = WHITE
    b.TextSize = 18
    b.Parent = speedPanel
    Instance.new("UICorner",b).CornerRadius =
        UDim.new(0,6)
    b.MouseButton1Click:Connect(callback)
end

speedButton("-", -80,function()
    speed = math.max(.5,speed-.5)
    speedLabel.Text = "Speed: x"..speed
end)

speedButton("+", -40,function()
    speed = math.min(5,speed+.5)
    speedLabel.Text = "Speed: x"..speed
end)

-- Start All
local function actionButton(text,x,color,callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(.46,0,0,38)
    b.Position = UDim2.new(x,0,0,370)
    b.BackgroundColor3 = color
    b.Text = text
    b.TextColor3 = WHITE
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.Parent = Main

    Instance.new("UICorner",b).CornerRadius =
        UDim.new(0,8)

    b.MouseButton1Click:Connect(callback)
end

actionButton("START ALL",.04,GREEN,function()
    for _,name in ipairs(features) do
        enabled[name] = true
        controls[name]()
    end
    updateStatus()
end)

actionButton("STOP ALL",.52,
    Color3.fromRGB(190,50,60),function()
    for _,name in ipairs(features) do
        enabled[name] = false
        controls[name]()
    end
    updateStatus()
end)

-- Hide menu
local Hide = Instance.new("TextButton")
Hide.Size = UDim2.new(1,-24,0,30)
Hide.Position = UDim2.fromOffset(12,415)
Hide.BackgroundColor3 = BLUE
Hide.Text = "HIDE MENU"
Hide.TextColor3 = WHITE
Hide.Font = Enum.Font.GothamBold
Hide.Parent = Main

local Open = Instance.new("TextButton")
Open.Size = UDim2.fromOffset(110,38)
Open.Position = UDim2.new(0,15,.5,0)
Open.BackgroundColor3 = BLUE
Open.Text = "OPEN WIDHA"
Open.TextColor3 = WHITE
Open.Font = Enum.Font.GothamBold
Open.Visible = false
Open.Parent = GUI

Hide.MouseButton1Click:Connect(function()
    Main.Visible = false
    Open.Visible = true
end)

Open.MouseButton1Click:Connect(function()
    Main.Visible = true
    Open.Visible = false
end)

-- Drag GUI
local dragging = false
local dragStart
local startPosition

local function beginDrag(input)
    dragging = true
    dragStart = input.Position
    startPosition = Main.Position
end

Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        beginDrag(input)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("Widha GrowBlox V3 GUI Loaded!")
print("Made by Widha Gaming")
