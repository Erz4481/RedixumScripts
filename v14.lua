-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ ]] --
-- Eski Çalışan Mantık + Yeni Kaliteli Görünüm
-- Created by: Rendix Studio
-- Support: Mobile & PC | Universal

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- Eski panelleri temizle
if CoreGui:FindFirstChild("TA_Rendix_V14") then CoreGui:FindFirstChild("TA_Rendix_V14"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_Rendix_V14"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Rayfield Style - Modern Dark)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 440, 0, 500)
Main.Position = UDim2.new(0.5, -220, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- Mavi Kenar Parlaması
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2.5

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 | SS ÜRETİCİSİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22

-- GİRİŞ ALANLARI (Kaliteleştirilmiş Inputlar)
local function CreateInput(ph, pos)
    local box = Instance.new("TextBox", Main)
    box.Size = UDim2.new(0.9, 0, 0, 50)
    box.Position = pos
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.PlaceholderText = ph
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    box.TextSize = 14
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    return box
end

local I_Name = CreateInput("Görünecek Yeni İsim", UDim2.new(0.05, 0, 0.18, 0))
local I_Rank = CreateInput("Görünecek Yeni Rütbe", UDim2.new(0.05, 0, 0.32, 0))
local I_Team = CreateInput("Takım İsmi (Otomatik Renk & Geçiş)", UDim2.new(0.05, 0, 0.46, 0))
local I_RGB = CreateInput("Özel Renk (Opsiyonel: 255,0,0)", UDim2.new(0.05, 0, 0.60, 0))

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 60)
Apply.Position = UDim2.new(0.05, 0, 0.78, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "NAMETAGLARİ ZORLA GÜNCELLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 18
Instance.new("UICorner", Apply).CornerRadius = UDim.new(0, 8)

-- RENDIX STUDIO İMZASI (Şeffaf)
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 1, -35)
Credits.BackgroundTransparency = 1
Credits.Text = "Produced by Rendix Studio"
Credits.TextColor3 = Color3.new(1,1,1)
Credits.TextTransparency = 0.6
Credits.Font = Enum.Font.GothamItalic
Credits.TextSize = 12

-- MOBİL TA BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 55, 0, 55)
Mob.Position = UDim2.new(1, -70, 0.5, -27)
Mob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Mob.Text = "TA"
Mob.TextColor3 = Color3.new(1,1,1)
Mob.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ESKİ SAĞLAM MANTIK (FIXED & IMPROVED)
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    -- Renk Belirleme
    local finalColor = Color3.new(1,1,1)
    if I_RGB.Text ~= "" then
        local r, g, b = I_RGB.Text:match("(%d+),(%d+),(%d+)")
        if r and g and b then finalColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
    end

    -- Takım ve Otomatik Renk
    if I_Team.Text ~= "" then
        local target = Teams:FindFirstChild(I_Team.Text)
        if target then
            Player.Team = target
            if I_RGB.Text == "" then finalColor = target.TeamColor.Color end
            -- Spawn Teleport
            task.wait(0.1)
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == target.TeamColor then
                    char:MoveTo(s.Position + Vector3.new(0, 5, 0))
                    break
                end
            end
        end
    end

    -- Nametag Değiştirici (Zorlayıcı Döngü)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text:lower()
            -- İsim mi?
            if I_Name.Text ~= "" and (txt:find(Player.Name:lower()) or txt:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = finalColor
            -- Rütbe mi?
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or txt:find("guest") or txt:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = finalColor
            -- Takım mı?
            elseif I_Team.Text ~= "" and (v.Name:lower():find("team") or txt:find("takım") or txt:find("sivil")) then
                v.Text = I_Team.Text
                v.TextColor3 = finalColor
            end
        end
    end
end)

-- PC İçin 'K' Tuşu
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
