-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ ]] --
-- Created by: Rendix Studio
-- Version: Ultra Force-Fix (Universal)
-- Support: Mobile & PC | All Executors (Delta, Vega, Fluxus, etc.)

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- ESKİ UI TEMİZLEME
local old = CoreGui:FindFirstChild("TA_FINAL_UI")
if old then old:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_FINAL_UI"
ScreenGui.ResetOnSpawn = false

-- RAYFIELD STYLE DARK PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 550)
Main.Position = UDim2.new(0.5, -225, 0.5, -275)
Main.BackgroundColor3 = Color3.fromRGB(13, 13, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 3

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 | RENDIX STUDIO"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22

-- INPUT OLUŞTURUCU
local function AddInput(ph, pos)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(0.9, 0, 0, 50)
    frame.Position = pos
    frame.BackgroundTransparency = 1

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(0.65, 0, 1, 0)
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.PlaceholderText = ph
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", frame)
    rgb.Size = UDim2.new(0.3, 0, 1, 0)
    rgb.Position = UDim2.new(0.7, 0, 0, 0)
    rgb.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    rgb.PlaceholderText = "R,G,B"
    rgb.Text = ""
    rgb.TextColor3 = Color3.new(1,1,1)
    rgb.Font = Enum.Font.Code
    Instance.new("UICorner", rgb)

    return box, rgb
end

local I_Name, C_Name = AddInput("Sahte İsim", UDim2.new(0.05, 0, 0.15, 0))
local I_Rank, C_Rank = AddInput("Sahte Rütbe", UDim2.new(0.05, 0, 0.26, 0))
local I_Team, C_Team = AddInput("Takım Değiştir", UDim2.new(0.05, 0, 0.37, 0))

-- GOD MODE (Hız/Zıplama)
local Hız = Instance.new("TextBox", Main)
Hız.Size = UDim2.new(0.42, 0, 0, 50)
Hız.Position = UDim2.new(0.05, 0, 0.48, 0)
Hız.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Hız.PlaceholderText = "Hız (16)"
Hız.Text = "16"
Hız.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Hız)

local Zip = Instance.new("TextBox", Main)
Zip.Size = UDim2.new(0.42, 0, 0, 50)
Zip.Position = UDim2.new(0.53, 0, 0, 48) -- Hata düzeltildi: Y pozisyonu
Zip.Position = UDim2.new(0.53, 0, 0.48, 0)
Zip.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Zip.PlaceholderText = "Zıplama (50)"
Zip.Text = "50"
Zip.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Zip)

-- UYGULA BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 65)
Apply.Position = UDim2.new(0.05, 0, 0.65, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ ZORLA ÇALIŞTIR"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 20
Instance.new("UICorner", Apply)

-- IMZA
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 1, -40)
Credits.BackgroundTransparency = 1
Credits.Text = "Produced by Rendix Studio"
Credits.TextColor3 = Color3.new(1,1,1)
Credits.TextTransparency = 0.5
Credits.Font = Enum.Font.GothamItalic

-- MOBİL TA BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 60, 0, 60)
Mob.Position = UDim2.new(1, -75, 0.5, -30)
Mob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Mob.Text = "TA"
Mob.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ZORLAYICI FONKSİYON
local function ForceEverything()
    local char = Player.Character
    if not char then return end
    
    -- Hız/Zıplama
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = tonumber(Hız.Text) or 16
        hum.JumpPower = tonumber(Zip.Text) or 50
    end

    local function Parse(box, def)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or def
    end

    -- Takım ve Renk
    local tCol = Color3.new(1,1,1)
    if I_Team.Text ~= "" then
        local t = Teams:FindFirstChild(I_Team.Text)
        if t then
            Player.Team = t
            tCol = t.TeamColor.Color
            task.wait(0.1)
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == t.TeamColor then
                    char:MoveTo(s.Position + Vector3.new(0, 5, 0))
                    break
                end
            end
        end
    end

    -- HER ŞEYİ DEĞİŞTİR (Karakter içindeki tüm TextLabel'ları tarar)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            -- İsim mi?
            if I_Name.Text ~= "" and (v.Text:find(Player.Name) or v.Text:find(Player.DisplayName) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = Parse(C_Name, tCol)
            -- Rütbe mi?
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or v.Text:lower():find("guest") or v.Text:lower():find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = Parse(C_Rank, tCol)
            -- Takım mı?
            elseif I_Team.Text ~= "" and (v.Name:lower():find("team") or v.Text:lower():find("takım")) then
                v.Text = I_Team.Text
                v.TextColor3 = Parse(C_Team, tCol)
            end
        end
    end
end

Apply.MouseButton1Click:Connect(ForceEverything)

-- PC AÇ/KAPAT
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
