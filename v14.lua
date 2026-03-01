local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

if CoreGui:FindFirstChild("Redixum_V14_Official") then CoreGui:FindFirstChild("Redixum_V14_Official"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_V14_Official"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 420)
Main.Position = UDim2.new(0.5, -180, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "REDIXUM PREMIUM PANEL"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

local function AddInput(ph, pos)
    local f = Instance.new("TextBox", Main)
    f.Size = UDim2.new(0.9, 0, 0, 45)
    f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    f.PlaceholderText = ph
    f.Text = ""
    f.TextColor3 = Color3.new(1,1,1)
    f.Font = Enum.Font.GothamBold
    Instance.new("UICorner", f)
    return f
end

local NameInput = AddInput("İsim Değiştir", UDim2.new(0.05, 0, 0.2, 0))
local RankInput = AddInput("Rütbe Değiştir", UDim2.new(0.05, 0, 0.4, 0))
local TeamInput = AddInput("Takım Değiştir", UDim2.new(0.05, 0, 0.6, 0))

local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 55)
Apply.Position = UDim2.new(0.05, 0, 0.8, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "ÜRET"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(1, 0, 0, 30)
Info.Position = UDim2.new(0, 0, 1, -40)
Info.BackgroundTransparency = 1
Info.Text = "Gizlemek/Açmak için 'K' Tuşuna Basın"
Info.TextColor3 = Color3.fromRGB(150, 150, 150)
Info.Font = Enum.Font.Gotham
Info.TextSize = 12

Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local t = v.Text:lower()
            if NameInput.Text ~= "" and (t:find(Player.Name:lower()) or t:find(Player.DisplayName:lower())) then
                v.Text = NameInput.Text
            elseif RankInput.Text ~= "" and (t:find("guest") or v.Name:lower():find("rank")) then
                v.Text = RankInput.Text
            elseif TeamInput.Text ~= "" and (t:find("sivil") or v.Name:lower():find("team")) then
                v.Text = TeamInput.Text
                local teamObj = Teams:FindFirstChild(TeamInput.Text)
                if teamObj then v.TextColor3 = teamObj.TeamColor.Color end
            end
        end
    end
end)

CloseBtn.MouseButton1Click:Connect(function() Main.Visible = false end)

UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
