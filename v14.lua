-- [[ TA 1.0 - VOID PREMIUM UNIVERSAL ]] --
-- UI Style: VOIDLUA HUB Professional
-- Created by: Rendix Studio
-- Fix: Bağımsız Renk Kontrolü & Global Uyumluluk

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("VOID_TA_UNIVERSAL") then CoreGui:FindFirstChild("VOID_TA_UNIVERSAL"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VOID_TA_UNIVERSAL"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (VOID Style)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 330)
Main.Position = UDim2.new(0.5, -260, 0.5, -165)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- SOL SIDEBAR (İkon Alanı)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 75, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

-- ÜST BİLGİ (Logo & Ping)
local Logo = Instance.new("TextLabel", Main)
Logo.Size = UDim2.new(0, 200, 0, 40)
Logo.Position = UDim2.new(0, 85, 0, 5)
Logo.Text = "VOIDLUA HUB | TA 1.0"
Logo.TextColor3 = Color3.new(1, 1, 1)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 14
Logo.TextXAlignment = Enum.TextXAlignment.Left

local Ping = Instance.new("TextLabel", Main)
Ping.Size = UDim2.new(0, 80, 0, 40)
Ping.Position = UDim2.new(1, -95, 0, 5)
Ping.Text = "Ping: 71 ms"
Ping.TextColor3 = Color3.fromRGB(0, 255, 120)
Ping.Font = Enum.Font.GothamBold
Ping.TextSize = 11

-- AYAR SATIRI OLUŞTURUCU
local function CreateRow(txt, y)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -95, 0, 42)
    frame.Position = UDim2.new(0, 85, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0, 140, 0, 30)
    input.Position = UDim2.new(0.4, 0, 0.5, -15)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    input.PlaceholderText = "Metin..."
    input.Text = ""
    input.TextColor3 = Color3.new(1, 1, 1)
    input.Font = Enum.Font.Gotham
    input.TextSize = 11
    Instance.new("UICorner", input)

    local color = Instance.new("TextBox", frame)
    color.Size = UDim2.new(0, 80, 0, 30)
    color.Position = UDim2.new(0.75, 0, 0.5, -15)
    color.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    color.PlaceholderText = "255,0,0"
    color.Text = "255,255,255"
    color.TextColor3 = Color3.new(1, 1, 1)
    color.Font = Enum.Font.Code
    color.TextSize = 10
    Instance.new("UICorner", color)

    return input, color
end

local I_Name, C_Name = CreateRow("İsim Değiştir", 50)
local I_Rank, C_Rank = CreateRow("Rütbe Değiştir", 100)

-- TAKIM LİSTESİ (Scrolling)
local TeamFrame = Instance.new("Frame", Main)
TeamFrame.Size = UDim2.new(1, -95, 0, 85)
TeamFrame.Position = UDim2.new(0, 85, 0, 150)
TeamFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
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
    b.Size = UDim2.new(1, 0, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    b.Text = t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        Logo.Text = "SEÇİLDİ: " .. t.Name:upper()
        Logo.TextColor3 = SelectedColor
    end)
end
Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)

-- ÜRET BUTONU (Universal Mavi)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -95, 0, 45)
Apply.Position = UDim2.new(0, 85, 0, 250)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI GÜNCELLE"
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Font = Enum.Font.GothamBold
Apply.TextSize = 14
Instance.new("UICorner", Apply)

-- ANA GÜNCELLEME MANTIĞI
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
            -- İSİM: Kendi RGB'sini kullanır
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetRGB(C_Name)
            -- RÜTBE: Kendi RGB'sini kullanır
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetRGB(C_Rank)
            -- TAKIM: Listeden seçilen takımın rengini kullanır
            elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = SelectedTeam
                v.TextColor3 = SelectedColor
            end
        end
    end
end)

-- MOBİL AÇ/KAPAT BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 50, 0, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Mob.Text = "TA"
Mob.TextColor3 = Color3.fromRGB(85, 95, 210)
Mob.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
local mStroke = Instance.new("UIStroke", Mob)
mStroke.Color = Color3.fromRGB(85, 95, 210)
mStroke.Thickness = 2
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- PC KISAYOL (K TUŞU)
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
