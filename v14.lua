-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ - RE-DEVELOPED ]] --
-- Created by: Rendix Studio
-- Focus: NameTag Text & Color (Universal)
-- Date: 02.03.2026 | Launch Ready

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("TA_Rendix_Final") then CoreGui:FindFirstChild("TA_Rendix_Final"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_Rendix_Final"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Rayfield Style - Modern & Karanlık)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 480)
Main.Position = UDim2.new(0.5, -210, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2.5

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 | SAHTE SS ÜRETİCİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20

-- INPUT OLUŞTURUCU
local function CreateRow(ph, pos)
    local box = Instance.new("TextBox", Main)
    box.Size = UDim2.new(0, 240, 0, 45)
    box.Position = pos
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.PlaceholderText = ph
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", Main)
    rgb.Size = UDim2.new(0, 120, 0, 45)
    rgb.Position = pos + UDim2.new(0, 250, 0, 0)
    rgb.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    rgb.PlaceholderText = "R,G,B (Oto)"
    rgb.Text = ""
    rgb.TextColor3 = Color3.new(1,1,1)
    rgb.Font = Enum.Font.Code
    Instance.new("UICorner", rgb)
    return box, rgb
end

local I_Name, C_Name = CreateRow("Yeni İsim", UDim2.new(0, 20, 0, 80))
local I_Rank, C_Rank = CreateRow("Yeni Rütbe", UDim2.new(0, 20, 0, 140))
local I_Team, C_Team = CreateRow("Takım İsmi", UDim2.new(0, 20, 0, 200))

-- UYGULA BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 380, 0, 60)
Apply.Position = UDim2.new(0, 20, 0, 280)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "NAMETAG GÜNCELLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
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
Mob.Size = UDim2.new(0, 50, 0, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Mob.Text = "TA"
Mob.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- GELİŞMİŞ GÜNCELLEME MANTIĞI
local function ForceUpdate()
    local char = Player.Character
    if not char then return end

    local function ParseRGB(box, default)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or default
    end

    -- Otomatik Takım Rengi Yakalama
    local teamCol = Color3.new(1,1,1)
    if I_Team.Text ~= "" then
        local t = Teams:FindFirstChild(I_Team.Text)
        if t then
            Player.Team = t
            teamCol = t.TeamColor.Color
            -- Spawn Teleport
            task.wait(0.1)
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == t.TeamColor then
                    char:MoveTo(s.Position + Vector3.new(0, 5, 0))
                    break
                end
            end
        end
    end

    -- Nametag Değiştirme (Tüm Billboard ve TextLabel'ları tarar)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text:lower()
            -- İSİM
            if I_Name.Text ~= "" and (txt:find(Player.Name:lower()) or txt:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = ParseRGB(C_Name, teamCol)
            -- RÜTBE
            elseif I_Rank.Text ~= "" and (txt:find("guest") or v.Name:lower():find("rank") or txt:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = ParseRGB(C_Rank, teamCol)
            -- TAKIM
            elseif I_Team.Text ~= "" and (txt:find("sivil") or v.Name:lower():find("team") or txt:find("takım")) then
                v.Text = I_Team.Text
                v.TextColor3 = ParseRGB(C_Team, teamCol)
            end
        end
    end
end

Apply.MouseButton1Click:Connect(ForceUpdate)
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
