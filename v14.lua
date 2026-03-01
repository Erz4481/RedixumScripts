-- [[ REDIXUM PREMIUM V14 - REAL TEAM SWAP & TELEPORT ]] --
-- Project: Artvin Roleplay | Date: 01.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

if CoreGui:FindFirstChild("Redixum_Ultimate_V14") then CoreGui:FindFirstChild("Redixum_Ultimate_V14"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_Ultimate_V14"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 480)
Main.Position = UDim2.new(0.5, -210, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
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
Title.Text = "REDIXUM ADMIN ULTIMATE"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20

-- SATIR OLUŞTURUCU
local function CreateRow(ph, pos)
    local input = Instance.new("TextBox", Main)
    input.Size = UDim2.new(0, 200, 0, 45)
    input.Position = pos
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    input.PlaceholderText = ph
    input.Text = ""
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.GothamBold
    Instance.new("UICorner", input)

    local colorBtn = Instance.new("TextButton", Main)
    colorBtn.Size = UDim2.new(0, 45, 0, 45)
    colorBtn.Position = pos + UDim2.new(0, 210, 0, 0)
    colorBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    colorBtn.Text = ""
    Instance.new("UICorner", colorBtn)

    local rgbInput = Instance.new("TextBox", Main)
    rgbInput.Size = UDim2.new(0, 110, 0, 45)
    rgbInput.Position = pos + UDim2.new(0, 265, 0, 0)
    rgbInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    rgbInput.Text = "255,255,255"
    rgbInput.TextColor3 = Color3.new(1,1,1)
    rgbInput.Font = Enum.Font.Code
    Instance.new("UICorner", rgbInput)

    return input, colorBtn, rgbInput
end

local I_Name, B_Name, C_Name = CreateRow("Yeni İsim", UDim2.new(0, 20, 0, 70))
local I_Rank, B_Rank, C_Rank = CreateRow("Yeni Rütbe", UDim2.new(0, 20, 0, 130))
local I_Team, B_Team, C_Team = CreateRow("Takım (Gerçek Atar)", UDim2.new(0, 20, 0, 190))

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 380, 0, 60)
Apply.Position = UDim2.new(0, 20, 0, 270)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ TETİKLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

-- RENK PARSE
local function ParseColor(txt)
    local r, g, b = txt:match("(%d+),(%d+),(%d+)")
    if r and g and b then return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
    return Color3.new(1,1,1)
end

-- ANA MANTIK
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    -- GERÇEK TAKIM DEĞİŞTİRME VE TELEPORT
    if I_Team.Text ~= "" then
        local targetTeam = Teams:FindFirstChild(I_Team.Text)
        if targetTeam then
            Player.Team = targetTeam
            -- Takım Spawnına Işınla
            for _, spawn in pairs(workspace:GetDescendants()) do
                if spawn:IsA("SpawnLocation") and spawn.TeamColor == targetTeam.TeamColor then
                    char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- YAZI VE RENK GÜNCELLEME
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text
                v.TextColor3 = ParseColor(C_Name.Text)
            elseif I_Rank.Text ~= "" and (t:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text
                v.TextColor3 = ParseColor(C_Rank.Text)
            elseif I_Team.Text ~= "" and (t:find("sivil") or v.Name:lower():find("team")) then
                v.Text = I_Team.Text
                v.TextColor3 = ParseColor(C_Team.Text)
            end
        end
    end
end)

-- K Tuşu Gizleme
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
