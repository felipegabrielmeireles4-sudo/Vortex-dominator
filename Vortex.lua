-- VORTEX DOMINATOR V10.1 - FIX IMORTAL & WORLD EATER
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local OpenBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local NameInput = Instance.new("TextBox")
local ListFrame = Instance.new("ScrollingFrame")
local UIList = Instance.new("UIListLayout")

-- [ SETUP DA SCREEN ]
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "Vortex_Ultimate"

-- [ BOTÃO FLUTUANTE ]
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.Text = "V10"; OpenBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
OpenBtn.Font = Enum.Font.SourceSansBold; OpenBtn.TextSize = 25
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 50)
local Stroke = Instance.new("UIStroke", OpenBtn)
Stroke.Color = Color3.fromRGB(255, 215, 0); Stroke.Thickness = 2

-- [ MENU PRINCIPAL ]
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(0, 260, 0, 580)
MainFrame.Position = UDim2.new(0.5, -130, 0.2, 0)
MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

Title.Parent = MainFrame; Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "VORTEX ULTIMATE (beta)"; Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Title.Font = Enum.Font.SourceSansBold

CloseBtn.Parent = MainFrame; CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(1, -35, 0, 7)
CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); CloseBtn.TextColor3 = Color3.new(1,1,1)

local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
    OpenBtn.Visible = not MainFrame.Visible
end
CloseBtn.MouseButton1Click:Connect(toggleMenu)
OpenBtn.MouseButton1Click:Connect(toggleMenu)

NameInput.Parent = MainFrame; NameInput.PlaceholderText = "NICK DO ALVO..."
NameInput.Size = UDim2.new(0.9, 0, 0, 35); NameInput.Position = UDim2.new(0.05, 0, 0.08, 0)
NameInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20); NameInput.TextColor3 = Color3.new(1,1,1)

ListFrame.Parent = MainFrame; ListFrame.Size = UDim2.new(0.9, 0, 0, 100); ListFrame.Position = UDim2.new(0.05, 0, 0.78, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); UIList.Parent = ListFrame

local function createBtn(txt, pos, col)
    local b = Instance.new("TextButton", MainFrame)
    b.Text = txt; b.Size = UDim2.new(0.9, 0, 0, 35); b.Position = pos
    b.BackgroundColor3 = col; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", b)
    return b
end

local escudado = false
local suspeitos = {}

-- [ SYNC MELHORADO ]
local function SyncServer()
    local p = game.Players.LocalPlayer
    local char = p.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            if hum.Health <= 0 then hum.Health = 100 end
        end
    end
end

-- [ WORLD EATER ]
local function WorldEater()
    local targetChar = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.find(p.Name:lower(), NameInput.Text:lower()) then targetChar = p.Character end
    end
    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        local hrp = targetChar.HumanoidRootPart
        task.spawn(function()
            for i = 1, 100 do
                for _, part in pairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
                        part.CFrame = hrp.CFrame * CFrame.new(math.random(-5,5), 2, math.random(-5,5))
                        part.Velocity = Vector3.new(0, 150, 0)
                    end
                end
                task.wait(0.05)
            end
        end)
    end
end

-- [ BOTÕES ]
createBtn("MARCAR ALVO (TAG)", UDim2.new(0.05, 0, 0.15, 0), Color3.fromRGB(138, 43, 226)).MouseButton1Click:Connect(function()
    local target = NameInput.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.find(p.Name:lower(), target) and p.Character and p.Character:FindFirstChild("Head") then
            local h = p.Character.Head
            if h:FindFirstChild("V9Tag") then h.V9Tag:Destroy() end
            local b = Instance.new("BillboardGui", h); b.Name = "V9Tag"; b.Size = UDim2.new(0, 200, 0, 50); b.AlwaysOnTop = true
            local t = Instance.new("TextLabel", b); t.Size = UDim2.new(1, 0, 1, 0); t.Text = "ALVO VORTEX"; t.TextColor3 = Color3.fromRGB(255, 0, 0); t.BackgroundTransparency = 1; t.TextScaled = true
        end
    end
end)

createBtn("WORLD EATER (LENDÁRIO)", UDim2.new(0.05, 0, 0.23, 0), Color3.fromRGB(255, 69, 0)).MouseButton1Click:Connect(WorldEater)

createBtn("EXPULSAR (POWER SPIN)", UDim2.new(0.05, 0, 0.31, 0), Color3.fromRGB(200, 0, 0)).MouseButton1Click:Connect(function()
    local lp = game.Players.LocalPlayer
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local oldPos = hrp.CFrame
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("V9Tag") then
            local tHrp = p.Character:FindFirstChild("HumanoidRootPart")
            if tHrp then
                for i = 1, 20 do
                    hrp.CFrame = tHrp.CFrame * CFrame.Angles(0, math.rad(i * 90), 0)
                    hrp.Velocity = Vector3.new(15000, 15000, 15000)
                    task.wait()
                end
            end
        end
    end
    hrp.CFrame = oldPos; SyncServer()
end)

createBtn("RADAR ELITE", UDim2.new(0.05, 0, 0.39, 0), Color3.fromRGB(40, 40, 40)).MouseButton1Click:Connect(function()
    task.spawn(function()
        while task.wait(0.5) do
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    if p.Character.HumanoidRootPart.Velocity.Magnitude > 165 and not suspeitos[p.Name] then
                        suspeitos[p.Name] = true
                        local l = Instance.new("TextLabel", ListFrame)
                        l.Size = UDim2.new(1, 0, 0, 25); l.Text = " [!] " .. p.Name; l.TextColor3 = Color3.new(1,1,1); l.BackgroundColor3 = Color3.fromRGB(40,0,0)
                    end
                end
            end
        end
    end)
end)

local BpBtn = createBtn("ESCUDO VORTEX: OFF", UDim2.new(0.05, 0, 0.47, 0), Color3.fromRGB(150, 0, 0))
BpBtn.MouseButton1Click:Connect(function()
    escudado = not escudado
    BpBtn.Text = escudado and "ESCUDO: ATIVO" or "ESCUDO VORTEX: OFF"
    BpBtn.BackgroundColor3 = escudado and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if escudado then SyncServer() end
end)

createBtn("SINCRONIZAR", UDim2.new(0.05, 0, 0.55, 0), Color3.fromRGB(0, 120, 120)).MouseButton1Click:Connect(SyncServer)

createBtn("VOO FANTASMA", UDim2.new(0.05, 0, 0.63, 0), Color3.fromRGB(0, 50, 150)).MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
end)

createBtn("LIMPAR RADAR", UDim2.new(0.05, 0, 0.71, 0), Color3.fromRGB(80, 0, 0)).MouseButton1Click:Connect(function()
    for _, c in pairs(ListFrame:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
    suspeitos = {}
end)

-- [ NOVO HEARTBEAT ULTRA-ESTÁVEL ]
game:GetService("RunService").Heartbeat:Connect(function()
    if escudado then
        local p = game.Players.LocalPlayer
        if p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                -- Impede a morte antes de acontecer
                hum.BreakJointsOnDeath = false
                if hum.Health <= 0.1 then 
                    hum.Health = 100
                    SyncServer()
                elseif hum.Health < 100 then
                    hum.Health = 100
                end
            end
        end
    end
end)
