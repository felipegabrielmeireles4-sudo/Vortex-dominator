-- ============================================
-- VORTEX HUB - FINAL
-- Tema: Roxo + Preto
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ============================================
-- CORES DO TEMA
-- ============================================
local COR_ROXA = Color3.fromRGB(138, 43, 226)        -- roxo principal
local COR_ROXA_CLARA = Color3.fromRGB(170, 90, 255)  -- roxo claro (hover)
local COR_ROXA_ESCURA = Color3.fromRGB(80, 20, 150)  -- roxo escuro
local COR_PRETA = Color3.fromRGB(8, 8, 12)           -- fundo preto
local COR_PRETA_CLARA = Color3.fromRGB(20, 15, 30)   -- preto com toque roxo
local COR_TEXTO = Color3.fromRGB(255, 255, 255)      -- branco
local COR_SUCESSO = Color3.fromRGB(100, 50, 200)     -- roxo ativo
local COR_PERIGO = Color3.fromRGB(180, 30, 30)       -- vermelho perigo

-- ============================================
-- GUI
-- ============================================
local g = Instance.new("ScreenGui")
g.Name = "VortexHub"
g.ResetOnSpawn = false
g.IgnoreGuiInset = true
g.DisplayOrder = 999
g.Parent = game:GetService("CoreGui")

-- Botao flutuante
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(0, 15, 0.4, 0)
openBtn.BackgroundColor3 = COR_PRETA
openBtn.Text = "V"
openBtn.TextColor3 = COR_ROXA_CLARA
openBtn.TextSize = 24
openBtn.Font = Enum.Font.SourceSansBold
openBtn.BorderSizePixel = 0
openBtn.Parent = g

local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(1, 0)
c1.Parent = openBtn

local s1 = Instance.new("UIStroke")
s1.Color = COR_ROXA
s1.Thickness = 2
s1.Parent = openBtn

task.wait(0.1)

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 480)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = COR_PRETA
frame.BorderSizePixel = 0
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = g

local s2 = Instance.new("UIStroke")
s2.Color = COR_ROXA
s2.Thickness = 1
s2.Parent = frame

task.wait(0.1)

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = COR_PRETA_CLARA
header.BorderSizePixel = 0
header.Parent = frame

-- Titulo VORTEX HUB
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "VORTEX HUB"
title.TextColor3 = COR_ROXA_CLARA
title.TextSize = 18
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Botao fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = COR_PERIGO
closeBtn.Text = "X"
closeBtn.TextColor3 = COR_TEXTO
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = header

local c4 = Instance.new("UICorner")
c4.CornerRadius = UDim.new(0, 6)
c4.Parent = closeBtn

task.wait(0.1)

