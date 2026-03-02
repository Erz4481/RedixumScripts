-- [[ TA 1.0 - ELITE CUSTOM HUB ]] --
-- Style: Rendix Studio Custom Elite
-- Features: Real-time FPS, Ping, Independent Colors

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("RENDIX_ELITE_HUB") then CoreGui:FindFirstChild("RENDIX_ELITE_HUB"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "RENDIX_ELITE_HUB"

-- ANA PANEL (Görseldeki VOID Tarzı - Modern & İnce)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 540, 0, 340)
Main.Position = UDim2.new(0.5, -270, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- SOL SIDEBAR (Premium Gradiant)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 75, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- LOGO ALANI
local Logo = Instance.new("TextLabel", Main)
Logo.Size = UDim2.new(0, 200, 0, 45)
Logo.Position = UDim2.new(0, 90, 0, 5)
Logo.Text = "RENDIX ELITE"
Logo.TextColor3 = Color3.new(1, 1, 1)
Logo.Font = Enum.Font.GothamBlack
Logo.TextSize = 16
Logo.TextXAlignment = Enum.TextXAlignment.Left

-- STATS (FPS & PING)
local StatsFrame = Instance.new("Frame", Main)
StatsFrame.Size = UDim2.new(0, 120, 0, 40)
StatsFrame.Position = UDim2.new(1, -130, 0, 8)
StatsFrame.BackgroundTransparency = 1

local PingLabel = Instance.new("TextLabel", StatsFrame)
PingLabel.Size = UDim2.new(1, 0, 0.5, 0)
PingLabel.Text = "Ping: -- ms"
PingLabel.TextColor3 = Color3.fromRGB(0, 255, 125)
PingLabel.Font = Enum.Font.GothamBold
PingLabel.TextSize = 11
PingLabel.TextXAlignment = Enum.TextXAlignment.Right

local FpsLabel = Instance.new("TextLabel", StatsFrame)
FpsLabel.Size = UDim2.new(1, 0, 0.5, 0)
FpsLabel.Position = UDim2.new(0, 0, 0.5, 0)
FpsLabel.Text = "FPS: --"
FpsLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
FpsLabel.Font = Enum.Font.GothamBold
FpsLabel.TextSize = 11
FpsLabel.TextXAlignment = Enum.TextXAlignment.Right

-- FPS/PING GÜNCELLEYİCİ
RunService.RenderStepped:Connect(function(dt)
    FpsLabel.Text = "FPS: " .. math.floor(1/dt)
    PingLabel.Text = "Ping: " .. math.floor(Player:GetNetworkPing() * 1000) .. " ms"
end)

-- AYAR SATIRI (Özel Tasarım)
local function CreateEliteRow(txt, y)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -105, 0, 45)
    frame.Position = UDim2.new(0, 90, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(180, 180, 180)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local inp = Instance.new("TextBox", frame)
    inp.Size = UDim2.new(0, 140, 0, 32)
    inp.Position = UDim2.new(0.38, 0, 0.5, -16)
    inp.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    inp.PlaceholderText = "Metin..."
    inp.Text = ""
    inp.TextColor3 = Color3.new(1, 1, 1)
    inp.Font = Enum.Font.Gotham
    inp.TextSize = 11
    Instance.new("UICorner", inp)

    local clr = Instance.new("TextBox", frame)
    clr.Size = UDim2.new(0, 85, 0, 32)
    clr.Position = UDim2.new(0.75, 0, 0.5, -16)
    clr.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
    clr.PlaceholderText = "RGB"
    clr.Text = "255,255,255"
    clr.TextColor3 = Color3.new(1, 1, 1)
    clr.Font = Enum.Font.Code
    clr.TextSize = 10
    Instance.new("UICorner", clr)

    return inp, clr
end

local I_Name, C_Name = CreateEliteRow("İSİM", 55)
local I_Rank, C_Rank = CreateEliteRow("RÜTBE", 105)

-- TAKIM SEÇİCİ (Modern Liste)
local TeamFrame = Instance.new("Frame", Main)
TeamFrame.Size = UDim2.new(1, -105, 0, 90)
TeamFrame.Position = UDim2.new(0, 90, 0, 155)
TeamFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
Instance.new("UICorner", TeamFrame)

local Scroll = Instance.new("ScrollingFrame", TeamFrame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 90, 200)
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 6)

local SelectedTeam, SelectedColor = "", Color3.new(1, 1, 1)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    b.Text = t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        Logo.Text = "TEAM: " .. t.Name:upper()
        Logo.TextColor3 = SelectedColor
    end)
end
Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)

-- GÜNCELLE BUTONU (Premium Blue)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -105, 0, 50)
Apply.Position = UDim2.new(0, 90, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(70, 80, 180)
Apply.Text = "NAMETAGLARI SİSTEME İŞLE"
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 14
Instance.new("UICorner", Apply)

-- ANA İŞLEM
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    local function GetRGB(box)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Color3.new(1, 1, 1)
    end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetRGB(C_Name)
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetRGB(C_Rank)
            elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = SelectedTeam
                v.TextColor3 = SelectedColor
            end
        end
    end
end)
