-- ============================================
-- VORTEX DOMINATOR V11.1
-- Escudo de dano + correções
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ============================================
-- GUI
-- ============================================
local g = Instance.new("ScreenGui")
g.Name = "V11_1"
g.ResetOnSpawn = false
g.IgnoreGuiInset = true
g.DisplayOrder = 999
g.Parent = game:GetService("CoreGui")

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(0, 15, 0.4, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
openBtn.Text = "V11.1"
openBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
openBtn.TextSize = 16
openBtn.Font = Enum.Font.SourceSansBold
openBtn.BorderSizePixel = 0
openBtn.Parent = g

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(1, 0)
c1.Parent = openBtn

local s1 = Instance.new("UIStroke")
s1.Color = Color3.fromRGB(255, 215, 0)
s1.Thickness = 2
s1.Parent = openBtn

task.wait(0.1)

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 500)
frame.Position = UDim2.new(0.5, -140, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = g

local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0, 14)
c2.Parent = frame

local s2 = Instance.new("UIStroke")
s2.Color = Color3.fromRGB(255, 215, 0)
s2.Thickness = 1
s2.Parent = frame

task.wait(0.1)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
title.Text = "VORTEX V11.1"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.BorderSizePixel = 0
title.Parent = frame

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 14)
c3.Parent = title

task.wait(0.1)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = frame

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 8)
c4.Parent = closeBtn

task.wait(0.1)

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 215, 0)
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)
layout.Parent = scroll

task.wait(0.1)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    openBtn.Visible = not frame.Visible
end)

-- makeBtn
local order = 0
local function makeBtn(text, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 42)
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Text = text
    b.TextSize = 14
    b.Font = Enum.Font.SourceSansBold
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    b.Parent = scroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = b

    b.MouseButton1Click:Connect(function()
        if callback then
            local ok, err = pcall(callback)
            if not ok then warn("[V11.1] Erro: " .. tostring(err)) end
        end
    end)

    order = order + 1
    return b
end

-- Input
local input = Instance.new("TextBox")
input.Size = UDim2.new(1, 0, 0, 40)
input.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.PlaceholderText = "Nick..."
input.Text = ""
input.TextSize = 15
input.Font = Enum.Font.SourceSans
input.BorderSizePixel = 0
input.ClearTextOnFocus = false
input.Parent = scroll

local cInput = Instance.new("UICorner")
cInput.CornerRadius = UDim.new(0, 10)
cInput.Parent = input

task.wait(0.1)

-- ============================================
-- VARIAVEIS
-- ============================================
local shieldOn = false
local radarOn = false
local espOn = false
local antiTpOn = false

local shieldConn = nil
local antiTpConn = nil
local radarConn = nil
local antiTpPos = nil

local function findPlayer(name)
    if name == "" then return nil end
    name = name:lower()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Name:lower():find(name, 1, true) then
            return p
        end
    end
    return nil
end

-- ============================================
-- 1. MARCAR ALVO
-- ============================================
makeBtn("Marcar Alvo", Color3.fromRGB(138, 43, 226), function()
    local t = findPlayer(input.Text)
    if not t or not t.Character then return end
    local h = t.Character:FindFirstChild("Head")
    if not h then return end
    local old = h:FindFirstChild("V11Tag")
    if old then old:Destroy() end
    local bb = Instance.new("BillboardGui")
    bb.Name = "V11Tag"
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = h
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "ALVO"
    lbl.TextColor3 = Color3.fromRGB(255, 50, 50)
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Parent = bb
end)

task.wait(0.05)

-- ============================================
-- 2. REMOVER MARCACAO
-- ============================================
makeBtn("Remover Marcacao", Color3.fromRGB(80, 20, 80), function()
    local t = findPlayer(input.Text)
    if not t or not t.Character then return end
    local h = t.Character:FindFirstChild("Head")
    if h then
        local tag = h:FindFirstChild("V11Tag")
        if tag then tag:Destroy() end
    end
end)

task.wait(0.05)