-- Scroll
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -16, 1, -58)
scroll.Position = UDim2.new(0, 8, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 5
scroll.ScrollBarImageColor3 = COR_ROXA
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

-- ============================================
-- makeBtn (roxo)
-- ============================================
local order = 0
local function makeBtn(text, color, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, 0, 0, 48)
    b.BackgroundColor3 = color
    b.TextColor3 = COR_TEXTO
    b.Text = text
    b.TextSize = 15
    b.Font = Enum.Font.SourceSansBold
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    b.Parent = scroll

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    b.MouseButton1Click:Connect(function()
        if callback then
            local ok, err = pcall(callback)
            if not ok then warn("[VORTEX] Erro: " .. tostring(err)) end
        end
    end)

    order = order + 1
    return b
end

-- Input
local input = Instance.new("TextBox")
input.Size = UDim2.new(1, 0, 0, 44)
input.BackgroundColor3 = COR_PRETA_CLARA
input.TextColor3 = COR_TEXTO
input.PlaceholderText = "Nick do alvo..."
input.Text = ""
input.TextSize = 15
input.Font = Enum.Font.SourceSans
input.BorderSizePixel = 0
input.ClearTextOnFocus = false
input.Parent = scroll

local cInput = Instance.new("UICorner")
cInput.CornerRadius = UDim.new(0, 8)
cInput.Parent = input

local sInput = Instance.new("UIStroke")
sInput.Color = COR_ROXA_ESCURA
sInput.Thickness = 1
sInput.Parent = input

task.wait(0.1)

-- ============================================
-- VARIAVEIS
-- ============================================
local espOn = false
local antiTpOn = false
local markedTargets = {}

local antiTpConn = nil
local espConn = nil
local antiTpPos = nil
local espEntries = {}

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
local function applyTag(p)
    if not p or not p.Character then return end
    local h = p.Character:FindFirstChild("Head")
    if not h then return end
    if h:FindFirstChild("VortexTag") then return end

    local bb = Instance.new("BillboardGui")
    bb.Name = "VortexTag"
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = h

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = "ALVO"
    lbl.TextColor3 = COR_ROXA_CLARA
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.TextScaled = true
    lbl.Font = Enum.Font.SourceSansBold
    lbl.Parent = bb
end

makeBtn("Marcar Alvo", COR_ROXA, function()
    local t = findPlayer(input.Text)
    if not t then return end
    markedTargets[t] = true
    applyTag(t)
end)

RunService.Heartbeat:Connect(function()
    for p, _ in pairs(markedTargets) do
        if p.Parent then
            applyTag(p)
        else
            markedTargets[p] = nil
        end
    end
end)

task.wait(0.05)

-- ============================================
-- 2. REMOVER MARCACAO
-- ============================================
makeBtn("Remover Marcacao", COR_ROXA_ESCURA, function()
    local t = findPlayer(input.Text)
    if not t then return end
    markedTargets[t] = nil
    if t.Character then
        local h = t.Character:FindFirstChild("Head")
        if h then
            local tag = h:FindFirstChild("VortexTag")
            if tag then tag:Destroy() end
        end
    end
end)

task.wait(0.05)

-- ============================================
-- 3. ESP PRO (Highlight + Nome + Distancia)
-- ============================================
local function getESPColor(dist)
    if dist < 50 then
        return COR_ROXA_CLARA
    elseif dist < 150 then
        return Color3.fromRGB(200, 100, 255)
    else
        return Color3.fromRGB(255, 255, 255)
    end
end

local function makeESP(p)
    if p == LocalPlayer then return end
    if not p.Character then return end

    if espEntries[p] then
        if espEntries[p].highlight then espEntries[p].highlight:Destroy() end
        if espEntries[p].billboard then espEntries[p].billboard:Destroy() end
        espEntries[p] = nil
    end

    local hl = Instance.new("Highlight")
    hl.Name = "Vortex_Highlight"
    hl.Adornee = p.Character
    hl.FillColor = COR_ROXA_CLARA
    hl.FillTransparency = 0.7
    hl.OutlineColor = COR_ROXA
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = p.Character

    local head = p.Character:FindFirstChild("Head")
    if not head then return end

    local bb = Instance.new("BillboardGui")
    bb.Name = "Vortex_ESPBb"
    bb.Size = UDim2.new(0, 200, 0, 40)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.AlwaysOnTop = true
    bb.Parent = head

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = UDim2.new(1, 0, 0.6, 0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = p.Name
    nameLbl.TextColor3 = COR_ROXA_CLARA
    nameLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLbl.TextStrokeTransparency = 0.3
    nameLbl.TextSize = 14
    nameLbl.Font = Enum.Font.SourceSansBold
    nameLbl.TextScaled = true
    nameLbl.Parent = bb

    local distLbl = Instance.new("TextLabel")
    distLbl.Size = UDim2.new(1, 0, 0.4, 0)
    distLbl.Position = UDim2.new(0, 0, 0.6, 0)
    distLbl.BackgroundTransparency = 1
    distLbl.Text = "0m"
    distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    distLbl.TextStrokeTransparency = 0.3
    distLbl.TextSize = 12
    distLbl.Font = Enum.Font.SourceSans
    distLbl.TextScaled = true
    distLbl.Parent = bb

    espEntries[p] = {
        highlight = hl,
        billboard = bb,
        nameLbl = nameLbl,
        distLbl = distLbl,
    }
end

local function removeAllESP()
    for p, entry in pairs(espEntries) do
        if entry.highlight then entry.highlight:Destroy() end
        if entry.billboard then entry.billboard:Destroy() end
    end
    espEntries = {}
end

local espBtn
espBtn = makeBtn("ESP: OFF", COR_ROXA_ESCURA, function()
    espOn = not espOn

    if espOn then
        espBtn.Text = "ESP: ON"
        espBtn.BackgroundColor3 = COR_SUCESSO

        for _, p in ipairs(Players:GetPlayers()) do
            makeESP(p)
        end

        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function()
                task.wait(0.5)
                if espOn then makeESP(p) end
            end)
        end)

        espConn = RunService.RenderStepped:Connect(function()
            if not espOn then return end
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end

            for p, entry in pairs(espEntries) do
                if p.Character and entry.distLbl then
                    local pRoot = p.Character:FindFirstChild("HumanoidRootPart")
                    if pRoot then
                        local dist = math.floor((pRoot.Position - myRoot.Position).Magnitude)
                        entry.distLbl.Text = dist .. "m"

                        if entry.highlight then
                            entry.highlight.FillColor = getESPColor(dist)
                        end
                    end
                end
            end
        end)
    else
        espBtn.Text = "ESP: OFF"
        espBtn.BackgroundColor3 = COR_ROXA_ESCURA
        removeAllESP()

        if espConn then
            espConn:Disconnect()
            espConn = nil
        end
    end
end)

