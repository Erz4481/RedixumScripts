-- [[ TA 1.0 - VOID STYLE PREMIUM ]] --
-- UI Style: VOIDLUA HUB (Inspired by Image)
-- Created by: Rendix Studio

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("VOID_TA_UI") then CoreGui:FindFirstChild("VOID_TA_UI"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "VOID_TA_UI"

-- ANA PANEL (Görseldeki gibi yuvarlatılmış ve koyu)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 550, 0, 320)
Main.Position = UDim2.new(0.5, -275, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- SOL MENÜ (Sidebar)
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 70, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- LOGO / BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(0, 200, 0, 40)
Title.Position = UDim2.new(0, 85, 0, 10)
Title.Text = "TA 1.0 HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- İÇERİK ALANI (Scrolling)
local Container = Instance.new("ScrollingFrame", Main)
Container.Size = UDim2.new(1, -90, 1, -60)
Container.Position = UDim2.new(0, 80, 0, 50)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 2
Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 8)

-- ÖZEL SATIR OLUŞTURUCU (VOID Style)
local function CreateVoidRow(text, ph)
    local frame = Instance.new("Frame", Container)
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    Instance.new("UICorner", frame)
    
    local lab = Instance.new("TextLabel", frame)
    lab.Size = UDim2.new(0.4, 0, 1, 0)
    lab.Position = UDim2.new(0, 10, 0, 0)
    lab.Text = text
    lab.TextColor3 = Color3.fromRGB(200, 200, 200)
    lab.Font = Enum.Font.Gotham
    lab.TextSize = 13
    lab.BackgroundTransparency = 1
    lab.TextXAlignment = Enum.TextXAlignment.Left

    local inp = Instance.new("TextBox", frame)
    inp.Size = UDim2.new(0.5, 0, 0.7, 0)
    inp.Position = UDim2.new(0.45, 0, 0.15, 0)
    inp.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    inp.PlaceholderText = ph
    inp.Text = ""
    inp.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", inp)
    
    return inp
end

local I_Name = CreateVoidRow("İsim Değiştir", "Yeni İsim...")
local C_Name = CreateVoidRow("İsim Rengi", "255,255,255")
local I_Rank = CreateVoidRow("Rütbe Değiştir", "Yeni Rütbe...")
local C_Rank = CreateVoidRow("Rütbe Rengi", "255,255,255")

-- TAKIM LİSTESİ (Butonlar)
local TeamFrame = Instance.new("Frame", Container)
TeamFrame.Size = UDim2.new(1, -10, 0, 120)
TeamFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", TeamFrame)

local TeamScroll = Instance.new("ScrollingFrame", TeamFrame)
TeamScroll.Size = UDim2.new(1, -10, 1, -10)
TeamScroll.Position = UDim2.new(0, 5, 0, 5)
TeamScroll.BackgroundTransparency = 1
TeamScroll.ScrollBarThickness = 2
Instance.new("UIListLayout", TeamScroll).Padding = UDim.new(0, 5)

local SelectedTeam, SelectedColor = "", Color3.new(1,1,1)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", TeamScroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    b.Text = t.Name
    b.TextColor3 = t.TeamColor.Color
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        Title.Text = "SEÇİLDİ: " .. t.Name:upper()
    end)
end

-- ÜRET BUTONU (Görseldeki Mavi Buton Stili)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 450, 0, 40)
Apply.Position = UDim2.new(0, 80, 1, -50)
Apply.BackgroundColor3 = Color3.fromRGB(80, 90, 180)
Apply.Text = "SİSTEMİ GÜNCELLE"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBold
Instance.new("UICorner", Apply)

-- ANA MANTIK
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
