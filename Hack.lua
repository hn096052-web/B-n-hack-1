-- 1. KHỞI TẠO DỊCH VỤ
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 2. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "H_HUB_OFFICIAL"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- HÀM TẠO TIẾNG CLICK
local function PlayClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853"
    sound.Volume = 1
    sound.Parent = ScreenGui
    sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

-- [MỚI] HÀM TẠO HIỆU ỨNG ĐỘNG CHO NÚT
local function AddButtonAnimation(btn)
    local originalSize = btn.Size
    local hoverSize = UDim2.new(originalSize.X.Scale, originalSize.X.Offset + 5, originalSize.Y.Scale, originalSize.Y.Offset + 2)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = hoverSize, BackgroundTransparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {Size = originalSize, BackgroundTransparency = 0}):Play()
    end)
end

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

-- 4. BẢNG GIỚI THIỆU (INTRO)
local IntroFrame = Instance.new("Frame")
IntroFrame.Size = UDim2.new(0, 300, 0, 120)
IntroFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroFrame.BorderSizePixel = 0
IntroFrame.Parent = ScreenGui
Instance.new("UICorner", IntroFrame).CornerRadius = UDim.new(0, 15)

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
MainFrame.Size = UDim2.new(0, 240, 0, 500)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false 
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame)
ApplySparkleEffect(MainFrame)

task.spawn(function()
    task.wait(2.5)
    local fadeInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear)
    TweenService:Create(IntroFrame, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(IntroText, fadeInfo, {TextTransparency = 1}):Play()
    task.wait(1.5)
    IntroFrame:Destroy()
    MainFrame.Visible = true
end)

local ContentFolder = Instance.new("ScrollingFrame")
ContentFolder.Size = UDim2.new(1, 0, 1, -110)
ContentFolder.Position = UDim2.new(0, 0, 0, 45)
ContentFolder.BackgroundTransparency = 1
ContentFolder.CanvasSize = UDim2.new(0, 0, 3.5, 0)
ContentFolder.ScrollBarThickness = 3
ContentFolder.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = ContentFolder
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0, 10)

-- HÀM TẠO NHÃN PHÂN LOẠI (CATEGORY)
local function CreateCategory(name)
    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(0.9, 0, 0, 30)
    lab.Text = "── " .. name .. " ──"
    lab.TextColor3 = Color3.fromRGB(200, 200, 200)
    lab.Font = Enum.Font.SourceSansItalic
    lab.TextSize = 15
    lab.BackgroundTransparency = 1
    lab.Parent = ContentFolder
end

-- 6. NÚT THU NHỎ "H"
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
Instance.new("UICorner", H_Button).CornerRadius = UDim.new(0, 15)
ApplySparkleEffect(H_Button)
AddButtonAnimation(H_Button)

H_Button.MouseButton1Click:Connect(function()
    PlayClickSound()
    MainFrame.Visible = true
    H_Button.Visible = false
end)

-- 7. THANH TIÊU ĐỀ & ĐO FPS
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Text = "H HUB OFFICIAL"
TitleText.Size = UDim2.new(0.6, 0, 1, 0)
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 18
TitleText.Parent = TitleBar

local FpsLabel = Instance.new("TextLabel")
FpsLabel.Size = UDim2.new(0, 60, 0, 40)
FpsLabel.Position = UDim2.new(0.5, 0, 0, 0)
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

local function CreateSysBtn(txt, pos, color)
    local btn = Instance.new("TextButton")
    btn.Text = txt
    btn.Size = UDim2.new(0, 30, 0, 30)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = TitleBar
    Instance.new("UICorner", btn)
    AddButtonAnimation(btn)
    btn.MouseButton1Click:Connect(PlayClickSound)
    return btn
end

local MinBtn = CreateSysBtn("-", UDim2.new(1, -65, 0, 5), Color3.fromRGB(60, 60, 60))
local CloseBtn = CreateSysBtn("×", UDim2.new(1, -35, 0, 5), Color3.fromRGB(150, 0, 0))

-- 8. BẢNG XÁC NHẬN
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size = UDim2.new(0, 260, 0, 140)
ConfirmFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ConfirmFrame.Visible = false
ConfirmFrame.ZIndex = 100
ConfirmFrame.Parent = ScreenGui
Instance.new("UICorner", ConfirmFrame)
ApplySparkleEffect(ConfirmFrame)