-- ============================================
-- 3. ESP
-- ============================================
local function makeESP(p)
    if p == LocalPlayer then return end
    if not p.Character then return end
    local h = p.Character:FindFirstChild("Head")
    if not h then return end
    if h:FindFirstChild("V11ESP") then return end
    local bb = Instance.new("BillboardGui")
    bb.Name = "V11ESP"
    bb.Size = UDim2.new(0, 120, 0, 20)
    bb.StudsOffset = Vector3.new(0, 2.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent = h
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = p.Name
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.TextStrokeTransparency = 0.3
    lbl.TextScaled = true
    lbl.Font = Enum.Font.SourceSans
    lbl.Parent = bb
end

local function removeAllESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild("Head")
            if h then
                local e = h:FindFirstChild("V11ESP")
                if e then e:Destroy() end
            end
        end
    end
end

local espBtn
espBtn = makeBtn("ESP: OFF", Color3.fromRGB(150, 100, 50), function()
    espOn = not espOn
    if espOn then
        espBtn.Text = "ESP: ON"
        espBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        for _, p in ipairs(Players:GetPlayers()) do makeESP(p) end
    else
        espBtn.Text = "ESP: OFF"
        espBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 50)
        removeAllESP()
    end
end)

task.wait(0.05)

-- ============================================
-- 4. ESCUDO DE DANO (cura rapida)
-- ============================================
local healBtn
healBtn = makeBtn("Escudo Dano: OFF", Color3.fromRGB(180, 30, 30), function()
    shieldOn = not shieldOn
    healBtn.Text = shieldOn and "Escudo Dano: ON" or "Escudo Dano: OFF"
    healBtn.BackgroundColor3 = shieldOn and Color3.fromRGB(0, 200, 50) or Color3.fromRGB(180, 30, 30)

    if shieldOn then
        shieldConn = RunService.RenderStepped:Connect(function()
            if not shieldOn then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end

            pcall(function()
                -- Cura IMEDIATO quando vida cai
                if hum.Health < hum.MaxHealth then
                    hum.Health = hum.MaxHealth
                end
                -- Revive se morreu
                if hum.Health <= 0 then
                    hum.Health = hum.MaxHealth
                end
                -- Sai do estado Dead
                if hum:GetState() == Enum.HumanoidStateType.Dead then
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end)

            -- Freio de queda
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                pcall(function()
                    if root.AssemblyLinearVelocity.Y < -30 then
                        root.AssemblyLinearVelocity = Vector3.new(
                            root.AssemblyLinearVelocity.X,
                            -30,
                            root.AssemblyLinearVelocity.Z
                        )
                    end
                end)
            end
        end)
        print("[V11.1] Escudo de dano ATIVADO")
    else
        if shieldConn then
            shieldConn:Disconnect()
            shieldConn = nil
        end
        print("[V11.1] Escudo de dano DESATIVADO")
    end
end)

task.wait(0.05)

-- ============================================
-- 5. ANTI-TP
-- ============================================
local antiTpBtn
antiTpBtn = makeBtn("Anti-TP: OFF", Color3.fromRGB(100, 50, 150), function()
    antiTpOn = not antiTpOn
    if antiTpOn then
        antiTpBtn.Text = "Anti-TP: ON"
        antiTpBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        local char = LocalPlayer.Character
        local r = char and char:FindFirstChild("HumanoidRootPart")
        if r then antiTpPos = r.Position end

        antiTpConn = RunService.Heartbeat:Connect(function()
            if not antiTpOn then return end
            local c = LocalPlayer.Character
            if not c then return end
            local ro = c:FindFirstChild("HumanoidRootPart")
            if not ro then return end
            if antiTpPos then
                local d = (ro.Position - antiTpPos).Magnitude
                if d > 50 then
                    ro.CFrame = CFrame.new(antiTpPos)
                else
                    antiTpPos = ro.Position
                end
            end
        end)
    else
        antiTpBtn.Text = "Anti-TP: OFF"
        antiTpBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
        antiTpPos = nil
        if antiTpConn then
            antiTpConn:Disconnect()
            antiTpConn = nil
        end
    end
end)

task.wait(0.05)

