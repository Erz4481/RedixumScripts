-- [[ REDIXUM PREMIUM V14 - MULTI-COLOR UPDATE ]] --
-- Project: Artvin Roleplay
-- Launch Date: 03.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

if CoreGui:FindFirstChild("Redixum_V14_MultiColor") then CoreGui:FindFirstChild("Redixum_V14_MultiColor"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_V14_MultiColor"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 400, 0, 450)
Main.Position = UDim2.new(0.5, -200, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "REDIXUM MULTI-COLOR PANEL"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

-- ÖZEL SATIR OLUŞTURUCU (Yazı + Renk)
local function AddRow(ph, pos, defColor)
    local input = Instance.new("TextBox", Main)
    input.Size = UDim2.new(0, 240, 0, 45)
    input.Position = pos
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    input.PlaceholderText = ph
    input.Text = ""
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.GothamBold
    Instance.new("UICorner", input)

    local colorInput = Instance.new("TextBox", Main)
    colorInput.Size = UDim2.new(0, 100, 0, 45)
    colorInput.Position = pos + UDim2.new(0, 250, 0, 0)
    colorInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    colorInput.PlaceholderText = "RGB"
    colorInput.Text = defColor
    colorInput.TextColor3 = Color3.new(1,1,1)
    colorInput.Font = Enum.Font.Code
    Instance.new("UICorner", colorInput)

    return input, colorInput
end

local I_Name, C_Name = AddRow("Yeni İsim", UDim2.new(0, 20, 0, 70), "255,255,255")
local I_Rank, C_Rank = AddRow("Yeni Rütbe", UDim2.new(0, 20, 0, 130), "200,200,200")
local I_Team, C_Team = AddRow("Yeni Takım", UDim2.new(0, 20, 0, 190), "255,0,0")

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 350, 0, 60)
Apply.Position = UDim2.new(0, 25, 0, 270)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "HEPSİNİ UYGULA"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

-- RENK ÇEVİRİCİ
local function GetColor(txt)
    local r, g, b = txt:match("(%d+),(%d+),(%d+)")
    if r and g and b then return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
    return Color3.new(1,1,1)
end

-- ÇALIŞMA MANTIĞI
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text:lower()
            -- İSİM KONTROL
            if I_Name.Text ~= "" and (txt:find(Player.Name:lower()) or txt:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text
                v.TextColor3 = GetColor(C_Name.Text)
            -- RÜTBE KONTROL
            elseif I_Rank.Text ~= "" and (txt:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetColor(C_Rank.Text)
            -- TAKIM KONTROL
            elseif I_Team.Text ~= "" and (txt:find("sivil") or v.Name:lower():find("team")) then
                v.Text = I_Team.Text
                v.TextColor3 = GetColor(C_Team.Text)
            end
        end
    end
end)

-- K Tuşu Gizleme
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
