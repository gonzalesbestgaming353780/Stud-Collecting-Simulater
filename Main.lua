-- ONLY WORKS IN: Stud Collecting Simulator (game id: 8358500938)
local allowedPlaceId = 8358500938

if game.PlaceId ~= allowedPlaceId then
    return
end

-- ONLY WORKS IN: Delta or KRNL executor
local isKrnl = (identifyexecutor and identifyexecutor():lower():find("krnl"))
local isDelta = (identifyexecutor and identifyexecutor():lower():find("delta"))
if not (isKrnl or isDelta) then
    return
end

-- Ensure only one tab (destroy if exists)
pcall(function()
    if game.CoreGui:FindFirstChild("RedzHubXeterStyle") then
        game.CoreGui:FindFirstChild("RedzHubXeterStyle"):Destroy()
    end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

local function createCorner(parent, radius)
    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, radius)
    uicorner.Parent = parent
    return uicorner
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedzHubXeterStyle"
screenGui.Parent = game.CoreGui

-- ========== FIRST TAB: KEY ENTRY ==========
local keyTab = Instance.new("Frame")
keyTab.Name = "KeyTab"
keyTab.Size = UDim2.new(0, 380, 0, 170)
keyTab.Position = UDim2.new(0.3, 0, 0.3, 0)
keyTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyTab.BorderSizePixel = 0
keyTab.Active = true
keyTab.Draggable = true
keyTab.Parent = screenGui
createCorner(keyTab, 12)

local keyTopBar = Instance.new("Frame")
keyTopBar.Parent = keyTab
keyTopBar.Size = UDim2.new(1, 0, 0, 38)
keyTopBar.Position = UDim2.new(0, 0, 0, 0)
keyTopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
keyTopBar.BorderSizePixel = 0
createCorner(keyTopBar, 12)

local keyTitleLabel = Instance.new("TextLabel")
keyTitleLabel.Parent = keyTopBar
keyTitleLabel.Size = UDim2.new(1, 0, 1, 0)
keyTitleLabel.Position = UDim2.new(0, 0, 0, 0)
keyTitleLabel.BackgroundTransparency = 1
keyTitleLabel.Text = "REDZ HUB (Stud Collecting Simulator) - Unlock"
keyTitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitleLabel.TextXAlignment = Enum.TextXAlignment.Center
keyTitleLabel.Font = Enum.Font.GothamBold
keyTitleLabel.TextScaled = true

local keyInputBox = Instance.new("TextBox")
keyInputBox.Parent = keyTab
keyInputBox.Size = UDim2.new(1, -60, 0, 40)
keyInputBox.Position = UDim2.new(0, 30, 0, 60)
keyInputBox.PlaceholderText = "Enter Key"
keyInputBox.Text = ""
keyInputBox.TextScaled = true
keyInputBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyInputBox.TextColor3 = Color3.fromRGB(255,255,255)
keyInputBox.Font = Enum.Font.Gotham
createCorner(keyInputBox, 8)

local keySubmitBtn = Instance.new("TextButton")
keySubmitBtn.Parent = keyTab
keySubmitBtn.Size = UDim2.new(1, -60, 0, 36)
keySubmitBtn.Position = UDim2.new(0, 30, 0, 110)
keySubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
keySubmitBtn.Text = "UNLOCK"
keySubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keySubmitBtn.Font = Enum.Font.GothamBold
keySubmitBtn.TextScaled = true
createCorner(keySubmitBtn, 8)

local keyErrorLabel = Instance.new("TextLabel")
keyErrorLabel.Parent = keyTab
keyErrorLabel.Size = UDim2.new(1, -40, 0, 24)
keyErrorLabel.Position = UDim2.new(0, 20, 1, -32)
keyErrorLabel.BackgroundTransparency = 1
keyErrorLabel.Text = ""
keyErrorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
keyErrorLabel.TextScaled = true
keyErrorLabel.Font = Enum.Font.Gotham

