-- [[ REDIXUM | TA SAHTE SS ÜRETİCİSİ V14 ]] --
-- Style: Rayfield UI (Dark & Glow) | Support: Mobile & PC
-- Project: Artvin Roleplay | Date: 01.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- Eski panelleri temizle
if CoreGui:FindFirstChild("Redixum_Rayfield_V14") then CoreGui:FindFirstChild("Redixum_Rayfield_V14"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_Rayfield_V14"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Rayfield Tarzı Karanlık & Oval)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 500)
Main.Position = UDim2.new(0.5, -225, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- Kenar Parlaması (Glow Effect)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- MOBİL İÇİN KAPAT/AÇ BUTONU (Ekranın sağında küçük buton)
local MobileToggle = Instance.new("TextButton", ScreenGui)
MobileToggle.Size = UDim2.new(0, 50, 0, 50)
MobileToggle.Position = UDim2.new(1, -60, 0.5, -25)
MobileToggle.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
MobileToggle.Text = "R"
MobileToggle.TextColor3 = Color3.new(1,1,1)
MobileToggle.Font = Enum.Font.GothamBlack
Instance.new("UICorner", MobileToggle).CornerRadius = UDim.new(1, 0)
MobileToggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "REDIXUM SS GEN V14"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20

-- INPUT OLUŞTURUCU (Rayfield Stili)
local function CreateInput(ph, pos)
    local box = Instance.new("TextBox", Main)
    box.Size = UDim2.new(0.9, 0, 0, 45)
    box.Position = pos
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    box.PlaceholderText = ph
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    return box
end

local I_Name = CreateInput("Yeni İsim", UDim2.new(0.05, 0, 0.15, 0))
local I_Rank = CreateInput("Yeni Rütbe", UDim2.new(0.05, 0, 0.28, 0))
local I_Team = CreateInput("Takım (Örn: Jandarma)", UDim2.new(0.05, 0, 0.41, 0))
local I_RGB = CreateInput("Renk (RGB: 255,255,255)", UDim2.new(0.05, 0, 0.54, 0))

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 55)
Apply.Position = UDim2.new(0.05, 0, 0.75, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "GÜNCELLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply).CornerRadius = UDim.new(0, 8)

-- ANA MANTIK (Fixlenmiş)
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    
    local teamCol = Color3.new(1,1,1)
    if I_RGB.Text ~= "" then
        local r, g, b = I_RGB.Text:match("(%d+),(%d+),(%d+)")
        if r and g and b then teamCol = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
    end

    -- Takım ve Teleport Fix
    if I_Team.Text ~= "" then
        local targetTeam = Teams:FindFirstChild(I_Team.Text)
        if targetTeam then
            Player.Team = targetTeam
            teamCol = (I_RGB.Text == "") and targetTeam.TeamColor.Color or teamCol
            task.wait(0.1)
            for _, s in pairs(workspace:GetDescendants()) do
                if s:IsA("SpawnLocation") and s.TeamColor == targetTeam.TeamColor then
                    char.HumanoidRootPart.CFrame = s.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- Karakter Etiketi Güncelleme
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text v.TextColor3 = teamCol
            elseif I_Rank.Text ~= "" and (t:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text v.TextColor3 = teamCol
            end
        end
    end

    -- TAB Menü Fix
    local pList = CoreGui:FindFirstChild("PlayerList")
    if pList then
        for _, frame in pairs(pList:GetDescendants()) do
            if frame:IsA("TextLabel") and frame.Text:find(Player.Name) then
                if I_Name.Text ~= "" then frame.Text = I_Name.Text end
                frame.TextColor3 = teamCol
            end
        end
    end
end)

-- PC İçin 'K' Tuşu, Mobil İçin Otomatik Gizleme
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
