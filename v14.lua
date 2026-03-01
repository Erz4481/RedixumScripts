-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ - FINAL FIX ]] --
-- Created by: Rendix Studio
-- Support: Mobile & PC | Universal Executor
-- Project: Artvin Roleplay | Date: 01.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- Eski UI temizleme
if CoreGui:FindFirstChild("TA_1.0_Official") then CoreGui:FindFirstChild("TA_1.0_Official"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_1.0_Official"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Rayfield Style Dark)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 460, 0, 520)
Main.Position = UDim2.new(0.5, -230, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2.5

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 SAHTE SS ÜRETİCİSİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22

-- INPUT SATIRLARI
local function CreateEntry(ph, pos)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(0.9, 0, 0, 45)
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
    rgb.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    rgb.PlaceholderText = "R,G,B"
    rgb.Text = ""
    rgb.TextColor3 = Color3.new(1,1,1)
    rgb.Font = Enum.Font.Code
    Instance.new("UICorner", rgb)

    return box, rgb
end

local I_Name, C_Name = CreateEntry("Yeni İsim", UDim2.new(0.05, 0, 0.18, 0))
local I_Rank, C_Rank = CreateEntry("Yeni Rütbe", UDim2.new(0.05, 0, 0.32, 0))
local I_Team, C_Team = CreateEntry("Takım İsmi", UDim2.new(0.05, 0, 0.46, 0))

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 60)
Apply.Position = UDim2.new(0.05, 0, 0.7, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ TETİKLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 18
Instance.new("UICorner", Apply)

-- IMZA
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 1, -40)
Credits.BackgroundTransparency = 1
Credits.Text = "Produced by Rendix Studio"
Credits.TextColor3 = Color3.new(1,1,1)
Credits.TextTransparency = 0.6
Credits.Font = Enum.Font.GothamItalic

-- MOBİL BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 55, 0, 55)
Mob.Position = UDim2.new(1, -70, 0.5, -27)
Mob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Mob.Text = "TA"
Mob.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- FONKSİYONLAR
local function ApplyAll()
    local char = Player.Character
    if not char then return end

    local function Parse(box, def)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or def
    end

    local finalCol = Color3.new(1,1,1)
    if I_Team.Text ~= "" then
        local t = Teams:FindFirstChild(I_Team.Text)
        if t then
            Player.Team = t
            finalCol = t.TeamColor.Color
            task.wait(0.1)
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == t.TeamColor then
                    char.HumanoidRootPart.CFrame = s.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text:lower()
            if I_Name.Text ~= "" and (txt:find(Player.Name:lower()) or txt:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text v.TextColor3 = Parse(C_Name, finalCol)
            elseif I_Rank.Text ~= "" and (txt:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text v.TextColor3 = Parse(C_Rank, finalCol)
            end
        end
    end
end

Apply.MouseButton1Click:Connect(ApplyAll)
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
