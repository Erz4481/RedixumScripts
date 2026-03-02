-- [[ REDIX ELITE v20 - GLOBAL FIX ]] --
-- Fix: Name/Rank/Team/RGB Functions
-- Style: High-Quality Dark Glass

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- ESKİ PANELİ KOMPLE SİL
if Player.PlayerGui:FindFirstChild("REDIX_V20") then Player.PlayerGui.REDIX_V20:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_V20"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

-- ANA PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(580, 420)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(85, 95, 210)

-- HEADER & STATS
local Stats = Instance.new("TextLabel", Main)
Stats.Size = UDim2.new(1, -20, 0, 30)
Stats.Position = UDim2.new(0, 0, 0, 5)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: -- | MS: --"
Stats.TextColor3 = Color3.fromRGB(0, 255, 150)
Stats.Font = Enum.Font.Code
Stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    Stats.Text = string.format("FPS: %d | MS: %d", 1/dt, Player:GetNetworkPing()*1000)
end)

-- SCROLLING AREA (Ayarların toplandığı yer)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -40, 0, 300)
Scroll.Position = UDim2.new(0, 20, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
Scroll.ScrollBarThickness = 3
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 10)

-- INPUT OLUŞTURUCU (Şeffaf yazılar ve RGB kutuları)
local function NewInput(title, placeholder)
    local f = Instance.new("Frame", Scroll)
    f.Size = UDim2.new(1, 0, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", f)

    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.fromScale(0.3, 1)
    lbl.Position = UDim2.fromOffset(10, 0)
    lbl.Text = title
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    lbl.BackgroundTransparency = 1

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.fromScale(0.4, 0.7)
    box.Position = UDim2.fromScale(0.32, 0.15)
    box.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    box.PlaceholderText = placeholder -- Burayı istediğin gibi doldurdum
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.fromScale(0.23, 0.7)
    rgb.Position = UDim2.fromScale(0.74, 0.15)
    rgb.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    rgb.Text = "255,255,255" -- Varsayılan Beyaz
    rgb.Font = Enum.Font.Code
    rgb.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", rgb)
    
    return box, rgb
end

local NameIn, NameCol = NewInput("İSİM DEĞİŞTİR", "Karakter Adı...")
local RankIn, RankCol = NewInput("RÜTBE DEĞİŞTİR", "Yeni Rütbe...")

-- TAKIM LİSTESİ (Scrolling)
local TeamLabel = Instance.new("TextLabel", Scroll)
TeamLabel.Size = UDim2.new(1, 0, 0, 30)
TeamLabel.Text = "TAKIM LİSTESİ (SEÇMEK İÇİN TIKLA)"
TeamLabel.TextColor3 = Color3.fromRGB(120, 170, 255)
TeamLabel.Font = Enum.Font.GothamBlack
TeamLabel.BackgroundTransparency = 1

local SelTeam = ""
for _, t in pairs(Teams:GetTeams()) do
    local tb = Instance.new("TextButton", Scroll)
    tb.Size = UDim2.new(1, 0, 0, 35)
    tb.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    tb.Text = t.Name
    tb.TextColor3 = t.TeamColor.Color
    tb.Font = Enum.Font.GothamBold
    Instance.new("UICorner", tb)
    
    tb.MouseButton1Click:Connect(function()
        SelTeam = t.Name
        TeamLabel.Text = "SEÇİLEN: " .. t.Name
    end)
end

-- GÜNCELLE BUTONU (Asıl işi yapan kısım)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 50)
Apply.Position = UDim2.new(0.5, 0, 1, -40)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "DEĞİŞİKLİKLERİ UYGULA"
Apply.Font = Enum.Font.GothamBlack
Apply.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Apply)

-- ÇALIŞMA MANTIĞI
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    local function ParseRGB(txt)
        local r, g, b = txt:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(r,g,b) or Color3.new(1,1,1)
    end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            -- İsim Kontrolü
            if NameIn.Text ~= "" and (v.Text:find(Player.Name) or v.Name:lower():find("name")) then
                v.Text = NameIn.Text
                v.TextColor3 = ParseRGB(NameCol.Text)
            end
            -- Rütbe Kontrolü
            if RankIn.Text ~= "" and (v.Name:lower():find("rank") or v.Name:lower():find("rütbe")) then
                v.Text = RankIn.Text
                v.TextColor3 = ParseRGB(RankCol.Text)
            end
            -- Takım Kontrolü
            if SelTeam ~= "" and (v.Name:lower():find("team") or v.Name:lower():find("takım")) then
                v.Text = SelTeam
            end
        end
    end
end)

-- MOBİL AÇ/KAPAT (Sürüklenebilir)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.fromOffset(50, 50)
Toggle.Position = UDim2.new(1, -60, 0.5, -25)
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Toggle.Text = "RE"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextColor3 = Color3.fromRGB(85, 95, 210)
Toggle.Draggable = true
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)

Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
