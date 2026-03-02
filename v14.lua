--// GLASS ELITE v2 - FIXED CLEAN BUILD

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GLASS_ELITE_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Blur
if not Lighting:FindFirstChild("EliteBlur") then
	local blur = Instance.new("BlurEffect")
	blur.Name = "EliteBlur"
	blur.Size = 20
	blur.Parent = Lighting
end

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 600, 0, 380)
Main.Position = UDim2.new(0.5, -300, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(25,25,35)
Main.BackgroundTransparency = 0.12
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(120,170,255)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.3

-- Open Animation
local function OpenUI()
	Main.Size = UDim2.new(0,0,0,0)
	Main.Visible = true
	TweenService:Create(Main,TweenInfo.new(0.3,Enum.EasingStyle.Quad),{
		Size = UDim2.new(0,600,0,380)
	}):Play()
end

-- Header (Only FPS)
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundTransparency = 1

local Stats = Instance.new("TextLabel", Header)
Stats.Size = UDim2.new(1, -25, 1, 0)
Stats.Position = UDim2.new(0, 15, 0, 0)
Stats.BackgroundTransparency = 1
Stats.Font = Enum.Font.GothamBold
Stats.TextSize = 14
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

-- Sidebar
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, -70)
Sidebar.Position = UDim2.new(0, 10, 0, 70)
Sidebar.BackgroundTransparency = 1

local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 10)

-- Content
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -170, 1, -90)
Content.Position = UDim2.new(0, 160, 0, 75)
Content.BackgroundTransparency = 1

-- Page System
local Pages = {}

local function CreatePage(name)
	local Page = Instance.new("Frame", Content)
	Page.Size = UDim2.new(1,0,1,0)
	Page.BackgroundTransparency = 1
	Page.Visible = false
	Pages[name] = Page
	return Page
end

local function SwitchPage(name)
	for _,v in pairs(Pages) do
		v.Visible = false
	end
	if Pages[name] then
		Pages[name].Visible = true
	end
end

-- Sidebar Button
local function CreateTab(text, pageName)
	local Button = Instance.new("TextButton", Sidebar)
	Button.Size = UDim2.new(1,0,0,45)
	Button.BackgroundColor3 = Color3.fromRGB(40,40,55)
	Button.BackgroundTransparency = 0.25
	Button.Text = text
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 13
	Button.TextColor3 = Color3.new(1,1,1)
	Button.AutoButtonColor = false
	Instance.new("UICorner", Button).CornerRadius = UDim.new(0,14)

	local Stroke = Instance.new("UIStroke", Button)
	Stroke.Color = Color3.fromRGB(120,170,255)
	Stroke.Transparency = 0.6

	Button.MouseEnter:Connect(function()
		TweenService:Create(Stroke,TweenInfo.new(0.2),{Transparency = 0.1}):Play()
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(Stroke,TweenInfo.new(0.2),{Transparency = 0.6}):Play()
	end)

	Button.MouseButton1Click:Connect(function()
		SwitchPage(pageName)
	end)

	return Button
end

-- Pages
local Home = CreatePage("Home")
local Settings = CreatePage("Settings")
local Info = CreatePage("Info")

-- Sample Home Content
local HomeLabel = Instance.new("TextLabel", Home)
HomeLabel.Size = UDim2.new(1,0,0,40)
HomeLabel.BackgroundTransparency = 1
HomeLabel.Text = "Ana Sayfa"
HomeLabel.Font = Enum.Font.GothamBlack
HomeLabel.TextSize = 22
HomeLabel.TextColor3 = Color3.new(1,1,1)

-- Tabs
CreateTab("Ana Sayfa","Home")
CreateTab("Ayarlar","Settings")
CreateTab("Bilgi","Info")

SwitchPage("Home")

-- Toggle Button
local Toggle = Instance.new("TextButton", ScreenGui)
Toggle.Size = UDim2.new(0,60,0,60)
Toggle.Position = UDim2.new(1,-75,0.5,-30)
Toggle.BackgroundColor3 = Color3.fromRGB(40,40,55)
Toggle.Text = "UI"
Toggle.Font = Enum.Font.GothamBlack
Toggle.TextSize = 18
Toggle.TextColor3 = Color3.fromRGB(120,170,255)
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(1,0)

Toggle.MouseButton1Click:Connect(function()
	if Main.Visible then
		Main.Visible = false
	else
		OpenUI()
	end
end)

UserInputService.InputBegan:Connect(function(i,g)
	if not g and i.KeyCode == Enum.KeyCode.K then
		if Main.Visible then
			Main.Visible = false
		else
			OpenUI()
		end
	end
end)
