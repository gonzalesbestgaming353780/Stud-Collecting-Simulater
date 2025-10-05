-- REDZ HUB (BETA ACCESS) for Stud Collecting Simulator
-- Features: Auto Collect, Auto Sell, Redeem All Codes, Destroy Tab, Movable GUI, Key System ("555")
-- Only one tab at a time. Tab can disappear instantly by clicking "X".

if getgenv().RedzHubGUI then
    getgenv().RedzHubGUI:Destroy()
    getgenv().RedzHubGUI = nil
end

local UserInputService = game:GetService("UserInputService")
local plr = game:GetService("Players").LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RedzHub"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 280)
Frame.Position = UDim2.new(0.5, -160, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Text = "REDZ HUB (BETA ACCESS)"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,50,50)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = Frame

-- Destroy Button
local destroyBtn = Instance.new("TextButton")
destroyBtn.Text = "X"
destroyBtn.Size = UDim2.new(0, 30, 0, 30)
destroyBtn.Position = UDim2.new(1, -35, 0, 5)
destroyBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
destroyBtn.TextColor3 = Color3.fromRGB(255,255,255)
destroyBtn.Font = Enum.Font.SourceSansBold
destroyBtn.TextSize = 20
destroyBtn.Parent = Frame
destroyBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    getgenv().RedzHubGUI = nil
end)

-- Key System
local KeyBox = Instance.new("TextBox")
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Size = UDim2.new(0.6, 0, 0, 40)
KeyBox.Position = UDim2.new(0.2, 0, 0, 60)
KeyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.Font = Enum.Font.SourceSans
KeyBox.TextSize = 20
KeyBox.Parent = Frame

local UnlockBtn = Instance.new("TextButton")
UnlockBtn.Text = "Unlock"
UnlockBtn.Size = UDim2.new(0.6, 0, 0, 40)
UnlockBtn.Position = UDim2.new(0.2, 0, 0, 110)
UnlockBtn.BackgroundColor3 = Color3.fromRGB(70,110,70)
UnlockBtn.TextColor3 = Color3.fromRGB(255,255,255)
UnlockBtn.Font = Enum.Font.SourceSans
UnlockBtn.TextSize = 20
UnlockBtn.Parent = Frame

-- Main buttons (hidden at start)
local function newButton(txt, y, callback)
    local btn = Instance.new("TextButton")
    btn.Text = txt
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Position = UDim2.new(0.1, 0, 0, 60 + y*50)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 20
    btn.Visible = false
    btn.Parent = Frame
    return btn
end

local autoCollect = false
local autoSell = false
local collectConn, sellConn

local autoCollectBtn = newButton("Auto Collect", 0, function()
    autoCollect = not autoCollect
    autoCollectBtn.Text = autoCollect and "Auto Collect [ON]" or "Auto Collect"
    if autoCollect then
        collectConn = game:GetService("RunService").RenderStepped:Connect(function()
            for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if v:IsA("RemoteEvent") and v.Name:lower():find("collect") then
                    v:FireServer()
                end
            end
        end)
    else
        if collectConn then collectConn:Disconnect() end
    end
end)

local autoSellBtn = newButton("Auto Sell", 1, function()
    autoSell = not autoSell
    autoSellBtn.Text = autoSell and "Auto Sell [ON]" or "Auto Sell"
    if autoSell then
        sellConn = game:GetService("RunService").RenderStepped:Connect(function()
            for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if v:IsA("RemoteEvent") and v.Name:lower():find("sell") then
                    v:FireServer()
                end
            end
        end)
    else
        if sellConn then sellConn:Disconnect() end
    end
end)

local redeemBtn = newButton("Redeem All Code", 2, function()
    local codes = { "RELEASE", "FREE", "STUDS", "UPDATE", "BETA" } -- Replace with actual codes
    for _,code in ipairs(codes) do
        for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if v:IsA("RemoteEvent") and v.Name:lower():find("code") then
                v:FireServer(code)
            end
        end
        wait(0.5)
    end
end)

-- Key unlock logic
UnlockBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "555" then
        KeyBox.Visible = false
        UnlockBtn.Visible = false
        autoCollectBtn.Visible = true
        autoSellBtn.Visible = true
        redeemBtn.Visible = true
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Wrong Key!"
    end
end)

-- Draggable GUI (for all executors)
do
    local dragging, dragInput, dragStart, startPos

    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

ScreenGui.Parent = plr:WaitForChild("PlayerGui")
getgenv().RedzHubGUI = ScreenGui
