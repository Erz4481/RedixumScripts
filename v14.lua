-- [[ REDIX ELITE v18 - FUNCTIONAL FINAL ]] --
-- Fix: Name/Rank Change, Custom RGB, Team Scrolling, Draggable Mobile UI
-- Style: Classic Dark Void/Rendix Hybrid

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Teams = game:GetService("Teams")

local Player = Players.LocalPlayer

-- TEMİZLİK
if Player.PlayerGui:FindFirstChild("REDIX_V18_FINAL") then Player.PlayerGui:FindFirstChild("REDIX_V18_FINAL"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_V18_FINAL"
ScreenGui.IgnoreGuiInset = true -- Mobil uyum
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Eski Koyu Görünüm)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(580, 400)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12) -- Eski görünüm tonu
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(60, 70, 150)

-- SOL SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 80, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
Instance.new("UICorner", Sidebar)

-- İÇERİK ALANI (Scrolling)
local ScrollFrame = Instance.new("ScrollingFrame", Main)
ScrollFrame.Size = UDim2.new(1, -100, 1, -80)
ScrollFrame.Position = UDim2.new(0, 90, 0, 20)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
ScrollFrame.ScrollBarThickness = 3
Instance.new("UIListLayout", ScrollFrame).Padding = UDim.new(0, 10)

-- ÖZEL INPUT SİSTEMİ (RGB Destekli)
local function CreateControl(title)
    local f = Instance.new("Frame", ScrollFrame)
    f.Size = UDim2.new(1, 0, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", f)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.3, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.Text = title
    l.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.BackgroundTransparency = 1

    local txt = Instance.new("TextBox", f)
    txt.Size = UDim2.new(0.4, 0, 0.7, 0)
    txt.Position = UDim2.new(0.32, 0, 0.15, 0)
    txt.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    txt.PlaceholderText = "Metin..."
    txt.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", txt)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.new(0.23, 0, 0.7, 0)
    rgb.Position = UDim2.new(0.74, 0, 0.15, 0)
    rgb.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    rgb.Text = "255,255,255"
    rgb.TextColor3 = Color3.new(1, 1, 1)
    rgb.Font = Enum.Font.Code
    Instance.new("UICorner", rgb)
    
    return txt, rgb
end

local I_Name, C_Name = CreateControl("İSİM")
local I_Rank, C_Rank = CreateControl("RÜTBE")

-- TAKIM SEÇME LİSTESİ (Scrolling List)
local TeamTitle = Instance.new("TextLabel", ScrollFrame)
TeamTitle.Size = UDim2.new(1, 0, 0, 30)
TeamTitle.Text = "LİSTEDEN TAKIM SEÇ"
TeamTitle.TextColor3 = Color3.fromRGB(120, 170, 255)
TeamTitle.Font = Enum.Font.GothamBlack
TeamTitle.BackgroundTransparency = 1

local SelectedTeam, SelectedTeamColor = "", Color3.new(1,1,1)
for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", ScrollFrame)
    b.Size = UDim2.new(1, 0, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedTeamColor = t.TeamColor.Color
        TeamTitle.Text = "SEÇİLDİ: " .. t.Name:upper()
    end)
end

-- GÜNCELLE BUTONU (Büyük Mavi)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -110, 0, 50)
Apply.Position = UDim2.new(0, 95, 1, -65)
Apply.BackgroundColor3 = Color3.fromRGB(40, 110, 230)
Apply.Text = "NAMETAGLARI SİSTEME BAS"
Apply.Font = Enum.Font.GothamBlack
Apply.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Apply)

-- FONKSİYON: İSİM VE RÜTBE DEĞİŞTİRME
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character or Player.CharacterAdded:Wait()
    local function GetColor(box)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(r,g,b) or Color3.new(1,1,1)
    end

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetColor(C_Name)
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetColor(C_Rank)
            elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım")) then
                v.Text = SelectedTeam
                v.TextColor3 = SelectedTeamColor
            end
        end
    end
end)

-- SÜRÜKLENEBİLİR MOBİL BUTON (Advanced)
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.fromOffset(50, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Mob.Text = "RE"
Mob.TextColor3 = Color3.fromRGB(85, 95, 210)
Mob.Font = Enum.Font.GothamBlack
Mob.Draggable = true -- Artık hareket ettirebilirsin
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Mob).Color = Color3.fromRGB(85, 95, 210)

Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
UserInputService.InputBegan:Connect(function(i, p) if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end end)
