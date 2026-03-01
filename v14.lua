-- [[ REDIXUM PREMIUM V14 - COLOR UPDATE ]] --
-- Project: Artvin Roleplay
-- Launch Date: 03.03.2026

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

if CoreGui:FindFirstChild("Redixum_V14_Color") then CoreGui:FindFirstChild("Redixum_V14_Color"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Redixum_V14_Color"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 500) -- Renk seçici için boyutu büyüttüm
Main.Position = UDim2.new(0.5, -180, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 120, 255)
Stroke.Thickness = 2

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "REDIXUM COLOR PANEL"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

-- GİRİŞ ALANLARI
local function AddInput(ph, pos)
    local f = Instance.new("TextBox", Main)
    f.Size = UDim2.new(0.9, 0, 0, 40)
    f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    f.PlaceholderText = ph
    f.Text = ""
    f.TextColor3 = Color3.new(1,1,1)
    f.Font = Enum.Font.GothamBold
    Instance.new("UICorner", f)
    return f
end

local NameInput = AddInput("İsim Değiştir", UDim2.new(0.05, 0, 0.12, 0))
local RankInput = AddInput("Rütbe Değiştir", UDim2.new(0.05, 0, 0.22, 0))
local TeamInput = AddInput("Takım Değiştir", UDim2.new(0.05, 0, 0.32, 0))
local ColorInput = AddInput("Renk Yaz (Örn: 255,0,0)", UDim2.new(0.05, 0, 0.42, 0))

-- HIZLI RENK SEÇİCİ (Scroll)
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(0.9, 0, 0, 60)
Scroll.Position = UDim2.new(0.05, 0, 0.52, 0)
Scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Scroll.CanvasSize = UDim2.new(2, 0, 0, 0)
Scroll.ScrollBarThickness = 4
Instance.new("UICorner", Scroll)

local colors = {
    ["Kırmızı"] = Color3.fromRGB(255, 0, 0),
    ["Mavi"] = Color3.fromRGB(0, 120, 255),
    ["Yeşil"] = Color3.fromRGB(0, 255, 0),
    ["Sarı"] = Color3.fromRGB(255, 255, 0),
    ["Mor"] = Color3.fromRGB(170, 0, 255),
    ["Beyaz"] = Color3.fromRGB(255, 255, 255)
}

local selectedColor = Color3.new(1,1,1)
local count = 0
for name, color in pairs(colors) do
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(0, 80, 0, 40)
    b.Position = UDim2.new(0, (count * 85) + 5, 0, 10)
    b.BackgroundColor3 = color
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        selectedColor = color
        ColorInput.Text = math.floor(color.R*255)..","..math.floor(color.G*255)..","..math.floor(color.B*255)
    end)
    count = count + 1
end

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0.9, 0, 0, 50)
Apply.Position = UDim2.new(0.05, 0, 0.7, 0)
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.Text = "UYGULA"
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

-- MANTIK
Apply.MouseButton1Click:Connect(function()
    -- RGB Yazı Kontrolü
    if ColorInput.Text ~= "" then
        local r, g, b = ColorInput.Text:match("(%d+),(%d+),(%d+)")
        if r and g and b then selectedColor = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
    end

    local char = Player.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text:lower()
            if NameInput.Text ~= "" and (txt:find(Player.Name:lower()) or txt:find(Player.DisplayName:lower())) then
                v.Text = NameInput.Text
                v.TextColor3 = selectedColor
            elseif RankInput.Text ~= "" and (txt:find("guest") or v.Name:lower():find("rank")) then
                v.Text = RankInput.Text
                v.TextColor3 = selectedColor
            elseif TeamInput.Text ~= "" and (txt:find("sivil") or v.Name:lower():find("team")) then
                v.Text = TeamInput.Text
                v.TextColor3 = selectedColor
            end
        end
    end
end)

-- K Tuşu
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
