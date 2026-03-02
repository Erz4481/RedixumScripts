-- [[ RENDIX STUDIO - REAL TEAM CHANGER v16.0 ]] --
-- Features: Real Team Swap, Name & Rank Override
-- Launch: 03.03.2026

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Player = Players.LocalPlayer

-- UI TEMİZLİK
if Player.PlayerGui:FindFirstChild("REDIX_FINAL_V16") then Player.PlayerGui.REDIX_FINAL_V16:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_FINAL_V16"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Görünüm Sabit)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(450, 360)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BackgroundTransparency = 0.2
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(85, 95, 210)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -30, 1, -80)
Content.Position = UDim2.new(0, 15, 0, 15)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Content.ScrollBarThickness = 0
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 8)

-- INPUT SİSTEMİ
local function CreateInp(place)
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

local I_Name, C_Name = CreateInp("İsim...")
local I_Rank, C_Rank = CreateInp("Rütbe...")

-- TAKIM SEÇİMİ
local SelectedTeamObj = nil
local DropBtn = Instance.new("TextButton", Content)
DropBtn.Size = UDim2.new(1, 0, 0, 40)
DropBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
DropBtn.Text = "  TAKIM SEÇİN ▼"
DropBtn.TextColor3 = Color3.fromRGB(120, 170, 255)
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
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeamObj = t
        DropBtn.Text = "SEÇİLDİ: " .. t.Name
        TeamScroll.Visible = false
        TeamScroll.Size = UDim2.new(1, 0, 0, 0)
    end)
end

-- GÜNCELLE BUTONU (REAL SWAP)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -30, 0, 50)
Apply.Position = UDim2.new(0.5, 0, 1, -35)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAG VE TAKIMI GÜNCELLE"
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

    -- 1. GERÇEK TAKIM DEĞİŞTİRME
    if SelectedTeamObj then
        Player.Team = SelectedTeamObj
    end

    -- 2. NAMETAG İSİM VE RÜTBE GÜNCELLEME
    task.spawn(function()
        for _, tag in pairs(char:GetDescendants()) do
            if tag:IsA("BillboardGui") then
                local labels = {}
                for _, v in pairs(tag:GetDescendants()) do
                    if v:IsA("TextLabel") and v.Visible then table.insert(labels, v) end
                end
                
                table.sort(labels, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)

                -- İsim ve Rütbeyi Zorla Değiştir
                if #labels >= 1 and I_Name.Text ~= "" then
                    labels[1].Text = I_Name.Text
                    labels[1].TextColor3 = nC
                end
                if #labels >= 2 and I_Rank.Text ~= "" then
                    labels[2].Text = I_Rank.Text
                    labels[2].TextColor3 = rC
                end
            end
        end
    end)
end)

-- MOBİL RE
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.fromOffset(50, 50)
Mob.Position = UDim2.new(1, -60, 0.5, -25)
Mob.Text = "RE"
Mob.Draggable = true
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
