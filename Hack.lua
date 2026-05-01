--[[ 
    H HUB - FINAL STABLE VERSION
    Fix: Drag, Intro, Static Text, Stable Auto Block
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Xóa bản cũ
if CoreGui:FindFirstChild("HHUB_Final_Stable") then CoreGui.HHUB_Final_Stable:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_Final_Stable"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

---------------------------------------------------
-- CHỨC NĂNG DI CHUYỂN (FIX MOBILE)
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
-- BẢNG CHÀO MỪNG (INTRO)
---------------------------------------------------
local IntroFrame = Instance.new("Frame", ScreenGui)
IntroFrame.Size = UDim2.new(0, 300, 0, 100)
IntroFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
IntroFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
IntroFrame.BackgroundTransparency = 1
Instance.new("UICorner", IntroFrame)

local IntroText = Instance.new("TextLabel", IntroFrame)
IntroText.Text = "Cảm ơn vì đã dùng H HUB"
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.TextColor3 = Color3.new(1, 1, 1)
IntroText.TextTransparency = 1
IntroText.BackgroundTransparency = 1
IntroText.Font = Enum.Font.GothamBold
IntroText.TextSize = 18

---------------------------------------------------
-- GIAO DIỆN CHÍNH
---------------------------------------------------
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
MakeDraggable(MainFrame)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "H HUB - JUJUTSU"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Các nút điều khiển
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -85, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -42, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)

-- Nút H (Khi thu nhỏ)
local MiniH = Instance.new("TextButton", ScreenGui)
MiniH.Text = "H"
MiniH.Size = UDim2.new(0, 60, 0, 60)
MiniH.Position = UDim2.new(0, 20, 0.5, -30)
MiniH.Visible = false
MiniH.Font = Enum.Font.GothamBold
MiniH.TextSize = 35
MiniH.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MiniH).CornerRadius = UDim.new(0, 15)
local MiniStroke = Instance.new("UIStroke", MiniH)
MiniStroke.Thickness = 3
MakeDraggable(MiniH)

---------------------------------------------------
-- TÍNH NĂNG AUTO BLOCK (FIXED)
---------------------------------------------------
local AutoBtn = Instance.new("TextButton", MainFrame)
AutoBtn.Text = "AUTO BLOCK: OFF"
AutoBtn.Size = UDim2.new(0, 260, 0, 55)
AutoBtn.Position = UDim2.new(0.5, -130, 0.45, 0)
AutoBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AutoBtn.TextColor3 = Color3.new(1, 1, 1)
AutoBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", AutoBtn)
local AutoStroke = Instance.new("UIStroke", AutoBtn)
AutoStroke.Thickness = 2

local blocking = false
AutoBtn.MouseButton1Click:Connect(function()
    blocking = not blocking
    AutoBtn.Text = "AUTO BLOCK: " .. (blocking and "ON" or "OFF")
    if not blocking then
        VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game) -- Thả phím khi tắt
    end
end)

---------------------------------------------------
-- RAINBOW LOOP (CHỈ VIỀN)
---------------------------------------------------
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = hue + 0.005
    if hue > 1 then hue = 0 end
    local color = Color3.fromHSV(hue, 1, 1)
    
    MainStroke.Color = color
    MiniStroke.Color = color
    MiniH.BackgroundColor3 = color
    AutoStroke.Color = color
end)

---------------------------------------------------
-- XỬ LÝ INTRO & SỰ KIỆN
---------------------------------------------------
task.spawn(function()
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(IntroText, TweenInfo.new(1), {TextTransparency = 0}):Play()
    task.wait(2.5)
    TweenService:Create(IntroFrame, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText, TweenInfo.new(1), {TextTransparency = 1}):Play()
    task.wait(1)
    IntroFrame:Destroy()
    MainFrame.Visible = true
end)

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false MiniH.Visible = true end)
MiniH.MouseButton1Click:Connect(function() MiniH.Visible = false MainFrame.Visible = true end)

-- Bảng xác nhận đóng
local ConfirmFrame = Instance.new("Frame", ScreenGui)
ConfirmFrame.Size = UDim2.new(0, 260, 0, 130)
ConfirmFrame.Position = UDim2.new(0.5, -130, 0.5, -65)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ConfirmFrame.Visible = false
Instance.new("UICorner", ConfirmFrame)

local ConfirmText = Instance.new("TextLabel", ConfirmFrame)
ConfirmText.Text = "Bạn có chắc chắn đóng Hub H không?"
ConfirmText.Size = UDim2.new(1, 0, 0, 70)
ConfirmText.TextColor3 = Color3.new(1, 1, 1)
ConfirmText.BackgroundTransparency = 1
ConfirmText.TextWrapped = true

CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)

local YesBtn = Instance.new("TextButton", ConfirmFrame)
YesBtn.Text = "Đóng"
YesBtn.Size = UDim2.new(0, 100, 0, 35)
YesBtn.Position = UDim2.new(0, 20, 0, 80)
YesBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
YesBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", YesBtn)
YesBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local NoBtn = Instance.new("TextButton", ConfirmFrame)
NoBtn.Text = "Quay lại"
NoBtn.Size = UDim2.new(0, 100, 0, 35)
NoBtn.Position = UDim2.new(1, -120, 0, 80)
NoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NoBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", NoBtn)
NoBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)

---------------------------------------------------
-- CORE: AUTO BLOCK LOGIC (PREVENT STICKY KEY)
---------------------------------------------------
RunService.Heartbeat:Connect(function()
    if blocking then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local enemyDetected = false
            -- Quét dummy và người chơi
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v ~= char and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Humanoid") then
                    local mag = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if mag < 18 then
                        enemyDetected = true
                        break
                    end
                end
            end
            
            if enemyDetected then
                VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            else
                -- Chỉ nhả phím khi thực sự an toàn để không kẹt nút nhảy
                VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
            end
        end
    end
end)
