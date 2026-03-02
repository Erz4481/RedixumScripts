-- [[ REDIX ELITE v17 - ZERO BUILD ]] --
-- Her cihazda (Mobil/PC) aynı görüntü garantisi
-- Lansman Tarihi: 03.03.2026

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

-- ESKİ NE VARSA SİL (Temiz sayfa)
for _, v in pairs(Player.PlayerGui:GetChildren()) do
    if v.Name == "REDIX_V17" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_V17"
ScreenGui.IgnoreGuiInset = true -- Mobildeki kaymayı %100 fixler
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (VOIDLUA & REDIX Tasarımı)
local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.fromOffset(550, 330) -- Sabit boyut ama merkezleme Scale
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- NEON ÇERÇEVE (Görsellerdeki o Premium hava)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(85, 95, 210)
Stroke.Thickness = 2
Stroke.Transparency = 0.2

-- YAN MENÜ (Sidebar)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.fromScale(0.15, 1)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- HEADER (Stats: FPS & MS)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.fromScale(0.85, 0.15)
Header.Position = UDim2.fromScale(0.15, 0)
Header.BackgroundTransparency = 1

local Stats = Instance.new("TextLabel", Header)
Stats.Size = UDim2.fromScale(0.95, 1)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: -- | MS: --"
Stats.Font = Enum.Font.Code
Stats.TextSize = 14
Stats.TextColor3 = Color3.fromRGB(0, 255, 150)
Stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function()
    local fps = math.floor(1/wait())
    local ping = math.floor(Player:GetNetworkPing() * 1000)
    Stats.Text = "FPS: "..fps.." | MS: "..ping
end)

-- İÇERİK ALANI (Ayarlar)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.fromScale(0.8, 0.65)
Content.Position = UDim2.fromScale(0.18, 0.18)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

-- MODERN INPUT FONKSİYONU
local function AddInput(title, place)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1, 0, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", f)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.fromScale(0.4, 1)
    l.Position = UDim2.fromOffset(10, 0)
    l.Text = title
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.BackgroundTransparency = 1

    local i = Instance.new("TextBox", f)
    i.Size = UDim2.fromScale(0.5, 0.6)
    i.Position = UDim2.fromScale(0.45, 0.2)
    i.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    i.PlaceholderText = place
    i.Text = ""
    i.TextColor3 = Color3.new(1,1,1)
    i.Font = Enum.Font.Gotham
    i.TextSize = 12
    Instance.new("UICorner", i)
    return i
end

local NameBox = AddInput("İSİM DEĞİŞTİR", "Metin...")
local RankBox = AddInput("RÜTBE DEĞİŞTİR", "Kral...")

-- UYGULA BUTONU (Görsellerdeki o büyük mavi buton)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.8, 0, 0, 50)
Apply.Position = UDim2.fromScale(0.575, 0.85)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI GÜNCELLE"
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 14
Apply.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Apply)

-- MOBİL AÇ/KAPAT (RE BUTONU)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.fromOffset(50, 50)
Toggle.Position = UDim2.new(1, -60, 0.5, -25)
Toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Toggle.Text = "RE"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextColor3 = Color3.fromRGB(85, 95, 210)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Toggle).Color = Color3.fromRGB(85, 95, 210)

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- PC KISAYOL (K TUŞU)
UserInputService.InputBegan:Connect(function(k, g)
    if not g and k.KeyCode == Enum.KeyCode.K then
        Main.Visible = not Main.Visible
    end
end)
