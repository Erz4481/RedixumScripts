-- [[ REDIXUM | TA SAHTE SS ÜRETİCİSİ ]] --
-- Professional Edition | Dark Theme | Multi-Target
-- Project: Artvin Roleplay | Launch: 03.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- Temizlik
if CoreGui:FindFirstChild("Redixum_SS_Pro") then CoreGui:FindFirstChild("Redixum_SS_Pro"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_SS_Pro"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL TASARIMI (Baya Kaliteli & Karanlık Tema)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 480, 0, 580)
Main.Position = UDim2.new(0.5, -240, 0.5, -290)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15) -- Çok Karanlık Arka Plan
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255) -- Mavi Vurgu
Stroke.Thickness = 2.5

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "REDIXUM | TA SAHTE SS ÜRETİCİSİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22

-- HEDEF SEÇİMİ (Kişi mi Liderlik Tablosu mu?)
local TargetLabel = Instance.new("TextLabel", Main)
TargetLabel.Size = UDim2.new(0.9, 0, 0, 30)
TargetLabel.Position = UDim2.new(0.05, 0, 0.12, 0)
TargetLabel.BackgroundTransparency = 1
TargetLabel.Text = "DEĞİŞTİRİLECEK HEDEFİ SEÇİN:"
TargetLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
TargetLabel.Font = Enum.Font.Gotham
TargetLabel.TextSize = 14

local isTargetLeaderboard = false
local ToggleTarget = Instance.new("TextButton", Main)
ToggleTarget.Size = UDim2.new(0.9, 0, 0, 40)
ToggleTarget.Position = UDim2.new(0.05, 0, 0.18, 0)
ToggleTarget.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleTarget.Text = "KİŞİSEL GÖRÜNÜMÜ DEĞİŞTİR"
ToggleTarget.TextColor3 = Color3.new(1,1,1)
ToggleTarget.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleTarget)
ToggleTarget.MouseButton1Click:Connect(function()
    isTargetLeaderboard = not isTargetLeaderboard
    if isTargetLeaderboard then
        ToggleTarget.Text = "LİDERLİK TABLOSUNU DEĞİŞTİR (TAB MENÜSÜ)"
        ToggleTarget.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    else
        ToggleTarget.Text = "KİŞİSEL GÖRÜNÜMÜ DEĞİŞTİR"
        ToggleTarget.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    end
end)

-- GİRİŞ ALANLARI
local function AddInput(ph, pos, sizeY)
    local f = Instance.new("TextBox", Main)
    f.Size = UDim2.new(0.9, 0, 0, sizeY or 45)
    f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    f.PlaceholderText = ph
    f.Text = ""
    f.TextColor3 = Color3.new(1,1,1)
    f.Font = Enum.Font.GothamBold
    Instance.new("UICorner", f)
    return f
end

local I_Name = AddInput("İsim Değiştir (Örn: AdminRedix)", UDim2.new(0.05, 0, 0.28, 0))
local I_Rank = AddInput("Rütbe Değiştir (Örn: OF-6.../Guest)", UDim2.new(0.05, 0, 0.38, 0))
local I_Team = AddInput("Takım Değiştir (Örn: Ordu Subayları/Sivil)", UDim2.new(0.05, 0, 0.48, 0))
local I_Color = AddInput("Takım Rengi (Örn: 255,0,0) (Yazılmazsa Otomatik)", UDim2.new(0.05, 0, 0.58, 0))

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 60)
Apply.Position = UDim2.new(0.05, 0, 0.75, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "SİSTEMİ TETİKLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 20
Instance.new("UICorner", Apply)

-- ALT BİLGİ
local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(1, 0, 0, 30)
Info.Position = UDim2.new(0, 0, 1, -40)
Info.BackgroundTransparency = 1
Info.Text = "Gizlemek/Açmak için 'K' Tuşuna Basın"
Info.TextColor3 = Color3.fromRGB(150, 150, 150)
Info.Font = Enum.Font.Gotham
Info.TextSize = 12

-- FONKSİYONLAR
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    
    local targetColor = Color3.new(1,1,1)
    
    -- Takım Rengi Kontrolü
    if I_Color.Text ~= "" then
        local r, g, b = I_Color.Text:match("(%d+),(%d+),(%d+)")
        if r and g and b then targetColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
    end

    -- Gerçek Takım Atama ve Spawn Teleport (Kişisel Görünüm)
    if not isTargetLeaderboard and I_Team.Text ~= "" then
        local targetTeam = Teams:FindFirstChild(I_Team.Text)
        if targetTeam then
            Player.Team = targetTeam
            task.wait(0.1)
            for _, spawn in pairs(workspace:GetDescendants()) do
                if spawn:IsA("SpawnLocation") and spawn.TeamColor == targetTeam.TeamColor then
                    char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
                    break
                end
            end
        end
    end

    -- YAZI GÜNCELLEME (Karanlık Mod)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower())) then
                v.Text = I_Name.Text
                v.TextColor3 = targetColor
            elseif I_Rank.Text ~= "" and (t:find("guest") or v.Name:lower():find("rank")) then
                v.Text = I_Rank.Text
                v.TextColor3 = targetColor
            elseif I_Team.Text ~= "" and (t:find("sivil") or v.Name:lower():find("team")) then
                v.Text = I_Team.Text
                v.TextColor3 = targetColor
            end
        end
    end

    -- LİDERLİK TABLOSUNU DEĞİŞTİRME MANTIĞI (TAB Menüsü)
    if isTargetLeaderboard then
        local coreGuiList = CoreGui:FindFirstChild("PlayerList")
        if coreGuiList then
            local playerList = coreGuiList:FindFirstChild("ClippedFrame"):FindFirstChild("Frame"):FindFirstChild("ScrollingFrame")
            if playerList then
                for _, playerFrame in pairs(playerList:GetChildren()) do
                    if playerFrame:IsA("Frame") and playerFrame.Name:find(Player.Name) then
                        local entryName = playerFrame:FindFirstChild("NameText")
                        local entryTeam = playerFrame:FindFirstChild("TeamText")
                        local entryRank = playerFrame:FindFirstChild("RankText")
                        
                        if entryName and I_Name.Text ~= "" then entryName.Text = I_Name.Text entryName.TextColor3 = targetColor end
                        if entryRank and I_Rank.Text ~= "" then entryRank.Text = I_Rank.Text entryRank.TextColor3 = targetColor end
                        if entryTeam and I_Team.Text ~= "" then entryTeam.Text = I_Team.Text entryTeam.TextColor3 = targetColor end
                    end
                end
            end
        end
    end
end)

-- Re Atınca Otomatik Işınla ve Güncelle
Player.CharacterAdded:Connect(function()
    task.wait(1)
    if I_Team.Text ~= "" then
        Apply:TiggerClick() -- Otomatik Tetikle
    end
end)

-- K Tuşu Gizleme/Açma
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
