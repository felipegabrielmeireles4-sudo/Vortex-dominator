--[[
    VORTEX NEBULA V12 - SISTEMA HUNTER ULTIMATE
    COMPLETAMENTE FUNCIONAL PARA ROBLOX
]]

-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- VARIÁVEIS GLOBAIS
local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local ScreenGui = Instance.new("ScreenGui")
local escudado = false
local vooAtivo = false
local linhasAtivas = {}
local suspeitos = {}
local MenuVisible = false

-- CONFIGURAÇÕES DA GUI
ScreenGui.Name = "VortexNebulaV12"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- BOTÃO FLUTUANTE
local OpenBtn = Instance.new("TextButton")
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 20, 0.5, -30)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Text = "V12"
OpenBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 20
OpenBtn.Draggable = true
OpenBtn.Active = true
OpenBtn.Selectable = true

-- ARREDONDAR BOTÃO
local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 30)
OpenCorner.Parent = OpenBtn

-- BORDA BOTÃO
local OpenStroke = Instance.new("UIStroke")
OpenStroke.Color = Color3.fromRGB(0, 255, 255)
OpenStroke.Thickness = 2
OpenStroke.Parent = OpenBtn

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Position = UDim2.new(0.5, -350, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- ARREDONDAR MENU
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- GRADIENTE MENU
local MainGradient = Instance.new("UIGradient")
MainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
})
MainGradient.Parent = MainFrame

-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "🔥 VORTEX NEBULA V12 🔥"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 24

-- CORNER DO TÍTULO
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- BOTÃO FECHAR
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0, 7)
CloseBtn.Text = "✕"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20

-- CORNER BOTÃO FECHAR
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- INPUT DE NOME
local NameInput = Instance.new("TextBox")
NameInput.Parent = MainFrame
NameInput.Size = UDim2.new(0.3, -10, 0, 40)
NameInput.Position = UDim2.new(0.02, 0, 0.12, 0)
NameInput.PlaceholderText = "🎯 NICK DO ALVO..."
NameInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
NameInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NameInput.TextColor3 = Color3.new(1, 1, 1)
NameInput.Font = Enum.Font.Gotham
NameInput.TextSize = 14
NameInput.ClearTextOnFocus = false

-- CORNER INPUT
local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 6)
InputCorner.Parent = NameInput

-- BORDA INPUT
local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(0, 255, 255)
InputStroke.Thickness = 1
InputStroke.Parent = NameInput

-- FRAME DE CONTEÚDO
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(0.96, 0, 0, 300)
ContentFrame.Position = UDim2.new(0.02, 0, 0.2, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ContentFrame.BackgroundTransparency = 0.5

-- CORNER CONTEÚDO
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

-- LISTA DE BOTÕES
local ButtonList = Instance.new("ScrollingFrame")
ButtonList.Parent = ContentFrame
ButtonList.Size = UDim2.new(1, -20, 1, -20)
ButtonList.Position = UDim2.new(0, 10, 0, 10)
ButtonList.BackgroundTransparency = 1
ButtonList.BorderSizePixel = 0
ButtonList.CanvasSize = UDim2.new(0, 0, 0, 0)
ButtonList.ScrollBarThickness = 5
ButtonList.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)

-- LAYOUT DOS BOTÕES
local ButtonLayout = Instance.new("UIListLayout")
ButtonLayout.Parent = ButtonList
ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
ButtonLayout.Padding = UDim.new(0, 5)