-- ========== SECOND TAB: MAIN HUB ==========
local mainFrame = Instance.new("Frame")
mainFrame.Name = "RedzHubFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 410)
mainFrame.Position = UDim2.new(0.3, 0, 0.23, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
mainFrame.Visible = false
createCorner(mainFrame, 12)

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Parent = mainFrame
topBar.Size = UDim2.new(1, 0, 0, 38)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
topBar.BorderSizePixel = 0
createCorner(topBar, 12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = topBar
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "REDZ HUB (Stud Collecting Simulator)"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextScaled = true

-- Minimize Button (-)
local minBtn = Instance.new("TextButton")
minBtn.Parent = topBar
minBtn.Size = UDim2.new(0, 36, 0, 28)
minBtn.Position = UDim2.new(1, -80, 0.5, -14)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextScaled = true
createCorner(minBtn, 6)

-- Close Button (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = topBar
closeBtn.Size = UDim2.new(0, 36, 0, 28)
closeBtn.Position = UDim2.new(1, -40, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
createCorner(closeBtn, 6)

local contentFrame = Instance.new("Frame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, 0, 1, -38)
contentFrame.Position = UDim2.new(0, 0, 0, 38)
contentFrame.BackgroundTransparency = 1

local studsLabel = Instance.new("TextLabel")
studsLabel.Parent = contentFrame
studsLabel.Size = UDim2.new(1, -40, 0, 36)
studsLabel.Position = UDim2.new(0, 20, 0, 10)
studsLabel.BackgroundTransparency = 0.5
studsLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
studsLabel.Text = "Studs: 0"
studsLabel.TextScaled = true
studsLabel.TextColor3 = Color3.fromRGB(255,255,255)
studsLabel.Font = Enum.Font.Gotham
createCorner(studsLabel, 8)

local collectBtn = Instance.new("TextButton")
collectBtn.Parent = contentFrame
collectBtn.Size = UDim2.new(1, -40, 0, 44)
collectBtn.Position = UDim2.new(0, 20, 0, 56)
collectBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
collectBtn.Text = "Collect Stud"
collectBtn.TextColor3 = Color3.fromRGB(255,255,255)
collectBtn.Font = Enum.Font.GothamBold
collectBtn.TextScaled = true
createCorner(collectBtn, 8)

local redeemBtn = Instance.new("TextButton")
redeemBtn.Parent = contentFrame
redeemBtn.Size = UDim2.new(1, -40, 0, 44)
redeemBtn.Position = UDim2.new(0, 20, 0, 110)
redeemBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
redeemBtn.Text = "Redeem Key (555)"
redeemBtn.TextColor3 = Color3.fromRGB(255,255,255)
redeemBtn.Font = Enum.Font.GothamBold
redeemBtn.TextScaled = true
createCorner(redeemBtn, 8)

local keyBox = Instance.new("TextBox")
keyBox.Parent = contentFrame
keyBox.Size = UDim2.new(1, -40, 0, 36)
keyBox.Position = UDim2.new(0, 20, 0, 164)
keyBox.PlaceholderText = "Enter Key"
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.TextColor3 = Color3.fromRGB(255,255,255)
keyBox.Font = Enum.Font.Gotham
createCorner(keyBox, 8)

local autoCollectBtn = Instance.new("TextButton")
autoCollectBtn.Parent = contentFrame
autoCollectBtn.Size = UDim2.new(1, -40, 0, 44)
autoCollectBtn.Position = UDim2.new(0, 20, 0, 210)
autoCollectBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
autoCollectBtn.Text = "Auto Collect (Toggle)"
autoCollectBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoCollectBtn.Font = Enum.Font.GothamBold
autoCollectBtn.TextScaled = true
createCorner(autoCollectBtn, 8)

local autoRedeemBtn = Instance.new("TextButton")
autoRedeemBtn.Parent = contentFrame
autoRedeemBtn.Size = UDim2.new(1, -40, 0, 44)
autoRedeemBtn.Position = UDim2.new(0, 20, 0, 264)
autoRedeemBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
autoRedeemBtn.Text = "Auto Redeem (555) (Toggle)"
autoRedeemBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoRedeemBtn.Font = Enum.Font.GothamBold
autoRedeemBtn.TextScaled = true
createCorner(autoRedeemBtn, 8)

local unlockAllBtn = Instance.new("TextButton")
unlockAllBtn.Parent = contentFrame
unlockAllBtn.Size = UDim2.new(1, -40, 0, 44)
unlockAllBtn.Position = UDim2.new(0, 20, 0, 318)
unlockAllBtn.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
unlockAllBtn.Text = "Unlock All (Demo Button)"
unlockAllBtn.TextColor3 = Color3.fromRGB(60,60,60)
unlockAllBtn.Font = Enum.Font.GothamBold
unlockAllBtn.TextScaled = true
createCorner(unlockAllBtn, 8)

-- ========== FUNCTIONALITY LOGIC ==========

-- Unlock function
local function unlockMainTab()
    keyTab.Visible = false
    mainFrame.Visible = true
end

local function tryKey(input)
    if tostring(input) == "555" then
        unlockMainTab()
        keyErrorLabel.Text = ""
    else
        keyErrorLabel.Text = "Incorrect key."
    end
end

keyInputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        tryKey(keyInputBox.Text)
    end
end)
keySubmitBtn.MouseButton1Click:Connect(function()
    tryKey(keyInputBox.Text)
end)

-- Minimize/Restore
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    minBtn.Text = minimized and "+" or "-"
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Update Studs label
local function updateStuds()
    local studs = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Studs")
    if studs then
        studsLabel.Text = "Studs: " .. studs.Value
    end
end

if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Studs") then
    player.leaderstats.Studs:GetPropertyChangedSignal("Value"):Connect(updateStuds)
    updateStuds()
end

player.ChildAdded:Connect(function(child)
    if child.Name == "leaderstats" then
        local studs = child:WaitForChild("Studs")
        studs:GetPropertyChangedSignal("Value"):Connect(updateStuds)
        updateStuds()
    end
end)

collectBtn.MouseButton1Click:Connect(function()
    ReplicatedStorage.CollectStud:FireServer()
end)

redeemBtn.MouseButton1Click:Connect(function()
    ReplicatedStorage.RedeemKey:FireServer("555")
end)

keyBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        ReplicatedStorage.RedeemKey:FireServer(keyBox.Text)
        keyBox.Text = ""
    end
end)

-- Auto Collect
local autoCollecting = false
autoCollectBtn.MouseButton1Click:Connect(function()
    autoCollecting = not autoCollecting
    autoCollectBtn.Text = autoCollecting and "Auto Collect (ON)" or "Auto Collect (OFF)"
    if autoCollecting then
        spawn(function()
            while autoCollecting do
                ReplicatedStorage.CollectStud:FireServer()
                wait(0.2)
            end
        end)
    end
end)

-- Auto Redeem
local autoRedeem = false
autoRedeemBtn.MouseButton1Click:Connect(function()
    autoRedeem = not autoRedeem
    autoRedeemBtn.Text = autoRedeem and "Auto Redeem (ON)" or "Auto Redeem (OFF)"
    if autoRedeem then
        spawn(function()
            while autoRedeem do
                ReplicatedStorage.RedeemKey:FireServer("555")
                wait(2)
            end
        end)
    end
end)

unlockAllBtn.MouseButton1Click:Connect(function()
    unlockAllBtn.Text = "Unlocked! (Demo)"
end)
