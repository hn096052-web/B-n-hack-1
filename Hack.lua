-- 1. KHỞI TẠO DỊCH VỤ
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- 2. TẠO SCREEN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumHackerHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- 3. HIỆU ỨNG LẤP LÁNH (Rainbow Glow Function)
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

-- 4. BẢNG ĐIỀU KHIỂN CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 400)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
ApplySparkleEffect(MainFrame)

local ContentFolder = Instance.new("ScrollingFrame") -- Chứa các nút chức năng
ContentFolder.Size = UDim2.new(1, 0, 1, -40)
ContentFolder.Position = UDim2.new(0, 0, 0, 40)
ContentFolder.BackgroundTransparency = 1
ContentFolder.CanvasSize = UDim2.new(0, 0, 1.5, 0)
ContentFolder.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = ContentFolder
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0, 10)

-- 5. THANH TIÊU ĐỀ & CÁC NÚT HỆ THỐNG (-, [], X)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Text = "HACKER HUB"
TitleText.Size = UDim2.new(0.5, 0, 1, 0)
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Parent = TitleBar

-- Nút Thu Nhỏ (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -95, 0, 2)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Parent = TitleBar

-- Nút Mở Rộng ([])
local MaxBtn = Instance.new("TextButton")
MaxBtn.Text = "⬜"
MaxBtn.Size = UDim2.new(0, 30, 0, 30)
MaxBtn.Position = UDim2.new(1, -65, 0, 2)
MaxBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MaxBtn.TextColor3 = Color3.new(1, 1, 1)
MaxBtn.Parent = TitleBar

-- Nút Đóng (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "×"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 2)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Parent = TitleBar

-- 6. TẠO NÚT H (KHI THU NHỎ)
local H_Button = Instance.new("TextButton")
H_Button.Size = UDim2.new(0, 60, 0, 60)
H_Button.Position = UDim2.new(0.5, -30, 0.5, -30)
H_Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
H_Button.Text = "H"
H_Button.TextColor3 = Color3.new(1, 1, 1)
H_Button.TextSize = 30
H_Button.Visible = false
H_Button.Parent = ScreenGui
ApplySparkleEffect(H_Button)

-- 7. BẢNG XÁC NHẬN TẮT
local ConfirmFrame = Instance.new("Frame")
ConfirmFrame.Size = UDim2.new(0, 250, 0, 120)
ConfirmFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
ConfirmFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ConfirmFrame.Visible = false
ConfirmFrame.Parent = ScreenGui
ApplySparkleEffect(ConfirmFrame)

local ConfirmText = Instance.new("TextLabel")
ConfirmText.Text = "Bạn có chắc chắn muốn tắt bảng không?"
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

-- 8. XỬ LÝ LOGIC NÚT HỆ THỐNG
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    H_Button.Visible = true
end)

H_Button.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    H_Button.Visible = false
end)

local isWide = false
MaxBtn.MouseButton1Click:Connect(function()
    isWide = not isWide
    MainFrame.Size = isWide and UDim2.new(0, 400, 0, 400) or UDim2.new(0, 220, 0, 400)
    MainFrame.Position = isWide and UDim2.new(0.5, -200, 0.5, -200) or UDim2.new(0.5, -110, 0.5, -200)
end)

CloseBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = true
end)

BackBtn.MouseButton1Click:Connect(function()
    ConfirmFrame.Visible = false
end)

ExitBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 9. TÍCH HỢP CÁC TÍNH NĂNG HACK (TỐC ĐỘ, NHẢY, BAY, NOCLIP, TÀNG HÌNH)
local function CreateHackButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Parent = ContentFolder
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Tốc độ
CreateHackButton("Tốc độ +", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed += 10 end)
CreateHackButton("Tốc độ -", function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed -= 10 end)

-- Sức nhảy
CreateHackButton("Nhảy cao +", function() 
    game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
    game.Players.LocalPlayer.Character.Humanoid.JumpPower += 10 
end)

-- Bay (Mobile Fly Logic)
local flying = false
local flySpeed = 50
local flyBtn = CreateHackButton("Bật Bay", function() end)

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    if flying then
        flyBtn.Text = "Đang Bay (Bật)"
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while flying do
                local moveDir = game.Players.LocalPlayer.Character.Humanoid.MoveDirection
                bv.Velocity = moveDir * flySpeed + Vector3.new(0, workspace.CurrentCamera.CFrame.LookVector.Y * flySpeed * moveDir.Magnitude, 0)
                task.wait()
            end
            bv:Destroy()
        end)
    else
        flyBtn.Text = "Bật Bay"
    end
end)

-- Xuyên tường (Noclip)
local noclip = false
CreateHackButton("Bật Xuyên Tường", function() noclip = not noclip end)
RunService.Stepped:Connect(function()
    if noclip and game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Tàng hình
local invisible = false
CreateHackButton("Bật Tàng Hình", function()
    invisible = not invisible
    for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if (v:IsA("BasePart") or v:IsA("Decal")) and v.Name ~= "HumanoidRootPart" then
            v.Transparency = invisible and 0.8 or 0
        end
    end
end)
