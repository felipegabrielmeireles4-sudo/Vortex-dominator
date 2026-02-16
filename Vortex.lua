--[[
    VORTEX NEBULA V12 - SISTEMA HUNTER ULTIMATE
    Funcionalidades: Detecção, Rastreamento, Eliminação Visual, Anti-Hacker
]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local OpenBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local NameInput = Instance.new("TextBox")
local TabButtons = Instance.new("Frame")
local TabContent = Instance.new("Frame")
local ListFrame = Instance.new("ScrollingFrame")
local UIList = Instance.new("UIListLayout")

-- CONFIGURAÇÕES AVANÇADAS
local Config = {
    RainbowMode = true,
    AutoDetect = true,
    AntiLag = true,
    TraceLines = true,
    NotificationSound = true,
    AutoKillHackers = false,
    DetectSpeedHack = true,
    DetectFlyHack = true,
    DetectAimbot = true,
    SpeedThreshold = 100,
    FlyThreshold = 10
}

-- VARIÁVEIS GLOBAIS
local escudado = false
local suspeitos = {}
local hackersDetectados = {}
local vooAtivo = false
local linhasAtivas = {}
local coresArcoIris = {1, 0, 0}
local tabAtual = "Hunt"

-- [ SETUP DA SCREEN ]
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "VortexNebulaV12"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [ BOTÃO FLUTUANTE ANIMADO ]
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
OpenBtn.Text = "VN12"
OpenBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 18
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 30)

local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Color = Color3.fromRGB(0, 255, 255)
OpenStroke.Thickness = 2
OpenStroke.Transparency = 0.5

-- [ MENU PRINCIPAL ]
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
MainFrame.BorderSizePixel = 0
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Position = UDim2.new(0.5, -350, 0.2, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIGradient", MainFrame).Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
})

-- [ TÍTULO COM EFEITO ]
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🔥 VORTEX NEBULA V12 🔥"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

-- [ BOTÃO FECHAR ]
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 7)
CloseBtn.Text = "✕"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- [ INPUT DE NOME ]
NameInput.Parent = MainFrame
NameInput.PlaceholderText = "🎯 NICK DO ALVO..."
NameInput.Size = UDim2.new(0.3, -10, 0, 40)
NameInput.Position = UDim2.new(0.02, 0, 0.12, 0)
NameInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NameInput.TextColor3 = Color3.new(1,1,1)
NameInput.Font = Enum.Font.Gotham
NameInput.TextSize = 14
Instance.new("UICorner", NameInput).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", NameInput).Color = Color3.fromRGB(0, 255, 255)

-- [ ABAS ]
TabButtons.Parent = MainFrame
TabButtons.Size = UDim2.new(1, -20, 0, 40)
TabButtons.Position = UDim2.new(0.02, 0, 0.2, 0)
TabButtons.BackgroundTransparency = 1

local function criarAba(nome, posX)
    local btn = Instance.new("TextButton")
    btn.Parent = TabButtons
    btn.Size = UDim2.new(0, 100, 0, 35)
    btn.Position = UDim2.new(posX, 0, 0, 0)
    btn.Text = nome
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        tabAtual = nome
        for _, v in pairs(TabContent:GetChildren()) do v.Visible = false end
        if TabContent:FindFirstChild(nome) then
            TabContent[nome].Visible = true
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        btn.TextColor3 = Color3.new(0,0,0)
        task.wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    end)
    
    return btn
end

criarAba("Hunt", 0)
criarAba("Detect", 0.15)
criarAba("Visual", 0.3)
criarAba("Admin", 0.45)
criarAba("Config", 0.6)

-- [ CONTEÚDO DAS ABAS ]
TabContent.Parent = MainFrame
TabContent.Size = UDim2.new(1, -20, 0, 250)
TabContent.Position = UDim2.new(0.02, 0, 0.3, 0)
TabContent.BackgroundTransparency = 1