-- ============================================
-- 6. RADAR
-- ============================================
local radarBtn
radarBtn = makeBtn("Radar: OFF", Color3.fromRGB(40, 40, 40), function()
    radarOn = not radarOn

    if radarOn then
        radarBtn.Text = "Radar: ON"
        radarBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)

        local fastTime = {}
        local airTime = {}
        local lastSeen = {}
        local lastY = {}

        radarConn = RunService.Heartbeat:Connect(function()
            if not radarOn then return end

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local root = p.Character:FindFirstChild("HumanoidRootPart")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")

                    if root and hum then
                        local vel = root.AssemblyLinearVelocity.Magnitude
                        local velY = root.AssemblyLinearVelocity.Y
                        local onGround = hum.FloorMaterial ~= Enum.Material.Air
                        local suspect = false

                        if vel > 60 then suspect = true end

                        if not onGround then
                            airTime[p.Name] = (airTime[p.Name] or 0) + 0.03
                            if airTime[p.Name] > 2 then suspect = true end
                        else
                            airTime[p.Name] = 0
                        end

                        if not onGround then
                            local prevY = lastY[p.Name]
                            if prevY then
                                if math.abs(velY) < 5 and vel > 5 then suspect = true end
                            end
                            lastY[p.Name] = root.Position.Y
                        else
                            lastY[p.Name] = nil
                        end

                        if velY > 15 and not onGround then suspect = true end

                        local h = p.Character:FindFirstChild("Head")
                        if h then
                            if suspect then
                                lastSeen[p.Name] = tick()
                                if not h:FindFirstChild("V11SpeedTag") then
                                    local bb = Instance.new("BillboardGui")
                                    bb.Name = "V11SpeedTag"
                                    bb.Size = UDim2.new(0, 140, 0, 25)
                                    bb.StudsOffset = Vector3.new(0, 3.5, 0)
                                    bb.AlwaysOnTop = true
                                    bb.Parent = h

                                    local lbl = Instance.new("TextLabel")
                                    lbl.Size = UDim2.new(1, 0, 1, 0)
                                    lbl.BackgroundTransparency = 1
                                    lbl.Text = "VOANDO"
                                    lbl.TextColor3 = Color3.fromRGB(255, 80, 80)
                                    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                                    lbl.TextStrokeTransparency = 0.2
                                    lbl.TextScaled = true
                                    lbl.Font = Enum.Font.SourceSansBold
                                    lbl.Parent = bb
                                end
                            else
                                local last = lastSeen[p.Name] or 0
                                if tick() - last > 3 then
                                    local tag = h:FindFirstChild("V11SpeedTag")
                                    if tag then tag:Destroy() end
                                end
                            end
                        end
                    end
                end
            end
        end)
    else
        radarBtn.Text = "Radar: OFF"
        radarBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

        if radarConn then
            radarConn:Disconnect()
            radarConn = nil
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChild("Head")
                if h then
                    local tag = h:FindFirstChild("V11SpeedTag")
                    if tag then tag:Destroy() end
                end
            end
        end
    end
end)

task.wait(0.05)

-- ============================================
-- 7. PARAR TUDO
-- ============================================
makeBtn("PARAR TUDO", Color3.fromRGB(200, 30, 30), function()
    -- Escudo de dano
    shieldOn = false
    healBtn.Text = "Escudo Dano: OFF"
    healBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    if shieldConn then
        shieldConn:Disconnect()
        shieldConn = nil
    end

    -- Radar
    radarOn = false
    radarBtn.Text = "Radar: OFF"
    radarBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    if radarConn then
        radarConn:Disconnect()
        radarConn = nil
    end

    -- Anti-TP
    antiTpOn = false
    antiTpBtn.Text = "Anti-TP: OFF"
    antiTpBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
    antiTpPos = nil
    if antiTpConn then
        antiTpConn:Disconnect()
        antiTpConn = nil
    end

    -- ESP
    espOn = false
    espBtn.Text = "ESP: OFF"
    espBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 50)
    removeAllESP()

    -- Tags do radar
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild("Head")
            if h then
                local tag = h:FindFirstChild("V11SpeedTag")
                if tag then tag:Destroy() end
            end
        end
    end

    print("[V11.1] Tudo parado!")
end)

task.wait(0.05)

-- ============================================
-- 8. INVINCIBLE FLY
-- ============================================
makeBtn("Invincible Fly", Color3.fromRGB(50, 100, 200), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/invincible-characters-animations-by-GioBolqv1-/refs/heads/main/universal.lua"))()
end)

scroll.CanvasSize = UDim2.new(0, 0, 0, order * 48 + 20)

print("[V11.1] Carregado com sucesso!")
