-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ ]] --
-- Created by: Rendix Studio
-- Support: Mobile & PC | Universal Executor
-- Project: Artvin Roleplay | Date: 01.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- Eski panelleri temizle
if CoreGui:FindFirstChild("TA_1.0_Rendix") then CoreGui:FindFirstChild("TA_1.0_Rendix"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_1.0_Rendix"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Rayfield Style)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 480, 0, 550)
Main.Position = UDim2.new(0.5, -240, 0.5, -275)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 SAHTE SS ÜRETİCİSİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20

-- SATIR OLUŞTURUCU (Her biri için özel renk)
local function CreateRow(ph, pos)
    local input = Instance.new("TextBox", Main)
    input.Size = UDim2.new(0, 260, 0, 45)
    input.Position = pos
    input.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    input.PlaceholderText = ph
    input.Text = ""
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.GothamBold
    Instance.new("UICorner", input)

    local rgbInput = Instance.new("TextBox", Main)
    rgbInput.Size = UDim2.new(0, 110, 0, 45)
    rgbInput.Position = pos + UDim2.new(0, 270, 0, 0)
    rgbInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    rgbInput.PlaceholderText = "Renk (R,G,B)"
    rgbInput.Text = ""
    rgbInput.TextColor3 = Color3.new(1,1,1)
    rgbInput.Font = Enum.Font.Code
    Instance.new("UICorner", rgbInput)

    return input, rgbInput
end

local I_Name, C_Name = CreateRow("Yeni İsim", UDim2.new(0, 20, 0, 70))
local I_Rank, C_Rank = CreateRow("Yeni Rütbe", UDim2.new(0, 20, 0, 130))
local I_Team, C_Team = CreateRow("Takım (Örn: Jandarma)", UDim2.new(0, 20, 0, 190))

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 440, 0, 60)
Apply.Position = UDim2.new(0, 20, 0, 270)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ TETİKLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

-- RENDIX STUDIO İMZASI (Şeffaf Alt Yazı)
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 1, -35)
Credits.BackgroundTransparency = 1
Credits.Text = "Produced by Rendix Studio"
Credits.TextColor3 = Color3.new(1,1,1)
Credits.TextTransparency = 0.6
Credits.Font = Enum.Font.GothamItalic
Credits.TextSize = 12

-- MOBİL TOGGLE BUTONU
local MobBtn = Instance.new("TextButton", ScreenGui)
MobBtn.Size = UDim2.new(0, 50, 0, 50)
MobBtn.Position = UDim2.new(1, -60, 0.5, -25)
MobBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MobBtn.Text = "TA"
MobBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MobBtn).CornerRadius = UDim.new(1, 0)
MobBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ANA FONKSİYON
local function RunLogic()
    local char = Player.Character
    if not char then return end

    local function GetCol(box, defaultCol)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        if r and g and b then return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
        return defaultCol
    end

    -- Takım Geçişi ve Otomatik Renk Yakalama
    local finalTeamCol = Color3.new(1,1,1)
    if I_Team.Text ~= "" then
        local target = Teams:FindFirstChild(I_Team.Text)
        if target then
            Player.Team = target
            finalTeamCol = target.TeamColor.Color
            task.wait(0.1)
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == target.TeamColor then
                    char.HumanoidRootPart.CFrame = s.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- Tag ve TAB Güncelleme
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text v.TextColor3 = GetCol(C_Name, finalTeamCol)
            elseif I_Rank.Text ~= "" and (t:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text v.TextColor3 = GetCol(C_Rank, finalTeamCol)
            elseif I_Team.Text ~= "" and (t:find("sivil") or v.Name:lower():find("team")) then
                v.Text = I_Team.Text v.TextColor3 = GetCol(C_Team, finalTeamCol)
            end
        end
    end
end

Apply.MouseButton1Click:Connect(RunLogic)
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
