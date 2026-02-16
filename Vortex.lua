--[[
    VORTEX NEBULA V12 - VERSÃO DELTA
    100% FUNCIONAL - COM END FINAL
]]

-- Carregar serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Função principal
local function main()
    -- Variáveis locais
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local screenGui = Instance.new("ScreenGui")
    local menuAberto = false
    local escudoAtivo = false
    local vooAtivo = false
    local alvos = {}
    local suspeitos = {}

    -- Configurar GUI principal
    screenGui.Name = "VortexNebula"
    screenGui.Parent = CoreGui
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Função para criar botão flutuante
    local function criarBotaoFlutuante()
        local botao = Instance.new("TextButton")
        botao.Parent = screenGui
        botao.Size = UDim2.new(0, 60, 0, 60)
        botao.Position = UDim2.new(0, 20, 0.5, -30)
        botao.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        botao.Text = "V12"
        botao.TextColor3 = Color3.fromRGB(0, 255, 255)
        botao.Font = Enum.Font.SourceSansBold
        botao.TextSize = 24
        botao.Draggable = true
        botao.Name = "BotaoFlutuante"
        
        -- Arredondar
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 30)
        corner.Parent = botao
        
        -- Borda
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 255, 255)
        stroke.Thickness = 2
        stroke.Parent = botao
        
        return botao
    end

    -- Função para criar menu principal
    local function criarMenu()
        local frame = Instance.new("Frame")
        frame.Parent = screenGui
        frame.Size = UDim2.new(0, 600, 0, 450)
        frame.Position = UDim2.new(0.5, -300, 0.2, 0)
        frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        frame.BackgroundTransparency = 0.1
        frame.Active = true
        frame.Draggable = true
        frame.Visible = false
        frame.Name = "MenuPrincipal"
        
        -- Arredondar
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
        
        -- Título
        local titulo = Instance.new("TextLabel")
        titulo.Parent = frame
        titulo.Size = UDim2.new(1, 0, 0, 40)
        titulo.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        titulo.Text = "🔥 VORTEX NEBULA V12 🔥"
        titulo.TextColor3 = Color3.fromRGB(0, 255, 255)
        titulo.Font = Enum.Font.SourceSansBold
        titulo.TextSize = 24
        
        -- Botão fechar
        local fechar = Instance.new("TextButton")
        fechar.Parent = frame
        fechar.Size = UDim2.new(0, 30, 0, 30)
        fechar.Position = UDim2.new(1, -40, 0, 5)
        fechar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        fechar.Text = "X"
        fechar.TextColor3 = Color3.new(1, 1, 1)
        fechar.Font = Enum.Font.SourceSansBold
        fechar.TextSize = 20
        
        local fecharCorner = Instance.new("UICorner")
        fecharCorner.CornerRadius = UDim.new(0, 6)
        fecharCorner.Parent = fechar
        
        -- Input de nome
        local input = Instance.new("TextBox")
        input.Parent = frame
        input.Size = UDim2.new(0.4, -10, 0, 35)
        input.Position = UDim2.new(0.02, 0, 0.1, 0)
        input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        input.PlaceholderText = "Nome do alvo..."
        input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        input.Text = ""
        input.TextColor3 = Color3.new(1, 1, 1)
        input.Font = Enum.Font.SourceSans
        input.TextSize = 16
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 6)
        inputCorner.Parent = input
        
        -- Container dos botões
        local container = Instance.new("ScrollingFrame")
        container.Parent = frame
        container.Size = UDim2.new(0.96, 0, 0, 250)
        container.Position = UDim2.new(0.02, 0, 0.2, 0)
        container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        container.BackgroundTransparency = 0.5
        container.CanvasSize = UDim2.new(0, 0, 0, 0)
        container.ScrollBarThickness = 5
        
        local containerCorner = Instance.new("UICorner")
        containerCorner.CornerRadius = UDim.new(0, 8)
        containerCorner.Parent = container
        
        local layout = Instance.new("UIListLayout")
        layout.Parent = container
        layout.Padding = UDim.new(0, 5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        
        -- Função para criar botões
        local function criarBotao(texto, cor, callback)
            local btn = Instance.new("TextButton")
            btn.Parent = container
            btn.Size = UDim2.new(1, -10, 0, 40)
            btn.BackgroundColor3 = cor
            btn.Text = texto
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.SourceSansBold
            btn.TextSize = 16
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(callback)
            
            return btn
        end
        
        -- Botões de função
        criarBotao("🎯 MARCAR ALVO", Color3.fromRGB(138, 43, 226), function()
            local nomeAlvo = input.Text
            if nomeAlvo == "" then return end
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Name:lower():find(nomeAlvo:lower()) then
                    if p.Character and p.Character:FindFirstChild("Head") then
                        local cabeca = p.Character.Head
                        
                        -- Remover tag antiga
                        if cabeca:FindFirstChild("Tag") then
                            cabeca.Tag:Destroy()
                        end
                        
                        -- Criar nova tag
                        local tag = Instance.new("BillboardGui")
                        tag.Name = "Tag"
                        tag.Parent = cabeca
                        tag.Size = UDim2.new(0, 150, 0, 40)
                        tag.StudsOffset = Vector3.new(0, 3, 0)
                        tag.AlwaysOnTop = true
                        
                        local texto = Instance.new("TextLabel")
                        texto.Parent = tag
                        texto.Size = UDim2.new(1, 0, 1, 0)
                        texto.BackgroundTransparency = 0.5
                        texto.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        texto.Text = "🔴 ALVO\n" .. p.Name
                        texto.TextColor3 = Color3.new(1, 1, 1)
                        texto.Font = Enum.Font.SourceSansBold
                        texto.TextScaled = true
                        
                        alvos[p.Name] = p
                    end
                end
            end
        end)
        
        criarBotao("🛡️ ATIVAR ESCUDO", Color3.fromRGB(0, 150, 0), function()
            escudoAtivo = not escudoAtivo
            
            if escudoAtivo then
                if player.Character then
                    local hum = player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.BreakJointsOnDeath = false
                    end
                end
            end
        end)
        
        criarBotao("🦅 ATIVAR VOO", Color3.fromRGB(0, 100, 200), function()
            vooAtivo = not vooAtivo
            
            if vooAtivo and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local bg = Instance.new("BodyGyro")
                    local bv = Instance.new("BodyVelocity")
                    
                    bg.Parent = hrp
                    bg.MaxTorque = Vector3.new(40000, 40000, 40000)
                    bg.P = 20000
                    
                    bv.Parent = hrp
                    bv.MaxForce = Vector3.new(40000, 40000, 40000)
                    
                    -- Loop do voo
                    spawn(function()
                        while vooAtivo and hrp and hrp.Parent do
                            local move = Vector3.new()
                            
                            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                                move = move + camera.CFrame.LookVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                                move = move - camera.CFrame.LookVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                                move = move - camera.CFrame.RightVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                                move = move + camera.CFrame.RightVector
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                move = move + Vector3.new(0, 1, 0)
                            end
                            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                                move = move - Vector3.new(0, 1, 0)
                            end
                            
                            if move.Magnitude > 0 then
                                move = move.Unit * 50
                            end
                            
                            bg.CFrame = CFrame.new(hrp.Position, hrp.Position + camera.CFrame.LookVector)
                            bv.Velocity = move
                            
                            RunService.RenderStepped:Wait()
                        end
                        
                        if bg then bg:Destroy() end
                        if bv then bv:Destroy() end
                    end)
                end
            end
        end)
        
        criarBotao("🔍 DETECTAR HACKERS", Color3.fromRGB(150, 0, 150), function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    
                    if hrp and hum then
                        -- Speed hack
                        if hum.WalkSpeed > 30 then
                            suspeitos[p.Name] = {
                                tipo = "Speed Hack",
                                valor = hum.WalkSpeed
                            }
                        end
                        
                        -- Fly hack (posição Y alta)
                        if hrp.Position.Y > 50 then
                            suspeitos[p.Name] = {
                                tipo = "Fly Hack",
                                valor = math.floor(hrp.Position.Y)
                            }
                        end
                    end
                end
            end
            
            print("=== SUSPEITOS DETECTADOS ===")
            for nome, dados in pairs(suspeitos) do
                print(nome .. " - " .. dados.tipo .. " (" .. dados.valor .. ")")
            end
        end)
        
        criarBotao("💥 EXPULSAR ALVO", Color3.fromRGB(200, 0, 0), function()
            local nomeAlvo = input.Text
            if nomeAlvo == "" then return end
            
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Name:lower():find(nomeAlvo:lower()) then
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = p.Character.HumanoidRootPart
                        hrp.Velocity = Vector3.new(0, 5000, 0)
                    end
                end
            end
        end)
        
        criarBotao("👻 INVISIBILIDADE", Color3.fromRGB(128, 0, 128), function()
            if player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = 1
                    end
                end
            end
        end)
        
        criarBotao("🧹 LIMPAR TUDO", Color3.fromRGB(80, 80, 80), function()
            -- Remover tags
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Head") then
                    local cabeca = p.Character.Head
                    if cabeca:FindFirstChild("Tag") then
                        cabeca.Tag:Destroy()
                    end
                end
            end
            
            -- Limpar listas
            alvos = {}
            suspeitos = {}
            
            -- Resetar visibilidade
            if player.Character then
                for _, v in pairs(player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.Transparency = 0
                    end
                end
            end
            
            -- Desativar voo
            vooAtivo = false
        end)
        
        -- Ajustar canvas size
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end)
        
        -- Frame de status
        local statusFrame = Instance.new("Frame")
        statusFrame.Parent = frame
        statusFrame.Size = UDim2.new(0.96, 0, 0, 60)
        statusFrame.Position = UDim2.new(0.02, 0, 0.8, 0)
        statusFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        
        local statusCorner = Instance.new("UICorner")
        statusCorner.CornerRadius = UDim.new(0, 8)
        statusCorner.Parent = statusFrame
        
        local statusTexto = Instance.new("TextLabel")
        statusTexto.Parent = statusFrame
        statusTexto.Size = UDim2.new(1, -10, 1, -10)
        statusTexto.Position = UDim2.new(0, 5, 0, 5)
        statusTexto.BackgroundTransparency = 1
        statusTexto.Text = "✅ Sistema carregado | Escudo: OFF | Voo: OFF"
        statusTexto.TextColor3 = Color3.new(1, 1, 1)
        statusTexto.Font = Enum.Font.SourceSans
        statusTexto.TextSize = 16
        statusTexto.TextXAlignment = Enum.TextXAlignment.Left
        
        -- Atualizar status
        spawn(function()
            while true do
                wait(0.5)
                statusTexto.Text = string.format("✅ Sistema ativo | Escudo: %s | Voo: %s", 
                    escudoAtivo and "ON" or "OFF",
                    vooAtivo and "ON" or "OFF")
            end
        end)
        
        return frame, fechar
    end

    -- Criar elementos
    local botaoFlutuante = criarBotaoFlutuante()
    local menu, botaoFechar = criarMenu()

    -- Controle do menu
    botaoFlutuante.MouseButton1Click:Connect(function()
        menu.Visible = true
        botaoFlutuante.Visible = false
    end)

    botaoFechar.MouseButton1Click:Connect(function()
        menu.Visible = false
        botaoFlutuante.Visible = true
    end)

    -- Loop de proteção do escudo
    RunService.RenderStepped:Connect(function()
        if escudoAtivo and player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
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

    -- Notificação inicial
    local notificacao = Instance.new("TextLabel")
    notificacao.Parent = screenGui
    notificacao.Size = UDim2.new(0, 300, 0, 50)
    notificacao.Position = UDim2.new(0.5, -150, 0, -50)
    notificacao.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notificacao.BackgroundTransparency = 0.2
    notificacao.Text = "🔥 VORTEX NEBULA V12 CARREGADO 🔥"
    notificacao.TextColor3 = Color3.fromRGB(0, 255, 255)
    notificacao.Font = Enum.Font.SourceSansBold
    notificacao.TextSize = 18
    notificacao.TextScaled = true

    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 10)
    notifCorner.Parent = notificacao

    -- Animação da notificação
    TweenService:Create(notificacao, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, 20)}):Play()
    wait(3)
    TweenService:Create(notificacao, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, -50)}):Play()
    wait(0.5)
    notificacao:Destroy()

    print("✅ Vortex Nebula V12 carregado com sucesso!")
    print("📌 Pressione o botão V12 na tela para abrir o menu")

end
