-- [[ TA 1.0 - ÇALIŞMA ODAKLI HAM SÜRÜM ]] --
-- Rendix Studio tarafından üretilmiştir.

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- ESKİ PANELİ SİL
if CoreGui:FindFirstChild("TA_Core_UI") then CoreGui:FindFirstChild("TA_Core_UI"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_Core_UI"

-- ANA PANEL (Çok Sade)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 400)
Main.Position = UDim2.new(0.5, -175, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.Active = true
Main.Draggable = true

-- INPUT OLUŞTURUCU FONKSİYON
local function CreateField(ph, y)
    local txt = Instance.new("TextBox", Main)
    txt.Size = UDim2.new(0.6, 0, 0, 40)
    txt.Position = UDim2.new(0.05, 0, 0, y)
    txt.PlaceholderText = ph
    txt.Text = ""
    txt.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    txt.TextColor3 = Color3.new(1,1,1)

    local clr = Instance.new("TextBox", Main)
    clr.Size = UDim2.new(0.3, 0, 0, 40)
    clr.Position = UDim2.new(0.67, 0, 0, y)
    clr.PlaceholderText = "R,G,B"
    clr.Text = "255,255,255"
    clr.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    clr.TextColor3 = Color3.new(1,1,1)
    
    return txt, clr
end

local I_Name, C_Name = CreateField("Yeni İsim", 60)
local I_Rank, C_Rank = CreateField("Yeni Rütbe", 120)
local I_Team, C_Team = CreateField("Yeni Takım", 180)

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 50)
Apply.Position = UDim2.new(0.05, 0, 0.75, 0)
Apply.Text = "ÜRET / GÜNCELLE"
Apply.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.SourceSansBold
Apply.TextSize = 20

-- MOBİL AÇ/KAPAT
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 50, 0, 50)
Mob.Position = UDim2.new(1, -60, 0.5, -25)
Mob.Text = "MENU"
Mob.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- RENK PARSE ETME
local function GetRGB(box)
    local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
    if r and g and b then
        return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))
    end
    return Color3.new(1,1,1)
end

-- ANA DÖNGÜ (HER ŞEYİ DEĞİŞTİRİR)
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            -- İSİM DEĞİŞTİRME
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetRGB(C_Name)
            -- RÜTBE DEĞİŞTİRME
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetRGB(C_Rank)
            -- TAKIM DEĞİŞTİRME
            elseif I_Team.Text ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = I_Team.Text
                v.TextColor3 = GetRGB(C_Team)
            end
        end
    end
end)

-- PC KISAYOL (K TUŞU)
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
