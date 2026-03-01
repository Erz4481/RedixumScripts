-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ - ULTIMATE EDITION ]] --
-- Created by: Rendix Studio
-- Project: Artvin Roleplay | Launch: 03.03.2026
-- Features: Real Team Swap, Spawn TP, Leaderboard Fix, Multi-Color, Mobile/PC Support

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("TA_1.0_Final") then CoreGui:FindFirstChild("TA_1.0_Final"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_1.0_Final"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Rayfield Style - Modern & Karanlık)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 620)
Main.Position = UDim2.new(0.5, -260, 0.5, -310)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- KENAR PARLAMASI (Glow Effect)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 3
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- BAŞLIK VE LOGO
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 70)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 SAHTE SS ÜRETİCİSİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24

-- GİRİŞ ALANLARI OLUŞTURUCU
local function CreateComplexRow(ph, pos, defaultRGB)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(0.9, 0, 0, 50)
    frame.Position = pos
    frame.BackgroundTransparency = 1

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.65, 0, 1, 0)
    box.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    box.PlaceholderText = ph
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    box.TextSize = 14
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", frame)
    rgb.Size = UDim2.new(0.3, 0, 1, 0)
    rgb.Position = UDim2.new(0.7, 0, 0, 0)
    rgb.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    rgb.PlaceholderText = "R,G,B"
    rgb.Text = defaultRGB or ""
    rgb.TextColor3 = Color3.new(1,1,1)
    rgb.Font = Enum.Font.Code
    Instance.new("UICorner", rgb)

    return box, rgb
end

local I_Name, C_Name = CreateComplexRow("Yeni İsim Girin", UDim2.new(0.05, 0, 0.15, 0))
local I_Rank, C_Rank = CreateComplexRow("Yeni Rütbe Girin", UDim2.new(0.05, 0, 0.26, 0))
local I_Team, C_Team = CreateComplexRow("Takım İsmi (Gerçek Geçiş)", UDim2.new(0.05, 0, 0.37, 0))

-- EKSTRA ÖZELLİKLER (Hız & Zıplama)
local SpeedBox = Instance.new("TextBox", Main)
SpeedBox.Size = UDim2.new(0.42, 0, 0, 50)
SpeedBox.Position = UDim2.new(0.05, 0, 0.48, 0)
SpeedBox.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
SpeedBox.PlaceholderText = "Hız (Walkspeed)"
SpeedBox.Text = "16"
SpeedBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", SpeedBox)

local JumpBox = Instance.new("TextBox", Main)
JumpBox.Size = UDim2.new(0.42, 0, 0, 50)
JumpBox.Position = UDim2.new(0.53, 0, 0.48, 0)
JumpBox.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
JumpBox.PlaceholderText = "Zıplama (Jump)"
JumpBox.Text = "50"
JumpBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", JumpBox)

-- ÜRET BUTONU (BÜYÜK)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 70)
Apply.Position = UDim2.new(0.05, 0, 0.65, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ VE HİLEYİ TETİKLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 20
Instance.new("UICorner", Apply)

-- RENDIX STUDIO İMZASI
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 40)
Credits.Position = UDim2.new(0, 0, 1, -50)
Credits.BackgroundTransparency = 1
Credits.Text = "Produced by Rendix Studio | Artvin RP Edition"
Credits.TextColor3 = Color3.new(1,1,1)
Credits.TextTransparency = 0.5
Credits.Font = Enum.Font.GothamItalic
Credits.TextSize = 14

-- MOBİL BUTONU (TA)
local MobBtn = Instance.new("TextButton", ScreenGui)
MobBtn.Size = UDim2.new(0, 60, 0, 60)
MobBtn.Position = UDim2.new(1, -80, 0.5, -30)
MobBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MobBtn.Text = "TA"
MobBtn.TextColor3 = Color3.new(1,1,1)
MobBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", MobBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", MobBtn).Thickness = 2
MobBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ANA SİSTEM FONKSİYONLARI (FIXED)
local function TriggerFinal()
    local char = Player.Character
    if not char or not char:FindFirstChild("Humanoid") then return end

    -- Hız ve Zıplama Uygulama
    char.Humanoid.WalkSpeed = tonumber(SpeedBox.Text) or 16
    char.Humanoid.JumpPower = tonumber(JumpBox.Text) or 50

    local function ParseRGB(box, default)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or default
    end

    -- Takım Geçişi, Otomatik Renk ve Spawn TP
    local teamColor = Color3.new(1,1,1)
    if I_Team.Text ~= "" then
        local targetTeam = Teams:FindFirstChild(I_Team.Text)
        if targetTeam then
            Player.Team = targetTeam
            teamColor = targetTeam.TeamColor.Color
            task.wait(0.2) -- Spawn garantileme süresi
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == targetTeam.TeamColor then
                    char.HumanoidRootPart.CFrame = s.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- İsim Etiketi ve Rütbe Senkronizasyonu
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local lowText = v.Text:lower()
            -- İSİM KONTROL
            if I_Name.Text ~= "" and (lowText:find(Player.Name:lower()) or lowText:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text
                v.TextColor3 = ParseRGB(C_Name, teamColor)
            -- RÜTBE KONTROL
            elseif I_Rank.Text ~= "" and (lowText:find("guest") or v.Name:lower():find("rank") or lowText:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = ParseRGB(C_Rank, teamColor)
            -- TAKIM KONTROL
            elseif I_Team.Text ~= "" and (lowText:find("sivil") or v.Name:lower():find("team")) then
                v.Text = I_Team.Text
                v.TextColor3 = ParseRGB(C_Team, teamColor)
            end
        end
    end

    -- Liderlik Tablosu (TAB) Fix
    local pList = CoreGui:FindFirstChild("PlayerList")
    if pList then
        for _, obj in pairs(pList:GetDescendants()) do
            if obj:IsA("TextLabel") and (obj.Text == Player.Name or obj.Text == Player.DisplayName) then
                if I_Name.Text ~= "" then obj.Text = I_Name.Text end
                obj.TextColor3 = teamColor
            end
        end
    end
end

-- OTOMATİK TEKRARLAMA (ÖLÜNCE GİTMEMESİ İÇERİN)
Player.CharacterAdded:Connect(function()
    task.wait(1.5)
    if I_Name.Text ~= "" or I_Team.Text ~= "" then
        TriggerFinal()
    end
end)

Apply.MouseButton1Click:Connect(TriggerFinal)

-- 'K' TUŞU PC KONTROL
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
