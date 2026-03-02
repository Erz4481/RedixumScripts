-- [[ REDIX ELITE v23 - ULTIMATE COLOR FORCE ]] --
-- Fix: TextColor3 Overwrite Protection
-- Feature: Team Color Sync & Dropdown

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

-- PANEL TEMİZLİĞİ
if Player.PlayerGui:FindFirstChild("REDIX_V23") then Player.PlayerGui.REDIX_V23:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_V23"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(580, 420)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(85, 95, 210)

local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -40, 0, 280)
Scroll.Position = UDim2.new(0, 20, 0, 40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Scroll.ScrollBarThickness = 2
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 8)

-- INPUT SİSTEMİ
local function CreateInp(title, placeholder)
    local f = Instance.new("Frame", Scroll)
    f.Size = UDim2.new(1, 0, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    Instance.new("UICorner", f)

    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.fromScale(0.3, 1)
    lbl.Position = UDim2.fromOffset(10, 0)
    lbl.Text = title
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    lbl.BackgroundTransparency = 1

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.fromScale(0.4, 0.7)
    box.Position = UDim2.fromScale(0.32, 0.15)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.fromScale(0.23, 0.7)
    rgb.Position = UDim2.fromScale(0.74, 0.15)
    rgb.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    rgb.Text = "255,255,255"
    rgb.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", rgb)
    
    return box, rgb
end

local NameIn, NameCol = CreateInp("İSİM DEĞİŞTİR", "Metin...")
local RankIn, RankCol = CreateInp("RÜTBE DEĞİŞTİR", "Kral...")

-- TAKIM DROPDOWN (TIKLA-AÇ)
local DropFrame = Instance.new("Frame", Scroll)
DropFrame.Size = UDim2.new(1, 0, 0, 45)
DropFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Instance.new("UICorner", DropFrame)

local DropBtn = Instance.new("TextButton", DropFrame)
DropBtn.Size = UDim2.new(1, 0, 1, 0)
DropBtn.BackgroundTransparency = 1
DropBtn.Text = "  TAKIM SEÇİM MENÜSÜ ▼"
DropBtn.TextColor3 = Color3.fromRGB(120, 170, 255)
DropBtn.Font = Enum.Font.GothamBold
DropBtn.TextXAlignment = Enum.TextXAlignment.Left

local TeamList = Instance.new("ScrollingFrame", Scroll)
TeamList.Size = UDim2.new(1, 0, 0, 0)
TeamList.Visible = false
TeamList.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
TeamList.CanvasSize = UDim2.new(0, 0, 2, 0)
TeamList.ScrollBarThickness = 2
Instance.new("UIListLayout", TeamList)

local SelTeam, SelTeamCol = "", nil

DropBtn.MouseButton1Click:Connect(function()
    TeamList.Visible = not TeamList.Visible
    TeamList.Size = TeamList.Visible and UDim2.new(1, 0, 0, 120) or UDim2.new(1, 0, 0, 0)
end)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", TeamList)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    
    b.MouseButton1Click:Connect(function()
        SelTeam = t.Name
        SelTeamCol = t.TeamColor.Color
        DropBtn.Text = "  SEÇİLDİ: " .. t.Name:upper()
        TeamList.Visible = false
        TeamList.Size = UDim2.new(1, 0, 0, 0)
    end)
end

-- UYGULA BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 50)
Apply.Position = UDim2.new(0.5, 0, 1, -40)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI GÜNCELLE"
Apply.Font = Enum.Font.GothamBlack
Apply.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Apply)

-- RENK FİKSLEME FONKSİYONU
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    local function GetRGB(txt)
        local r, g, b = txt:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(r,g,b) or Color3.new(1,1,1)
    end

    local nColor = GetRGB(NameCol.Text)
    local rColor = GetRGB(RankCol.Text)

    for _, tag in pairs(char:GetDescendants()) do
        if tag:IsA("BillboardGui") then
            for _, v in pairs(tag:GetDescendants()) do
                if v:IsA("TextLabel") then
                    local textLower = v.Text:lower()
                    
                    -- İsim ve Renk
                    if NameIn.Text ~= "" and (textLower:find(Player.Name:lower()) or v.Name:lower():find("name")) then
                        v.Text = NameIn.Text
                        v.TextColor3 = nColor
                        -- RENK OVERWRITE KORUMASI:
                        v:GetPropertyChangedSignal("TextColor3"):Connect(function() v.TextColor3 = nColor end)
                    end
                    
                    -- Rütbe ve Renk
                    if RankIn.Text ~= "" and (v.Name:lower():find("rank") or v.Name:lower():find("rütbe") or textLower:find("kral")) then
                        v.Text = RankIn.Text
                        v.TextColor3 = rColor
                        v:GetPropertyChangedSignal("TextColor3"):Connect(function() v.TextColor3 = rColor end)
                    end
                    
                    -- Takım ve Takım Rengi
                    if SelTeam ~= "" and (v.Name:lower():find("team") or v.Name:lower():find("takım") or textLower:find("hapis") or textLower:find("dy")) then
                        v.Text = SelTeam
                        v.TextColor3 = SelTeamCol
                        v:GetPropertyChangedSignal("TextColor3"):Connect(function() v.TextColor3 = SelTeamCol end)
                    end
                end
            end
        end
    end
end)

-- MOBİL SÜRÜKLENEBİLİR BUTON
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.fromOffset(50, 50)
Toggle.Position = UDim2.new(1, -60, 0.5, -25)
Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Toggle.Text = "RE"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextColor3 = Color3.fromRGB(85, 95, 210)
Toggle.Draggable = true
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1, 0)
Toggle.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
