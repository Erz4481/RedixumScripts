-- [[ TA 1.0 - CLASSIC REDIX EDITION ]] --
-- Style: Classic Blue Design
-- Creator: Redixum / Redix Studio

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("REDIX_CLASSIC_HUB") then CoreGui:FindFirstChild("REDIX_CLASSIC_HUB"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "REDIX_CLASSIC_HUB"

-- ANA PANEL (Alıştığın Klasik Koyu Tasarım)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 320)
Main.Position = UDim2.new(0.5, -250, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

-- ÜST MAVİ BAR (Marka Alanı)
local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "RENDIX STUDIO | TA 1.0"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- FPS SAYACI (Gerçek Zamanlı)
local FpsLabel = Instance.new("TextLabel", Main)
FpsLabel.Size = UDim2.new(0, 100, 0, 20)
FpsLabel.Position = UDim2.new(1, -110, 1, -25)
FpsLabel.BackgroundTransparency = 1
FpsLabel.Text = "FPS: --"
FpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FpsLabel.Font = Enum.Font.Code
FpsLabel.TextSize = 10
FpsLabel.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    FpsLabel.Text = "FPS: " .. math.floor(1/dt)
end)

-- AYAR SATIRI FONKSİYONU
local function CreateRow(txt, y)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", frame)

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0, 200, 0, 30)
    input.Position = UDim2.new(0.05, 0, 0.5, -15)
    input.PlaceholderText = txt
    input.Text = ""
    input.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    input.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", input)

    local color = Instance.new("TextBox", frame)
    color.Size = UDim2.new(0, 100, 0, 30)
    color.Position = UDim2.new(0.7, 0, 0.5, -15)
    color.Text = "255,255,255"
    color.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    color.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", color)

    return input, color
end

local I_Name, C_Name = CreateRow("Yeni İsim...", 50)
local I_Rank, C_Rank = CreateRow("Yeni Rütbe...", 100)

-- TAKIM LİSTESİ
local TeamFrame = Instance.new("Frame", Main)
TeamFrame.Size = UDim2.new(1, -20, 0, 80)
TeamFrame.Position = UDim2.new(0, 10, 0, 150)
TeamFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", TeamFrame)

local Scroll = Instance.new("ScrollingFrame", TeamFrame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 5)

local SelectedTeam, SelectedColor = "", Color3.new(1,1,1)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.Text = t.Name
    b.TextColor3 = t.TeamColor.Color
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        Title.Text = "SEÇİLDİ: " .. t.Name:upper()
    end)
end
Scroll.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)

-- MAVİ UYGULA BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -20, 0, 50)
Apply.Position = UDim2.new(0, 10, 1, -70)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI SİSTEME BAS"
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Font = Enum.Font.GothamBold
Instance.new("UICorner", Apply)

Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    local function GetRGB(box)
        local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Color3.new(1, 1, 1)
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
