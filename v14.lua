-- [[ TA 1.0 - REDIX STUDIO CYBER-UI ]] --
-- Created by: Redixum / Redix Studio
-- Design: Ultra Modern Glass & Neon Hybrid

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Teams = game:GetService("Teams")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("Redix_CyberUI") then CoreGui:FindFirstChild("Redix_CyberUI"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redix_CyberUI"

-- ANA PANEL (Transparan Cam Efekti)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 500, 0, 320)
Main.Position = UDim2.new(0.5, -250, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Main.BackgroundTransparency = 0.1
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- NEON KENAR (Glow Effect)
local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 170, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- ÜST BAŞLIK (Brand & Info)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "TA 1.0 // REDIX STUDIO"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local FPS = Instance.new("TextLabel", Header)
FPS.Size = UDim2.new(0.3, 0, 1, 0)
FPS.Position = UDim2.new(0.7, -10, 0, 0)
FPS.Text = "FPS: --"
FPS.TextColor3 = Color3.fromRGB(0, 255, 150)
FPS.Font = Enum.Font.Code
FPS.TextSize = 12
FPS.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    FPS.Text = "FPS: " .. math.floor(1/dt)
end)

-- AYAR KUTULARI (Görseldeki gibi düzgün hizalı)
local function CreateNeonInput(txt, y)
    local frame = Instance.new("Frame", Main)
    frame.Size = UDim2.new(1, -40, 0, 40)
    frame.Position = UDim2.new(0, 20, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    frame.BackgroundTransparency = 0.3
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = txt
    label.TextColor3 = Color3.fromRGB(150, 150, 150)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left

    local input = Instance.new("TextBox", frame)
    input.Size = UDim2.new(0, 160, 0, 28)
    input.Position = UDim2.new(0.3, 10, 0.5, -14)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    input.Text = ""
    input.PlaceholderText = "Metin..."
    input.TextColor3 = Color3.new(1, 1, 1)
    input.Font = Enum.Font.Gotham
    input.TextSize = 11
    Instance.new("UICorner", input)

    local rgb = Instance.new("TextBox", frame)
    rgb.Size = UDim2.new(0, 90, 0, 28)
    rgb.Position = UDim2.new(0.7, 20, 0.5, -14)
    rgb.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    rgb.Text = "255,255,255"
    rgb.TextColor3 = Color3.fromRGB(0, 170, 255)
    rgb.Font = Enum.Font.Code
    rgb.TextSize = 10
    Instance.new("UICorner", rgb)

    return input, rgb
end

local I_Name, C_Name = CreateNeonInput("İSİM:", 50)
local I_Rank, C_Rank = CreateNeonInput("RÜTBE:", 100)

-- TEAM SCROLLER (Glass Style)
local ScrollFrame = Instance.new("ScrollingFrame", Main)
ScrollFrame.Size = UDim2.new(1, -40, 0, 90)
ScrollFrame.Position = UDim2.new(0, 20, 0, 150)
ScrollFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
ScrollFrame.BackgroundTransparency = 0.5
ScrollFrame.ScrollBarThickness = 2
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", ScrollFrame)
local Layout = Instance.new("UIListLayout", ScrollFrame)
Layout.Padding = UDim.new(0, 5)

local SelectedTeam, SelectedColor = "", Color3.new(1,1,1)

for _, t in pairs(Teams:GetTeams()) do
    local b = Instance.new("TextButton", ScrollFrame)
    b.Size = UDim2.new(0.95, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = "  " .. t.Name
    b.TextColor3 = t.TeamColor.Color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        SelectedTeam = t.Name
        SelectedColor = t.TeamColor.Color
        UIStroke.Color = SelectedColor
        Title.Text = "ACTIVE: " .. t.Name:upper()
    end)
end
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)

-- EXECUTE BUTTON (The Final Touch)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -40, 0, 45)
Apply.Position = UDim2.new(0, 20, 1, -60)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "GÜNCELLEMELERİ SİSTEME ENJEKTE ET"
Apply.TextColor3 = Color3.new(1, 1, 1)
Apply.Font = Enum.Font.GothamBlack
Apply.TextSize = 13
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
