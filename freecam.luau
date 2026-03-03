local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

local active = false
local speed = 1 -- Velocidade do movimento

-- Criar a Interface (Botão para Mobile)
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0.5, -50, 0.05, 0)
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = "Freecam: OFF"
button.Parent = screenGui

-- Função para restaurar o corpo (R15 Safe)
local function toggleBody(visible)
    local char = player.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                -- No R15, usamos o Modifier para não quebrar o personagem
                part.LocalTransparencyModifier = visible and 0 or 1
            end
        end
    end
end

-- Lógica da Câmera
button.MouseButton1Click:Connect(function()
    active = not active
    if active then
        button.Text = "Freecam: ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        camera.CameraType = Enum.CameraType.Scriptable
        toggleBody(false) -- Esconde o corpo
    else
        button.Text = "Freecam: OFF"
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        camera.CameraType = Enum.CameraType.Custom
        toggleBody(true) -- Mostra o corpo e o BRAÇO de volta
    end
end)

-- Controle de Movimento (Adaptado para Mobile)
runService.RenderStepped:Connect(function()
    if active then
        -- No mobile, a câmera segue para onde você arrasta o dedo
        local lookVector = camera.CFrame.LookVector
        -- Se você estiver se movendo com o joystick, a camera flutua
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local moveDir = player.Character.Humanoid.MoveDirection
            camera.CFrame = camera.CFrame + (moveDir * speed)
        end
    end
end)
-- codigo pra rodar esse script: loadstring(game:HttpGet("https://raw.githubusercontent.com/usoparacetamol/scripts-delta-luau/refs/heads/main/freecam.luau"))()
