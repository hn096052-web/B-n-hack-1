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
ScreenGui.Name = "H_HUB_JJS_EDITION"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- HÀM TIỆN ÍCH
local function PlayClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6895079853"; sound.Volume = 1; sound.Parent = ScreenGui; sound:Play()
    sound.Ended:Connect(function() sound:Destroy() end)
end

local function ApplySparkleEffect(object)
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    uiGradient.Parent = object
    task.spawn(function()
        while true do TweenService:Create(uiGradient, TweenInfo.new(3, Enum.EasingStyle.Linear), {Rotation = 360}):Play(); task.wait(3) end
    end)
end

-- 3. BẢNG CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 520); MainFrame.Position = UDim2.new(0.5, -225, 0.5, -260); MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); MainFrame.Active = true; MainFrame.Draggable = true; MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
ApplySparkleEffect(MainFrame)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 90, 1, -20); Sidebar.Position = UDim2.new(0, 10, 0, 10); Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar)
local SideLayout = Instance.new("UIListLayout"); SideLayout.Parent = Sidebar; SideLayout.Padding = UDim.new(0, 15); SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -120, 1, -20); Container.Position = UDim2.new(0, 110, 0, 10); Container.BackgroundTransparency = 1; Container.Parent = MainFrame

-- 4. HÀM TẠO NHẬN DIỆN (USER CARD)
local function CreateUserCard(parent)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0.95, 0, 0, 65); card.BackgroundColor3 = Color3.fromRGB(30, 30, 30); card.Parent = parent
    Instance.new("UICorner", card)
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 45, 0, 45); avatar.Position = UDim2.new(0, 10, 0.5, -22.5); avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=150&h=150"; avatar.Parent = card
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
    local n = Instance.new("TextLabel")
    n.Text = player.DisplayName; n.Size = UDim2.new(1, -65, 0, 20); n.Position = UDim2.new(0, 60, 0.2, 0); n.TextColor3 = Color3.new(1, 1, 1); n.Font = Enum.Font.SourceSansBold; n.BackgroundTransparency = 1; n.TextXAlignment = Enum.TextXAlignment.Left; n.Parent = card
    local id = Instance.new("TextLabel")
    id.Text = "@"..player.Name; id.Size = UDim2.new(1, -65, 0, 20); id.Position = UDim2.new(0, 60, 0.55, 0); id.TextColor3 = Color3.fromRGB(150, 150, 150); id.Font = Enum.Font.SourceSans; id.BackgroundTransparency = 1; id.TextXAlignment = Enum.TextXAlignment.Left; id.Parent = card
end

-- 5. HÀM TẠO TAB
local function CreateTab()
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, 0, 1, 0); scroll.BackgroundTransparency = 1; scroll.Visible = false; scroll.CanvasSize = UDim2.new(0, 0, 3, 0); scroll.ScrollBarThickness = 2; scroll.Parent = Container
    local layout = Instance.new("UIListLayout"); layout.Parent = scroll; layout.Padding = UDim.new(0, 12); layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    return scroll
end
local TabJJS = CreateTab(); local TabPlayer = CreateTab(); local TabEsp = CreateTab(); local TabSys = CreateTab()

local function CreateSideBtn(txt, tab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 75, 0, 45); btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.Parent = Sidebar
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() PlayClickSound(); TabJJS.Visible = false; TabPlayer.Visible = false; TabEsp.Visible = false; TabSys.Visible = false; tab.Visible = true end)
end
CreateSideBtn("JJS", TabJJS); CreateSideBtn("MAIN", TabPlayer); CreateSideBtn("ESP", TabEsp); CreateSideBtn("SYS", TabSys)

-- 6. HÀM TẠO TÍNH NĂNG
local function CreateCategory(name, parent)
    local lab = Instance.new("TextLabel")
    lab.Size = UDim2.new(0.9, 0, 0, 30); lab.Text = "── " .. name .. " ──"; lab.TextColor3 = Color3.fromRGB(255, 255, 255); lab.Font = Enum.Font.SourceSansItalic; lab.BackgroundTransparency = 1; lab.Parent = parent
