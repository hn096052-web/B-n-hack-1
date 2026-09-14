-- ==========================================
-- H HUB - SPECTATE & SHOOT FROM TARGET'S PERSPECTIVE
-- ==========================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then return end
local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Xóa GUI cũ nếu tồn tại
pcall(function()
    if playerGui:FindFirstChild("SpectateHubGui") then
        playerGui.SpectateHubGui:Destroy()
    end
end)

-- Biến khởi tạo an toàn
local spectating = false
local spectateIndex = 1
local spectateConnection = nil
local GLOBAL_FONT = Enum.Font.GothamBold

-- UI Root
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpectateHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- NÚT BẬT/TẮT PHỤ
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleSpectateButton"
toggleButton.Size = UDim2.new(0, 110, 0, 40)
toggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
toggleButton.Text = "👁️ Spectate"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = GLOBAL_FONT
toggleButton.TextSize = 14
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleButton

local btnStroke = Instance.new("UIStroke")
btnStroke.Thickness = 2
btnStroke.Color = Color3.fromRGB(80, 80, 255)
btnStroke.Parent = toggleButton

-- SPECTATE HUD FRAME
local spectateFrame = Instance.new("Frame")
spectateFrame.Size = UDim2.new(0, 320, 0, 115)
spectateFrame.Position = UDim2.new(0.5, -160, 0.85, -55)
spectateFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
spectateFrame.BackgroundTransparency = 0.2
spectateFrame.BorderSizePixel = 0
spectateFrame.Visible = false
spectateFrame.Parent = screenGui

local specCorner = Instance.new("UICorner")
specCorner.CornerRadius = UDim.new(0, 8)
specCorner.Parent = spectateFrame

local specStroke = Instance.new("UIStroke")
specStroke.Color = Color3.fromRGB(80, 80, 255)
specStroke.Thickness = 2
specStroke.Parent = spectateFrame

local specNameLabel = Instance.new("TextLabel")
specNameLabel.Size = UDim2.new(1, -90, 0, 34)
specNameLabel.Position = UDim2.new(0, 45, 0, 6)
specNameLabel.BackgroundTransparency = 1
specNameLabel.Text = "Player Name"
specNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
specNameLabel.Font = GLOBAL_FONT
specNameLabel.TextSize = 13
specNameLabel.Parent = spectateFrame

local specPrevBtn = Instance.new("TextButton")
specPrevBtn.Size = UDim2.new(0, 35, 0, 34)
specPrevBtn.Position = UDim2.new(0, 8, 0, 6)
specPrevBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
specPrevBtn.Text = "<"
specPrevBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
specPrevBtn.Font = GLOBAL_FONT
specPrevBtn.TextSize = 16
specPrevBtn.Parent = spectateFrame
Instance.new("UICorner", specPrevBtn).CornerRadius = UDim.new(0, 6)

local specNextBtn = Instance.new("TextButton")
specNextBtn.Size = UDim2.new(0, 35, 0, 34)
specNextBtn.Position = UDim2.new(1, -43, 0, 6)
specNextBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
specNextBtn.Text = ">"
specNextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
specNextBtn.Font = GLOBAL_FONT
specNextBtn.TextSize = 16
specNextBtn.Parent = spectateFrame
Instance.new("UICorner", specNextBtn).CornerRadius = UDim.new(0, 6)

-- NÚT BẮN TỪ GÓC NHÌN CỦA NGƯỜI ĐƯỢC SPECTATE
local shootSpecBtn = Instance.new("TextButton")
shootSpecBtn.Size = UDim2.new(0, 160, 0, 28)
shootSpecBtn.Position = UDim2.new(0.5, -80, 0, 44)
shootSpecBtn.BackgroundColor3 = Color3.fromRGB(45, 160, 85)
shootSpecBtn.Text = "⚡ Bắn Từ Người Đó"
shootSpecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
shootSpecBtn.Font = GLOBAL_FONT
shootSpecBtn.TextSize = 11
shootSpecBtn.Parent = spectateFrame
Instance.new("UICorner", shootSpecBtn).CornerRadius = UDim.new(0, 5)

local specCloseBtn = Instance.new("TextButton")
specCloseBtn.Size = UDim2.new(0, 120, 0, 24)
specCloseBtn.Position = UDim2.new(0.5, -60, 0, 78)
specCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
specCloseBtn.Text = "Đóng Spectate"
specCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
specCloseBtn.Font = GLOBAL_FONT
specCloseBtn.TextSize = 11
specCloseBtn.Parent = spectateFrame
Instance.new("UICorner", specCloseBtn).CornerRadius = UDim.new(0, 5)

-- LẤY DANH SÁCH AN TOÀN
local function getSpectateTargets()
    local targets = {}
    pcall(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p and p ~= player and p.Parent then
                table.insert(targets, p)
            end
        end
    end)
    return targets
