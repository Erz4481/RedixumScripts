-- [[ TA 1.0 - OTOMATİK TAKIM RENGİ FİX ]] --
-- Created by: Rendix Studio

local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

-- ESKİ PANELİ SİL
if CoreGui:FindFirstChild("TA_Color_Fix") then CoreGui:FindFirstChild("TA_Color_Fix"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "TA_Color_Fix"

-- ANA PANEL
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 380, 0, 420)
Main.Position = UDim2.new(0.5, -190, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

-- BAŞLIK
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "TA 1.0 | OTO RENK SİSTEMİ"
Title.TextColor3 = Color3.fromRGB(0, 120, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

-- INPUTLAR
local function CreateField(ph, y)
    local txt = Instance.new("TextBox", Main)
    txt.Size = UDim2.new(0, 220, 0, 40)
    txt.Position = UDim2.new(0.05, 0, 0, y)
    txt.PlaceholderText = ph
    txt.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    txt.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", txt)

    local clr = Instance.new("TextBox", Main)
    clr.Size = UDim2.new(0, 100, 0, 40)
    clr.Position = UDim2.new(0.65, 0, 0, y)
    clr.PlaceholderText = "R,G,B"
    clr.Text = "255,255,255"
    clr.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    clr.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", clr)
    
    return txt, clr
end

local I_Name, C_Name = CreateField("Yeni İsim", 70)
local I_Rank, C_Rank = CreateField("Yeni Rütbe", 130)
local I_Team, C_Team = CreateField("Yeni Takım", 190)

-- ÜRET BUTONU
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(0, 340, 0, 55)
Apply.Position = UDim2.new(0.05, 0, 0.75, 0)
Apply.Text = "SİSTEMİ TETİKLE"
Apply.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Apply.TextColor3 = Color3.new(1,1,1)
Apply.Font = Enum.Font.GothamBlack
Instance.new("UICorner", Apply)

-- MOBİL BUTON
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.new(0, 50, 0, 50)
Mob.Position = UDim2.new(1, -65, 0.5, -25)
Mob.Text = "TA"
Mob.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1,0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- RENK PARSE
local function GetRGB(box)
    local r, g, b = box.Text:match("(%d+),(%d+),(%d+)")
    return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Color3.new(1,1,1)
end

-- ANA FONKSİYON
Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    -- TAKIM RENK KONTROLÜ (ZORLAYICI)
    local finalTeamColor = GetRGB(C_Team)
    if I_Team.Text ~= "" then
        for _, t in pairs(Teams:GetTeams()) do
            if t.Name:lower() == I_Team.Text:lower() then
                finalTeamColor = t.TeamColor.Color
                break
            end
        end
    end

    -- NAMETAG GÜNCELLEME
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text:lower()
            -- İSİM
            if I_Name.Text ~= "" and (txt:find(Player.Name:lower()) or txt:find(Player.DisplayName:lower()) or v.Name:lower():find("name")) then
                v.Text = I_Name.Text
                v.TextColor3 = GetRGB(C_Name)
            -- RÜTBE
            elseif I_Rank.Text ~= "" and (v.Name:lower():find("rank") or txt:find("guest") or txt:find("rütbe")) then
                v.Text = I_Rank.Text
                v.TextColor3 = GetRGB(C_Rank)
            -- TAKIM (İşte burası o otomatik rengi basan yer)
            elseif I_Team.Text ~= "" and (v.Name:lower():find("team") or txt:find("takım") or txt:find("sivil")) then
                v.Text = I_Team.Text
                v.TextColor3 = finalTeamColor
            end
        end
    end
end)

-- PC K KISAYOL
UserInputService.InputBegan:Connect(function(i, p)
    if not p and i.KeyCode == Enum.KeyCode.K then Main.Visible = not Main.Visible end
end)
