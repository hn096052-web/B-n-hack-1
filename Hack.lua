--[[ 
    H HUB - V6 ULTIMATE (FORCE MOVE & ATTACK)
    - Fix: Ép di chuyển bằng CFrame/Vector (Không bị game chặn)
    - Fix: Đầy đủ nút Thu nhỏ (-), Đóng (X), Chữ H
    - Feature: Auto Play (Lao vào đánh), Smart Block (Tự đỡ)
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("HHUB_V6") then CoreGui.HHUB_V6:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_V6"
ScreenGui.Parent = CoreGui

---------------------------------------------------
-- HÀM DI CHUYỂN BẢNG (DRAG)
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
-- GIAO DIỆN
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
Title.Text = "H HUB - AUTO PLAY V6"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)

local MiniH = Instance.new("TextButton", ScreenGui)
MiniH.Text = "H"
MiniH.Size = UDim2.new(0, 60, 0, 60)
MiniH.Position = UDim2.new(0, 20, 0.5, -30)
MiniH.Visible = false
MiniH.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
MiniH.TextColor3 = Color3.new(1, 1, 1)
MiniH.Font = Enum.Font.GothamBold
MiniH.TextSize = 30
Instance.new("UICorner", MiniH).CornerRadius = UDim.new(0, 15)
local MiniStroke = Instance.new("UIStroke", MiniH)
MiniStroke.Thickness = 3
MakeDraggable(MiniH)

local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Text = "BẮT ĐẦU AUTO PLAY"
KillBtn.Size = UDim2.new(0, 240, 0, 60)
KillBtn.Position = UDim2.new(0.5, -120, 0.5, -10)
KillBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", KillBtn)
local KillStroke = Instance.new("UIStroke", KillBtn)
KillStroke.Thickness = 2

---------------------------------------------------
-- LOGIC CẦU VỒNG & NÚT
---------------------------------------------------
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = (hue + 0.005) % 1
    local color = Color3.fromHSV(hue, 1, 1)
    MainStroke.Color = color
    KillStroke.Color = color
    MiniStroke.Color = color
end)

local autoKill = false
KillBtn.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    KillBtn.Text = autoKill and "ĐANG CHẠY..." or "BẮT ĐẦU AUTO PLAY"
    KillBtn.BackgroundColor3 = autoKill and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(30, 30, 30)
    if not autoKill then VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game) end
end)

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false MiniH.Visible = true end)
MiniH.MouseButton1Click:Connect(function() MiniH.Visible = false MainFrame.Visible = true end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

---------------------------------------------------
-- TỐI ƯU QUÉT MỤC TIÊU
---------------------------------------------------
local function getClosest()
    local target = nil
    local dist = 200
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end

    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v ~= myChar and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
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

---------------------------------------------------
-- CORE: AUTO PLAY (ÉP DI CHUYỂN & ĐÁNH)
---------------------------------------------------
task.spawn(function()
    while task.wait() do
        if autoKill then
            local myChar = LocalPlayer.Character
            local enemy = getClosest()
            
            if myChar and enemy and myChar:FindFirstChild("HumanoidRootPart") then
                local myHRP = myChar.HumanoidRootPart
                local enHRP = enemy.HumanoidRootPart
                local distance = (myHRP.Position - enHRP.Position).Magnitude
                
                -- 1. XOAY NGƯỜI
                myHRP.CFrame = CFrame.new(myHRP.Position, Vector3.new(enHRP.Position.X, myHRP.Position.Y, enHRP.Position.Z))
                
                -- 2. ÉP DI CHUYỂN (Dùng Velocity để lao vào)
                if distance > 5 then
                    myHRP.Velocity = (enHRP.Position - myHRP.Position).Unit * 50
                end

                -- 3. SMART DEFENSE & ATTACK
                local enemyHum = enemy:FindFirstChildOfClass("Humanoid")
                local isEnemyAttacking = enemyHum and #enemyHum:GetPlayingAnimationTracks() > 0

                if distance < 12 and isEnemyAttacking then
                    VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                else
                    VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                    if distance < 10 then
                        VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                        task.wait(0.05)
                        VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    end
                end
            end
        end
    end
end)

---------------------------------------------------
-- INTRO
---------------------------------------------------
task.spawn(function()
    local Intro = Instance.new("Frame", ScreenGui)
    Intro.Size = UDim2.new(0, 250, 0, 80)
    Intro.Position = UDim2.new(0.5, -125, 0.5, -40)
    Intro.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    local T = Instance.new("TextLabel", Intro)
    T.Text = "Cảm ơn vì đã dùng H HUB"
    T.Size = UDim2.new(1, 0, 1, 0)
    T.TextColor3 = Color3.new(1, 1, 1)
    T.BackgroundTransparency = 1
    Instance.new("UICorner", Intro)
    task.wait(1.5)
    Intro:Destroy()
    MainFrame.Visible = true
end)