end

local function updateSpectateCamera()
    pcall(function()
        local targets = getSpectateTargets()
        if #targets == 0 then
            specNameLabel.Text = "Không có người chơi khác!"
            return
        end
        if spectateIndex > #targets then spectateIndex = 1 end
        if spectateIndex < 1 then spectateIndex = #targets end

        local target = targets[spectateIndex]
        if target and target.Parent then
            local nameStr = (target.DisplayName or target.Name) .. " (@" .. target.Name .. ")"
            specNameLabel.Text = nameStr
            
            local cam = Workspace.CurrentCamera
            if cam and target.Character then
                local hum = target.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    cam.CameraSubject = hum
                else
                    local root = target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso")
                    if root then cam.CameraSubject = root end
                end
            end
        end
    end)
end

-- LOGIC BẮN XUẤT PHÁT TRỰC TIẾP TỪ GÓC NHÌN / VỊ TRÍ CỦA NGƯỜI ĐƯỢC SPECTATE
local function shootFromTargetPerspective()
    pcall(function()
        local targets = getSpectateTargets()
        if #targets == 0 then return end
        
        local targetP = targets[spectateIndex]
        if not targetP or not targetP.Parent then return end
        
        local targetChar = targetP.Character
        if not targetChar then return end
        
        -- Lấy phần đầu hoặc tâm của người đang được spectate làm gốc bắn
        local targetHead = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
        if not targetHead then return end
        
        local myChar = player and player.Character
        if not myChar then return end
        
        local myHum = myChar:FindFirstChildOfClass("Humanoid")
        local backpack = player and player:FindFirstChild("Backpack")
        if not myHum then return end
        
        -- Tìm vũ khí FreezeRay
        local freezeRayTool = myChar:FindFirstChild("FreezeRay") or (backpack and backpack:FindFirstChild("FreezeRay"))
        if freezeRayTool then
            if freezeRayTool.Parent == backpack then
                myHum:EquipTool(freezeRayTool)
            end
            
            local fireEvent = freezeRayTool:FindFirstChild("FireEvent") or freezeRayTool:FindFirstChild("RemoteEvent")
            if fireEvent and fireEvent:IsA("RemoteEvent") then
                -- Gốc xuất phát là vị trí và hướng nhìn của người chơi mục tiêu
                local originPos = targetHead.Position
                local lookDir = targetHead.CFrame.LookVector
                
                local raycastParams = RaycastParams.new()
                -- Loại bỏ người chơi mục tiêu và bản thân ra khỏi raycast để tia đạn không bị vướng trúng chính họ
                raycastParams.FilterDescendantsInstances = {targetChar, myChar}
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                
                local raycastResult = Workspace:Raycast(originPos, lookDir * 1000, raycastParams)
                local hitPos = raycastResult and raycastResult.Position or (originPos + lookDir * 1000)
                local hitPart = raycastResult and raycastResult.Instance or nil
                
                fireEvent:FireServer(hitPos, hitPart)
            end
        end
    end)
end

local function toggleSpectate(state)
    spectating = state
    spectateFrame.Visible = state
    
    pcall(function()
        local cam = Workspace.CurrentCamera
        if not cam then return end
        
        if state then
            spectateIndex = 1
            updateSpectateCamera()

            if not spectateConnection then
                spectateConnection = RunService.RenderStepped:Connect(function()
                    pcall(function()
                        if spectating then
                            local targets = getSpectateTargets()
                            if #targets > 0 then
                                local currentTarget = targets[spectateIndex]
                                if currentTarget and currentTarget.Character then
                                    local hum = currentTarget.Character:FindFirstChildOfClass("Humanoid")
                                    if hum and cam.CameraSubject ~= hum then
                                        cam.CameraSubject = hum
                                    end
                                end
                            end
                        end
                    end)
                end)
            end
        else
            if spectateConnection then
                spectateConnection:Disconnect()
                spectateConnection = nil
            end
            if player and player.Character then
                local myHum = player.Character:FindFirstChildOfClass("Humanoid")
                if myHum then
                    cam.CameraSubject = myHum
                end
            end
        end
    end)
end

-- SỰ KIỆN NÚT BẤM
specPrevBtn.MouseButton1Click:Connect(function()
    spectateIndex = spectateIndex - 1
    updateSpectateCamera()
end)

specNextBtn.MouseButton1Click:Connect(function()
    spectateIndex = spectateIndex + 1
    updateSpectateCamera()
end)

shootSpecBtn.MouseButton1Click:Connect(function()
    shootFromTargetPerspective()
end)

specCloseBtn.MouseButton1Click:Connect(function()
    toggleSpectate(false)
end)

toggleButton.MouseButton1Click:Connect(function()
    toggleSpectate(not spectating)
end)
