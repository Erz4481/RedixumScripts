-- [[ TA 1.0 - COMPACT GLASS EDITION ]] --
-- Style: Centered Compact Glass
-- Fixes: Force Color Sync, Dropdown System, Centered UI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- TEMİZLİK
if Player.PlayerGui:FindFirstChild("REDIX_FINAL_COMPACT") then Player.PlayerGui.REDIX_FINAL_COMPACT:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_FINAL_COMPACT"
ScreenGui.ResetOnSpawn = false

-- ARKA PLAN BLUR
local Blur = Lighting:FindFirstChild("CompactBlur") or Instance.new("BlurEffect", Lighting)
Blur.Name = "CompactBlur"
Blur.Size = 20
Blur.Enabled = false

-- ANA PANEL (Küçültüldü ve Ortalandı)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(450, 350) -- Daha küçük boyut
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BackgroundTransparency = 0.2 -- Cam efekti
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(100, 150, 255)
Stroke.Thickness = 1.5

-- İÇERİK ALANI
local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -30, 1, -80)
Content.Position = UDim2.new(0, 15, 0, 15)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 1.8, 0)
Content.ScrollBarThickness = 0
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 8)

-- INPUT OLUŞTURUCU
local function CreateInp(title, place)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    f.BackgroundTransparency = 0.4
    Instance.new("UICorner", f)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.fromScale(0.3, 1)
    l.Position = UDim2.fromOffset(10, 0)
    l.Text = title
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
    l.BackgroundTransparency = 1

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.fromScale(0.4, 0.7)
    box.Position = UDim2.fromScale(0.32, 0.15)
    box.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    box.PlaceholderText = place
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.Font = Enum.Font.Gotham
    box.TextSize = 11
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.fromScale(0.23, 0.7)
    rgb.Position = UDim2.fromScale(0.74, 0.15)
    rgb.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    rgb.Text = "255,255,255"
    rgb.TextColor3 = Color3.new(1, 1, 1)
    rgb.Font = Enum.Font.Code
    rgb.TextSize = 9
    Instance.new("UICorner", rgb)
    
    return box, rgb
end

local I_Name, C_Name = CreateInp("İSİM", "Metin...")
local I_Rank, C_Rank = CreateInp("RÜTBE", "Kral...")

-- DROPDOWN TAKIM SEÇME
local DropFrame = Instance.new("Frame", Content)
DropFrame.Size = UDim2.new(1, 0, 0, 40)
DropFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
DropFrame.BackgroundTransparency = 0.4
Instance.new("UICorner", DropFrame)

local DropBtn = Instance.new("TextButton", DropFrame)
DropBtn.Size = UDim2.fromScale(1, 1)
DropBtn.BackgroundTransparency = 1
DropBtn.Text = "  TAKIM SEÇİMİ ▼"
DropBtn.TextColor3 = Color3.fromRGB(120, 170, 255)
DropBtn.Font = Enum.Font.GothamBold
DropBtn.TextSize = 11
DropBtn.TextXAlignment = Enum.TextXAlignment.Left

local TeamScroll = Instance.new("ScrollingFrame", Content)
TeamScroll.Size = UDim2.new(1, 0, 0, 0)
TeamScroll.Visible = false
TeamScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TeamScroll.BorderSizePixel = 0
TeamScroll.CanvasSize = UDim2.new(0, 0, 2, 0)
Instance.new("UIListLayout", TeamScroll)

local SelTeam, SelCol = "", nil

DropBtn.MouseButton1Click:Connect(function()
    TeamScroll.Visible = not TeamScroll.Visible
    TeamScroll.Size = TeamScroll.Visible and UDim2.new(1, 0, 0, 100) or UDim2.new(1, 0, 0, 0)
end)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", TeamScroll)
    b.Size = UDim2.new(1, 0, 0, 25)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelTeam, SelCol = t.Name, t.TeamColor.Color
        DropBtn.Text = "  SEÇİLDİ: " .. t.Name:upper()
        TeamScroll.Visible = false
        TeamScroll.Size = UDim2.new(1, 0, 0, 0)
    end)
end

-- UYGULA BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -30, 0, 45)
Apply.Position = UDim2.new(0.5, 0, 1, -35)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "DEĞİŞİKLİKLERİ KAYDET"
Apply.Font = Enum.Font.GothamBlack
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.TextSize = 13
Instance.new("UICorner", Apply)

-- RENK VE İSİM FİKSLEME
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    local function GetRGB(txt)
        local r, g, b = txt:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(r,g,b) or Color3.new(1,1,1)
    end

    local nC, rC = GetRGB(C_Name.Text), GetRGB(C_Rank.Text)

    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local low = v.Text:lower()
            if I_Name.Text ~= "" and (low:find(Player.Name:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = nC
                v:GetPropertyChangedSignal("TextColor3"):Connect(function() v.TextColor3 = nC end)
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or low:find("guest") or v.Name:lower():find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = rC
                v:GetPropertyChangedSignal("TextColor3"):Connect(function() v.TextColor3 = rC end)
            elseif SelTeam ~= "" and (v.Name:lower():find("team") or low:find("takım")) then
                v.Text = SelTeam
                v.TextColor3 = SelCol
                v:GetPropertyChangedSignal("TextColor3"):Connect(function() v.TextColor3 = SelCol end)
            end
        end
    end
end)

-- MOBİL RE BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.fromOffset(50, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Mob.Text = "RE"
Mob.TextColor3 = Color3.fromRGB(120, 170, 255)
Mob.Font = Enum.Font.GothamBlack
Mob.Draggable = true
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Mob).Color = Color3.fromRGB(100, 150, 255)

Mob.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    Blur.Enabled = Main.Visible
end)
