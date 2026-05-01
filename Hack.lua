--[[ 
    H HUB - V5 FINAL EDITION (AUTO PLAY + SMART BLOCK)
    - Fix: Thêm nút thu nhỏ (-), Fix di chuyển Delta
    - Feature: Auto Kill & Defend (Player/Dummy)
    - Optimization: Anti-Lag, CFrame Rotation
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Xóa bản cũ
if CoreGui:FindFirstChild("HHUB_V5_Final") then CoreGui.HHUB_V5_Final:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_V5_Final"
ScreenGui.Parent = CoreGui

---------------------------------------------------
-- HÀM DI CHUYỂN BẢNG
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
MainFrame.Size = UDim2.new(0, 320, 0, 180)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3
MakeDraggable(MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "H HUB - AUTO PLAY V5"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- Nút Thu Nhỏ (-)
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

-- Nút Chữ H (Khi thu nhỏ)
local MiniH = Instance.new("TextButton", ScreenGui)
MiniH.Text = "H"
MiniH.Size = UDim2.new(0, 60, 0, 60)
MiniH.Position = UDim2.new(0, 20, 0.5, -30)
MiniH.Visible = false
MiniH.Font = Enum.Font.GothamBold
MiniH.TextSize = 30
MiniH.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MiniH).CornerRadius = UDim.new(0, 15)
local MiniStroke = Instance.new("UIStroke", MiniH)
MiniStroke.Thickness = 3
MakeDraggable(MiniH)

-- Nút Đóng (X)
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)

-- Nút Bật/Tắt Auto
local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Text = "BẮT ĐẦU AUTO PLAY"
KillBtn.Size = UDim2.new(0, 240, 0, 50)
KillBtn.Position = UDim2.new(0.5, -120, 0.6, -10)
KillBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", KillBtn)
local KillStroke = Instance.new("UIStroke", KillBtn)
KillStroke.Thickness = 2

---------------------------------------------------
-- LOGIC RAINBOW & SỰ KIỆN NÚT
---------------------------------------------------
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = hue + 0.005
    local color = Color3.fromHSV(hue, 1, 1)
    MainStroke.Color = color
    KillStroke.Color = color
    MiniStroke.Color = color
    MiniH.BackgroundColor3 = color
end)

local autoKill = false
KillBtn.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    KillBtn.Text = autoKill and "ĐANG AUTO PLAY..." or "BẮT ĐẦU AUTO PLAY"
    KillBtn.BackgroundColor3 = autoKill and Color3.fromRGB(0, 80, 0) or Color3.fromRGB(30, 30, 30)
    if not autoKill then VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game) end
end)

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false MiniH.Visible = true end)
MiniH.MouseButton1Click:Connect(function() MiniH.Visible = false MainFrame.Visible = true end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

---------------------------------------------------
-- CORE: TỰ ĐỘNG DI CHUYỂN & CHIẾN ĐẤU (OPTIMIZED)
---------------------------------------------------
local function findTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local dist = 150
    local target = nil
    
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v ~= myChar then
            if v.Humanoid.Health > 0 then
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
    while task.wait(0.05) do
        if autoKill then
            local myChar = LocalPlayer.Character
            local enemy = findTarget()
            
            if myChar and enemy and myChar:FindFirstChild("Humanoid") then
                local myRP = myChar.HumanoidRootPart
                local enemyRP = enemy.HumanoidRootPart
                local d = (myRP.Position - enemyRP.Position).Magnitude
                
                -- Xoay mặt và di chuyển
                myRP.CFrame = CFrame.new(myRP.Position, Vector3.new(enemyRP.Position.X, myRP.Position.Y, enemyRP.Position.Z))
                if d > 6 then myChar.Humanoid:MoveTo(enemyRP.Position) end

                -- Đỡ đòn khi địch tấn công
                local enemyHum = enemy:FindFirstChildOfClass("Humanoid")
                local isAttacking = enemyHum and #enemyHum:GetPlayingAnimationTracks() > 0

                if d < 12 and isAttacking then
                    VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                else
                    VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                    -- Đánh M1
                    if d < 10 then
                        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.03)
                        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end
                end
            end
        end
    end
end)

---------------------------------------------------
-- INTRO CHÀO MỪNG
---------------------------------------------------
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(0, 260, 0, 80)
IntroFrame.Position = UDim2.new(0.5, -130, 0.5, -40)
IntroFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
local IntroText = Instance.new("TextLabel", IntroFrame)
IntroText.Text = "Cảm ơn vì đã dùng H HUB"
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.TextColor3 = Color3.new(1, 1, 1)
IntroText.BackgroundTransparency = 1
Instance.new("UICorner", IntroFrame)
task.spawn(function()
    task.wait(1.5)
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
    MainFrame.Visible = true
end)

