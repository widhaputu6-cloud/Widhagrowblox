
-- GROWBLOX AUTO FARM GUI
-- Executor Lua Script
-- Widha Gaming

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WidhaGrowBlox"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 300)
Main.Position = UDim2.new(0.5, -125, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
Title.Text = "WIDHA GROWBLOX"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.Parent = Main

local function createButton(name, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 210, 0, 38)
    button.Position = UDim2.new(0, 20, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Text = name .. " : OFF"
    button.Parent = Main

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 8)

    return button
end

local features = {
    "Auto Break",
    "Auto Plant",
    "Auto Harvest",
    "Auto Clear"
}

local enabled = {}

for i, name in ipairs(features) do
    enabled[name] = false

    local button = createButton(name, 55 + (i-1)*48)

    button.MouseButton1Click:Connect(function()
        enabled[name] = not enabled[name]

        button.Text = name ..
            (enabled[name] and " : ON" or " : OFF")

        button.BackgroundColor3 = enabled[name]
            and Color3.fromRGB(30, 150, 90)
            or Color3.fromRGB(55, 55, 70)
    end)
end

local Close = createButton("HIDE MENU", 255)

Close.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(0, 100, 0, 35)
Toggle.Position = UDim2.new(0, 20, 0, 150)
Toggle.Text = "OPEN MENU"
Toggle.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Parent = ScreenGui

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

ScreenGui.Parent = game:GetService("CoreGui")

print("Widha GrowBlox GUI Loaded!")
