-- 1. KHỞI TẠO DỊCH VỤ
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local player = game.Players.LocalPlayer

-- 2. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumHackerHubV8"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- 3. HÀM HIỆU ỨNG LẤP LÁNH
local function ApplySparkleEffect(object)
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    uiGradient.Parent = object
    task.spawn(function()
        while true do
            TweenService:Create(uiGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {Rotation = 360}):Play()
            task.wait(2)
        end
    end)
end

-- 4. BẢNG CHÍNH (MAIN FRAME)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 420)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép kéo bảng chính
MainFrame.Parent = ScreenGui
ApplySparkleEffect(MainFrame)

local ContentFolder = Instance.new("ScrollingFrame")
ContentFolder.Size = UDim2.new(1, 0, 1, -40)
ContentFolder.Position = UDim2.new(0, 0, 0, 40)
ContentFolder.BackgroundTransparency = 1
ContentFolder.CanvasSize = UDim2.new(0, 0, 1.8, 0)
ContentFolder.ScrollBarThickness = 4
ContentFolder.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = ContentFolder
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0, 10)

-- 5. NÚT THU NHỎ "H" (CÓ THỂ DI CHUYỂN)
local H_Button = Instance.new("TextButton")
H_Button.Size = UDim2.new(0, 60, 0, 60)
H_Button.Position = UDim2.new(0.1, 0, 0.5, -30)
H_Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
H_Button.Text = "H"
H_Button.TextColor3 = Color3.new(1, 1, 1)
H_Button.TextSize = 35
H_Button.Font = Enum.Font.SourceSansBold
H_Button.Visible = false
H_Button.Active = true
H_Button.Draggable = true -- QUAN TRỌNG: Cho phép kéo nút H
H_Button.Parent = ScreenGui

local UICornerH = Instance.new("UICorner")
UICornerH.CornerRadius = UDim.new(0, 15)
UICornerH.Parent = H_Button
ApplySparkleEffect(H_Button)

-- 6. THANH TIÊU ĐỀ & NÚT HỆ THỐNG
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Text = "HACKER HUB V8"
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Parent = TitleBar

local MinBtn = Instance.new("TextButton")
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -95, 0, 2)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Parent = TitleBar

local MaxBtn = Instance.new("TextButton")
MaxBtn.Text = "⬜"
MaxBtn.Size = UDim2.new(0, 30, 0, 30)
MaxBtn.Position = UDim2.new(1, -65, 0, 2)
MaxBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MaxBtn.TextColor3 = Color3.new(1, 1, 1)
MaxBtn.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Parent = TitleBar

-- 7. BẢNG XÁC NHẬN TẮT
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size = UDim2.new(0, 260, 0, 130)
ConfirmFrame.Position = UDim2.new(0.5, -130, 0.5, -65)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 10
ConfirmFrame.Parent = ScreenGui
ApplySparkleEffect(ConfirmFrame)

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Text = "Bạn có chắc muốn tắt hack không?"
ConfirmText.Size = UDim2.new(1, 0, 0, 60)
ConfirmText.TextColor3 = Color3.new(1, 1, 1)
ConfirmText.BackgroundTransparency = 1
ConfirmText.Parent = ConfirmFrame

local ExitBtn = Instance.new("TextButton")
ExitBtn.Text = "Đóng"
ExitBtn.Size = UDim2.new(0, 100, 0, 40)
ExitBtn.Position = UDim2.new(0, 20, 1, -50)
ExitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.Parent = ConfirmFrame

local BackBtn = Instance.new("TextButton")
BackBtn.Text = "Quay lại"
BackBtn.Size = UDim2.new(0, 100, 0, 40)
BackBtn.Position = UDim2.new(1, -120, 1, -50)
BackBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
BackBtn.TextColor3 = Color3.new(1, 1, 1)
BackBtn.Parent = ConfirmFrame

