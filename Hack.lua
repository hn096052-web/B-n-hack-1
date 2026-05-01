--[[ 
    H HUB - JUJUTSU SHENANIGANS EDITION
    Tính năng: Fade In, Thu nhỏ (H), Xác nhận đóng, Auto Block, Fix Lag
]]

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GIẢ LẬP UI (Bạn hãy trỏ đúng đường dẫn đến UI của bạn)
local ScreenGui = script.Parent
local MainFrame = ScreenGui.MainFrame   -- Bảng điều khiển chính
local MiniFrame = ScreenGui.MiniFrame   -- Nút vuông nhỏ chữ H
local ConfirmFrame = ScreenGui.ConfirmFrame -- Bảng xác nhận đóng
local IntroLabel = MainFrame.IntroLabel -- Chữ "Cảm ơn đã dùng H HUB"

-- CẤU HÌNH MÀU SẮC & TWEEN
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local neonColor = Color3.fromRGB(0, 255, 255) -- Màu xanh Neon

---------------------------------------------------
-- 1. HIỆU ỨNG MỞ ĐẦU (INTRO FADE)
---------------------------------------------------
MainFrame.BackgroundTransparency = 1
IntroLabel.TextTransparency = 1

local function StartHub()
    MainFrame.Visible = true
    -- Hiện bảng và chữ cảm ơn
    TweenService:Create(MainFrame, tweenInfo, {BackgroundTransparency = 0.2}):Play()
    local fadeIn = TweenService:Create(IntroLabel, tweenInfo, {TextTransparency = 0})
    fadeIn:Play()
    
    fadeIn.Completed:Connect(function()
        task.wait(1.5) -- Hiển thị lời chào trong 1.5s
        TweenService:Create(IntroLabel, tweenInfo, {TextTransparency = 1}):Play()
    end)
end

---------------------------------------------------
-- 2. ĐIỀU KHIỂN GIAO DIỆN (MINIMIZE / CLOSE)
---------------------------------------------------

-- Nút Thu nhỏ (-) -> Thành ô vuông chữ H
MainFrame.MinimizeBtn.MouseButton1Click:Connect(function()
    local shrink = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    shrink:Play()
    shrink.Completed:Connect(function()
        MainFrame.Visible = false
        MiniFrame.Visible = true
        MiniFrame.Size = UDim2.new(0, 50, 0, 50) -- Kích thước ô vuông chữ H
    end)
end)

-- Nút Phóng to (H) -> Hiện lại bảng
MiniFrame.MouseButton1Click:Connect(function()
    MiniFrame.Visible = false
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 400, 0, 300), "Out", "Quart", 0.4, true)
end)

-- Nút Đóng (X) -> Hiện bảng xác nhận
MainFrame.CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
    ConfirmFrame.GroupTransparency = 1
    TweenService:Create(ConfirmFrame, tweenInfo, {GroupTransparency = 0}):Play()
end)

-- Nút Quay lại trong bảng xác nhận
ConfirmFrame.BackBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

-- Nút Đóng hẳn
ConfirmFrame.ExitBtn.MouseButton1Click:Connect(function()
    print("Cảm ơn đã sử dụng H HUB!")
    ScreenGui:Destroy()
end)

---------------------------------------------------
-- 3. TÍNH NĂNG TỰ ĐỘNG ĐỠ ĐÒN (AUTO BLOCK)
---------------------------------------------------
local autoBlock = true -- Có thể gắn vào một nút Toggle trên UI

RunService.Heartbeat:Connect(function()
    if not autoBlock then return end
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    for _, enemy in pairs(Players:GetPlayers()) do
        if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (char.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
            
            -- Nếu kẻ địch ở quá gần (khoảng cách 12-15 studs)
            if distance < 15 then
                -- Kích hoạt Block (Tùy thuộc vào RemoteEvent của game Jujutsu Shenanigans)
                -- Ví dụ: game:GetService("ReplicatedStorage").Events.Block:FireServer(true)
            end
        end
    end
end)

---------------------------------------------------
-- 4. HIỆU ỨNG NÚT BẤM ĐỘNG (HOVER)
---------------------------------------------------
local function AddHoverEffect(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = neonColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
end

AddHoverEffect(MainFrame.MinimizeBtn)
AddHoverEffect(MainFrame.CloseBtn)

-- KHỞI CHẠY HUB
StartHub()