-- FUNÇÃO PARA CRIAR BOTÕES
local function criarBotao(texto, cor, callback)
    local botao = Instance.new("TextButton")
    botao.Parent = ButtonList
    botao.Size = UDim2.new(1, -10, 0, 45)
    botao.BackgroundColor3 = cor
    botao.Text = texto
    botao.TextColor3 = Color3.new(1, 1, 1)
    botao.Font = Enum.Font.GothamBold
    botao.TextSize = 14
    botao.AutoButtonColor = false
    
    local botaoCorner = Instance.new("UICorner")
    botaoCorner.CornerRadius = UDim.new(0, 8)
    botaoCorner.Parent = botao
    
    local botaoStroke = Instance.new("UIStroke")
    botaoStroke.Color = Color3.fromRGB(255, 255, 255)
    botaoStroke.Thickness = 1
    botaoStroke.Transparency = 0.7
    botaoStroke.Parent = botao
    
    botao.MouseButton1Click:Connect(callback)
    
    -- Efeito hover
    botao.MouseEnter:Connect(function()
        TweenService:Create(botao, TweenInfo.new(0.2), {BackgroundColor3 = cor:Lerp(Color3.new(1,1,1), 0.2)}):Play()
    end)
    
    botao.MouseLeave:Connect(function()
        TweenService:Create(botao, TweenInfo.new(0.2), {BackgroundColor3 = cor}):Play()
    end)
    
    return botao
end

-- BOTÃO 1: MARCAR ALVO
criarBotao("🎯 MARCAR ALVO", Color3.fromRGB(138, 43, 226), function()
    local alvo = NameInput.Text
    if alvo == "" then
        alvo = "Todos"
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and (alvo == "Todos" or string.find(player.Name:lower(), alvo:lower())) then
            if player.Character and player.Character:FindFirstChild("Head") then
                local head = player.Character.Head
                
                -- Remover tag antiga
                if head:FindFirstChild("TagV12") then
                    head.TagV12:Destroy()
                end
                
                -- Criar nova tag
                local tag = Instance.new("BillboardGui")
                tag.Name = "TagV12"
                tag.Parent = head
                tag.Size = UDim2.new(0, 200, 0, 50)
                tag.StudsOffset = Vector3.new(0, 3, 0)
                tag.AlwaysOnTop = true
                
                local frame = Instance.new("Frame")
                frame.Parent = tag
                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                frame.BackgroundTransparency = 0.3
                
                local frameCorner = Instance.new("UICorner")
                frameCorner.CornerRadius = UDim.new(0, 10)
                frameCorner.Parent = frame
                
                local texto = Instance.new("TextLabel")
                texto.Parent = tag
                texto.Size = UDim2.new(1, 0, 1, 0)
                texto.Text = "🔥 ALVO V12 🔥\n" .. player.Name
                texto.TextColor3 = Color3.new(1, 1, 1)
                texto.BackgroundTransparency = 1
                texto.TextScaled = true
                texto.Font = Enum.Font.GothamBlack
                
                local textoStroke = Instance.new("UIStroke")
                textoStroke.Color = Color3.fromRGB(255, 0, 0)
                textoStroke.Thickness = 2
                textoStroke.Parent = texto
            end
        end
    end
end)

-- BOTÃO 2: WORLD EATER
criarBotao("🌍 WORLD EATER", Color3.fromRGB(255, 69, 0), function()
    local alvo = NameInput.Text
    if alvo == "" then return end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LP and string.find(player.Name:lower(), alvo:lower()) then
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                
                spawn(function()
                    local partes = {}
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and not obj.Anchored and obj.Parent and not obj:IsDescendantOf(LP.Character) then
                            if obj.Name ~= "Baseplate" and obj.Size.Magnitude < 50 then
                                table.insert(partes, obj)
                            end
                        end
                    end
                    
                    for i, parte in ipairs(partes) do
                        if parte and parte.Parent then
                            parte.CFrame = hrp.CFrame * CFrame.new(0, 5 + i, 0)
                            parte.Velocity = Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))
                            wait(0.01)
                        end
                    end
                end)
            end
        end
    end
end)

-- BOTÃO 3: EXPULSAR
criarBotao("💥 EXPULSAR", Color3.fromRGB(200, 0, 0), function()
    local lp = LP
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = lp.Character.HumanoidRootPart
    local oldPos = hrp.CFrame
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local thrp = player.Character.HumanoidRootPart
            
            for i = 1, 20 do
                hrp.CFrame = thrp.CFrame * CFrame.new(0, 10 * math.sin(i), 10 * math.cos(i))
                thrp.Velocity = Vector3.new(0, 500, 0)
                
                local efeito = Instance.new("Part")
                efeito.Size = Vector3.new(2, 2, 2)
                efeito.CFrame = thrp.CFrame
                efeito.BrickColor = BrickColor.new("Bright red")
                efeito.Material = Enum.Material.Neon
                efeito.Anchored = true
                efeito.CanCollide = false
                efeito.Parent = workspace
                
                game:GetService("Debris"):AddItem(efeito, 0.3)
                wait(0.03)
            end
        end
    end
    
    hrp.CFrame = oldPos
end)

