-- [[ TA 1.0 - REDIX STUDIO EDITION ]] --
-- Style: Branded Elite UI
-- Creator: Redixum / Redix Studio

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("REDIX_BRAND_HUB") then CoreGui:FindFirstChild("REDIX_BRAND_HUB"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "REDIX_BRAND_HUB"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 540, 0, 340)
Main.Position = UDim2.new(0.5, -270, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- ÜST PANEL (BRANDING AREA)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1

local ScriptTitle = Instance.new("TextLabel", TopBar)
ScriptTitle.Size = UDim2.new(0, 250, 1, 0)
ScriptTitle.Position = UDim2.new(0, 85, 0, 0)
ScriptTitle.Text = "TA 1.0 | NAME CHANGER"
ScriptTitle.TextColor3 = Color3.new(1, 1, 1)
ScriptTitle.Font = Enum.Font.GothamBlack
ScriptTitle.TextSize = 14
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

local CreatorTag = Instance.new("TextLabel", TopBar)
CreatorTag.Size = UDim2.new(0, 200, 1, 0)
CreatorTag.Position = UDim2.new(1, -210, 0, 0)
CreatorTag.Text = "BY REDIX STUDIO"
CreatorTag.TextColor3 = Color3.fromRGB(0, 150, 255)
CreatorTag.Font = Enum.Font.GothamBlack
CreatorTag.TextSize = 13
CreatorTag.TextXAlignment = Enum.TextXAlignment.Right

-- SOL SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 75, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- FPS SAYACI (Sadece FPS kalsın dedin, Ping'i kaldırdım)
local FpsLabel = Instance.new("TextLabel", Main)
FpsLabel.Size = UDim2.new(0, 60, 0, 20)
FpsLabel.Position = UDim2.new(1, -70, 1, -25)
FpsLabel.BackgroundTransparency = 1
FpsLabel.Text = "FPS: --"
FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsLabel.Font = Enum.Font.Code
FpsLabel.TextSize = 10
FpsLabel.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    FpsLabel.Text = "FPS: " .. math.floor(1/dt)
end)

-- AYAR SATIRLARI
local function CreateEliteRow(txt, y)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -100, 0, 45)
    frame.Position = UDim2.new(0, 85, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(180, 180, 180)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0, 150, 0, 30)
    input.Position = UDim2.new(0.38, 0, 0.5, -15)
    input.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    input.PlaceholderText = "Metin..."
    input.Text = ""
    input.TextColor3 = Color3.new(1, 1, 1)
    input.Font = Enum.Font.Gotham
    input.TextSize = 11
    Instance.new("UICorner", input)

    local color = Instance.new("TextBox", frame)
    color.Size = UDim2.new(0, 85, 0, 30)
    color.Position = UDim2.new(0.76, 0, 0.5, -15)
    color.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    color.PlaceholderText = "RGB"
    color.Text = "255,255,255"
    color.TextColor3 = Color3.new(1, 1, 1)
    color.Font = Enum.Font.Code
    color.TextSize = 10
    Instance.new("UICorner", color)

    return input, color
end

local I_Name, C_Name = CreateEliteRow("İSİM DEĞİŞTİR", 60)
local I_Rank, C_Rank = CreateEliteRow("RÜTBE DEĞİŞTİR", 115)

-- TAKIM SEÇİCİ
local TeamFrame = Instance.new("Frame", Main)
TeamFrame.Size = UDim2.new(1, -100, 0, 90)
TeamFrame.Position = UDim2.new(0, 85, 0, 170)
TeamFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UICorner", TeamFrame)

local Scroll = Instance.new("ScrollingFrame", TeamFrame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
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
        ScriptTitle.Text = "SELECTED: " .. t.Name:upper()
        ScriptTitle.TextColor3 = SelectedColor
    end)
end
Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)

-- GÜNCELLE BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -100, 0, 50)
Apply.Position = UDim2.new(0, 85, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "AYARLARI KAYDET VE UYGULA"
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 14
Instance.new("UICorner", Apply)

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
