-- [[ TA 1.0 - ULTRA-FUNCTIONAL GLASS EDITION ]] --
-- Style: Ultra Glassmorphism
-- Target Launch: 03.03.2026
-- Fixes: Name/Rank/Color/Dropdown Functions

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- ESKİ PANELİ TEMİZLE
if Player.PlayerGui:FindFirstChild("REDIX_GLASS_FINAL") then Player.PlayerGui:FindFirstChild("REDIX_GLASS_FINAL"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_GLASS_FINAL"
ScreenGui.IgnoreGuiInset = true -- Mobil uyum
ScreenGui.ResetOnSpawn = false

-- ARKA PLAN BLUR (O premium "Glass" hissi için)
local BlurEffect = Lighting:FindFirstChild("RedixGlassBlur") or Instance.new("BlurEffect", Lighting)
BlurEffect.Name = "RedixGlassBlur"
BlurEffect.Size = 25
BlurEffect.Enabled = false -- Panel açıkken aktif olur

-- ANA PANEL (Glassmorphism Tasarımı)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(580, 430) -- Takım Dropdown için yer açıldı
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 40) -- Koyu cam tonu
Main.BackgroundTransparency = 0.15 -- Şeffaflık
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true -- PC için sürüklenebilir
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(100, 150, 255) -- Mavi neon kenar

-- SCROLLING AREA (Ayarlar)
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -100, 1, -90)
Content.Position = UDim2.new(0, 90, 0, 20)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 2, 0)
Content.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 10)

-- ÖZEL INPUT OLUŞTURUCU (RGB Destekli)
local function CreateEliteInput(title, place)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1, 0, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 30) -- Cam içi koyuluk
    f.BackgroundTransparency = 0.5 -- Hafif şeffaf
    f.BorderSizePixel = 0
    Instance.new("UICorner", f)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.fromScale(0.3, 1)
    l.Position = UDim2.fromOffset(10, 0)
    l.Text = title
    l.TextColor3 = Color3.new(0.8, 0.8, 0.8) -- Soluk gri metin
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.BackgroundTransparency = 1

    local txt = Instance.new("TextBox", f)
    txt.Size = UDim2.fromScale(0.4, 0.7)
    txt.Position = UDim2.fromScale(0.32, 0.15)
    txt.BackgroundColor3 = Color3.fromRGB(15, 15, 25) -- Koyu kutu
    txt.PlaceholderText = place
    txt.Text = ""
    txt.TextColor3 = Color3.new(1, 1, 1) -- Beyaz metin
    txt.Font = Enum.Font.Gotham
    txt.TextSize = 12
    Instance.new("UICorner", txt)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.fromScale(0.23, 0.7)
    rgb.Position = UDim2.fromScale(0.74, 0.15)
    rgb.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- Koyu kutu
    rgb.Text = "255,255,255" -- Varsayılan Beyaz
    rgb.TextColor3 = Color3.new(1, 1, 1)
    rgb.Font = Enum.Font.Code
    rgb.TextSize = 10
    Instance.new("UICorner", rgb)
    
    return txt, rgb
end

local I_Name, C_Name = CreateEliteInput("İSİM DEĞİŞTİR", "Metin...")
local I_Rank, C_Rank = CreateEliteInput("RÜTBE DEĞİŞTİR", "Kral...")

-- TAKIM DROPDOWN MENÜSÜ (Tıkla-Aç Scrolling)
local TeamTitleFrame = Instance.new("Frame", Content)
TeamTitleFrame.Size = UDim2.new(1, 0, 0, 45)
TeamTitleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30) -- Cam içi koyuluk
TeamTitleFrame.BackgroundTransparency = 0.5 -- Hafif şeffaf
Instance.new("UICorner", TeamTitleFrame)

local TeamTitleBtn = Instance.new("TextButton", TeamTitleFrame)
TeamTitleBtn.Size = UDim2.fromScale(1, 1)
TeamTitleBtn.BackgroundTransparency = 1
TeamTitleBtn.Text = "  TAKIM SEÇİM MENÜSÜ ▼" -- Referans görseldeki gibi
TeamTitleBtn.TextColor3 = Color3.fromRGB(120, 170, 255) -- Mavi metin
TeamTitleBtn.Font = Enum.Font.GothamBold
TeamTitleBtn.TextXAlignment = Enum.TextXAlignment.Left

