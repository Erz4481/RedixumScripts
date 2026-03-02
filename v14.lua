-- [[ REDIX ELITE v16 - THE FINAL FIX ]] --
-- Fix: Layout Alignment, Text Scaling, Mobile Clipping
-- Target Launch: 03.03.2026

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- TEMİZLİK OPERASYONU
for _, v in pairs(Player.PlayerGui:GetChildren()) do
    if v.Name == "REDIX_FINAL_V16" then v:Destroy() end
end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_FINAL_V16"
ScreenGui.IgnoreGuiInset = true -- Mobildeki kayma hatasını bitirir
ScreenGui.ResetOnSpawn = false

-- BLUR KATMANI
local blur = Instance.new("BlurEffect", Lighting)
blur.Size = 15
blur.Name = "FinalEliteBlur"

-- ANA PANEL (VOID & REDIX HYBRID)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 560, 0, 340)
Main.Position = UDim2.new(0.5, -280, 0.5, -170)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- NEON BORDER (Görsellerdeki o mor/mavi glow)
local Border = Instance.new("UIStroke", Main)
Border.Color = Color3.fromRGB(85, 95, 210)
Border.Thickness = 1.8
Border.Transparency = 0.3

-- SIDEBAR (Kategoriler)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 75, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

-- HEADER (Ping & FPS)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, -75, 0, 50)
Header.Position = UDim2.new(0, 75, 0, 0)
Header.BackgroundTransparency = 1

local Stats = Instance.new("TextLabel", Header)
Stats.Size = UDim2.new(1, -15, 1, 0)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: -- | MS: --"
Stats.Font = Enum.Font.Code
Stats.TextSize = 13
Stats.TextColor3 = Color3.fromRGB(0, 255, 150)
Stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    Stats.Text = string.format("FPS: %d | MS: %d", math.floor(1/dt), math.floor(Player:GetNetworkPing() * 1000))
end)

-- SCROLLING CONTENT (Hata Fix: Metinler artık buraya sığacak)
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -95, 1, -110)
Content.Position = UDim2.new(0, 85, 0, 60)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 1.1, 0)
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(85, 95, 210)

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 8)

-- MODERN INPUT (Görsellerdeki kutuların düzeltilmiş hali)
local function CreateRow(title, placeholder)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1, 0, 0, 42)
    f.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Instance.new("UICorner", f)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.35, 0, 1, 0)
    l.Position = UDim2.new(0, 12, 0, 0)
    l.Text = title
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextColor3 = Color3.fromRGB(160, 160, 160)
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.BackgroundTransparency = 1

    local i = Instance.new("TextBox", f)
    i.Size = UDim2.new(0.55, 0, 0, 28)
    i.Position = UDim2.new(0.4, 0, 0.5, -14)
    i.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    i.Text = ""
    i.PlaceholderText = placeholder
    i.TextColor3 = Color3.new(1,1,1)
    i.Font = Enum.Font.Gotham
    i.TextSize = 11
    i.ClipsDescendants = true -- Yazının taşmasını önler
    Instance.new("UICorner", i)
    
    return i
end

local NameBox = CreateRow("NAME TAG", "Yeni isim...")
local RankBox = CreateRow("RANK TAG", "Rütbe...")

-- ANA UYGULA BUTONU (image_50bd02.jpg tarzı geniş buton)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -95, 0, 50)
Apply.Position = UDim2.new(0, 85, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "AYARLARI KAYDET VE UYGULA"
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 14
Apply.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Apply)

-- TOGGLE ICON (Mobil kullanıcılar için)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Position = UDim2.new(1, -65, 0.5, -25)
Toggle.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
Toggle.Text = "RE"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextColor3 = Color3.fromRGB(85, 95, 210)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke", Toggle).Color = Color3.fromRGB(85, 95, 210)

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    blur.Enabled = Main.Visible
end)

-- PC KISAYOL
UserInputService.InputBegan:Connect(function(k, g)
    if not g and k.KeyCode == Enum.KeyCode.K then
        Main.Visible = not Main.Visible
        blur.Enabled = Main.Visible
    end
end)
