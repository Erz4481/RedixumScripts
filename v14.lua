-- [[ TA 1.0 - VOID PREMIUM EDITION ]] --
-- UI Style: VOIDLUA HUB Professional
-- Created by: Rendix Studio

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")

-- ESKİ UI TEMİZLEME
if CoreGui:FindFirstChild("VOID_TA_HUB") then CoreGui:FindFirstChild("VOID_TA_HUB"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VOID_TA_HUB"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (VOID Style)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 520, 0, 310)
Main.Position = UDim2.new(0.5, -260, 0.5, -155)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- SOL MENÜ (Sidebar)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 75, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

-- LOGO VE PING
local Logo = Instance.new("TextLabel", Main)
Logo.Size = UDim2.new(0, 150, 0, 40)
Logo.Position = UDim2.new(0, 85, 0, 5)
Logo.Text = "VOIDLUA HUB"
Logo.TextColor3 = Color3.new(1, 1, 1)
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 15
Logo.TextXAlignment = Enum.TextXAlignment.Left

local Ping = Instance.new("TextLabel", Main)
Ping.Size = UDim2.new(0, 100, 0, 40)
Ping.Position = UDim2.new(1, -110, 0, 5)
Ping.Text = "Ping: 71 ms"
Ping.TextColor3 = Color3.fromRGB(0, 255, 100)
Ping.Font = Enum.Font.GothamBold
Ping.TextSize = 12
Ping.TextXAlignment = Enum.TextXAlignment.Right

-- AYAR SATIRI OLUŞTURUCU
local function CreateRow(text, yPos, isInput)
    local row = Instance.new("Frame", Main)
    row.Size = UDim2.new(1, -95, 0, 40)
    row.Position = UDim2.new(0, 85, 0, yPos)
    row.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", row)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.Gotham
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1

    if isInput then
        local inp = Instance.new("TextBox", row)
        inp.Size = UDim2.new(0.4, 0, 0.7, 0)
        inp.Position = UDim2.new(0.55, 0, 0.15, 0)
        inp.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
        inp.Text = ""
        inp.PlaceholderText = "..."
        inp.TextColor3 = Color3.new(1,1,1)
        inp.Font = Enum.Font.Gotham
        inp.TextSize = 11
        Instance.new("UICorner", inp)
        return inp
    end
end

-- AYARLAR
local I_Name = CreateRow("İsim Değiştir", 50, true)
local I_Rank = CreateRow("Rütbe Değiştir", 95, true)

-- TAKIM SEÇME (SCROLLING)
local TeamFrame = Instance.new("Frame", Main)
TeamFrame.Size = UDim2.new(1, -95, 0, 80)
TeamFrame.Position = UDim2.new(0, 85, 0, 140)
TeamFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Instance.new("UICorner", TeamFrame).CornerRadius = UDim.new(0, 6)

local Scroll = Instance.new("ScrollingFrame", TeamFrame)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 4)

local SelectedTeam, SelectedColor = "", Color3.new(1,1,1)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1, 0, 0, 25)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    b.Text = t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        Logo.Text = "SEÇİLDİ: " .. t.Name:upper()
    end)
end
Scroll.CanvasSize = UDim2.new(0,0,0, Layout.AbsoluteContentSize.Y)

-- ANA BUTON (Mavi Modern)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -95, 0, 45)
Apply.Position = UDim2.new(0, 85, 0, 235)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "NAMETAGLARI GÜNCELLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBold
Apply.TextSize = 14
Instance.new("UICorner", Apply).CornerRadius = UDim.new(0, 6)

-- MANTIK (Sadece Nametag ve Renk)
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if I_Name.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or t:find("guest") or t:find("rütbe")) then
                v.Text = I_Rank.Text
            elseif SelectedTeam ~= "" and (v.Name:lower():find("team") or t:find("takım") or t:find("sivil")) then
                v.Text = SelectedTeam
                v.TextColor3 = SelectedColor
            end
        end
    end
end)
