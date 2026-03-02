-- [[ TA 1.0 - UNIVERSAL ELITE EDITION ]] --
-- Style: VOIDLUA + RENDIX Hybrid Professional
-- Device: Mobile, PC & All Executors Compatible
-- Creator: Redixum / Redix Studio

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ESKİ PANELİ SİL (Global Değişken Kontrolü)
if _G.REDIX_V14_LOADED and CoreGui:FindFirstChild("REDIX_MASTER_HUB") then
    CoreGui:FindFirstChild("REDIX_MASTER_HUB"):Destroy()
end
_G.REDIX_V14_LOADED = true

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "REDIX_MASTER_HUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true -- Mobil executorda tam ekran uyumu

-- ANA PANEL (VOID Style Premium Dark)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 330)
Main.Position = UDim2.new(0.5, -260, 0.5, -165)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- NEON STROKE (Kenar Glow)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(85, 95, 210)
Stroke.Thickness = 1
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- SOL SIDEBAR (Görseldeki Gibi)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 75, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- HEADER BAR (Marka & Stats)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 85, 0, 0)
Title.Text = "RENDIX STUDIO | ELITE v14"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- FPS SAYACI (Gerçek MS ve FPS)
local StatsLabel = Instance.new("TextLabel", Header)
StatsLabel.Size = UDim2.new(0, 150, 1, 0)
StatsLabel.Position = UDim2.new(1, -160, 0, 0)
StatsLabel.BackgroundTransparency = 1
StatsLabel.Text = "FPS: -- | MS: --"
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
StatsLabel.Font = Enum.Font.GothamBold
StatsLabel.TextSize = 10
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    local fps = math.floor(1/dt)
    local ping = math.floor(Player:GetNetworkPing() * 1000)
    StatsLabel.Text = string.format("FPS: %d | MS: %d", fps, ping)
end)

-- AYAR SATIRI OLUŞTURUCU (Universal Input Style)
local function CreateEliteRow(txt, y)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -100, 0, 42)
    frame.Position = UDim2.new(0, 85, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    frame.BorderSizePixel = 0
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
    color.PlaceholderText = "255,255,255"
    color.Text = "255,255,255"
    color.TextColor3 = Color3.new(1, 1, 1)
    color.Font = Enum.Font.Code
    color.TextSize = 10
    Instance.new("UICorner", color)

    return input, color
end

local I_Name, C_Name = CreateEliteRow("İSİM DEĞİŞTİR", 50)
local I_Rank, C_Rank = CreateEliteRow("RÜTBE DEĞİŞTİR", 100)

-- TAKIM SEÇİCİ (Modern Liste)
local TeamFrame = Instance.new("Frame", Main)
TeamFrame.Size = UDim2.new(1, -100, 0, 100)
TeamFrame.Position = UDim2.new(0, 85, 0, 155)
TeamFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
TeamFrame.BorderSizePixel = 0
Instance.new("UICorner", TeamFrame)

local Scroll = Instance.new("ScrollingFrame", TeamFrame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
Scroll.ScrollBarImageColor3 = Color3.fromRGB(85, 95, 210)
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)

local SelectedTeam, SelectedColor = "", Color3.new(1, 1, 1)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.AutoButtonColor = false
    Instance.new("UICorner", b)
    
    local BStroke = Instance.new("UIStroke", b)
    BStroke.Thickness = 1
    BStroke.Color = t.TeamColor.Color
    BStroke.Transparency = 0.8

    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        Title.Text = "TEAM SELECTED: " .. t.Name:upper()
        Title.TextColor3 = SelectedColor
        TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        task.wait(0.2)
        TweenService:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 38)}):Play()
    end)
end
Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)

-- GÜNCELLE BUTONU (Classic Blue Premium)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -100, 0, 50)
Apply.Position = UDim2.new(0, 85, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI SİSTEME BAS"
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 14
Instance.new("UICorner", Apply)

Apply.MouseEnter:Connect(function()
    TweenService:Create(Apply, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 110, 230), Size = UDim2.new(1, -95, 0, 55), Position = UDim2.new(0, 82.5, 1, -67.5)}):Play()
end)
Apply.MouseLeave:Connect(function()
    TweenService:Create(Apply, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(85, 95, 210), Size = UDim2.new(1, -100, 0, 50), Position = UDim2.new(0, 85, 1, -65)}):Play()
end)

-- ANA MANTIK (İsim/Rütbe Bağımsız, Takım Oto Renk)
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
            -- İSİM (Kendi RGB'si)
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetRGB(C_Name)
            -- RÜTBE (Kendi RGB'si)
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetRGB(C_Rank)
            -- TAKIM (Seçilen Takım Rengi)
            elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = SelectedTeam
                v.TextColor3 = SelectedColor
            end
        end
    end
end)

-- MOBİL AÇ/KAPAT BUTONU (Universal)
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 50, 0, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Mob.Text = "TA"
Mob.TextColor3 = Color3.fromRGB(85, 95, 210)
Mob.Font = Enum.Font.GothamBlack
Mob.TextSize = 18
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
local mStroke = Instance.new("UIStroke", Mob)
mStroke.Color = Color3.fromRGB(85, 95, 210)
mStroke.Thickness = 2
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- PC K tuşu Aç/Kapat
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
