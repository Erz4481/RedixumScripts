-- [[ TA 1.0 SAHTE SS ÜRETİCİSİ - NAMETAG FOCUS ]] --
-- Created by: Rendix Studio
-- Focus: NameTag Text & Color Manipulation (Fake SS)
-- Support: Mobile & PC | All Universal NameTag Systems

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- Eski UI temizleme
if CoreGui:FindFirstChild("TA_NameTag_Pro") then CoreGui:FindFirstChild("TA_NameTag_Pro"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_NameTag_Pro"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Karanlık & Şık Rayfield Esintisi)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 420, 0, 480)
Main.Position = UDim2.new(0.5, -210, 0.5, -240)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2.5

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "TA 1.0 | NAMETAG CHANGER"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20

-- INPUT OLUŞTURUCU (Yazı ve Renk Yan Yana)
local function CreateTagRow(ph, pos)
    local box = Instance.new("TextBox", Main)
    box.Size = UDim2.new(0, 240, 0, 45)
    box.Position = pos
    box.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    box.PlaceholderText = ph
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    box.Font = Enum.Font.GothamBold
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", Main)
    rgb.Size = UDim2.new(0, 120, 0, 45)
    rgb.Position = pos + UDim2.new(0, 250, 0, 0)
    rgb.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    rgb.PlaceholderText = "R,G,B (Boş=Oto)"
    rgb.Text = ""
    rgb.TextColor3 = Color3.new(1,1,1)
    rgb.Font = Enum.Font.Code
    Instance.new("UICorner", rgb)

    return box, rgb
end

local I_Name, C_Name = CreateTagRow("Yeni İsim", UDim2.new(0, 20, 0, 80))
local I_Rank, C_Rank = CreateTagRow("Yeni Rütbe", UDim2.new(0, 20, 0, 140))
local I_Team, C_Team = CreateTagRow("Takım (Renk İçin)", UDim2.new(0, 20, 0, 200))

-- UYGULA BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 380, 0, 60)
Apply.Position = UDim2.new(0, 20, 0, 280)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "NAMETAG GÜNCELLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 18
Instance.new("UICorner", Apply)

-- IMZA
local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 30)
Credits.Position = UDim2.new(0, 0, 1, -40)
Credits.BackgroundTransparency = 1
Credits.Text = "Produced by Rendix Studio"
Credits.TextColor3 = Color3.new(1,1,1)
Credits.TextTransparency = 0.5
Credits.Font = Enum.Font.GothamItalic

-- MOBİL TA BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 50, 0, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Mob.Text = "TA"
Mob.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- ANA MANTIK (Sadece Yazı ve Renk)
local function UpdateTags()
    local char = Player.Character
    if not char then return end

    local function GetColor(box, default)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        if r and g and b then return Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
        return default
    end

    -- Otomatik Takım Rengi Yakalama
    local autoCol = Color3.new(1,1,1)
    if I_Team.Text ~= "" then
        local target = Teams:FindFirstChild(I_Team.Text)
        if target then
            autoCol = target.TeamColor.Color
        end
    end

    -- NameTag Üzerindeki Her Şeyi Bul ve Değiştir
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            -- İSİM DEĞİŞİMİ
            if I_Name.Text ~= "" and (v.Text:find(Player.Name) or v.Text:find(Player.DisplayName) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetColor(C_Name, autoCol)
            -- RÜTBE DEĞİŞİMİ
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetColor(C_Rank, autoCol)
            -- TAKIM DEĞİŞİMİ
            elseif I_Team.Text ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = I_Team.Text
                v.TextColor3 = GetColor(C_Team, autoCol)
            end
        end
    end
end

Apply.MouseButton1Click:Connect(UpdateTags)

-- PC Kısayol (K Tuşu)
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
