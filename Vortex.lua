-- VORTEX DOMINATOR V10.4 - THE HUNTER LEGACY
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
ScreenGui.Name = "VortexV10_HunterEdition"

-- [ BOTÃO FLUTUANTE ]
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenBtn.Text = "V10"; OpenBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
OpenBtn.Font = Enum.Font.SourceSansBold; OpenBtn.TextSize = 25
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 50)

-- [ MENU PRINCIPAL ]
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
MainFrame.Size = UDim2.new(0, 260, 0, 580)
MainFrame.Position = UDim2.new(0.5, -130, 0.2, 0)
MainFrame.Active = true; MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

Title.Parent = MainFrame; Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "VORTEX ULTIMATE"; Title.TextColor3 = Color3.fromRGB(255, 215, 0)
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

-- [ SISTEMA DE ESCUDO V8.4 HUNTER INTEGRADO ]
local function HunterShield()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")

    -- Método Hunter: Desativação de juntas e proteção de estado
    hum.BreakJointsOnDeath = false
    
    -- O Segredo da 8.4: Conexão direta com a mudança de vida
    hum.HealthChanged:Connect(function(health)
        if escudado and health < 100 then
            hum.Health = 100
        end
    end)

    -- Proteção de queda e estado da 8.4
    hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
end

-- [ WORLD EATER ]
createBtn("WORLD EATER (LENDÁRIO)", UDim2.new(0.05, 0, 0.23, 0), Color3.fromRGB(255, 69, 0)).MouseButton1Click:Connect(function()
    local targetChar = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.find(p.Name:lower(), NameInput.Text:lower()) then targetChar = p.Character end
    end
    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        local hrp = targetChar.HumanoidRootPart
        task.spawn(function()
            for i = 1, 150 do
                for _, part in pairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
                        part.CFrame = hrp.CFrame * CFrame.new(0, 2, 0)
                        part.Velocity = Vector3.new(0, 100, 0)
                    end
                end
                task.wait(0.03)
            end
        end)
    end
end)

-- [ BOTÃO ESCUDO V8.4 ]
local BpBtn = createBtn("ESCUDO VORTEX: OFF", UDim2.new(0.05, 0, 0.47, 0), Color3.fromRGB(150, 0, 0))
BpBtn.MouseButton1Click:Connect(function()
    escudado = not escudado
    BpBtn.Text = escudado and "ESCUDO: ATIVO" or "ESCUDO VORTEX: OFF"
    BpBtn.BackgroundColor3 = escudado and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    if escudado then 
        HunterShield() 
    end
end)

-- [ FUNÇÃO DE FLING POWER SPIN ]
createBtn("EXPULSAR (POWER SPIN)", UDim2.new(0.05, 0, 0.31, 0), Color3.fromRGB(200, 0, 0)).MouseButton1Click:Connect(function()
    local lp = game.Players.LocalPlayer
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local oldPos = hrp.CFrame
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("V9Tag") then
            local tHrp = p.Character:FindFirstChild("HumanoidRootPart")
            if tHrp then
                for i = 1, 15 do
                    hrp.CFrame = tHrp.CFrame * CFrame.Angles(0, math.rad(i * 90), 0)
                    hrp.Velocity = Vector3.new(12000, 12000, 12000)
                    task.wait()
                end
            end
        end
    end
    hrp.CFrame = oldPos
end)

-- [ OUTRAS FUNÇÕES ]
createBtn("SINCRONIZAR", UDim2.new(0.05, 0, 0.55, 0), Color3.fromRGB(0, 120, 120)).MouseButton1Click:Connect(HunterShield)

-- [ LOOP REGENERATIVO DA 8.4 ]
game:GetService("RunService").RenderStepped:Connect(function()
    if escudado then
        local p = game.Players.LocalPlayer
        if p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum.Health < 100 then hum.Health = 100 end
            -- Garante que o estado não mude para morto
            if hum:GetState() == Enum.HumanoidStateType.Dead then
                hum:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end
end)