task.wait(0.05)

-- ============================================
-- 4. SUPER RING V5
-- ============================================
makeBtn("Super Ring V5", COR_ROXA, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Lukashub-coder/Super-ring-V5/refs/heads/main/By%20lukas!!"))()
end)

task.wait(0.05)

-- ============================================
-- 5. ANTI-TP
-- ============================================
local antiTpBtn
antiTpBtn = makeBtn("Anti-TP: OFF", COR_ROXA_ESCURA, function()
    antiTpOn = not antiTpOn
    if antiTpOn then
        antiTpBtn.Text = "Anti-TP: ON"
        antiTpBtn.BackgroundColor3 = COR_SUCESSO
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
        antiTpBtn.BackgroundColor3 = COR_ROXA_ESCURA
        antiTpPos = nil
        if antiTpConn then
            antiTpConn:Disconnect()
            antiTpConn = nil
        end
    end
end)

task.wait(0.05)

-- ============================================
-- 6. PARAR TUDO
-- ============================================
makeBtn("PARAR TUDO", COR_PERIGO, function()
    espOn = false
    espBtn.Text = "ESP: OFF"
    espBtn.BackgroundColor3 = COR_ROXA_ESCURA
    removeAllESP()
    if espConn then
        espConn:Disconnect()
        espConn = nil
    end

    antiTpOn = false
    antiTpBtn.Text = "Anti-TP: OFF"
    antiTpBtn.BackgroundColor3 = COR_ROXA_ESCURA
    antiTpPos = nil
    if antiTpConn then
        antiTpConn:Disconnect()
        antiTpConn = nil
    end

    markedTargets = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild("Head")
            if h then
                local t1 = h:FindFirstChild("VortexTag")
                if t1 then t1:Destroy() end
            end
        end
    end

    print("[VORTEX] Tudo parado!")
end)

task.wait(0.05)

-- ============================================
-- 7. INVINCIBLE FLY
-- ============================================
makeBtn("Invincible Fly", COR_ROXA, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/giobolqv1/invincible-characters-animations-by-GioBolqv1-/refs/heads/main/universal.lua"))()
end)

scroll.CanvasSize = UDim2.new(0, 0, 0, order * 54 + 20)

print("[VORTEX] Hub carregado!")
