--// GLASS ELITE v2 - FULL PROFESSIONAL BUILD
--// Mobile + PC | Smooth | Sidebar | FPS | Animated

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

--// GUI SETUP
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GLASS_ELITE_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

--// BLUR
if not Lighting:FindFirstChild("EliteBlur") then
    local blur = Instance.new("BlurEffect")
    blur.Name = "EliteBlur"
    blur.Size = 20
    blur.Parent = Lighting
end

--// MAIN FRAME
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 380)
Main.Position = UDim2.new(0.5, -300, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(25,25,35)
Main.BackgroundTransparency = 0.12
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

-- Stroke Glow
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(120,170,255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3

-- Gradient
local Grad = Instance.new("UIGradient", Main)
Grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60,60,80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30,30,40))
}
Grad.Rotation = 90

--// OPEN ANIMATION
local function OpenUI()
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Visible = true
    TweenService:Create(Main, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 600, 0, 380)
    }):Play()
end

--// HEADER
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "GLASS ELITE v2"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- FPS COUNTER
local Stats = Instance.new("TextLabel", Header)
Stats.Size = UDim2.new(0.5, -20, 1, 0)
Stats.Position = UDim2.new(0.5, 0, 0, 0)
Stats.BackgroundTransparency = 1
Stats.Text = "FPS: -- | MS: --"
Stats.Font = Enum.Font.GothamBold
Stats.TextSize = 13
Stats.TextColor3 = Color3.fromRGB(120,255,170)
Stats.TextXAlignment = Enum.TextXAlignment.Right

RunService.RenderStepped:Connect(function(dt)
    local fps = math.floor(1/dt)
    local ping = math.floor(Player:GetNetworkPing() * 1000)
    Stats.Text = "FPS: "..fps.." | MS: "..ping
end)

-- Divider
local Divider = Instance.new("Frame", Main)
Divider.Size = UDim2.new(1, -40, 0, 1)
Divider.Position = UDim2.new(0, 20, 0, 60)
Divider.BackgroundColor3 = Color3.fromRGB(120,170,255)
Divider.BorderSizePixel = 0

--// SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, -70)
Sidebar.Position = UDim2.new(0, 10, 0, 70)
Sidebar.BackgroundTransparency = 1

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 10)

--// CONTENT AREA
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -170, 1, -90)
Content.Position = UDim2.new(0, 160, 0, 75)
Content.BackgroundTransparency = 1

-- PAGE SYSTEM
local Pages = {}

local function CreatePage(name)
    local Page = Instance.new("Frame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Pages[name] = Page
    return Page
end

local function SwitchPage(name)
    for i,v in pairs(Pages) do
        v.Visible = false
    end
    Pages[name].Visible = true
end

--// SIDEBAR BUTTON
local function CreateTab(text)
    local Button = Instance.new("TextButton", Sidebar)
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(40,40,55)
    Button.BackgroundTransparency = 0.25
    Button.Text = text
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.TextColor3 = Color3.new(1,1,1)
    Button.AutoButtonColor = false
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 14)

    local Stroke = Instance.new("UIStroke", Button)
    Stroke.Color = Color3.fromRGB(120,170,255)
    Stroke.Transparency = 0.6

    Button.MouseEnter:Connect(function()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.1}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.6}):Play()
    end)

    return Button
end

-- CREATE PAGES
local Home = CreatePage("Home")
local Settings = CreatePage("Settings")
local Info = CreatePage("Info")

-- SAMPLE CONTENT
local label = Instance.new("TextLabel", Home)
label.Size = UDim2.new(1, 0, 0, 40)
label.BackgroundTransparency = 1
label.Text = "Ana Sayfa"
label.Font = Enum.Font.GothamBlack
label.TextSize = 22
label.TextColor3 = Color3.new(1,1,1)

-- TABS
local HomeTab = CreateTab("Ana Sayfa")
local SetTab = CreateTab("Ayarlar")
local InfoTab = CreateTab("Bilgi")

HomeTab.MouseButton1Click:Connect(function() SwitchPage("Home") end)
SetTab.MouseButton1Click:Connect(function() SwitchPage("Settings") end)
InfoTab.MouseButton1Click:Connect(function() SwitchPage("Info") end)

SwitchPage("Home")

--// TOGGLE BUTTON
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0, 60, 0, 60)
Toggle.Position = UDim2.new(1, -75, 0.5, -30)
Toggle.BackgroundColor3 = Color3.fromRGB(40,40,55)
Toggle.Text = "UI"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextSize = 18
Toggle.TextColor3 = Color3.fromRGB(120,170,255)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

Toggle.MouseButton1Click:Connect(OpenUI)

UserInputService.InputBegan:Connect(function(i,g)
    if not g and i.KeyCode == Enum.KeyCode.K then
        if Main.Visible then
            Main.Visible = false
        else
            OpenUI()
        end
    end
end)