local ExitBtn = Instance.new("TextButton")
ExitBtn.Text = "ĐÓNG"; ExitBtn.Size = UDim2.new(0, 100, 0, 40); ExitBtn.Position = UDim2.new(0, 20, 1, -55); ExitBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0); ExitBtn.TextColor3 = Color3.new(1, 1, 1); ExitBtn.ZIndex = 101; ExitBtn.Parent = ConfirmFrame
Instance.new("UICorner", ExitBtn)
AddButtonAnimation(ExitBtn)

local BackBtn = Instance.new("TextButton")
BackBtn.Text = "QUAY LẠI"; BackBtn.Size = UDim2.new(0, 100, 0, 40); BackBtn.Position = UDim2.new(1, -120, 1, -55); BackBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); BackBtn.TextColor3 = Color3.new(1, 1, 1); BackBtn.ZIndex = 101; BackBtn.Parent = ConfirmFrame
Instance.new("UICorner", BackBtn)
AddButtonAnimation(BackBtn)

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; H_Button.Visible = true end)
CloseBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = true end)
BackBtn.MouseButton1Click:Connect(function() ConfirmFrame.Visible = false end)
ExitBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- PHẦN NHẬN BIẾT NGƯỜI CHƠI (USER INFO)
local UserFrame = Instance.new("Frame")
UserFrame.Size = UDim2.new(1, -10, 0, 55)
UserFrame.Position = UDim2.new(0, 5, 1, -60)
UserFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
UserFrame.Parent = MainFrame
Instance.new("UICorner", UserFrame)

local UserImage = Instance.new("ImageLabel")
UserImage.Size = UDim2.new(0, 40, 0, 40)
UserImage.Position = UDim2.new(0, 8, 0.5, -20)
UserImage.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"
UserImage.Parent = UserFrame
Instance.new("UICorner", UserImage).CornerRadius = UDim.new(1, 0)

local UserName = Instance.new("TextLabel")
UserName.Size = UDim2.new(1, -60, 0, 20)
UserName.Position = UDim2.new(0, 55, 0.2, 0)
UserName.Text = player.DisplayName
UserName.TextColor3 = Color3.new(1, 1, 1)
UserName.Font = Enum.Font.SourceSansBold
UserName.TextSize = 15
UserName.TextXAlignment = Enum.TextXAlignment.Left
UserName.BackgroundTransparency = 1
UserName.Parent = UserFrame

local UserID = Instance.new("TextLabel")
UserID.Size = UDim2.new(1, -60, 0, 20)
UserID.Position = UDim2.new(0, 55, 0.55, 0)
UserID.Text = "@" .. player.Name
UserID.TextColor3 = Color3.fromRGB(160, 160, 160)
UserID.Font = Enum.Font.SourceSans
UserID.TextSize = 13
UserID.TextXAlignment = Enum.TextXAlignment.Left
UserID.BackgroundTransparency = 1
UserID.Parent = UserFrame

-- 9. HÀM TẠO BỘ ĐIỀU CHỈNH (+/-)
local function CreateAdjuster(name, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 60); frame.BackgroundTransparency = 1; frame.Parent = ContentFolder
    local label = Instance.new("TextLabel")
    label.Text = name .. ": " .. defaultVal; label.Size = UDim2.new(1, 0, 0, 25); label.TextColor3 = Color3.new(1, 1, 1); label.BackgroundTransparency = 1; label.Parent = frame
    local val = defaultVal
    local dec = Instance.new("TextButton")
    dec.Text = "-"; dec.Size = UDim2.new(0, 45, 0, 30); dec.Position = UDim2.new(0.05, 0, 0, 25); dec.BackgroundColor3 = Color3.fromRGB(70, 70, 70); dec.TextColor3 = Color3.new(1, 1, 1); dec.Parent = frame
    Instance.new("UICorner", dec)
    AddButtonAnimation(dec)
    
    local inc = Instance.new("TextButton")
    inc.Text = "+"; inc.Size = UDim2.new(0, 45, 0, 30); inc.Position = UDim2.new(0.72, 0, 0, 25); inc.BackgroundColor3 = Color3.fromRGB(70, 70, 70); inc.TextColor3 = Color3.new(1, 1, 1); inc.Parent = frame
    Instance.new("UICorner", inc)
    AddButtonAnimation(inc)

    dec.MouseButton1Click:Connect(function() PlayClickSound(); val = math.max(0, val - 10); label.Text = name .. ": " .. val; callback(val) end)
    inc.MouseButton1Click:Connect(function() PlayClickSound(); val = val + 10; label.Text = name .. ": " .. val; callback(val) end)
