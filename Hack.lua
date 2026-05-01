--[[
    H HUB - DELTA EXECUTOR VERSION
    Game: Jujutsu Shenanigans
    Features: Smooth UI, Minimize to "H", Auto Block
]]

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Xóa bản cũ nếu đã chạy trước đó để tránh trùng lặp
if CoreGui:FindFirstChild("HHUB_Delta") then
    CoreGui.HHUB_Delta:Destroy()
end

-- TẠO GIAO DIỆN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_Delta"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 1. BẢNG CHÍNH (MAIN FRAME)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Delta hỗ trợ kéo thả

-- Bo góc cho đẹp
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Viền phát sáng (Neon Border)
local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 255, 255)
Stroke.Parent = MainFrame

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -90, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "H HUB - JUJUTSU"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

---------------------------------------------------
-- 2. CÁC NÚT ĐIỀU KHIỂN (MIN / CLOSE)
---------------------------------------------------

-- Nút Thu nhỏ (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Parent = MainFrame
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

-- Nút Đóng (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- Ô vuông nhỏ chữ H (Khi thu nhỏ)
local MiniFrame = Instance.new("TextButton")
MiniFrame.Parent = ScreenGui
MiniFrame.Text = "H"
MiniFrame.Size = UDim2.new(0, 50, 0, 50)
MiniFrame.Position = UDim2.new(0, 20, 0.4, 0)
MiniFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
MiniFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
MiniFrame.Font = Enum.Font.GothamBold
MiniFrame.TextSize = 25
MiniFrame.Visible = false
Instance.new("UICorner", MiniFrame).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", MiniFrame).Thickness = 2

---------------------------------------------------
-- 3. BẢNG XÁC NHẬN ĐÓNG
---------------------------------------------------
local ConfirmPanel = Instance.new("Frame")
ConfirmPanel.Parent = ScreenGui
ConfirmPanel.Size = UDim2.new(0, 200, 0, 100)
ConfirmPanel.Position = UDim2.new(0.5, -100, 0.5, -50)
ConfirmPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ConfirmPanel.Visible = false
Instance.new("UICorner", ConfirmPanel)

local Msg = Instance.new("TextLabel", ConfirmPanel)
Msg.Text = "Đóng H HUB?"
Msg.Size = UDim2.new(1, 0, 0, 40)
Msg.TextColor3 = Color3.new(1,1,1)
Msg.BackgroundTransparency = 1

local YesBtn = Instance.new("TextButton", ConfirmPanel)
YesBtn.Text = "Đóng"
YesBtn.Size = UDim2.new(0, 80, 0, 30)
YesBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
YesBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

local NoBtn = Instance.new("TextButton", ConfirmPanel)
NoBtn.Text = "Quay lại"
NoBtn.Size = UDim2.new(0, 80, 0, 30)
NoBtn.Position = UDim2.new(0.55, 0, 0.6, 0)
NoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)

---------------------------------------------------
-- 4. LOGIC HOẠT ĐỘNG
---------------------------------------------------

-- Hiệu ứng mờ dần khi mở (Fade In)
MainFrame.GroupTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.5), {GroupTransparency = 0}):Play()

-- Thu nhỏ
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    MiniFrame.Visible = true
end)

-- Phóng to
MiniFrame.MouseButton1Click:Connect(function()
    MiniFrame.Visible = false
    MainFrame.Visible = true
end)

-- Xử lý đóng Hub
CloseBtn.MouseButton1Click:Connect(function()
    ConfirmPanel.Visible = true
end)

NoBtn.MouseButton1Click:Connect(function()
    ConfirmPanel.Visible = false
end)

YesBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

---------------------------------------------------
-- 5. TÍNH NĂNG TỰ ĐỘNG ĐỠ ĐÒN (AUTO BLOCK)
---------------------------------------------------
local AutoBtn = Instance.new("TextButton", MainFrame)
AutoBtn.Size = UDim2.new(0, 260, 0, 45)
AutoBtn.Position = UDim2.new(0, 20, 0, 60)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
AutoBtn.Text = "Auto Block: OFF"
AutoBtn.TextColor3 = Color3.new(1,1,1)
AutoBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", AutoBtn)

local autoBlock = false
AutoBtn.MouseButton1Click:Connect(function()
    autoBlock = not autoBlock
    AutoBtn.Text = "Auto Block: " .. (autoBlock and "ON" or "OFF")
    AutoBtn.BackgroundColor3 = autoBlock and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 45)
    Stroke.Color = autoBlock and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(0, 255, 255)
end)

-- Vòng lặp Auto Block
RunService.Stepped:Connect(function()
    if autoBlock then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, enemy in pairs(Players:GetPlayers()) do
                if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 18 then -- Khoảng cách kích hoạt đỡ
                        -- Giả lập giữ phím F
                        VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                        task.wait(0.1)
                        VIM:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                    end
                end
            end
        end
    end
end)

print("H HUB đã sẵn sàng trên Delta!")
