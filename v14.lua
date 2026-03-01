-- [[ REDIXUM ULTIMATE V14 - AUTO COLOR & SPAWN FIX ]] --
-- Project: Artvin Roleplay | Launch: 03.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

if CoreGui:FindFirstChild("Redixum_Ultimate_Final") then CoreGui:FindFirstChild("Redixum_Ultimate_Final"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_Ultimate_Final"
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
    input.Size = UDim2.new(0, 380, 0, 45)
    input.Position = pos
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    input.PlaceholderText = ph
    input.Text = ""
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.GothamBold
    Instance.new("UICorner", input)
    return input
end

local I_Name = CreateRow("Yeni İsim", UDim2.new(0, 20, 0, 70))
local I_Rank = CreateRow("Yeni Rütbe", UDim2.new(0, 20, 0, 130))
local I_Team = CreateRow("Takım İsmi (Örn: Jandarma)", UDim2.new(0, 20, 0, 190))

local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 380, 0, 60)
Apply.Position = UDim2.new(0, 20, 0, 270)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ TETİKLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

-- IŞINLANMA VE GÜNCELLEME FONKSİYONU
local function ExecuteAdmin()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local teamColor = Color3.new(1,1,1)
    
    -- TAKIM KONTROLÜ
    if I_Team.Text ~= "" then
        local targetTeam = Teams:FindFirstChild(I_Team.Text)
        if targetTeam then
            Player.Team = targetTeam
            teamColor = targetTeam.TeamColor.Color
            
            -- Spawn'a Işınla (Karakter yüklendikten sonra)
            task.wait(0.1)
            for _, spawn in pairs(workspace:GetDescendants()) do
                if spawn:IsA("SpawnLocation") and spawn.TeamColor == targetTeam.TeamColor then
                    char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- YAZI GÜNCELLEME
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text
                v.TextColor3 = teamColor
            elseif I_Rank.Text ~= "" and (t:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text
                v.TextColor3 = teamColor
            elseif I_Team.Text ~= "" and (t:find("sivil") or v.Name:lower():find("team")) then
                v.Text = I_Team.Text
                v.TextColor3 = teamColor
            end
        end
    end
end

-- Reset Atınca Otomatik Işınla
Player.CharacterAdded:Connect(function()
    task.wait(1) -- Spawn olması için süre
    if I_Team.Text ~= "" then
        ExecuteAdmin()
    end
end)

Apply.MouseButton1Click:Connect(ExecuteAdmin)

UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
