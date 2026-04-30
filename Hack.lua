-- 1. KHỞI TẠO DỊCH VỤ
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

-- 2. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "H_HUB_OFFICIAL"
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

-- [MỚI] 4. BẢNG GIỚI THIỆU (INTRO)
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(0, 300, 0, 120)
IntroFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner", IntroFrame)
IntroCorner.CornerRadius = UDim.new(0, 15)

local IntroText = Instance.new("TextLabel")
IntroText.Text = "Cảm ơn vì đã dùng H HUB"
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.TextColor3 = Color3.new(1, 1, 1)
IntroText.TextSize = 22
IntroText.Font = Enum.Font.SourceSansBold
IntroText.BackgroundTransparency = 1
IntroText.Parent = IntroFrame

ApplySparkleEffect(IntroFrame)

-- 5. BẢNG CHÍNH (MAIN FRAME)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 420)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Tạm ẩn để hiện Intro
MainFrame.Parent = ScreenGui
ApplySparkleEffect(MainFrame)

-- XỬ LÝ INTRO MỜ DẦN
task.spawn(function()
    task.wait(2.5) -- Hiện bảng trong 2.5 giây
    local fadeInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear)
    TweenService:Create(IntroFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText, fadeInfo, {TextTransparency = 1}):Play()
    task.wait(1.5)
    IntroFrame:Destroy()
    MainFrame.Visible = true -- Hiện bảng hack
end)

local ContentFolder = Instance.new("ScrollingFrame")
ContentFolder.Size = UDim2.new(1, 0, 1, -40)
ContentFolder.Position = UDim2.new(0, 0, 0, 40)
ContentFolder.BackgroundTransparency = 1
ContentFolder.CanvasSize = UDim2.new(0, 0, 2.5, 0)
ContentFolder.ScrollBarThickness = 4
ContentFolder.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = ContentFolder
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0, 10)

-- 6. NÚT THU NHỎ "H HUB" (DI CHUYỂN ĐƯỢC)
local H_Button = Instance.new("TextButton")
H_Button.Size = UDim2.new(0, 65, 0, 65)
H_Button.Position = UDim2.new(0.1, 0, 0.5, -30)
H_Button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
H_Button.Text = "H"
H_Button.TextColor3 = Color3.new(1, 1, 1)
H_Button.TextSize = 35
H_Button.Font = Enum.Font.SourceSansBold
H_Button.Visible = false
H_Button.Active = true
H_Button.Draggable = true
H_Button.Parent = ScreenGui

local UICornerH = Instance.new("UICorner")
UICornerH.CornerRadius = UDim.new(0, 15)
UICornerH.Parent = H_Button
ApplySparkleEffect(H_Button)

H_Button.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    H_Button.Visible = false
end)

-- 7. THANH TIÊU ĐỀ & ĐO FPS
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Text = "H HUB"
TitleText.Size = UDim2.new(0.4, 0, 1, 0)
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.Parent = TitleBar

local FpsLabel = Instance.new("TextLabel")
FpsLabel.Size = UDim2.new(0, 60, 0, 40)
FpsLabel.Position = UDim2.new(0.35, 0, 0, 0)
FpsLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
FpsLabel.BackgroundTransparency = 1
FpsLabel.TextSize = 14
FpsLabel.Parent = TitleBar

task.spawn(function()
    local lastTime = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastTime >= 1 then
            FpsLabel.Text = "FPS: " .. frameCount
            frameCount = 0
            lastTime = tick()
        end
    end)
end)

-- Các nút hệ thống
local function CreateSysBtn(txt, pos, color)
    local btn = Instance.new("TextButton")
    btn.Text = txt
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = TitleBar
    return btn
end

local MinBtn = CreateSysBtn("-", UDim2.new(1, -65, 0, 5), Color3.fromRGB(60, 60, 60))
local CloseBtn = CreateSysBtn("×", UDim2.new(1, -35, 0, 5), Color3.fromRGB(150, 0, 0))

-- 8. BẢNG XÁC NHẬN
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size = UDim2.new(0, 260, 0, 140)
ConfirmFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ConfirmFrame.BorderSizePixel = 2
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 100
ConfirmFrame.Parent = ScreenGui
ApplySparkleEffect(ConfirmFrame)

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Text = "BẠN CÓ CHẮC CHẮN\nMUỐN TẮT H HUB KHÔNG?"
ConfirmText.Size = UDim2.new(1, 0, 0, 70)
ConfirmText.TextColor3 = Color3.new(1, 1, 1)
ConfirmText.TextSize = 16
ConfirmText.Font = Enum.Font.SourceSansBold
ConfirmText.BackgroundTransparency = 1
ConfirmText.ZIndex = 101
ConfirmText.Parent = ConfirmFrame

local ExitBtn = Instance.new("TextButton")
ExitBtn.Text = "ĐÓNG"
ExitBtn.Size = UDim2.new(0, 100, 0, 40)
ExitBtn.Position = UDim2.new(0, 20, 1, -55)
ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
ExitBtn.TextColor3 = Color3.new(1, 1, 1)
ExitBtn.ZIndex = 101
ExitBtn.Parent = ConfirmFrame