end

-- 10. CÁC TÍNH NĂNG CHÍNH
local function CreateHackBtn(txt, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = ContentFolder
    Instance.new("UICorner", btn)
    AddButtonAnimation(btn)
    btn.MouseButton1Click:Connect(function()
        PlayClickSound()
        callback(btn)
    end)
    return btn
end

-- FIX TRẠNG THÁI NÚT (BẬT/TẮT)
local function ToggleBtnUI(btn, state, baseText)
    btn.Text = baseText .. (state and ": BẬT" or ": TẮT")
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
end

-- MỤC NGƯỜI CHƠI
CreateCategory("NGƯỜI CHƠI")

local infJump = false
local btnInf = CreateHackBtn("Nhảy Vô Hạn: TẮT", function(btn)
    infJump = not infJump
    ToggleBtnUI(btn, infJump, "Nhảy Vô Hạn")
end)
UserInputService.JumpRequest:Connect(function()
    if infJump then player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end
end)

local noclip = false
local btnNoc = CreateHackBtn("Xuyên Tường: TẮT", function(btn)
    noclip = not noclip
    ToggleBtnUI(btn, noclip, "Xuyên Tường")
end)
RunService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

local invis = false
local btnInvis = CreateHackBtn("Tàng Hình: TẮT", function(btn)
    invis = not invis
    ToggleBtnUI(btn, invis, "Tàng Hình")
    if player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then
                v.Transparency = invis and 0.8 or 0
            end
        end
    end
end)

CreateAdjuster("Tốc Độ", 16, function(v) if player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = v end end)
CreateAdjuster("Sức Nhảy", 50, function(v) if player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.UseJumpPower = true; player.Character.Humanoid.JumpPower = v end end)

-- MỤC ESP
CreateCategory("ESP")

local function UpdateESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            if not p.Character.Head:FindFirstChild("H_ESP") then
                local bbg = Instance.new("BillboardGui", p.Character.Head)
                bbg.Name = "H_ESP"; bbg.AlwaysOnTop = true; bbg.Size = UDim2.new(0, 100, 0, 50); bbg.ExtentsOffset = Vector3.new(0, 3, 0)
                local nam = Instance.new("TextLabel", bbg)
                nam.Size = UDim2.new(1, 0, 1, 0); nam.BackgroundTransparency = 1; nam.Text = p.DisplayName; nam.TextColor3 = Color3.new(1, 1, 1); nam.TextStrokeTransparency = 0; nam.Font = Enum.Font.SourceSansBold; nam.TextSize = 14
            end
        end
    end
end

local espEnabled = false
local btnEsp = CreateHackBtn("ESP Người Chơi: TẮT", function(btn)
    espEnabled = not espEnabled
    ToggleBtnUI(btn, espEnabled, "ESP Người Chơi")
    if espEnabled then
        _G.ESPLoop = RunService.RenderStepped:Connect(UpdateESP)
    else
        if _G.ESPLoop then _G.ESPLoop:Disconnect() end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character.Head:FindFirstChild("H_ESP") then p.Character.Head.H_ESP:Destroy() end
        end
    end
end)

-- MỤC TIỆN ÍCH
CreateCategory("HỆ THỐNG")

CreateHackBtn("🚀 FIX LAG (MƯỢT)", function(btn)
    settings().Rendering.QualityLevel = 1
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
    end
    Lighting.GlobalShadows = false
    btn.Text = "ĐÃ TỐI ƯU ✅"
end)

local flying = false
local flySpd = 50
local btnFly = CreateHackBtn("Bay: TẮT", function(btn)
    flying = not flying
    ToggleBtnUI(btn, flying, "Bay")
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if flying and root then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                local hum = player.Character:FindFirstChild("Humanoid")
                if hum then bv.Velocity = hum.MoveDirection * flySpd + Vector3.new(0, workspace.CurrentCamera.CFrame.LookVector.Y * flySpd * hum.MoveDirection.Magnitude, 0) end
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)
CreateAdjuster("Tốc Độ Bay", 50, function(v) flySpd = v end)