-- BOTÃO 4: INVISIBILIDADE
criarBotao("👻 INVISIBILIDADE", Color3.fromRGB(128, 0, 128), function()
    if LP.Character then
        for _, parte in ipairs(LP.Character:GetDescendants()) do
            if parte:IsA("BasePart") then
                parte.Transparency = 1
            end
        end
    end
end)

-- BOTÃO 5: VOO
criarBotao("🦅 ATIVAR VOO", Color3.fromRGB(0, 100, 200), function()
    vooAtivo = not vooAtivo
    
    if vooAtivo and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVelocity = Instance.new("BodyVelocity")
        
        bodyGyro.Parent = hrp
        bodyGyro.MaxTorque = Vector3.new(40000, 40000, 40000)
        bodyGyro.P = 20000
        bodyGyro.D = 1000
        
        bodyVelocity.Parent = hrp
        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        spawn(function()
            while vooAtivo and LP.Character and hrp.Parent do
                local moveDir = Vector3.new()
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    moveDir = moveDir - Vector3.new(0, 1, 0)
                end
                
                if moveDir.Magnitude > 0 then
                    moveDir = moveDir.Unit * 50
                end
                
                bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + (Camera.CFrame.LookVector * 10))
                bodyVelocity.Velocity = moveDir
                
                wait()
            end
            
            if bodyGyro then bodyGyro:Destroy() end
            if bodyVelocity then bodyVelocity:Destroy() end
        end)
    end
end)

-- BOTÃO 6: DETECTAR HACKERS
criarBotao("🔍 DETECTAR HACKERS", Color3.fromRGB(0, 150, 0), function()
    spawn(function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LP and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                
                if hrp and hum then
                    -- Detectar speed hack
                    if hum.WalkSpeed > 30 then
                        suspeitos[player.Name] = {
                            tipo = "⚡ SPEED HACK",
                            valor = hum.WalkSpeed
                        }
                    end
                    
                    -- Detectar fly hack
                    if hrp.Position.Y > 50 then
                        suspeitos[player.Name] = {
                            tipo = "🦅 FLY HACK",
                            valor = math.floor(hrp.Position.Y)
                        }
                    end
                end
            end
        end
        
        -- Mostrar suspeitos
        for nome, dados in pairs(suspeitos) do
            print(string.format("🚨 SUSPEITO: %s | %s | %s", nome, dados.tipo, dados.valor))
        end
    end)
end)

-- BOTÃO 7: LIMPAR TAGS
criarBotao("🧹 LIMPAR TAGS", Color3.fromRGB(150, 0, 150), function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            if head:FindFirstChild("TagV12") then
                head.TagV12:Destroy()
            end
        end
    end
    
    for _, line in pairs(linhasAtivas) do
        if line then line:Destroy() end
    end
    linhasAtivas = {}
    suspeitos = {}
end)

-- ATUALIZAR CANVAS SIZE
ButtonLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ButtonList.CanvasSize = UDim2.new(0, 0, 0, ButtonLayout.AbsoluteContentSize.Y + 10)
end)

-- ESCUDO
local ShieldBtn = Instance.new("TextButton")
ShieldBtn.Parent = MainFrame
ShieldBtn.Size = UDim2.new(0.3, 0, 0, 45)
ShieldBtn.Position = UDim2.new(0.02, 0, 0.85, 0)
ShieldBtn.Text = "🛡️ ESCUDO: OFF"
ShieldBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ShieldBtn.TextColor3 = Color3.new(1, 1, 1)
ShieldBtn.Font = Enum.Font.GothamBold
ShieldBtn.TextSize = 14