-- ABA HUNT
local huntFrame = Instance.new("Frame")
huntFrame.Name = "Hunt"
huntFrame.Parent = TabContent
huntFrame.Size = UDim2.new(1, 0, 1, 0)
huntFrame.BackgroundTransparency = 1

-- ABA DETECT
local detectFrame = Instance.new("ScrollingFrame")
detectFrame.Name = "Detect"
detectFrame.Parent = TabContent
detectFrame.Size = UDim2.new(1, 0, 1, 0)
detectFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
detectFrame.Visible = false
detectFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
Instance.new("UIListLayout", detectFrame).Padding = UDim.new(0, 5)

-- [ FUNÇÃO PARA CRIAR BOTÕES ]
local function criarBotao(aba, txt, posY, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = aba
    btn.Size = UDim2.new(0.48, 0, 0, 45)
    btn.Position = UDim2.new(0.01, 0, posY, 0)
    btn.Text = txt
    btn.BackgroundColor3 = cor
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- [ BOTÕES HUNT ]
criarBotao(huntFrame, "🎯 MARCAR ALVO", 0.05, Color3.fromRGB(138, 43, 226), function()
    local target = NameInput.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.find(p.Name:lower(), target) and p.Character and p.Character:FindFirstChild("Head") then
            local h = p.Character.Head
            if h:FindFirstChild("V12Tag") then h.V12Tag:Destroy() end
            
            local bg = Instance.new("BillboardGui", h)
            bg.Name = "V12Tag"
            bg.Size = UDim2.new(0, 300, 0, 80)
            bg.AlwaysOnTop = true
            bg.StudsOffset = Vector3.new(0, 3, 0)
            
            local frame = Instance.new("Frame", bg)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            frame.BackgroundTransparency = 0.3
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
            
            local txt = Instance.new("TextLabel", bg)
            txt.Size = UDim2.new(1, 0, 1, 0)
            txt.Text = "🔥 ALVO VORTEX 🔥\n" .. p.Name
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
            txt.BackgroundTransparency = 1
            txt.TextScaled = true
            txt.Font = Enum.Font.GothamBlack
            
            local outline = Instance.new("UIStroke", txt)
            outline.Color = Color3.fromRGB(255, 0, 0)
            outline.Thickness = 2
        end
    end
end)

criarBotao(huntFrame, "🌀 WORLD EATER V2", 0.2, Color3.fromRGB(255, 69, 0), function()
    local targetChar = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.find(p.Name:lower(), NameInput.Text:lower()) then 
            targetChar = p.Character 
        end
    end
    
    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
        local hrp = targetChar.HumanoidRootPart
        task.spawn(function()
            local parts = {}
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part.Anchored and part.Parent and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
                    if part.Name ~= "Baseplate" and part.Size.Magnitude < 50 then
                        table.insert(parts, part)
                    end
                end
            end
            
            for i = 1, #parts do
                local part = parts[i]
                if part and part.Parent then
                    part.CFrame = hrp.CFrame * CFrame.new(0, 5 + i, 0)
                    part.Velocity = Vector3.new(math.random(-100,100), 200, math.random(-100,100))
                    part.Anchored = false
                end
                task.wait(0.01)
            end
        end)
    end
end)

criarBotao(huntFrame, "⚡ EXPULSAR QUÂNTICO", 0.35, Color3.fromRGB(200, 0, 0), function()
    local lp = game.Players.LocalPlayer
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local oldPos = hrp.CFrame
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
            local tHrp = p.Character:FindFirstChild("HumanoidRootPart")
            if tHrp then
                for i = 1, 30 do
                    hrp.CFrame = tHrp.CFrame * CFrame.new(0, 10 * math.sin(i), 10 * math.cos(i))
                    hrp.Velocity = Vector3.new(0, 5000, 0)
                    
                    local effect = Instance.new("Part")
                    effect.Size = Vector3.new(2,2,2)
                    effect.CFrame = tHrp.CFrame
                    effect.BrickColor = BrickColor.new("Bright red")
                    effect.Material = Enum.Material.Neon
                    effect.Anchored = true
                    effect.CanCollide = false
                    effect.Parent = workspace
                    
                    game:GetService("Debris"):AddItem(effect, 0.5)
                    task.wait()
                end
            end
        end
    end
    hrp.CFrame = oldPos
    HunterShield()
end)

criarBotao(huntFrame, "🎭 INVISIBILIDADE", 0.5, Color3.fromRGB(128, 0, 128), function()
    local lp = game.Players.LocalPlayer
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
    end
end)

criarBotao(huntFrame, "👻 MODO FANTASMA", 0.65, Color3.fromRGB(0, 100, 200), function()
    vooAtivo = not vooAtivo
    if vooAtivo then
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
    end
end)

-- [ SISTEMA DE DETECÇÃO AVANÇADO ]
local function iniciarDetecção()
    task.spawn(function()
        while task.wait(1) do
            if not Config.AutoDetect then break end
            
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    
                    if hrp and humanoid then
                        -- DETECTAR SPEED HACK
                        if Config.DetectSpeedHack and humanoid.WalkSpeed > Config.SpeedThreshold then
                            adicionarSuspeito(player, "⚡ SPEED HACK", "Velocidade: " .. math.floor(humanoid.WalkSpeed))
                        end
                        
                        -- DETECTAR FLY HACK
                        if Config.DetectFlyHack then
                            local velocity = hrp.Velocity
                            if math.abs(velocity.Y) < 1 and hrp.Position.Y > 20 then
                                adicionarSuspeito(player, "🦅 FLY HACK", "Altura: " .. math.floor(hrp.Position.Y))
                            end
                        end
                        
                        -- DETECTAR AIMBOT (movimento de cabeça anormal)
                        if Config.DetectAimbot and player.Character:FindFirstChild("Head") then
                            local head = player.Character.Head
                            if head.Rotation.X > 80 or head.Rotation.X < -80 then
                                adicionarSuspeito(player, "🎯 AIMBOT", "Rotação suspeita")
                            end
                        end
                        
                        -- DETECTAR TELEPORT (distância percorrida em 1 segundo)
                        if hackersDetectados[player] and hackersDetectados[player].lastPos then
                            local dist = (hrp.Position - hackersDetectados[player].lastPos).Magnitude
                            if dist > 200 then
                                adicionarSuspeito(player, "🌀 TELEPORT", "Distância: " .. math.floor(dist))
                            end
                        end
                        
                        if not hackersDetectados[player] then
                            hackersDetectados[player] = {}
                        end
                        hackersDetectados[player].lastPos = hrp.Position
                    end
                end
            end
        end
    end)
end

local function adicionarSuspeito(player, hackType, detalhes)
    if not suspeitos[player.Name] then
        suspeitos[player.Name] = true
        
        local item = Instance.new("Frame")
        item.Parent = detectFrame
        item.Size = UDim2.new(1, -10, 0, 60)
        item.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
        Instance.new("UICorner", item).CornerRadius = UDim.new(0, 8)
        
        local nomeLabel = Instance.new("TextLabel", item)
        nomeLabel.Size = UDim2.new(0.4, 0, 1, 0)
        nomeLabel.Text = player.Name
        nomeLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        nomeLabel.BackgroundTransparency = 1
        nomeLabel.Font = Enum.Font.GothamBold
        nomeLabel.TextSize = 16
        
        local hackLabel = Instance.new("TextLabel", item)
        hackLabel.Size = UDim2.new(0.3, 0, 1, 0)
        hackLabel.Position = UDim2.new(0.4, 0, 0, 0)
        hackLabel.Text = hackType
        hackLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        hackLabel.BackgroundTransparency = 1
        
        local detalhesLabel = Instance.new("TextLabel", item)
        detalhesLabel.Size = UDim2.new(0.3, 0, 1, 0)
        detalhesLabel.Position = UDim2.new(0.7, 0, 0, 0)
        detalhesLabel.Text = detalhes
        detalhesLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        detalhesLabel.BackgroundTransparency = 1
        
        -- Botão eliminar
        local eliminar = Instance.new("TextButton", item)
        eliminar.Size = UDim2.new(0, 40, 0, 30)
        eliminar.Position = UDim2.new(0.9, 0, 0.5, -15)
        eliminar.Text = "💀"
        eliminar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        eliminar.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", eliminar).CornerRadius = UDim.new(0, 6)
        
        eliminar.MouseButton1Click:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0
            end
        end)
        
        detectFrame.CanvasSize = UDim2.new(0, 0, 0, #detectFrame:GetChildren() * 65)
    end
end

-- [ SISTEMA DE LINHAS DE RASTREAMENTO ]
local function criarLinhas()
    task.spawn(function()
        while task.wait(0.1) do
            if Config.TraceLines then
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        
                        if not linhasAtivas[player] then
                            local line = Instance.new("Part")
                            line.Size = Vector3.new(1, 1, 1)
                            line.Anchored = true
                            line.CanCollide = false
                            line.Material = Enum.Material.Neon
                            line.BrickColor = suspeitos[player.Name] and BrickColor.new("Bright red") or BrickColor.new("Bright blue")
                            line.Transparency = 0.3
                            line.Parent = workspace
                            linhasAtivas[player] = line
                        end
                        
                        local line = linhasAtivas[player]
                        if line then
                            local camera = workspace.CurrentCamera
                            local dist = (camera.CFrame.Position - hrp.Position).Magnitude
                            
                            line.Size = Vector3.new(0.2, 0.2, dist)
                            line.CFrame = CFrame.lookAt(camera.CFrame.Position, hrp.Position) * CFrame.new(0, 0, -dist/2)
                        end
                    end
                end
            end
        end
    end)
end

-- [ ESCUDO HUNTER ]
local function HunterShield()
    local p = game.Players.LocalPlayer
    local char = p.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.BreakJointsOnDeath = false
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            hum.Health = 100
            
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
end

-- [ BOTÕES DETECT ]
local function criarBotaoDetect(txt, posY, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = detectFrame
    btn.Size = UDim2.new(0.98, 0, 0, 40)
    btn.Position = UDim2.new(0.01, 0, posY, 0)
    btn.Text = txt
    btn.BackgroundColor3 = cor
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

criarBotaoDetect("INICIAR DETECÇÃO AUTOMÁTICA", 0.05, Color3.fromRGB(0, 100, 0), function()
    Config.AutoDetect = true
    iniciarDetecção()
end)

criarBotaoDetect("LIGAR LINHAS DE RASTREAMENTO", 0.15, Color3.fromRGB(0, 0, 150), function()
    Config.TraceLines = true
    criarLinhas()
end)

criarBotaoDetect("ESCANEAR TODOS AGORA", 0.25, Color3.fromRGB(150, 0, 150), function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            
            if hrp and hum then
                if hum.WalkSpeed > 30 then
                    adicionarSuspeito(player, "SPEED HACK", hum.WalkSpeed)
                end
                if hrp.Position.Y > 30 then
                    adicionarSuspeito(player, "FLY HACK", hrp.Position.Y)
                end
            end
        end
    end
end)

-- [ ESCUDO ]
local escudoBtn = Instance.new("TextButton")
escudoBtn.Parent = MainFrame
escudoBtn.Size = UDim2.new(0.3, 0, 0, 45)
escudoBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
escudoBtn.Text = "🛡️ ESCUDO: OFF"
escudoBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
escudoBtn.TextColor3 = Color3.new(1,1,1)
escudoBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", escudoBtn).CornerRadius = UDim.new(0, 8)

escudoBtn.MouseButton1Click:Connect(function()
    escudado = not escudado
   
