--[[ 
    H HUB - AUTO KILL & SMART DEFENSE (ULTRA OPTIMIZED)
    - Fix: No Lag (Lag-Free Scanning)
    - Feature: Auto Move, Auto Attack, Smart Defense
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("HHUB_V3_Stable") then CoreGui.HHUB_V3_Stable:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_V3_Stable"
ScreenGui.Parent = CoreGui

---------------------------------------------------
-- CHỨC NĂNG DI CHUYỂN BẢNG
---------------------------------------------------
local function MakeDraggable(gui)
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

---------------------------------------------------
-- GIAO DIỆN CHÍNH
---------------------------------------------------
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 200)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3
MakeDraggable(MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "H HUB - AUTO PLAY V3"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Text = "AUTO KILL & DEFEND: OFF"
KillBtn.Size = UDim2.new(0, 280, 0, 60)
KillBtn.Position = UDim2.new(0.5, -140, 0.5, -10)
KillBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", KillBtn)
local KillStroke = Instance.new("UIStroke", KillBtn)
KillStroke.Thickness = 2

local autoKill = false
KillBtn.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    KillBtn.Text = "AUTO KILL & DEFEND: " .. (autoKill and "ON" or "OFF")
    if not autoKill then 
        VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
    end
end)

---------------------------------------------------
-- HIỆU ỨNG RAINBOW & INTRO
---------------------------------------------------
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = hue + 0.005
    local color = Color3.fromHSV(hue, 1, 1)
    MainStroke.Color = color
    KillStroke.Color = color
end)

task.spawn(function()
    local IntroFrame = Instance.new("Frame", ScreenGui)
    IntroFrame.Size = UDim2.new(0, 300, 0, 100)
    IntroFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
    IntroFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    local IntroText = Instance.new("TextLabel", IntroFrame)
    IntroText.Text = "Cảm ơn vì đã dùng H HUB"
    IntroText.Size = UDim2.new(1, 0, 1, 0)
    IntroText.TextColor3 = Color3.new(1, 1, 1)
    IntroText.BackgroundTransparency = 1
    Instance.new("UICorner", IntroFrame)
    
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 0.2}):Play()
    task.wait(2)
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
    MainFrame.Visible = true
end)

---------------------------------------------------
-- CORE LOGIC: AUTO KILL + DEFENSE (ANTI-LAG)
---------------------------------------------------
local function getBestTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    
    local target = nil
    local dist = 100 -- Khoảng cách tối đa để tự động chạy tới
    
    -- Chỉ quét các Model trực tiếp trong Workspace (Giảm lag)
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v ~= myChar and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Humanoid") then
            if v:FindFirstChildOfClass("Humanoid").Health > 0 then
                local d = (myChar.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if d < dist then
                    dist = d
                    target = v
                end
            end
        end
    end
    return target
end

task.spawn(function()
    while task.wait(0.05) do -- Tần suất 20 lần/giây, đủ mượt và không lag
        if autoKill then
            local myChar = LocalPlayer.Character
            local enemy = getBestTarget()
            
            if myChar and enemy and myChar:FindFirstChild("Humanoid") then
                local myRP = myChar.HumanoidRootPart
                local enemyRP = enemy.HumanoidRootPart
                local d = (myRP.Position - enemyRP.Position).Magnitude
                
                -- 1. DI CHUYỂN TỚI MỤC TIÊU
                myChar.Humanoid:MoveTo(enemyRP.Position)
                
                -- 2. SMART DEFENSE (ĐỠ ĐÒN KHI GẦN)
                -- Kiểm tra nếu đối thủ đang chơi animation (đang tấn công)
                local enemyHum = enemy:FindFirstChildOfClass("Humanoid")
                local isAttacking = false
                if enemyHum then
                    local tracks = enemyHum:GetPlayingAnimationTracks()
                    if #tracks > 0 then isAttacking = true end
                end
                
                if d < 12 and isAttacking then
                    VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game) -- Giữ F để đỡ
                else
                    VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game) -- Nhả F để đánh
                    
                    -- 3. TẤN CÔNG (CHỈ ĐÁNH KHI KHÔNG CẦN ĐỠ)
                    if d < 10 then
                        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.05)
                        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end
                end
            end
        end
    end
end)

-- Nút đóng
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
