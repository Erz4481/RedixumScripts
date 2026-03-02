-- [[ GLASS ELITE v2 - PROFESSIONAL REDIX EDITION ]] --
-- Style: Ultra Modern Glassmorphism
-- Device: Universal (Mobile & PC Compatible)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- ESKİ UI TEMİZLEME
if Player.PlayerGui:FindFirstChild("GLASS_ELITE_V2") then 
    Player.PlayerGui:FindFirstChild("GLASS_ELITE_V2"):Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GLASS_ELITE_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true -- Mobil tam ekran uyumu
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- BLUR EFEKTİ (Arka Plan Derinliği)
if not Lighting:FindFirstChild("EliteBlur") then
    local blur = Instance.new("BlurEffect")
    blur.Name = "EliteBlur"
    blur.Size = 20
    blur.Parent = Lighting
end

-- MAIN PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 620, 0, 380)
Main.Position = UDim2.new(0.5, -310, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = true -- İlk açılışta görünür
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- NEON KENARLIK
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(120, 170, 255)
Stroke.Thickness = 1.2
Stroke.Transparency = 0.4

-- SIDEBAR (Sol Menü Alanı)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 15)

-- MARKA BAŞLIĞI
local Brand = Instance.new("TextLabel", Sidebar)
Brand.Size = UDim2.new(1, 0, 0, 60)
Brand.Text = "REDIX ELITE"
Brand.Font = Enum.Font.GothamBlack
Brand.TextSize = 16
Brand.TextColor3 = Color3.fromRGB(120, 170, 255)
Brand.BackgroundTransparency = 1

-- HEADER (Stats Alanı)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, -160, 0, 60)
Header.Position = UDim2.new(0, 160, 0, 0)
Header.BackgroundTransparency = 1

local Stats = Instance.new("TextLabel", Header)
Stats.Size = UDim2.new(1, -30, 1, 0)
Stats.Position = UDim2.new(0, 15, 0, 0)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: -- | MS: --"
Stats.Font = Enum.Font.Code
Stats.TextSize = 13
Stats.TextColor3 = Color3.fromRGB(0, 255, 150)
Stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    local fps = math.floor(1/dt)
    local ping = math.floor(Player:GetNetworkPing() * 1000)
    Stats.Text = "FPS: "..fps.." | MS: "..ping
end)

-- CONTENT AREA (İçerik Alanı)
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -180, 1, -80)
Content.Position = UDim2.new(0, 170, 0, 70)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 12)

-- MODERN INPUT FONKSİYONU
local function CreateInput(placeholder, title)
    local container = Instance.new("Frame", Content)
    container.Size = UDim2.new(1, 0, 0, 45)
    container.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    container.BackgroundTransparency = 0.5
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

    local lbl = Instance.new("TextLabel", container)
    lbl.Size = UDim2.new(0.4, 0, 1, 0)
    lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.Text = title
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1

    local box = Instance.new("TextBox", container)
    box.Size = UDim2.new(0.5, 0, 0, 30)
    box.Position = UDim2.new(0.45, 0, 0.5, -15)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)
    
    return box
end

local NameInput = CreateInput("İsim Girin...", "NAME TAG")
local RankInput = CreateInput("Rütbe Girin...", "RANK TAG")

-- ACTION BUTTON (Uygula)
local ApplyBtn = Instance.new("TextButton", Content)
ApplyBtn.Size = UDim2.new(1, 0, 0, 50)
ApplyBtn.BackgroundColor3 = Color3.fromRGB(120, 170, 255)
ApplyBtn.Text = "AYARLARI SİSTEME ENJEKTE ET"
ApplyBtn.Font = Enum.Font.GothamBlack
ApplyBtn.TextSize = 14
ApplyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ApplyBtn)

-- TOGGLE BUTTON (Mobil İçin)
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(1, -70, 0.5, -27)
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Toggle.Text = "RE"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextSize = 18
Toggle.TextColor3 = Color3.fromRGB(120, 170, 255)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
local tStroke = Instance.new("UIStroke", Toggle)
tStroke.Color = Color3.fromRGB(120, 170, 255)
tStroke.Thickness = 2

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- PC KISAYOLU
UserInputService.InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        Main.Visible = not Main.Visible
    end
end)