local BackBtn = Instance.new("TextButton")
BackBtn.Text = "QUAY LẠI"
BackBtn.Size = UDim2.new(0, 100, 0, 40)
BackBtn.Position = UDim2.new(1, -120, 1, -55)
BackBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
BackBtn.TextColor3 = Color3.new(1, 1, 1)
BackBtn.ZIndex = 101
BackBtn.Parent = ConfirmFrame

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; H_Button.Visible = true end)
CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
BackBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- 9. HÀM TẠO BỘ ĐIỀU CHỈNH (+/-)
local function CreateAdjuster(name, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 60)
    frame.BackgroundTransparency = 1
    frame.Parent = ContentFolder

    local label = Instance.new("TextLabel")
    label.Text = name .. ": " .. defaultVal
    label.Size = UDim2.new(1, 0, 0, 25)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.Parent = frame

    local dec = Instance.new("TextButton")
    dec.Text = "-"
    dec.Size = UDim2.new(0, 45, 0, 30)
    dec.Position = UDim2.new(0.05, 0, 0, 25)
    dec.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    dec.TextColor3 = Color3.new(1, 1, 1)
    dec.Parent = frame

    local inc = Instance.new("TextButton")
    inc.Text = "+"
    inc.Size = UDim2.new(0, 45, 0, 30)
    inc.Position = UDim2.new(0.72, 0, 0, 25)
    inc.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
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

-- 10. CÁC TÍNH NĂNG CHÍNH
-- [MỚI] NÚT FIX LAG (GIẢM ĐỒ HỌA)
local btnLag = Instance.new("TextButton")
btnLag.Size = UDim2.new(0, 180, 0, 40)
btnLag.Text = "🚀 FIX LAG (MƯỢT)"
btnLag.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
btnLag.TextColor3 = Color3.new(1, 1, 1)
btnLag.Font = Enum.Font.SourceSansBold
btnLag.Parent = ContentFolder

btnLag.MouseButton1Click:Connect(function()
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
    Lighting.GlobalShadows = false
    btnLag.Text = "ĐÃ TỐI ƯU LAG ✅"
end)

CreateAdjuster("Tốc Độ", 16, function(v) if player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = v end end)
CreateAdjuster("Sức Nhảy", 50, function(v) if player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.UseJumpPower = true; player.Character.Humanoid.JumpPower = v end end)

local flySpd = 50
CreateAdjuster("Tốc Độ Bay", 50, function(v) flySpd = v end)

-- Nút Bay
local flying = false
local btnFly = Instance.new("TextButton")
btnFly.Size = UDim2.new(0, 180, 0, 40); btnFly.Text = "Bay: TẮT"; btnFly.BackgroundColor3 = Color3.fromRGB(200, 50, 50); btnFly.TextColor3 = Color3.new(1, 1, 1); btnFly.Parent = ContentFolder
btnFly.MouseButton1Click:Connect(function()
    flying = not flying
    btnFly.Text = flying and "Bay: BẬT" or "Bay: TẮT"; btnFly.BackgroundColor3 = flying and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if flying and root then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                local hum = player.Character:FindFirstChild("Humanoid")
                if hum then
                    bv.Velocity = hum.MoveDirection * flySpd + Vector3.new(0, workspace.CurrentCamera.CFrame.LookVector.Y * flySpd * hum.MoveDirection.Magnitude, 0)
                end
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- Nút Xuyên Tường
local noclip = false
local btnNoc = Instance.new("TextButton")
btnNoc.Size = UDim2.new(0, 180, 0, 40); btnNoc.Text = "Xuyên Tường: TẮT"; btnNoc.BackgroundColor3 = Color3.fromRGB(200, 50, 50); btnNoc.TextColor3 = Color3.new(1, 1, 1); btnNoc.Parent = ContentFolder
btnNoc.MouseButton1Click:Connect(function()
    noclip = not noclip
    btnNoc.Text = noclip and "Xuyên Tường: BẬT" or "Xuyên Tường: TẮT"; btnNoc.BackgroundColor3 = noclip and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
end)
RunService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

-- Nút Tàng Hình
local invis = false
local btnInvis = Instance.new("TextButton")
btnInvis.Size = UDim2.new(0, 180, 0, 40); btnInvis.Text = "Tàng Hình: TẮT"; btnInvis.BackgroundColor3 = Color3.fromRGB(200, 50, 50); btnInvis.TextColor3 = Color3.new(1, 1, 1); btnInvis.Parent = ContentFolder
btnInvis.MouseButton1Click:Connect(function()
    invis = not invis
    btnInvis.Text = invis and "Tàng Hình: BẬT" or "Tàng Hình: TẮT"; btnInvis.BackgroundColor3 = invis and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
    if player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then
                v.Transparency = invis and 0.8 or 0
            end
        end
    end
end)