end

local function CreateToggle(txt, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40); btn.Text = txt .. ": TẮT"; btn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); btn.TextColor3 = Color3.new(1, 1, 1); btn.Font = Enum.Font.SourceSansBold; btn.Parent = parent
    Instance.new("UICorner", btn)
    local state = false
    btn.MouseButton1Click:Connect(function()
        PlayClickSound(); state = not state
        btn.Text = txt .. (state and ": BẬT" or ": TẮT")
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(200, 50, 50)
        callback(state)
    end)
end

-- 7. TÍNH NĂNG ĐẶC BIỆT JJS
CreateCategory("JJS COMBAT", TabJJS)

CreateToggle("Auto Parry (Đỡ đòn)", TabJJS, function(state)
    _G.AutoParry = state
    task.spawn(function()
        while _G.AutoParry do
            -- Logic: Kiểm tra nếu có đòn đánh gần thì gửi RemoteEvent block
            -- Lưu ý: Đây là code mẫu, cần mapping đúng Remote của game JJS
            task.wait(0.1)
        end
    end)
end)

CreateToggle("Kill Aura (Tầm gần)", TabJJS, function(state)
    _G.KillAura = state
    task.spawn(function()
        while _G.KillAura do
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < 15 then
                        -- Gửi sự kiện tấn công ở đây
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end)

CreateToggle("No Cooldown (Giảm hồi chiêu)", TabJJS, function(state)
    -- Logic JJS thường nằm trong local script, phần này cần bypass cụ thể hơn
    print("No Cooldown: " .. tostring(state))
end)
CreateUserCard(TabJJS)

-- 8. TÍNH NĂNG NGƯỜI CHƠI (TỪ CÁC BẢN TRƯỚC)
CreateCategory("MOVEMENT", TabPlayer)
CreateToggle("Nhảy Vô Hạn", TabPlayer, function(state) _G.InfJ = state end)
UserInputService.JumpRequest:Connect(function() if _G.InfJ then player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping") end end)

CreateToggle("Xuyên Tường", TabPlayer, function(state) _G.Noc = state end)
RunService.Stepped:Connect(function() if _G.Noc and player.Character then for _, v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end end)

CreateToggle("Bay", TabPlayer, function(state)
    _G.Fly = state; local root = player.Character.HumanoidRootPart
    if state then
        local bv = Instance.new("BodyVelocity", root); bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        task.spawn(function()
            while _G.Fly do 
                bv.Velocity = player.Character.Humanoid.MoveDirection * 50 + Vector3.new(0, workspace.CurrentCamera.CFrame.LookVector.Y * 50, 0)
                task.wait() 
            end; bv:Destroy()
        end)
    end
end)
CreateUserCard(TabPlayer)

-- 9. ESP & HỆ THỐNG
CreateCategory("VISUALS", TabEsp)
CreateToggle("ESP Người Chơi", TabEsp, function(state)
    _G.Esp = state
    if not state then 
        for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character.Head:FindFirstChild("H_ESP") then p.Character.Head.H_ESP:Destroy() end end
    end
end)
RunService.RenderStepped:Connect(function()
    if _G.Esp then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                if not p.Character.Head:FindFirstChild("H_ESP") then
                    local b = Instance.new("BillboardGui", p.Character.Head); b.Name = "H_ESP"; b.AlwaysOnTop = true; b.Size = UDim2.new(0, 100, 0, 50)
                    local t = Instance.new("TextLabel", b); t.Size = UDim2.new(1, 0, 1, 0); t.BackgroundTransparency = 1; t.Text = p.DisplayName; t.TextColor3 = Color3.new(1, 1, 1); t.Font = Enum.Font.SourceSansBold
                end
            end
        end
    end
end)
CreateUserCard(TabEsp)

CreateCategory("SYSTEM", TabSys)
CreateToggle("🚀 Fix Lag", TabSys, function(state)
    if state then settings().Rendering.QualityLevel = 1; Lighting.GlobalShadows = false end
end)
CreateUserCard(TabSys)

-- MẶC ĐỊNH MỞ TAB JJS
TabJJS.Visible = true
