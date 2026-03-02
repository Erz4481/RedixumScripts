-- [[ RENDIX STUDIO - UNIVERSAL TEAM & COLOR FORCE ]] --
-- GitHub: https://raw.githubusercontent.com/Erz4481/RedixumScripts/refs/heads/main/v14_fix.lua
-- Fix: Deep Scan for Sivil/İnzibat/Rank Labels

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

-- UI TEMİZLİK
if Player.PlayerGui:FindFirstChild("REDIX_V14_FIX") then Player.PlayerGui.REDIX_V14_FIX:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_V14_FIX"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Kompakt Glass Tasarımı)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(450, 360)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BackgroundTransparency = 0.2
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(85, 95, 210)
Stroke.Thickness = 2

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -30, 1, -80)
Content.Position = UDim2.new(0, 15, 0, 15)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 2, 0)
Content.ScrollBarThickness = 0
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 8)

-- INPUT SİSTEMİ
local function CreateInp(title, place)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    f.BackgroundTransparency = 0.5
    Instance.new("UICorner", f)

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.fromScale(0.4, 0.7)
    box.Position = UDim2.fromScale(0.32, 0.15)
    box.PlaceholderText = place
    box.Text = ""
    box.TextColor3 = Color3.new(1, 1, 1)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.fromScale(0.23, 0.7)
    rgb.Position = UDim2.fromScale(0.74, 0.15)
    rgb.Text = "255,255,255"
    rgb.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    rgb.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", rgb)
    
    return box, rgb
end

local I_Name, C_Name = CreateInp("İSİM", "Metin...")
local I_Rank, C_Rank = CreateInp("RÜTBE", "Kral...")

-- TAKIM SEÇİMİ
local SelTeam, SelCol = "", nil
local DropBtn = Instance.new("TextButton", Content)
DropBtn.Size = UDim2.new(1, 0, 0, 40)
DropBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
DropBtn.Text = "  TAKIM SEÇİN ▼"
DropBtn.TextColor3 = Color3.fromRGB(120, 170, 255)
DropBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", DropBtn)

local TeamScroll = Instance.new("ScrollingFrame", Content)
TeamScroll.Size = UDim2.new(1, 0, 0, 0)
TeamScroll.Visible = false
TeamScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Instance.new("UIListLayout", TeamScroll)

DropBtn.MouseButton1Click:Connect(function()
    TeamScroll.Visible = not TeamScroll.Visible
    TeamScroll.Size = TeamScroll.Visible and UDim2.new(1, 0, 0, 100) or UDim2.new(1, 0, 0, 0)
end)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", TeamScroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.Text = t.Name
    b.TextColor3 = t.TeamColor.Color
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelTeam, SelCol = t.Name, t.TeamColor.Color
        DropBtn.Text = "SEÇİLDİ: " .. t.Name
        TeamScroll.Visible = false
        TeamScroll.Size = UDim2.new(1, 0, 0, 0)
    end)
end

-- GÜNCELLEME VE FORCE MANTIĞI
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -30, 0, 50)
Apply.Position = UDim2.new(0.5, 0, 1, -35)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI ZORLA GÜNCELLE"
Apply.Font = Enum.Font.GothamBlack
Apply.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Apply)

Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    local function GetRGB(txt)
        local r, g, b = txt:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Color3.new(1, 1, 1)
    end

    local nC, rC = GetRGB(C_Name.Text), GetRGB(C_Rank.Text)

    -- Nametag taraması ve konum bazlı tespit
    for _, tag in pairs(char:GetDescendants()) do
        if tag:IsA("BillboardGui") then
            local labels = {}
            for _, v in pairs(tag:GetDescendants()) do
                if v:IsA("TextLabel") and v.Visible then table.insert(labels, v) end
            end
            
            -- Ekrandaki yüksekliğe göre sırala (Üstten alta)
            table.sort(labels, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)

            -- İSİM (En Üstteki Yazı)
            if #labels >= 1 and I_Name.Text ~= "" then
                labels[1].Text = I_Name.Text
                labels[1].TextColor3 = nC
                labels[1]:GetPropertyChangedSignal("TextColor3"):Connect(function() labels[1].TextColor3 = nC end)
            end
            -- RÜTBE (Ortadaki Yazı)
            if #labels >= 2 and I_Rank.Text ~= "" then
                labels[2].Text = I_Rank.Text
                labels[2].TextColor3 = rC
                labels[2]:GetPropertyChangedSignal("TextColor3"):Connect(function() labels[2].TextColor3 = rC end)
            end
            -- TAKIM (En Alttaki Yazı - Sivil/İnzibat Fix)
            if #labels >= 3 and SelTeam ~= "" then
                labels[#labels].Text = SelTeam
                labels[#labels].TextColor3 = SelCol
                labels[#labels]:GetPropertyChangedSignal("TextColor3"):Connect(function() labels[#labels].TextColor3 = SelCol end)
            end
        end
    end
end)

-- MOBİL AÇ/KAPAT
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.fromOffset(50, 50)
Mob.Position = UDim2.new(1, -60, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Mob.Text = "RE"
Mob.TextColor3 = Color3.fromRGB(120, 170, 255)
Mob.Draggable = true
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