-- 8. HÀM TẠO BỘ ĐIỀU CHỈNH (+/-) FIX LỖI
local function CreateAdjuster(name, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 55)
    frame.BackgroundTransparency = 1
    frame.Parent = ContentFolder

    local label = Instance.new("TextLabel")
    label.Text = name .. ": " .. defaultVal
    label.Size = UDim2.new(1, 0, 0, 20)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Parent = frame

    local dec = Instance.new("TextButton")
    dec.Text = "-"
    dec.Size = UDim2.new(0, 40, 0, 30)
    dec.Position = UDim2.new(0.1, 0, 0, 22)
    dec.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    dec.TextColor3 = Color3.new(1, 1, 1)
    dec.Parent = frame

    local inc = Instance.new("TextButton")
    inc.Text = "+"
    inc.Size = UDim2.new(0, 40, 0, 30)
    inc.Position = UDim2.new(0.7, 0, 0, 22)
    inc.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    inc.TextColor3 = Color3.new(1, 1, 1)
    inc.Parent = frame

    local val = defaultVal
    dec.MouseButton1Click:Connect(function()
        val = math.max(0, val - 10)
        label.Text = name .. ": " .. val
        callback(val)
    end)
    inc.MouseButton1Click:Connect(function()
        val = val + 10
        label.Text = name .. ": " .. val
        callback(val)
    end)
end

-- 9. LOGIC DI CHUYỂN & HỆ THỐNG
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    H_Button.Visible = true
end)

H_Button.MouseButton1Click:Connect(function()
    -- Nếu đang bị kéo thì không thu nhỏ, cái này giúp phân biệt click và drag
    MainFrame.Visible = true
    H_Button.Visible = false
end)

local isWide = false
MaxBtn.MouseButton1Click:Connect(function()
    isWide = not isWide
    MainFrame.Size = isWide and UDim2.new(0, 350, 0, 420) or UDim2.new(0, 220, 0, 420)
end)

CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
BackBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- 10. KẾT NỐI TÍNH NĂNG HACK
local currentFlySpeed = 50

CreateAdjuster("Tốc Độ", 16, function(v) 
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = v 
    end
end)

CreateAdjuster("Sức Nhảy", 50, function(v) 
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.UseJumpPower = true
        player.Character.Humanoid.JumpPower = v 
    end
end)

CreateAdjuster("Tốc độ Bay", 50, function(v) currentFlySpeed = v end)

-- Bay (Fly)
local flying = false
local btnFly = Instance.new("TextButton")
btnFly.Size = UDim2.new(0, 180, 0, 40)
btnFly.Text = "Bay: TẮT"
btnFly.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btnFly.TextColor3 = Color3.new(1, 1, 1)
btnFly.Parent = ContentFolder

btnFly.MouseButton1Click:Connect(function()
    flying = not flying
    btnFly.Text = flying and "Bay: BẬT" or "Bay: TẮT"
    btnFly.BackgroundColor3 = flying and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if flying and root then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                local hum = player.Character and player.Character:FindFirstChild("Humanoid")
                if hum then
                    local moveDir = hum.MoveDirection
                    bv.Velocity = moveDir * currentFlySpeed + Vector3.new(0, workspace.CurrentCamera.CFrame.LookVector.Y * currentFlySpeed * moveDir.Magnitude, 0)
                end
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- Xuyên tường (Noclip)
local noclip = false
local btnNoclip = Instance.new("TextButton")
btnNoclip.Size = UDim2.new(0, 180, 0, 40)
btnNoclip.Text = "Xuyên tường: TẮT"
btnNoclip.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btnNoclip.TextColor3 = Color3.new(1, 1, 1)
btnNoclip.Parent = ContentFolder

btnNoclip.MouseButton1Click:Connect(function()
    noclip = not noclip
    btnNoclip.Text = noclip and "Xuyên tường: BẬT" or "Xuyên tường: TẮT"
    btnNoclip.BackgroundColor3 = noclip and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
end)

RunService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
