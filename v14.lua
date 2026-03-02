-- [[ REDIX ELITE v15 - FULL FIX ]] --
-- Fixes: Mobile Clipping, Text Overflow, Blur Layering
-- Compatibility: All Devices & Executors

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- ESKİ PANEL TEMİZLİĞİ (Çakışmaları önler)
if Player.PlayerGui:FindFirstChild("REDIX_V15_ELITE") then 
    Player.PlayerGui:FindFirstChild("REDIX_V15_ELITE"):Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "REDIX_V15_ELITE"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true -- Mobil cihazlarda çentik/bar hatasını fixler
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- BLUR (Görsellerdeki o derinlik hissi için)
local blur = Lighting:FindFirstChild("EliteBlurV15") or Instance.new("BlurEffect", Lighting)
blur.Name = "EliteBlurV15"
blur.Size = 20
blur.Enabled = true

-- ANA PANEL (VOIDLUA Tarzı Modern Dark)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 580, 0, 360) -- Sabit ama responsive boyut
Main.Position = UDim2.new(0.5, -290, 0.5, -180)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- NEON KENARLIK (Lilly'nin Obby'sindeki gibi glow efekti)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(85, 95, 210)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.2

-- SOL SIDEBAR (Kategori Menüsü)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 70, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

-- HEADER (Stats & Ping)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, -70, 0, 50)
Header.Position = UDim2.new(0, 70, 0, 0)
Header.BackgroundTransparency = 1

local Stats = Instance.new("TextLabel", Header)
Stats.Size = UDim2.new(1, -20, 1, 0)
Stats.Position = UDim2.new(0, 10, 0, 0)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: -- | MS: --"
Stats.Font = Enum.Font.Code
Stats.TextSize = 13
Stats.TextColor3 = Color3.fromRGB(0, 255, 130)
Stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    local fps = math.floor(1/dt)
    local ping = math.floor(Player:GetNetworkPing() * 1000)
    Stats.Text = string.format("FPS: %d | MS: %d", fps, ping)
end)

-- İÇERİK ALANI (Tüm ayarlar burada)
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -90, 1, -70)
Content.Position = UDim2.new(0, 80, 0, 60)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 1.2, 0)
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(85, 95, 210)

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

-- INPUT FONKSİYONU (Hatalar düzeltildi)
local function CreateEliteInput(title, placeholder)
    local frame = Instance.new("Frame", Content)
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    Instance.new("UICorner", frame)

    local lbl = Instance.new("TextLabel", frame)
    lbl.Size = UDim2.new(0.4, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.Text = title
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.5, 0, 0, 30)
    box.Position = UDim2.new(0.45, 0, 0.5, -15)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)
    
    return box
end

local NameIn = CreateEliteInput("NAME TAG", "Metin...")
local RankIn = CreateEliteInput("RANK TAG", "Kral...")

-- ANA BUTON (Görsellerdeki gibi neon mavi)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -100, 0, 50)
Apply.Position = UDim2.new(0, 85, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "AYARLARI KAYDET VE UYGULA"
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 14
Apply.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Apply)

-- TOGGLE (Mobil Aç-Kapat)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(1, -70, 0.5, -27)
Toggle.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Toggle.Text = "RE"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextSize = 18
Toggle.TextColor3 = Color3.fromRGB(85, 95, 210)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Toggle).Color = Color3.fromRGB(85, 95, 210)

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    blur.Enabled = Main.Visible
end)

-- KISAYOL (K Tuşu)
UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        Main.Visible = not Main.Visible
        blur.Enabled = Main.Visible
    end
end)
