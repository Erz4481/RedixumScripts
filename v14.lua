-- [[ TA 1.0 - ELITE VISUAL EDITION ]] --
-- Created by: Rendix Studio
-- Style: Vanguard & Wave Premium UI

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")

-- ESKİ PANELİ SİL
if CoreGui:FindFirstChild("TA_Elite_UI") then CoreGui:FindFirstChild("TA_Elite_UI"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_Elite_UI"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Premium Dark Glass)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 440, 0, 540)
Main.Position = UDim2.new(0.5, -220, 0.5, -270)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- NEON KENAR ÇİZGİSİ (Glow)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2.5
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- ARKA PLAN GRADIENT (Üstten alta hafif renk geçişi)
local Gradient = Instance.new("UIGradient", Main)
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
})

-- BAŞLIK ALANI
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "RENDIX STUDIO | TA 1.0"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- INPUT SİSTEMİ (Premium Tasarım)
local function CreateEliteInput(ph, y, isColor)
    local box = Instance.new("TextBox", Main)
    box.Size = isColor and UDim2.new(0, 110, 0, 45) or UDim2.new(0, 230, 0, 45)
    box.Position = isColor and UDim2.new(0, 280, 0, y) or UDim2.new(0, 30, 0, y)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    box.PlaceholderText = ph
    box.Text = isColor and "255,255,255" or ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    box.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)
    
    local s = Instance.new("UIStroke", box)
    s.Color = Color3.fromRGB(40, 40, 45)
    s.Thickness = 1.2
    
    box.Focused:Connect(function() s.Color = Color3.fromRGB(0, 120, 255) end)
    box.FocusLost:Connect(function() s.Color = Color3.fromRGB(40, 40, 45) end)
    
    return box
end

local I_Name = CreateEliteInput("Yeni İsim Gir...", 70, false)
local C_Name = CreateEliteInput("R,G,B", 70, true)
local I_Rank = CreateEliteInput("Yeni Rütbe Gir...", 125, false)
local C_Rank = CreateEliteInput("R,G,B", 125, true)

-- TAKIM LİSTESİ BAŞLIĞI
local TeamLabel = Instance.new("TextLabel", Main)
TeamLabel.Size = UDim2.new(0, 200, 0, 20)
TeamLabel.Position = UDim2.new(0, 30, 0, 185)
TeamLabel.BackgroundTransparency = 1
TeamLabel.Text = "LİSTEDEN TAKIM SEÇ"
TeamLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
TeamLabel.Font = Enum.Font.GothamBold
TeamLabel.TextSize = 12
TeamLabel.TextXAlignment = Enum.TextXAlignment.Left

-- SCROLLING LIST (Vanguard Style)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(0, 380, 0, 180)
Scroll.Position = UDim2.new(0, 30, 0, 210)
Scroll.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 255)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UICorner", Scroll)
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 6)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local SelectedTeam = ""
local SelectedColor = Color3.new(1,1,1)

local function RefreshTeams()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, t in pairs(Teams:GetTeams()) do
        local btn = Instance.new("TextButton", Scroll)
        btn.Size = UDim2.new(0.95, 0, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        btn.Text = "  " .. t.Name
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.GothamBold
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        Instance.new("UICorner", btn)
        
        local bStroke = Instance.new("UIStroke", btn)
        bStroke.Color = t.TeamColor.Color
        bStroke.Thickness = 1.5
        bStroke.Transparency = 0.5

        btn.MouseButton1Click:Connect(function()
            SelectedTeam = t.Name
            SelectedColor = t.TeamColor.Color
            Title.Text = "SEÇİLEN: " .. t.Name:upper()
            Title.TextColor3 = t.TeamColor.Color
            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
            task.wait(0.2)
            TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(25, 25, 30)}):Play()
        end)
    end
    Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end
RefreshTeams()

-- ÜRET BUTONU (Zirve Efektli)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 380, 0, 55)
Apply.Position = UDim2.new(0, 30, 0, 410)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "NAMETAGLARI SİSTEME BAS"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 16
Instance.new("UICorner", Apply)

Apply.MouseEnter:Connect(function()
    TweenService:Create(Apply, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255), Size = UDim2.new(0, 390, 0, 60), Position = UDim2.new(0, 25, 0, 407.5)}):Play()
end)
Apply.MouseLeave:Connect(function()
    TweenService:Create(Apply, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 120, 255), Size = UDim2.new(0, 380, 0, 55), Position = UDim2.new(0, 30, 0, 410)}):Play()
end)

-- ANA GÜNCELLEME DÖNGÜSÜ (Eski Sağlam Mantık)
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    local function GetRGB(box)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Color3.new(1,1,1)
    end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetRGB(C_Name)
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetRGB(C_Rank)
            elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = SelectedTeam
                v.TextColor3 = SelectedColor
            end
        end
    end
end)

-- MOBİL BUTON (Elite Logo)
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 55, 0, 55)
Mob.Position = UDim2.new(1, -70, 0.5, -27)
Mob.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Mob.Text = "TA"
Mob.TextColor3 = Color3.fromRGB(0, 120, 255)
Mob.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1,0)
local mS = Instance.new("UIStroke", Mob)
mS.Color = Color3.fromRGB(0, 120, 255)
mS.Thickness = 2
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- PC K KISAYOL
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