local ShieldCorner = Instance.new("UICorner")
ShieldCorner.CornerRadius = UDim.new(0, 8)
ShieldCorner.Parent = ShieldBtn

ShieldBtn.MouseButton1Click:Connect(function()
    escudado = not escudado
    ShieldBtn.Text = escudado and "🛡️ ESCUDO: ATIVO" or "🛡️ ESCUDO: OFF"
    ShieldBtn.BackgroundColor3 = escudado and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- LISTA DE SUSPEITOS
local SuspectList = Instance.new("ScrollingFrame")
SuspectList.Parent = MainFrame
SuspectList.Size = UDim2.new(0.6, 0, 0, 100)
SuspectList.Position = UDim2.new(0.35, 0, 0.85, 0)
SuspectList.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SuspectList.BorderSizePixel = 0
SuspectList.CanvasSize = UDim2.new(0, 0, 0, 0)

local SuspectCorner = Instance.new("UICorner")
SuspectCorner.CornerRadius = UDim.new(0, 8)
SuspectCorner.Parent = SuspectList

local SuspectLayout = Instance.new("UIListLayout")
SuspectLayout.Parent = SuspectList
SuspectLayout.Padding = UDim.new(0, 2)

-- FUNÇÃO PARA ALTERNAR MENU
local function toggleMenu()
    MenuVisible = not MenuVisible
    MainFrame.Visible = MenuVisible
    OpenBtn.Visible = not MenuVisible
end

CloseBtn.MouseButton1Click:Connect(toggleMenu)
OpenBtn.MouseButton1Click:Connect(toggleMenu)

-- LOOP DE PROTEÇÃO
RunService.RenderStepped:Connect(function()
    if escudado and LP.Character then
        local hum = LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            if hum.Health < 100 then
                hum.Health = 100
            end
            
            if hum:GetState() == Enum.HumanoidStateType.Dead then
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
    end
end)

-- ATUALIZAR LISTA DE SUSPEITOS
spawn(function()
    while true do
        wait(2)
        
        -- Limpar lista antiga
        for _, child in ipairs(SuspectList:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        
        -- Adicionar suspeitos
        for nome, dados in pairs(suspeitos) do
            local label = Instance.new("TextLabel")
            label.Parent = SuspectList
            label.Size = UDim2.new(1, -10, 0, 25)
            label.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
            label.Text = string.format("%s | %s | %s", nome, dados.tipo, tostring(dados.valor))
            label.TextColor3 = Color3.fromRGB(255, 100, 100)
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            
            local labelCorner = Instance.new("UICorner")
            labelCorner.CornerRadius = UDim.new(0, 4)
            labelCorner.Parent = label
        end
        
        SuspectList.CanvasSize = UDim2.new(0, 0, 0, SuspectLayout.AbsoluteContentSize.Y)
    end
end)

-- SISTEMA DE ARCO-ÍRIS
spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.01) % 1
        local color = Color3.fromHSV(hue, 1, 1)
        OpenBtn.TextColor3 = color
        OpenStroke.Color = color
        Title.TextColor3 = color
        wait(0.05)
    end
end)

-- NOTIFICAÇÃO
local Notification = Instance.new("TextLabel")
Notification.Parent = ScreenGui
Notification.Size = UDim2.new(0, 300, 0, 50)
Notification.Position = UDim2.new(0.5, -150, 0, -50)
Notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Notification.BackgroundTransparency = 0.3
Notification.Text = "🔥 VORTEX NEBULA V12 CARREGADO 🔥"
Notification.TextColor3 = Color3.fromRGB(0, 255, 255)
Notification.Font = Enum.Font.GothamBold
Notification.TextSize = 16

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 10)
NotifCorner.Parent = Notification

local NotifStroke = Instance.new("UIStroke")
NotifStroke.Color = Color3.fromRGB(0, 255, 255)
NotifStroke.Thickness = 2
NotifStroke.Parent = Notification

-- ANIMAÇÃO DA NOTIFICAÇÃO
TweenService:Create(Notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, 20)}):Play()
wait(3)
TweenService:Create(Notification, TweenInfo.new(0.5), {Position = UDim2.n
