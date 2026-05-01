local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Xóa bản cũ nếu có
if CoreGui:FindFirstChild("HHUB_Final") then CoreGui.HHUB_Final:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HHUB_Final"
ScreenGui.Parent = CoreGui

-- 1. BẢNG CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(170, 0, 255) -- Màu tím Jujutsu

-- 2. CÁC NÚT ĐIỀU KHIỂN GÓC TRÊN
local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 35, 0, 35)
MinBtn.Position = UDim2.new(1, -80, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)

-- 3. NÚT CHỮ H (KHI THU NHỎ)
local MiniH = Instance.new("TextButton", ScreenGui)
MiniH.Name = "MiniH"
MiniH.Text = "H"
MiniH.Size = UDim2.new(0, 60, 0, 60)
MiniH.Position = UDim2.new(0, 10, 0.5, -30)
MiniH.Visible = false
MiniH.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
MiniH.Font = Enum.Font.GothamBold
MiniH.TextSize = 30
Instance.new("UICorner", MiniH).CornerRadius = UDim.new(0, 15)

-- 4. BẢNG XÁC NHẬN ĐÓNG (Hiện ra khi bấm X)
local ConfirmFrame = Instance.new("Frame", ScreenGui)
ConfirmFrame.Size = UDim2.new(0, 250, 0, 120)
ConfirmFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConfirmFrame.Visible = false
Instance.new("UICorner", ConfirmFrame)
Instance.new("UIStroke", ConfirmFrame).Color = Color3.new(1,0,0)

local ConfirmText = Instance.new("TextLabel", ConfirmFrame)
ConfirmText.Text = "Bạn có chắc chắn đóng Hub H không?"
ConfirmText.Size = UDim2.new(1, 0, 0, 50)
ConfirmText.TextColor3 = Color3.new(1, 1, 1)
ConfirmText.BackgroundTransparency = 1
ConfirmText.TextWrapped = true

local YesBtn = Instance.new("TextButton", ConfirmFrame)
YesBtn.Text = "Đóng"
YesBtn.Size = UDim2.new(0, 100, 0, 35)
YesBtn.Position = UDim2.new(0, 15, 0, 70)
YesBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

local NoBtn = Instance.new("TextButton", ConfirmFrame)
NoBtn.Text = "Quay lại"
NoBtn.Size = UDim2.new(0, 100, 0, 35)
NoBtn.Position = UDim2.new(0, 135, 0, 70)
NoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

---------------------------------------------------
-- LOGIC HIỆU ỨNG & TÍNH NĂNG
---------------------------------------------------

-- Thu nhỏ bảng thành nút H
MinBtn.MouseButton1Click:Connect(function()
    MainFrame:TweenSize(UDim2.new(0,0,0,0), "Out", "Quart", 0.3, true)
    task.wait(0.3)
    MainFrame.Visible = false
    MiniH.Visible = true
end)

-- Bấm H để to lại
MiniH.MouseButton1Click:Connect(function()
    MiniH.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 350, 0, 250), "Out", "Quart", 0.3, true)
end)

-- Xử lý nút X
CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
end)

NoBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

YesBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- TÍNH NĂNG TỰ ĐỘNG ĐỠ ĐÒN (AUTO BLOCK)
local AutoBtn = Instance.new("TextButton", MainFrame)
AutoBtn.Text = "AUTO BLOCK: OFF"
AutoBtn.Size = UDim2.new(0, 250, 0, 50)
AutoBtn.Position = UDim2.new(0.5, -125, 0.4, 0)
AutoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AutoBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AutoBtn)

local blocking = false
AutoBtn.MouseButton1Click:Connect(function()
    blocking = not blocking
    AutoBtn.Text = "AUTO BLOCK: " .. (blocking and "ON" or "OFF")
    AutoBtn.BackgroundColor3 = blocking and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
end)

-- Vòng lặp Auto Block (Quét kẻ địch)
RunService.RenderStepped:Connect(function()
    if blocking then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local mag = (char.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                    if mag < 20 then -- Khoảng cách an toàn
                        VIM:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                    end
                end
            end
        end
    end
end)

-- Hiệu ứng đổi màu nút khi di chuột (Dành cho Mobile/Delta giả lập)
local function Hover(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
end
Hover(MinBtn)
Hover(NoBtn)
