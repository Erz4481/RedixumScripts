-- [[ RENDIX STUDIO - UNIVERSAL SUPREME v15.5 ]] --
-- Fix: OIO, AAT and TA Game Structures
-- Feature: Deep Billboard Injection & Layout Fix

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local Player = Players.LocalPlayer

-- UI TEMİZLİK
if Player.PlayerGui:FindFirstChild("REDIX_SUPREME_V15") then Player.PlayerGui.REDIX_SUPREME_V15:Destroy() end

local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "REDIX_SUPREME_V15"
ScreenGui.ResetOnSpawn = false

-- ANA PANEL (Görseldeki Glass UI Tasarımı)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(450, 380)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BackgroundTransparency = 0.2
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(85, 95, 210)

local Content = Instance.new("ScrollingFrame", Main)
Content.Size = UDim2.new(1, -30, 1, -100)
Content.Position = UDim2.new(0, 15, 0, 15)
Content.BackgroundTransparency = 1
Content.CanvasSize = UDim2.new(0, 0, 2, 0)
Content.ScrollBarThickness = 0
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 8)

-- INPUT OLUŞTURUCU
local function CreateInp(place)
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    f.BackgroundTransparency = 0.5
    Instance.new("UICorner", f)

    local box = Instance.new("TextBox", f)
    box.Size = UDim2.fromScale(0.4, 0.7)
    box.Position = UDim2.fromScale(0.3, 0.15)
    box.PlaceholderText = place
    box.TextColor3 = Color3.new(1, 1, 1)
    box.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Instance.new("UICorner", box)

    local rgb = Instance.new("TextBox", f)
    rgb.Size = UDim2.fromScale(0.25, 0.7)
    rgb.Position = UDim2.fromScale(0.72, 0.15)
    rgb.Text = "255,255,255"
    rgb.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    rgb.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", rgb)
    return box, rgb
end

local I_Name, C_Name = CreateInp("İsim Değiştir...")
local I_Rank, C_Rank = CreateInp("Rütbe Değiştir...")

-- OIO ÖZEL TAKIM SEÇİCİ
local SelTeam, SelCol = "", nil
local DropBtn = Instance.new("TextButton", Content)
DropBtn.Size = UDim2.new(1, 0, 0, 40)
DropBtn.Text = "TAKIM SEÇİN (OIO/AAT)"
DropBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
DropBtn.TextColor3 = Color3.fromRGB(120, 170, 255)
Instance.new("UICorner", DropBtn)

-- GÜNCELLE BUTONU (OIO DEEP FIX)
local Apply = Instance.new("TextButton", Main)
Apply.Size = UDim2.new(1, -30, 0, 50)
Apply.Position = UDim2.new(0.5, 0, 1, -35)
Apply.AnchorPoint = Vector2.new(0.5, 0.5)
Apply.BackgroundColor3 = Color3.fromRGB(85, 95, 210)
Apply.Text = "OIO NAMETAGLARINI ZORLA KIR"
Apply.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Apply)

Apply.MouseButton1Click:Connect(function()
    local char = Player.Character
    if not char then return end

    local function GetRGB(txt)
        local r, g, b = txt:match("(%d+),(%d+),(%d+)")
        return (r and g and b) and Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) or Color3.new(1, 1, 1)
    end

    local nC, rC = GetRGB(C_Name.Text), GetRGB(C_Rank.Text)

    -- OIO İÇİN DERİN TARAMA (DEEP SCAN)
    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            local labels = {}
            for _, v in pairs(obj:GetDescendants()) do
                if v:IsA("TextLabel") and v.Visible then table.insert(labels, v) end
            end
            
            -- OIO'da katmanlar farklı olabilir, konuma göre sıralıyoruz
            table.sort(labels, function(a, b) return a.AbsolutePosition.Y < b.AbsolutePosition.Y end)

            if #labels >= 1 and I_Name.Text ~= "" then
                labels[1].Text = I_Name.Text
                labels[1].TextColor3 = nC
            end
            if #labels >= 2 and I_Rank.Text ~= "" then
                labels[2].Text = I_Rank.Text
                labels[2].TextColor3 = rC
            end
            -- En alttaki her zaman takımdır (OIO Takım Fix)
            if #labels >= 3 and SelTeam ~= "" then
                labels[#labels].Text = SelTeam
                labels[#labels].TextColor3 = SelCol
            end
        end
    end
end)

-- MOBİL RE BUTONU
local Mob = Instance.new("TextButton", ScreenGui)
Mob.Size = UDim2.fromOffset(50, 50)
Mob.Position = UDim2.new(1, -60, 0.5, -25)
Mob.Text = "RE"
Mob.Draggable = true
Instance.new("UICorner", Mob).CornerRadius = UDim.new(1, 0)
Mob.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
