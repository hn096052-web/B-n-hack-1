--[[ 
    H HUB - V7 BRUTE FORCE EDITION
    - Fix: Di chuyển bằng CFrame (Chống đứng yên tuyệt đối)
    - Fix: Đầy đủ nút thu nhỏ (-), Đóng (X)
    - Feature: Auto Play (Teleport-Follow), Smart Block
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("HHUB_V7") then CoreGui.HHUB_V7:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_V7"
ScreenGui.Parent = CoreGui

---------------------------------------------------
-- HÀM KÉO BẢNG
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
MainFrame.Size = UDim2.new(0, 300, 0, 160)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 2
MakeDraggable(MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "H HUB - BRUTE FORCE V7"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- Nút Thu Nhỏ (-)
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

-- Nút Chữ H
local MiniH = Instance.new("TextButton", ScreenGui)
MiniH.Text = "H"
MiniH.Size = UDim2.new(0, 50, 0, 50)
MiniH.Position = UDim2.new(0, 10, 0.5, -25)
MiniH.Visible = false
MiniH.Font = Enum.Font.GothamBold
MiniH.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MiniH).CornerRadius = UDim.new(0, 10)
local MiniStroke = Instance.new("UIStroke", MiniH)
MiniStroke.Thickness = 2
MakeDraggable(MiniH)

-- Nút Bật/Tắt
local KillBtn = Instance.new("TextButton", MainFrame)
KillBtn.Text = "START AUTO PLAY"
KillBtn.Size = UDim2.new(0, 220, 0, 50)
KillBtn.Position = UDim2.new(0.5, -110, 0.6, -10)
KillBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KillBtn.TextColor3 = Color3.new(1, 1, 1)
KillBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", KillBtn)
local KillStroke = Instance.new("UIStroke", KillBtn)

---------------------------------------------------
-- RAINBOW & EVENTS
---------------------------------------------------
local hue = 0
RunService.Heartbeat:Connect(function()
    hue = (hue + 0.005) % 1
    local color = Color3.fromHSV(hue, 1, 1)
    MainStroke.Color = color
    KillStroke.Color = color
    MiniStroke.Color = color
    MiniH.BackgroundColor3 = color
end)

local autoKill = false
KillBtn.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    KillBtn.Text = autoKill and "AUTO IS RUNNING..." or "START AUTO PLAY"
    if not autoKill then VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game) end
end)

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false MiniH.Visible = true end)
MiniH.MouseButton1Click:Connect(function() MiniH.Visible = false MainFrame.Visible = true end)
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"; CloseBtn.Size = UDim2.new(0,25,0,25); CloseBtn.Position = UDim2.new(1,-30,0,5); CloseBtn.BackgroundColor3 = Color3.fromRGB(150,0,0); CloseBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", CloseBtn);
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

---------------------------------------------------
-- CORE: BRUTE FORCE MOVE & DEFEND
---------------------------------------------------
local function getTarget()
    local target, dist = nil, 150
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v ~= LocalPlayer.Character and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then
                local d = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if d < dist then dist = d; target = v end
            end
        end
    end
    return target
end

RunService.Stepped:Connect(function()
    if autoKill then
        local myChar = LocalPlayer.Character
        local enemy = getTarget()
        
        if myChar and enemy and myChar:FindFirstChild("HumanoidRootPart") then
            local myHRP = myChar.HumanoidRootPart
            local enHRP = enemy.HumanoidRootPart
            local dist = (myHRP.Position - enHRP.Position).Magnitude
            
            -- ÉP DỊCH CHUYỂN (CFRAME LERP)
            if dist > 4 then
                myHRP.CFrame = myHRP.CFrame:Lerp(CFrame.new(myHRP.Position, Vector3.new(enHRP.Position.X, myHRP.Position.Y, enHRP.Position.Z)) * CFrame.new(0, 0, -2), 0.15)
            end

            -- ĐỠ ĐÒN & TẤN CÔNG
            local isAttacking = #enemy.Humanoid:GetPlayingAnimationTracks() > 0
            if dist < 12 and isAttacking then
                VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            else
                VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                if dist < 8 then
                    VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                end
            end
        end
    end
end)

-- Hiện Main
task.wait(1.5)
MainFrame.Visible = true
