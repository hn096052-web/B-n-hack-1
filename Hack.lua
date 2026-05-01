--[[ 
    H HUB - ULTIMATE RAINBOW EDITION (FIXED DRAG)
    Executor: Delta / Mobile
    Feature: Full Rainbow, Draggable, Auto Block (Dummy/Player)
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Xóa bản cũ nếu có để tránh lỗi
if CoreGui:FindFirstChild("HHUB_Ultimate") then CoreGui.HHUB_Ultimate:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_Ultimate"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

---------------------------------------------------
-- HÀM HỖ TRỢ DI CHUYỂN (FIX CHO DELTA MOBILE)
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    RunService.RenderStepped:Connect(function()
        if dragging and dragInput then
            local delta = dragInput.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

---------------------------------------------------
-- 1. BẢNG CHÍNH (MAIN FRAME)
---------------------------------------------------
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BorderSizePixel = 0
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
MakeDraggable(MainFrame) -- Kích hoạt kéo bảng

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 3

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "H HUB - ULTIMATE RAINBOW"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

---------------------------------------------------
-- 2. CÁC NÚT ĐIỀU KHIỂN (MIN / CLOSE)
---------------------------------------------------
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -85, 0, 8)
MinBtn.BackgroundTransparency = 0.8
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -42, 0, 8)
CloseBtn.BackgroundTransparency = 0.8
Instance.new("UICorner", CloseBtn)

-- NÚT CHỮ H (THU NHỎ)
local MiniH = Instance.new("TextButton", ScreenGui)
MiniH.Name = "MiniH"
MiniH.Text = "H"
MiniH.Size = UDim2.new(0, 65, 0, 65)
MiniH.Position = UDim2.new(0, 20, 0.5, -32)
MiniH.Visible = false
MiniH.Font = Enum.Font.GothamBold
MiniH.TextSize = 40
Instance.new("UICorner", MiniH).CornerRadius = UDim.new(0, 20)
local MiniStroke = Instance.new("UIStroke", MiniH)
MiniStroke.Thickness = 3
MakeDraggable(MiniH) -- H có thể kéo đi chỗ khác

---------------------------------------------------
-- 3. BẢNG XÁC NHẬN ĐÓNG
---------------------------------------------------
local ConfirmFrame = Instance.new("Frame", ScreenGui)
ConfirmFrame.Size = UDim2.new(0, 280, 0, 140)
ConfirmFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ConfirmFrame.Visible = false
Instance.new("UICorner", ConfirmFrame)
local ConfirmStroke = Instance.new("UIStroke", ConfirmFrame)
ConfirmStroke.Thickness = 3

local ConfirmText = Instance.new("TextLabel", ConfirmFrame)
ConfirmText.Text = "Bạn có chắc chắn đóng Hub H không?"
ConfirmText.Size = UDim2.new(1, 0, 0, 70)
ConfirmText.BackgroundTransparency = 1
ConfirmText.TextSize = 16
ConfirmText.Font = Enum.Font.GothamSemibold
ConfirmText.TextWrapped = true

---------------------------------------------------
-- 4. TÍNH NĂNG AUTO BLOCK
---------------------------------------------------
local AutoBtn = Instance.new("TextButton", MainFrame)
AutoBtn.Size = UDim2.new(0, 260, 0, 60)
AutoBtn.Position = UDim2.new(0.5, -130, 0.5, 0)
AutoBtn.Text = "AUTO BLOCK: OFF"
AutoBtn.Font = Enum.Font.GothamBold
AutoBtn.TextSize = 18
AutoBtn.BackgroundTransparency = 0.9
Instance.new("UICorner", AutoBtn)
local AutoStroke = Instance.new("UIStroke", AutoBtn)
AutoStroke.Thickness = 2

---------------------------------------------------
-- 5. HỆ THỐNG FULL RAINBOW (CẦU VỒNG TOÀN BỘ)
---------------------------------------------------
local hue = 0
RunService.RenderStepped:Connect(function()
    hue = hue + 0.005
    if hue > 1 then hue = 0 end
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    
    -- Áp dụng màu cho viền, chữ và nền nút
    MainStroke.Color = rainbowColor
    Title.TextColor3 = rainbowColor
    MinBtn.TextColor3 = rainbowColor
    CloseBtn.TextColor3 = rainbowColor
    
    MiniH.BackgroundColor3 = rainbowColor
    MiniH.TextColor3 = Color3.new(1, 1, 1) -- Chữ H màu trắng
    MiniStroke.Color = rainbowColor
    
    ConfirmStroke.Color = rainbowColor
    ConfirmText.TextColor3 = rainbowColor
    
    AutoBtn.TextColor3 = rainbowColor
    AutoStroke.Color = rainbowColor
end)

---------------------------------------------------
-- 6. LOGIC XỬ LÝ SỰ KIỆN
---------------------------------------------------
local blocking = false
AutoBtn.MouseButton1Click:Connect(function()
    blocking = not blocking
    AutoBtn.Text = "AUTO BLOCK: " .. (blocking and "ON" or "OFF")
end)

-- Thu nhỏ bảng
MinBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0,0,0,0), "Out", "Quart", 0.3, true)
    task.wait(0.3)
    MainFrame.Visible = false
    MiniH.Visible = true
end)

-- Phóng to bảng
MiniH.MouseButton1Click:Connect(function()
    MiniH.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 350, 0, 250), "Out", "Quart", 0.3, true)
end)

-- Nút X hiện bảng xác nhận
CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)

-- Nút đóng trong bảng xác nhận
local YesBtn = Instance.new("TextButton", ConfirmFrame)
YesBtn.Text = "ĐÓNG"
YesBtn.Size = UDim2.new(0, 100, 0, 40)
YesBtn.Position = UDim2.new(0, 30, 0, 85)
YesBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
YesBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", YesBtn)
YesBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local NoBtn = Instance.new("TextButton", ConfirmFrame)
NoBtn.Text = "QUAY LẠI"
NoBtn.Size = UDim2.new(0, 100, 0, 40)
NoBtn.Position = UDim2.new(1, -130, 0, 85)
NoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
NoBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", NoBtn)
NoBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)

-- VÒNG LẶP AUTO BLOCK (Quét mọi đối thủ gần bạn)
RunService.Heartbeat:Connect(function()
    if blocking then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Quét cả người chơi và các NPC/Dummy trong Workspace
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v ~= char and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChildOfClass("Humanoid") then
                    local mag = (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if mag < 18 then -- Khoảng cách đỡ đòn
                        VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                        task.wait(0.05)
                        VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                    end
                end
            end
        end
    end
end)

print("H HUB Rainbow Ultimate Loaded Successfully!")