local TeamListScroll = Instance.new("ScrollingFrame", Content)
TeamListScroll.Size = UDim2.new(1, 0, 0, 0) -- Başta kapalı
TeamListScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 25) -- Koyu liste
TeamListScroll.BackgroundTransparency = 0.2 -- Hafif şeffaf
TeamListScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
TeamListScroll.ScrollBarThickness = 2
TeamListScroll.Visible = false
local TeamListLayout = Instance.new("UIListLayout", TeamListScroll)

local SelectedTeam, SelectedTeamColor = "", Color3.new(1, 1, 1)

-- DROPDOWN AÇ/KAPAT MANTIĞI
TeamTitleBtn.MouseButton1Click:Connect(function()
    TeamListScroll.Visible = not TeamListScroll.Visible
    TeamListScroll.Size = TeamListScroll.Visible and UDim2.new(1, 0, 0, 120) or UDim2.new(1, 0, 0, 0)
    Content.CanvasSize = UDim2.new(0, 0, TeamListScroll.Visible and 2.5 or 2, 0) -- Canvası ayarla
end)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", TeamListScroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- Koyu buton
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedTeamColor = t.TeamColor.Color -- Takımın rengi
        TeamTitleBtn.Text = "  SEÇİLDİ: " .. t.Name:upper()
        TeamListScroll.Visible = false
        TeamListScroll.Size = UDim2.new(1, 0, 0, 0)
        Content.CanvasSize = UDim2.new(0, 0, 2, 0)
    end)
end

-- GÜNCELLE BUTONU (Lilly's Obby Referansı)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -110, 0, 50)
Apply.Position = UDim2.new(0, 95, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210) -- Premium mavi buton
Apply.Text = "AYARLARI KAYDET VE UYGULA"
Apply.Font = Enum.Font.GothamBlack
Apply.TextColor3 = Color3.new(1, 1, 1) -- Beyaz metin
Apply.TextSize = 14
Instance.new("UICorner", Apply)

-- ANA İŞLEM (Hatalar düzeltildi)
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local function GetColor(box)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(r,g,b) or Color3.new(1,1,1)
    end

    -- BillboardGui taraması (Nametagler buradadır)
    for _, tag in pairs(char:GetDescendants()) do
        if tag:IsA("BillboardGui") then
            for _, v in pairs(tag:GetDescendants()) do
                if v:IsA("TextLabel") then
                    local t = v.Text:lower()
                    -- İSİM (Senin RGB Rengin)
                    if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or v.Name:lower():find("name") or v.Name:lower():find("isim")) then
                        v.Text = I_Name.Text
                        v.TextColor3 = GetColor(C_Name) -- RGB kutusundan renk al
                    -- RÜTBE (Senin RGB Rengin)
                    elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or v.Name:lower():find("rütbe")) then
                        v.Text = I_Rank.Text
                        v.TextColor3 = GetColor(C_Rank) -- RGB kutusundan renk al
                    -- TAKIM VE TAKIM RENK FİKS (Kesin Çözüm)
                    elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım")) then
                        v.Text = SelectedTeam
                        v.TextColor3 = SelectedTeamColor -- Takımın kendi rengini bas
                    end
                end
            end
        end
    end
end)

-- MOBİL AÇ/KAPAT (Advanced Draggable "RE" Button)
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.fromOffset(55, 55)
Mob.Position = UDim2.new(1, -70, 0.5, -27)
Mob.BackgroundColor3 = Color3.fromRGB(30, 30, 40) -- Koyu cam tonu
Mob.Text = "RE"
Mob.TextColor3 = Color3.fromRGB(120, 170, 255) -- Mavi metin
Mob.Font = Enum.Font.GothamBlack
Mob.TextSize = 18
Mob.Draggable = true -- Harekete ettirebilirsin
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0) -- Yuvarlak
local MobStroke = Instance.new("UIStroke", Mob)
MobStroke.Color = Color3.fromRGB(100, 150, 255) -- Mavi neon kenar
MobStroke.Thickness = 1.5

-- PANEL AÇ/KAPAT & BLUR KONTROLÜ
local function ToggleHub()
    Main.Visible = not Main.Visible
    BlurEffect.Enabled = Main.Visible -- Panel açıkken blur aktif
end

Mob.MouseButton1Click:Connect(ToggleHub)
UserInputService.InputBegan:Connect(function(i, p) if not p and i.KeyCode == Enum.KeyCode.K then ToggleHub() end end)
