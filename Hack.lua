-- ==========================================
-- H HUB - AUTOFARM & EXPERIMENTAL (FULL + ANTIBAN)
-- ==========================================

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
if not player then return end

local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then return end

-- 1. Dọn GUI cũ
pcall(function()
    local old1 = playerGui:FindFirstChild("AutoFarmHubGui")
    if old1 then old1:Destroy() end
    if typeof(gethui) == "function" then
        local hui = gethui()
        if hui then
            local oldHui1 = hui:FindFirstChild("AutoFarmHubGui")
            if oldHui1 then oldHui1:Destroy() end
        end
    end
end)

-- 2. Tạo ScreenGui An Toàn
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmHubGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local guiParent = playerGui
pcall(function()
    if typeof(gethui) == "function" then
        local hui = gethui()
        if hui then guiParent = hui end
    end
end)
screenGui.Parent = guiParent

-- Trạng thái Hệ thống
local tpEnabled = false
local walkEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local invisibleEnabled = false
local flyEnabled = false
local infJumpEnabled = false
local freezeRayEnabled = false
local espEnabled = false
local fpsEnabled = false
local gravityEnabled = false
local autoPressButtonEnabled = false
local fixLagEnabled = false
local hideMapOthersEnabled = false
local muteAllSoundsEnabled = false

-- Trạng thái Antiban & Server Hop mới
local autoServerHopEnabled = false
local adminDetectorEnabled = true

-- Spectate & Camera View State
local spectating = false
local spectateIndex = 1
local spectateConnection = nil
local currentCameraMode = "Default"
local cameraViewConnection = nil

-- Cấu hình mặc định
local tpSpeed = 0.15
local walkSpeed = 35
local jumpPower = 75
local flySpeed = 100
local customGravity = 196.2
local coinName = "Coin"
local freezeRadius = 150
local autoPressRadius = 15
local autoPressDelay = 0.1
local FREEZE_COOLDOWN = 6
local SHOT_DELAY = 1
local selectedTargetPlayer = nil

local selectedEspTarget = "Tất cả"
local espColor = Color3.fromRGB(255, 0, 0)
local currentThemeColor = Color3.fromRGB(35, 35, 45)
local currentTextColor = Color3.fromRGB(255, 255, 255)
local frozenPlayersTable = {}
local currentLang = "VI"

local themeButtons = {}
local textElements = {}
local GLOBAL_FONT = Enum.Font.GothamBold

local translations = {
    EN = {
        title = "H HUB - AutoFarm",
        tabMain = "Main", tabEsp = "Players/ESP", tabMisc = "Settings", tabFixLag = "Fix Lag", tabExperimental = "Experimental",
        tpSpd = "TP Speed (s):", walkSpd = "Walk Speed:", flySpd = "Fly Speed:",
        jumpSpd = "Jump Power:", gravSpd = "Gravity:", freezeRng = "Freeze Range:",
        clickDelayLabel = "Click Delay (s):", targetBtn = "Target: ", allTarget = "All",
        tpBtn = "Auto TP Coins", walkBtn = "Custom Speed", jumpBtn = "Custom Jump",
        flyBtn = "Fly Mode", gravBtn = "Custom Gravity", noclipBtn = "Noclip Pass-Wall",
        invisBtn = "Invisibility", infJumpBtn = "Infinite Jump", freezeBtn = "Auto Freeze Ray",
        autoEquipBtn = "Equip Items (Run Once)", godBtn = "⚡ Open God Mode Panel",
        espBtn = "ESP Wallhack", fpsBtn = "Display FPS",
        autoPressRadiusLabel = "Click Button Range:", autoPressDelayLabel = "Click Button Delay (s):",
        autoPressBtn = "Auto Click Buttons", fixLagBtn = "Ultra Fix Lag (Max FPS)",
        hideMapBtn = "Hide Map & Players", muteSoundsBtn = "Mute Game Sounds",
        espColorLabel = "ESP Highlight Color:", boardColorLabel = "Board Background Color:",
        themeLabel = "UI Button Color:", textLabel = "UI Text Color:", langLabel = "Language:",
        rejoinBtn = "Rejoin Server", serverHopBtn = "Server Hop", on = "ON", off = "OFF",
        specBtnToggle = "👁️ Spectate Mode", cameraViewLabel = "Camera View Angle:",
        autoHopBtn = "Auto Server Hop (20m)", adminDetectBtn = "Anti-Admin Detector"
    },
    VI = {
        title = "H HUB - AutoFarm",
        tabMain = "Chính", tabEsp = "Người chơi/ESP", tabMisc = "Cài đặt", tabFixLag = "Fix Lag", tabExperimental = "Thử nghiệm",
        tpSpd = "Tốc độ TP (giây):", walkSpd = "Tốc độ Đi bộ:", flySpd = "Tốc độ Bay:",
        jumpSpd = "Độ Cao Nhảy:", gravSpd = "Trọng Lực Game:", freezeRng = "Khoảng cách Freeze:",
        clickDelayLabel = "Tốc độ Click (giây):", targetBtn = "Mục tiêu: ", allTarget = "Tất cả",
        tpBtn = "Auto TP Nhặt Xu", walkBtn = "Chỉnh Tốc Độ Đi", jumpBtn = "Chỉnh Độ Nhảy",
        flyBtn = "Chế Độ Bay", gravBtn = "Trọng Lực Tùy Chỉnh", noclipBtn = "Đi Xuyên Tường (Noclip)",
        invisBtn = "Tàng Hình Nhìn Thấy", infJumpBtn = "Nhảy Vô Hạn",
        freezeBtn = "Tự Động Freeze Ray", autoEquipBtn = "Trang Bị Đồ (Nhấn 1 Lần)",
        godBtn = "⚡ Bảng God Mode (Bất Tử)", espBtn = "ESP Nhìn Xuyên Tường",
        fpsBtn = "Hiển Thị FPS", autoPressRadiusLabel = "Bán kính Click Nút:",
        autoPressDelayLabel = "Tốc độ Click Nút (s):", autoPressBtn = "Auto Click Nút",
        fixLagBtn = "Siêu Giảm Lag (Max FPS)", hideMapBtn = "Ẩn Bản Đồ & Người Khác",
        muteSoundsBtn = "Tắt Âm Thanh Game", espColorLabel = "Màu ESP Xuyên Tường:",
        boardColorLabel = "Màu Bảng Điều Khiển:", themeLabel = "Màu Nút Giao Diện:",
        textLabel = "Màu Chữ Giao Diện:", langLabel = "Ngôn ngữ / Language:",
        rejoinBtn = "Vào Lại Server", serverHopBtn = "Đổi Server Khác", on = "BẬT", off = "TẮT",
        specBtnToggle = "👁️ Chế Độ Spectate", cameraViewLabel = "Chỉnh Góc Nhìn Camera:",
        autoHopBtn = "Tự Động Đổi Server (20p)", adminDetectBtn = "Phát Hiện Admin (Antiban)"
    }
}

-- ==========================================
-- HỆ THỐNG SERVER HOP & ANTIBAN THÔNG MINH
-- ==========================================

local function serverHopFiltered()
    task.spawn(function()
        local placeId = game.PlaceId
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
        local ok, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
        if ok and result and result.data then
            for _, server in ipairs(result.data) do
                -- Lọc server khác JobId hiện tại và có từ 5 người trở lên
                if server.id ~= game.JobId and server.playing >= 5 and server.playing < server.maxPlayers then
                    pcall(function() TeleportService:TeleportToPlaceInstance(placeId, server.id, player) end)
                    return
                end
            end
        end
        -- Nếu không tìm thấy server >= 5 người, fallback về server bất kỳ
        pcall(function() TeleportService:Teleport(placeId, player) end)
    end)
end

-- Tạo bảng Popup Thông Báo Antiban / Server Hop
local alertPopup = Instance.new("Frame")
alertPopup.Size = UDim2.fromOffset(320, 140)
alertPopup.Position = UDim2.new(0.5, -160, 0.3, -70)
alertPopup.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
alertPopup.BorderSizePixel = 0
alertPopup.Visible = false
alertPopup.ZIndex = 99999
alertPopup.Parent = screenGui
Instance.new("UICorner", alertPopup).CornerRadius = UDim.new(0, 10)
local alertStroke = Instance.new("UIStroke"); alertStroke.Color = Color3.fromRGB(255, 100, 100); alertStroke.Thickness = 2; alertStroke.Parent = alertPopup

local alertTitle = Instance.new("TextLabel")
alertTitle.Size = UDim2.new(1, 0, 0, 35)
alertTitle.BackgroundTransparency = 1
alertTitle.Text = "⚠️ CẢNH BÁO BẢO MẬT"
alertTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
alertTitle.Font = GLOBAL_FONT
alertTitle.TextSize = 14
alertTitle.Parent = alertPopup

local alertDesc = Instance.new("TextLabel")
alertDesc.Size = UDim2.new(1, -20, 0, 50)
alertDesc.Position = UDim2.new(0, 10, 0, 35)
alertDesc.BackgroundTransparency = 1
alertDesc.Text = "Sắp tiến hành chuyển server..."
alertDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
alertDesc.Font = GLOBAL_FONT
alertDesc.TextSize = 12
alertDesc.TextWrapped = true
alertDesc.Parent = alertPopup

local btnNow = Instance.new("TextButton")
btnNow.Size = UDim2.new(0, 135, 0, 30)
btnNow.Position = UDim2.new(0, 15, 1, -40)
btnNow.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
btnNow.Text = "Chuyển ngay"
btnNow.TextColor3 = Color3.fromRGB(255, 255, 255)
btnNow.Font = GLOBAL_FONT
btnNow.TextSize = 12
btnNow.Parent = alertPopup
Instance.new("UICorner", btnNow).CornerRadius = UDim.new(0, 6)

local btnIgnore = Instance.new("TextButton")
btnIgnore.Size = UDim2.new(0, 135, 0, 30)
btnIgnore.Position = UDim2.new(1, -150, 1, -40)
btnIgnore.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
btnIgnore.Text = "Kệ"
btnIgnore.TextColor3 = Color3.fromRGB(255, 255, 255)
btnIgnore.Font = GLOBAL_FONT
btnIgnore.TextSize = 12
btnIgnore.Parent = alertPopup
Instance.new("UICorner", btnIgnore).CornerRadius = UDim.new(0, 6)

local alertActiveAction = nil
btnNow.MouseButton1Click:Connect(function()
    alertPopup.Visible = false
    if alertActiveAction then alertActiveAction() end
end)
btnIgnore.MouseButton1Click:Connect(function()
    alertPopup.Visible = false
end)

local function showAlertPopup(titleTextStr, descTextStr, actionCallback, countdownSec)
    alertTitle.Text = titleTextStr
    alertDesc.Text = descTextStr
    alertActiveAction = actionCallback
    alertPopup.Visible = true

    if countdownSec then
        task.spawn(function()
            for i = countdownSec, 1, -1 do
                if not alertPopup.Visible then break end
                alertDesc.Text = descTextStr .. " (" .. i .. "s)"
                task.wait(1)
            end
            if alertPopup.Visible then
                alertPopup.Visible = false
                if alertActiveAction then alertActiveAction() end
            end
        end)
    end
end

-- 1. Luồng tự động đổi server mỗi 20 phút (30 giây cuối hiện bảng)
task.spawn(function()
    while true do
        -- Đợi 19 phút rưỡi (1170 giây)
        task.wait(1170)
        if autoServerHopEnabled then
            showAlertPopup(
                "⚠️ CHUYỂN SERVER ĐỊNH KỲ",
                "Sắp tiến hành chuyển sang server mới (>= 5 người) để tránh quét bảo mật!",
                serverHopFiltered,
                30
            )
        else
            task.wait(30)
        end
    end
end)

-- 2. Luồng phát hiện Admin / Developer game RNG Fight
local function isAdminOrDev(p)
    if not p then return false end
    -- Kiểm tra Group Role, Game Creator hoặc tên/ID đặc biệt
    local success, isMember = pcall(function() return p:IsInGroup(12000000) end) -- Thay thế hoặc mở rộng nếu game có group riêng
    if success and isMember then return true end

    -- Check quyền đặc biệt hoặc CreatorId của game
    if p.UserId == game.CreatorId then return true end
    
    -- Check các danh xưng Admin phổ biến trong tên hoặc huy hiệu
    local nameLower = p.Name:lower()
    local displayLower = p.DisplayName:lower()
    if nameLower:find("admin") or nameLower:find("owner") or nameLower:find("developer") or
       displayLower:find("admin") or displayLower:find("owner") or displayLower:find("dev") then
        return true
    end
    return false
end

task.spawn(function()
    while true do
        task.wait(5)
        if adminDetectorEnabled then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and isAdminOrDev(p) then
                    showAlertPopup(
                        "🚨 PHÁT HIỆN ADMIN TRONG SERVER!",
                        "Hiện đang có admin (" .. p.Name .. ") trong server tiến hành chuyển đổi bảo mật khẩn cấp...",
                        serverHopFiltered,
                        10
                    )
                    break
                end
            end
        end
    end
end)

-- ==========================================
-- LOGIC HỆ THỐNG KHÁC
-- ==========================================

local function setBackpackVisible(visible)
    pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, visible) end)
end

local allEquipItems = {
    "PieThrow","SmallPotion","GiantPotion","GhostPotion","Healing","GravityPotion",
    "Bloxiade","ClownBomb","Slate","WindPotion","IcePotion","Caltrops","SlowDownGun",
    "GravityGun","GravityDisruptor","FreezeRay","Bomb","Jetpack","DecoyDeploy",
    "AprilShowers","Balloon","MarchingDrum","Trumpet","Trowel","TeapotLauncher",
    "BunchOfBalloons","BangGun","EpicJuice","EpicSauce","Ball","Torch","Cake",
    "MoneyBag","IceCreamCone","Teddy","Witch","Watermelon","Taco","Bloxy","Pizza","Coco"
}

local function equipItemsOnce()
    task.spawn(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local equipEvent = ReplicatedStorage:WaitForChild("Equip", 5)
        if not equipEvent then return end
        for _, item in ipairs(allEquipItems) do
            pcall(function() equipEvent:FireServer("UNEQUIP", item) end)
            task.wait(0.03)
        end
        task.wait(0.2)
        for _, item in ipairs(allEquipItems) do
            pcall(function() equipEvent:FireServer("EQUIP", item) end)
            task.wait(0.03)
        end
    end)
end

local function applyMuteToSound(sound)
    if not muteAllSoundsEnabled then return end
    pcall(function()
        if sound:IsA("Sound") then
            if mutedSounds[sound] == nil then mutedSounds[sound] = sound.Volume end
            sound.Volume = 0
        end
    end)
end

local function toggleMuteAllSounds(state)
    muteAllSoundsEnabled = state
    if state then
        for _, v in ipairs(game:GetDescendants()) do applyMuteToSound(v) end
        if not muteSoundsConnection then
            muteSoundsConnection = game.DescendantAdded:Connect(function(v)
                if muteAllSoundsEnabled then applyMuteToSound(v) end
            end)
        end
    else
        if muteSoundsConnection then muteSoundsConnection:Disconnect(); muteSoundsConnection = nil end
        for sound, origVol in pairs(mutedSounds) do
            if sound and sound.Parent then pcall(function() sound.Volume = origVol end) end
        end
        mutedSounds = {}
    end
end

local function isMySelfOrItem(obj)
    local char = player.Character
    if char and (obj == char or obj:IsDescendantOf(char)) then return true end
    local backpack = player:FindFirstChild("Backpack")
    if backpack and (obj == backpack or obj:IsDescendantOf(backpack)) then return true end
    return obj:IsA("Sky") or obj:IsA("Atmosphere") or obj:IsA("SunRaysEffect") or obj:IsA("BloomEffect")
end

local function applyHideToObject(v)
    if not hideMapOthersEnabled or isMySelfOrItem(v) then return end
    pcall(function()
        if v:IsA("BasePart") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.LocalTransparencyModifier end
            v.LocalTransparencyModifier = 1
        elseif v:IsA("Decal") or v:IsA("Texture") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.Transparency end
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
            or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.Enabled end
            v.Enabled = false
        end
    end)
end

local hiddenObjects = {}
local mutedSounds = {}

local function toggleHideMapAndOthers(state)
    hideMapOthersEnabled = state
    if state then
        for _, v in ipairs(Workspace:GetDescendants()) do applyHideToObject(v) end
        if not hideMapConnection then
            hideMapConnection = Workspace.DescendantAdded:Connect(function(v)
                if hideMapOthersEnabled then applyHideToObject(v) end
            end)
        end
    else
        if hideMapConnection then hideMapConnection:Disconnect(); hideMapConnection = nil end
        for obj, originalVal in pairs(hiddenObjects) do
            if obj and obj.Parent then
                pcall(function()
                    if obj:IsA("BasePart") then obj.LocalTransparencyModifier = originalVal
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = originalVal
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke")
                        or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("BillboardGui")
                        or obj:IsA("SurfaceGui") then
                        obj.Enabled = originalVal
                    end
                end)
            end
        end
        hiddenObjects = {}
    end
end

local function optimizePartExtreme(v)
    if not fixLagEnabled then return end
    pcall(function()
        if v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0; v.CastShadow = false; v.TextureID = ""
        elseif v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0; v.CastShadow = false
        elseif v:IsA("SpecialMesh") then
            v.TextureId = ""
        elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") then
            v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke")
            or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then
            v.Enabled = false
        elseif v:IsA("PostEffect") then
            v.Enabled = false
        elseif v:IsA("Explosion") then
            pcall(function() v.Visible = false end)
        end
    end)
end

local fixLagChildConnection, fixLagTask, hideMapConnection, muteSoundsConnection
local function toggleFixLag(state)
    fixLagEnabled = state
    if state then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9; Lighting.FogStart = 9e9
            Lighting.Brightness = 1
            Lighting.Technology = Enum.Technology.Compatibility
            local terrain = Workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0; terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0; terrain.WaterTransparency = 0; terrain.Decoration = false
            end
        end)
        for _, v in ipairs(game:GetDescendants()) do optimizePartExtreme(v) end
        if not fixLagChildConnection then
            fixLagChildConnection = game.DescendantAdded:Connect(function(v)
                if fixLagEnabled then optimizePartExtreme(v) end
            end)
        end
        if not fixLagTask then
            fixLagTask = task.spawn(function()
                while fixLagEnabled do
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if not fixLagEnabled then break end
                        optimizePartExtreme(v)
                    end
                    task.wait(2)
                end
            end)
        end
    else
        if fixLagChildConnection then fixLagChildConnection:Disconnect(); fixLagChildConnection = nil end
        if fixLagTask then task.cancel(fixLagTask); fixLagTask = nil end
    end
end

local function rejoinServer()
    pcall(function()
        if #Players:GetPlayers() <= 1 then
            TeleportService:Teleport(game.PlaceId, player)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
        end
    end)
end

local autoPressButtonTask
local function toggleAutoPressButton(state)
    autoPressButtonEnabled = state
    if state then
        if not autoPressButtonTask then
            autoPressButtonTask = task.spawn(function()
                while autoPressButtonEnabled do
                    pcall(function()
                        local char = player.Character
                        local root = char and char:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, v in ipairs(Workspace:GetDescendants()) do
                                if not autoPressButtonEnabled then break end
                                local pos
                                if v:IsA("BasePart") then pos = v.Position
                                elseif v:IsA("PVInstance") then pos = v:GetPivot().Position
                                elseif v.Parent and v.Parent:IsA("BasePart") then pos = v.Parent.Position end
                                
                                if pos and (root.Position - pos).Magnitude <= autoPressRadius then
                                    if v:IsA("ClickDetector") and fireclickdetector then fireclickdetector(v)
                                    elseif v:IsA("ProximityPrompt") and fireproximityprompt then fireproximityprompt(v) end
                                end
                            end
                        end
                    end)
                    task.wait(math.max(autoPressDelay, 0.05))
                end
            end)
        end
    elseif autoPressButtonTask then
        task.cancel(autoPressButtonTask); autoPressButtonTask = nil
    end
end

local noclipConnection, originalHipHeight
local function toggleNoclip(state)
    noclipEnabled = state
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if state then
        if humanoid and not originalHipHeight then
            originalHipHeight = humanoid.HipHeight
            humanoid.HipHeight = originalHipHeight + 0.5
        end
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(function()
                local char = player.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        end
    else
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        if humanoid and originalHipHeight then
            humanoid.HipHeight = originalHipHeight; originalHipHeight = nil
        end
    end
end

local invisibleConnection, savedTransparencies = nil, {}
local function toggleInvisibility(state)
    invisibleEnabled = state
    local character = player.Character
    if not character then return end
    if state then
        savedTransparencies = {}
        if not invisibleConnection then
            invisibleConnection = RunService.RenderStepped:Connect(function()
                local char = player.Character
                if char then
                    for _, child in ipairs(char:GetDescendants()) do
                        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                            if savedTransparencies[child] == nil then savedTransparencies[child] = child.Transparency end
                            child.Transparency = 1
                        elseif child:IsA("Decal") or child:IsA("Texture") then
                            if savedTransparencies[child] == nil then savedTransparencies[child] = child.Transparency end
                            child.Transparency = 1
                        elseif child:IsA("BillboardGui") or child:IsA("SurfaceGui") then child.Enabled = false end
                    end
                end
            end)
        end
    elseif invisibleConnection then
        invisibleConnection:Disconnect(); invisibleConnection = nil
        for child, transp in pairs(savedTransparencies) do
            if child and child.Parent then child.Transparency = transp end
        end
        savedTransparencies = {}
    end
end

local flyConnection
local function toggleFly(state)
    flyEnabled = state
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if state then
        if not rootPart or not humanoid then return end
        humanoid.PlatformStand = true
        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"; bg.P = 9e4; bg.MaxTorque = Vector3.new(9e4, 9e4, 9e4); bg.CFrame = rootPart.CFrame; bg.Parent = rootPart
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"; bv.Velocity = Vector3.zero; bv.MaxForce = Vector3.new(9e4, 9e4, 9e4); bv.Parent = rootPart
        
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled or not character.Parent then
                if bg.Parent then bg:Destroy() end
                if bv.Parent then bv:Destroy() end
                return
            end
            local cam = Workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 and cam then
                bv.Velocity = moveDir * flySpeed
            else
                bv.Velocity = Vector3.zero
            end
            bg.CFrame = cam and cam.CFrame or rootPart.CFrame
        end)
    else
        if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
        if rootPart then
            local bg = rootPart:FindFirstChild("FlyGyro")
            local bv = rootPart:FindFirstChild("FlyVelocity")
            if bg then bg:Destroy() end
            if bv then bv:Destroy() end
        end
        if humanoid then humanoid.PlatformStand = false end
    end
end

local infJumpConnection
local function toggleInfJump(state)
    infJumpEnabled = state
    if state then
        if not infJumpConnection then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                if infJumpEnabled then
                    local character = player.Character
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end)
        end
    elseif infJumpConnection then
        infJumpConnection:Disconnect(); infJumpConnection = nil
    end
end

local function createHighlight(character, targetPlayer)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if head and not head:FindFirstChild("H_HUB_NameESP") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "H_HUB_NameESP"; billboard.Adornee = head; billboard.Size = UDim2.fromOffset(150, 30); billboard.StudsOffset = Vector3.new(0, 2.5, 0); billboard.AlwaysOnTop = true
        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(1, 1); label.BackgroundTransparency = 1; label.Text = targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")"
        label.TextColor3 = espColor; label.TextStrokeTransparency = 0; label.TextStrokeColor3 = Color3.new(0, 0, 0); label.TextScaled = true; label.Font = GLOBAL_FONT; label.Parent = billboard
        billboard.Parent = head
    end
    local highlight = character:FindFirstChild("H_HUB_ESP")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "H_HUB_ESP"; highlight.Adornee = character; highlight.FillTransparency = 0.5; highlight.OutlineColor = Color3.new(1, 1, 1); highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; highlight.Parent = character
    end
    highlight.FillColor = espColor
end

local function removeHighlight(character)
    if not character then return end
    local h = character:FindFirstChild("H_HUB_ESP")
    if h then h:Destroy() end
    local head = character:FindFirstChild("Head")
    local n = head and head:FindFirstChild("H_HUB_NameESP")
    if n then n:Destroy() end
end

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then removeHighlight(p.Character) end
    end
    if not espEnabled then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            if selectedEspTarget == "Tất cả" or p.Name == selectedEspTarget or p.DisplayName == selectedEspTarget then
                createHighlight(p.Character, p)
            end
        end
    end
end

local function isPlayerInCooldown(targetPlayer)
    if not targetPlayer then return true end
    return (tick() - (frozenPlayersTable[targetPlayer] or 0)) < FREEZE_COOLDOWN
end

local function getDirectTarget()
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil, nil end
    if selectedTargetPlayer and selectedTargetPlayer.Parent then
        if isPlayerInCooldown(selectedTargetPlayer) then return nil, nil end
        local tc = selectedTargetPlayer.Character
        local tr = tc and (tc:FindFirstChild("HumanoidRootPart") or tc:FindFirstChild("Torso"))
        if tr and (tr.Position - root.Position).Magnitude <= freezeRadius then return tr, selectedTargetPlayer end
        return nil, nil
    end
    local closest, closestPlayer, shortest = nil, nil, freezeRadius
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and not isPlayerInCooldown(p) then
            local tc = p.Character
            local tr = tc and (tc:FindFirstChild("HumanoidRootPart") or tc:FindFirstChild("Torso"))
            if tr then
                local d = (tr.Position - root.Position).Magnitude
                if d <= shortest then closest, closestPlayer, shortest = tr, p, d end
            end
        end
    end
    return closest, closestPlayer
end

local freezeRayTask
local function toggleFreezeRay(state)
    freezeRayEnabled = state
    if state then
        if not freezeRayTask then
            freezeRayTask = task.spawn(function()
                while freezeRayEnabled do
                    local targetPart, targetPlayerObj = getDirectTarget()
                    if targetPart and targetPlayerObj then
                        local char = player.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        local backpack = player:FindFirstChild("Backpack")
                        local tool = char and char:FindFirstChild("FreezeRay") or (backpack and backpack:FindFirstChild("FreezeRay"))
                        if tool and hum then
                            if tool.Parent == backpack then hum:EquipTool(tool) end
                            local event = tool:FindFirstChild("FireEvent") or tool:FindFirstChild("RemoteEvent")
                            if event then
                                event:FireServer(targetPart.Position, targetPart)
                                frozenPlayersTable[targetPlayerObj] = tick()
                            end
                        end
                    end
                    task.wait(SHOT_DELAY)
                end
            end)
        end
    elseif freezeRayTask then
        task.cancel(freezeRayTask); freezeRayTask = nil
    end
end

local function findAllCoins()
    local coins = {}
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == coinName then
            coins[#coins + 1] = part
        end
    end
    return coins
end

task.spawn(function()
    while task.wait(math.max(tpSpeed, 0.05)) do
        if tpEnabled then
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if char and hum and root then
                for _, coin in ipairs(findAllCoins()) do
                    if not tpEnabled then break end
                    if coin and coin.Parent then
                        root.CFrame = CFrame.new(coin.Position + Vector3.new(0, 1, 0))
                        hum:Move(Vector3.new(1, 0, 0), true)
                        hum.Jump = false
                        task.wait(math.max(tpSpeed, 0.05))
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- GIAO DIỆN CHÍNH (UI)
-- ==========================================

local openUIButton = Instance.new("TextButton")
openUIButton.Name = "OpenHubButton"
openUIButton.Size = UDim2.fromOffset(50, 50)
openUIButton.Position = UDim2.new(0.02, 0, 0.4, 0)
openUIButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
openUIButton.Text = "HUB"
openUIButton.TextColor3 = Color3.new(1, 1, 1)
openUIButton.Font = GLOBAL_FONT
openUIButton.TextSize = 16
openUIButton.Visible = false
openUIButton.Active = true
openUIButton.Draggable = true
openUIButton.ZIndex = 100
openUIButton.Parent = screenGui

local openCorner = Instance.new("UICorner"); openCorner.CornerRadius = UDim.new(1, 0); openCorner.Parent = openUIButton
local openStroke = Instance.new("UIStroke"); openStroke.Thickness = 2; openStroke.Color = Color3.fromRGB(80, 80, 255); openStroke.Parent = openUIButton

local fpsButton = Instance.new("TextButton")
fpsButton.Name = "FPSDisplayButton"
fpsButton.Size = UDim2.fromOffset(85, 32)
fpsButton.Position = UDim2.new(1, -95, 0.1, 0)
fpsButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
fpsButton.Text = "FPS: --"
fpsButton.TextColor3 = Color3.fromRGB(0, 255, 0)
fpsButton.Font = GLOBAL_FONT
fpsButton.TextSize = 14
fpsButton.Visible = false
fpsButton.Active = true
fpsButton.Draggable = true
fpsButton.Parent = screenGui
local fc = Instance.new("UICorner"); fc.CornerRadius = UDim.new(0, 6); fc.Parent = fpsButton

local frameCount, lastUpdate = 0, tick()
local fpsConnection
local function toggleFPSDisplay(state)
    fpsEnabled = state
    fpsButton.Visible = state
    if state then
        if not fpsConnection then
            fpsConnection = RunService.RenderStepped:Connect(function()
                frameCount += 1
                local now = tick()
                if now - lastUpdate >= 1 then
                    local fps = math.floor(frameCount / (now - lastUpdate))
                    fpsButton.Text = "FPS: " .. fps
                    fpsButton.TextColor3 = fps <= 15 and Color3.fromRGB(255, 50, 50)
                        or (fps <= 30 and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(50, 255, 50))
                    frameCount, lastUpdate = 0, now
                end
            end)
        end
    elseif fpsConnection then
        fpsConnection:Disconnect(); fpsConnection = nil
    end
end

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.fromOffset(390, 320)
frame.Position = UDim2.new(0.5, -195, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Visible = true
frame.ZIndex = 10
frame.Parent = screenGui

local gradientFrame = Instance.new("UIGradient")
gradientFrame.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(.5, Color3.fromRGB(30, 25, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20))
}
gradientFrame.Parent = frame

local frameCorner = Instance.new("UICorner"); frameCorner.CornerRadius = UDim.new(0, 8); frameCorner.Parent = frame
local frameStroke = Instance.new("UIStroke"); frameStroke.Thickness = 2; frameStroke.Color = Color3.fromRGB(60, 60, 100); frameStroke.Transparency = 0.4; frameStroke.Parent = frame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.BackgroundTransparency = .2
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 20
titleBar.Parent = frame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = currentTextColor
titleText.Font = GLOBAL_FONT
titleText.TextSize = 15
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 21
titleText.Parent = titleBar
table.insert(textElements, titleText)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.fromOffset(28, 22)
minimizeButton.Position = UDim2.new(1, -62, 0, 6)
minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.Font = GLOBAL_FONT; minimizeButton.TextSize = 20; minimizeButton.ZIndex = 22; minimizeButton.Parent = titleBar
local minCorner = Instance.new("UICorner"); minCorner.CornerRadius = UDim.new(0, 4); minCorner.Parent = minimizeButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(28, 22)
closeButton.Position = UDim2.new(1, -30, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = GLOBAL_FONT; closeButton.TextSize = 13; closeButton.ZIndex = 22; closeButton.Parent = titleBar
local closeCorner = Instance.new("UICorner"); closeCorner.CornerRadius = UDim.new(0, 4); closeCorner.Parent = closeButton

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BackgroundTransparency = .35
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 15
sidebar.Parent = frame

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -115, 1, -35)
container.Position = UDim2.new(0, 115, 0, 35)
container.BackgroundTransparency = 1
container.ZIndex = 15
container.Parent = frame

local tabs = {}
local tabNames = {"Main", "ESP", "FixLag", "Misc", "Experimental"}
for _, name in ipairs(tabNames) do
    local scroll = Instance.new("ScrollingFrame")
    scroll.Name = name .. "Tab"
    scroll.Size = UDim2.new(1, -5, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 4
    scroll.CanvasSize = UDim2.new()
    scroll.Visible = false
    scroll.ZIndex = 16
    scroll.Parent = container

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = scroll

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 6); pad.PaddingBottom = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 2); pad.PaddingRight = UDim.new(0, 6)
    pad.Parent = scroll

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    tabs[name] = scroll
end

local function updateButtonVisual(btn, isOn)
    btn.BackgroundColor3 = isOn and Color3.fromRGB(45, 160, 85) or currentThemeColor
end

local function applyThemeColor(color)
    currentThemeColor = color
    for _, btn in ipairs(themeButtons) do
        if btn and btn.Parent and not btn:GetAttribute("IsOnState") then
            btn.BackgroundColor3 = color
        end
    end
end

local function applyBoardColor(baseColor)
    local r, g, b = baseColor.R * 255, baseColor.G * 255, baseColor.B * 255
    local dark = Color3.fromRGB(math.clamp(r - 15, 0, 255), math.clamp(g - 15, 0, 255), math.clamp(b - 15, 0, 255))
    local light = Color3.fromRGB(math.clamp(r + 10, 0, 255), math.clamp(g + 10, 0, 255), math.clamp(b + 10, 0, 255))
    gradientFrame.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, dark), ColorSequenceKeypoint.new(.5, light),
        ColorSequenceKeypoint.new(1, dark)
    }
    sidebar.BackgroundColor3 = dark
    titleBar.BackgroundColor3 = Color3.fromRGB(math.clamp(r - 20, 0, 255), math.clamp(g - 20, 0, 255), math.clamp(b - 20, 0, 255))
end

local function applyTextColor(color)
    currentTextColor = color
    for _, txt in ipairs(textElements) do if txt and txt.Parent then txt.TextColor3 = color end end
end

local function createToggleRow(parent, labelKey, stateBool, callback)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.Parent = parent
    local btn = Instance.new("TextButton"); btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundColor3 = currentThemeColor; btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT; btn.TextSize = 11; btn.Parent = row
    table.insert(themeButtons, btn); table.insert(textElements, btn)
    local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0, 6); cr.Parent = btn
    local function refresh()
        local t = translations[currentLang]
        btn.Text = (t[labelKey] or labelKey) .. (stateBool and " [" .. t.on .. "]" or " [" .. t.off .. "]")
        btn:SetAttribute("IsOnState", stateBool)
        updateButtonVisual(btn, stateBool)
    end
    btn.MouseButton1Click:Connect(function()
        stateBool = not stateBool; refresh(); callback(stateBool)
    end)
    refresh()
    return btn, refresh
end

local function createButtonRow(parent, labelKey, callback)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.Parent = parent
    local btn = Instance.new("TextButton"); btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundColor3 = currentThemeColor; btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT; btn.TextSize = 11; btn.Parent = row
    table.insert(themeButtons, btn); table.insert(textElements, btn)
    local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0, 6); cr.Parent = btn
    local function refresh() btn.Text = translations[currentLang][labelKey] or labelKey end
    refresh(); btn.MouseButton1Click:Connect(callback)
    return btn, refresh
end

local function createInputRow(parent, labelKey, defaultVal, callback)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 30); row.BackgroundTransparency = 1; row.Parent = parent
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(.6, 0, 1, 0)
    lbl.BackgroundTransparency = 1; lbl.TextColor3 = currentTextColor; lbl.Font = GLOBAL_FONT
    lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = row
    table.insert(textElements, lbl)
    local box = Instance.new("TextBox"); box.Size = UDim2.new(.38, 0, 1, 0)
    box.Position = UDim2.new(.62, 0, 0, 0); box.BackgroundColor3 = currentThemeColor
    box.TextColor3 = currentTextColor; box.Font = GLOBAL_FONT; box.TextSize = 11
    box.Text = tostring(defaultVal); box.Parent = row
    table.insert(themeButtons, box); table.insert(textElements, box)
    local cr = Instance.new("UICorner"); cr.CornerRadius = UDim.new(0, 6); cr.Parent = box
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then callback(val) else box.Text = tostring(defaultVal) end
    end)
    local function refresh() lbl.Text = translations[currentLang][labelKey] or labelKey end
    refresh(); return row, refresh
end

local mainTab = tabs.Main; mainTab.Visible = true
local refreshFuncs = {}

local function addToggle(parent, key, state, callback)
    local _, r = createToggleRow(parent, key, state, callback); table.insert(refreshFuncs, r)
end
local function addInput(parent, key, value, callback)
    local _, r = createInputRow(parent, key, value, callback); table.insert(refreshFuncs, r)
end
local function addButton(parent, key, callback)
    local _, r = createButtonRow(parent, key, callback); table.insert(refreshFuncs, r)
end

addInput(mainTab, "tpSpd", tpSpeed, function(v) tpSpeed = v end)
addToggle(mainTab, "tpBtn", tpEnabled, function(v) tpEnabled = v end)
addInput(mainTab, "walkSpd", walkSpeed, function(v)
    walkSpeed = v
    if walkEnabled then
        local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = v end
    end
end)

local walkConnection
addToggle(mainTab, "walkBtn", walkEnabled, function(v)
    walkEnabled = v
    if walkConnection then walkConnection:Disconnect(); walkConnection = nil end
    if v then
        walkConnection = RunService.RenderStepped:Connect(function()
            local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if h then h.WalkSpeed = walkSpeed end
        end)
    else
        local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if h then h.WalkSpeed = 16 end
    end
end)

addInput(mainTab, "jumpSpd", jumpPower, function(v)
    jumpPower = v
    local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if jumpEnabled and h then h.UseJumpPower = true; h.JumpPower = v end
end)

local jumpConnection
addToggle(mainTab, "jumpBtn", jumpEnabled, function(v)
    jumpEnabled = v
    if jumpConnection then jumpConnection:Disconnect(); jumpConnection = nil end
    if v then
        jumpConnection = RunService.RenderStepped:Connect(function()
            local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if h then h.UseJumpPower = true; h.JumpPower = jumpPower end
        end)
    end
end)

addInput(mainTab, "flySpd", flySpeed, function(v) flySpeed = v end)
addToggle(mainTab, "flyBtn", flyEnabled, toggleFly)
addInput(mainTab, "gravSpd", customGravity, function(v) customGravity = v if gravityEnabled then Workspace.Gravity = v end end)

local gravityConnection
addToggle(mainTab, "gravBtn", gravityEnabled, function(v)
    gravityEnabled = v
    if gravityConnection then gravityConnection:Disconnect(); gravityConnection = nil end
    if v then
        gravityConnection = RunService.RenderStepped:Connect(function() Workspace.Gravity = customGravity end)
    else Workspace.Gravity = 196.2 end
end)

addToggle(mainTab, "noclipBtn", noclipEnabled, toggleNoclip)
addToggle(mainTab, "invisBtn", invisibleEnabled, toggleInvisibility)
addToggle(mainTab, "infJumpBtn", infJumpEnabled, toggleInfJump)
addInput(mainTab, "freezeRng", freezeRadius, function(v) freezeRadius = v end)
addToggle(mainTab, "freezeBtn", freezeRayEnabled, toggleFreezeRay)
addButton(mainTab, "autoEquipBtn", equipItemsOnce)
addInput(mainTab, "autoPressRadiusLabel", autoPressRadius, function(v) autoPressRadius = v end)
addInput(mainTab, "autoPressDelayLabel", autoPressDelay, function(v) autoPressDelay = v end)
addToggle(mainTab, "autoPressBtn", autoPressButtonEnabled, toggleAutoPressButton)

local godRow = Instance.new("Frame"); godRow.Size = UDim2.new(1, 0, 0, 36); godRow.BackgroundTransparency = 1; godRow.Parent = mainTab
local godButton = Instance.new("TextButton"); godButton.Size = UDim2.fromScale(1, 1)
godButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40); godButton.TextColor3 = Color3.new(1, 1, 1)
godButton.Font = GLOBAL_FONT; godButton.TextSize = 12; godButton.Parent = godRow
local gc = Instance.new("UICorner"); gc.CornerRadius = UDim.new(0, 6); gc.Parent = godButton
godButton.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))()
    end)
end)

local espTab = tabs.ESP
addToggle(espTab, "espBtn", espEnabled, function(v) espEnabled = v; updateESP() end)
addToggle(espTab, "fpsBtn", fpsEnabled, toggleFPSDisplay)

local espColorLabel = Instance.new("TextLabel"); espColorLabel.Size = UDim2.new(1, 0, 0, 20)
espColorLabel.BackgroundTransparency = 1; espColorLabel.TextColor3 = currentTextColor; espColorLabel.Font = GLOBAL_FONT
espColorLabel.TextSize = 11; espColorLabel.TextXAlignment = Enum.TextXAlignment.Left; espColorLabel.Parent = espTab
table.insert(textElements, espColorLabel)

local espPalette = Instance.new("Frame"); espPalette.Size = UDim2.new(1, 0, 0, 28); espPalette.BackgroundTransparency = 1; espPalette.Parent = espTab
local espColors = {
    Color3.fromRGB(255, 50, 50), Color3.fromRGB(50, 255, 50), Color3.fromRGB(50, 150, 255),
    Color3.fromRGB(255, 255, 50), Color3.fromRGB(255, 50, 255), Color3.fromRGB(255, 255, 255)
}
for i, col in ipairs(espColors) do
    local b = Instance.new("TextButton"); b.Size = UDim2.fromOffset(28, 28); b.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    b.BackgroundColor3 = col; b.Text = ""; b.Parent = espPalette
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = b
    b.MouseButton1Click:Connect(function() espColor = col; updateESP() end)
end

local fixTab = tabs.FixLag
addToggle(fixTab, "fixLagBtn", fixLagEnabled, toggleFixLag)
addToggle(fixTab, "hideMapBtn", hideMapOthersEnabled, toggleHideMapAndOthers)
addToggle(fixTab, "muteSoundsBtn", muteAllSoundsEnabled, toggleMuteAllSounds)

local miscTab = tabs.Misc
local function addLabel(parent, key)
    local l = Instance.new("TextLabel"); l.Size = UDim2.new(1, 0, 0, 18); l.BackgroundTransparency = 1
    l.TextColor3 = currentTextColor; l.Font = GLOBAL_FONT; l.TextSize = 11; l.TextXAlignment = Enum.TextXAlignment.Left; l.Parent = parent
    table.insert(textElements, l)
    local function refresh() l.Text = translations[currentLang][key] or key end
    refresh(); return l, refresh
end
local _, rBoard = addLabel(miscTab, "boardColorLabel"); table.insert(refreshFuncs, rBoard)

local function addPalette(parent, colors, callback)
    local pal = Instance.new("Frame"); pal.Size = UDim2.new(1, 0, 0, 28); pal.BackgroundTransparency = 1; pal.Parent = parent
    for i, col in ipairs(colors) do
        local b = Instance.new("TextButton"); b.Size = UDim2.fromOffset(28, 28); b.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
        b.BackgroundColor3 = col; b.Text = ""; b.Parent = pal
        local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = b
        b.MouseButton1Click:Connect(function() callback(col) end)
    end
end

addPalette(miscTab, {
    Color3.fromRGB(20, 20, 25), Color3.fromRGB(40, 20, 20), Color3.fromRGB(20, 40, 20),
    Color3.fromRGB(20, 25, 40), Color3.fromRGB(40, 30, 20)
}, applyBoardColor)

local _, rTheme = addLabel(miscTab, "themeLabel"); table.insert(refreshFuncs, rTheme)
addPalette(miscTab, {
    Color3.fromRGB(35, 35, 45), Color3.fromRGB(50, 40, 80), Color3.fromRGB(30, 60, 90),
    Color3.fromRGB(70, 30, 40), Color3.fromRGB(30, 70, 50)
}, applyThemeColor)

local _, rText = addLabel(miscTab, "textLabel"); table.insert(refreshFuncs, rText)
addPalette(miscTab, {
    Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 220, 100),
    Color3.fromRGB(100, 255, 200), Color3.fromRGB(255, 150, 200)
}, applyTextColor)

-- Thêm các nút Bật/Tắt Antiban & Server Hop vào tab Misc
addToggle(miscTab, "autoHopBtn", autoServerHopEnabled, function(v) autoServerHopEnabled = v end)
addToggle(miscTab, "adminDetectBtn", adminDetectorEnabled, function(v) adminDetectorEnabled = v end)

local _, rLang = addLabel(miscTab, "langLabel"); table.insert(refreshFuncs, rLang)
local langFrame = Instance.new("Frame"); langFrame.Size = UDim2.new(1, 0, 0, 30); langFrame.BackgroundTransparency = 1; langFrame.Parent = miscTab
local btnEnglish = Instance.new("TextButton"); btnEnglish.Size = UDim2.new(.48, 0, 1, 0); btnEnglish.BackgroundColor3 = currentThemeColor
btnEnglish.TextColor3 = currentTextColor; btnEnglish.Font = GLOBAL_FONT; btnEnglish.TextSize = 11; btnEnglish.Text = "English"; btnEnglish.Parent = langFrame
local btnVietnamese = btnEnglish:Clone(); btnVietnamese.Position = UDim2.new(.52, 0, 0, 0); btnVietnamese.Text = "Tiếng Việt"; btnVietnamese.Parent = langFrame
for _, b in ipairs({btnEnglish, btnVietnamese}) do
    table.insert(themeButtons, b); table.insert(textElements, b)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = b
end

local serverFrame = Instance.new("Frame"); serverFrame.Size = UDim2.new(1, 0, 0, 32); serverFrame.BackgroundTransparency = 1; serverFrame.Parent = miscTab
local rejoinButton = btnEnglish:Clone(); rejoinButton.Size = UDim2.new(.48, 0, 1, 0); rejoinButton.Position = UDim2.new(); rejoinButton.Parent = serverFrame
local serverHopButton = btnVietnamese:Clone(); serverHopButton.Size = UDim2.new(.48, 0, 1, 0); serverHopButton.Position = UDim2.new(.52, 0, 0, 0); serverHopButton.Parent = serverFrame
for _, b in ipairs({rejoinButton, serverHopButton}) do table.insert(themeButtons, b); table.insert(textElements, b) end
rejoinButton.MouseButton1Click:Connect(rejoinServer)
serverHopButton.MouseButton1Click:Connect(serverHopFiltered)

local tabButtons = {}
local tabTextKeys = {Main = "tabMain", ESP = "tabEsp", FixLag = "tabFixLag", Misc = "tabMisc", Experimental = "tabExperimental"}
local y = 10
for i, name in ipairs(tabNames) do
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1, -16, 0, 32); b.Position = UDim2.new(0, 8, 0, y)
    b.BackgroundColor3 = i == 1 and Color3.fromRGB(70, 70, 90) or Color3.fromRGB(30, 30, 40)
    b.TextColor3 = currentTextColor; b.Font = GLOBAL_FONT; b.TextSize = 11; b.Parent = sidebar
    table.insert(textElements, b)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = b
    b.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, other in pairs(tabButtons) do other.BackgroundColor3 = Color3.fromRGB(30, 30, 40) end
        tabs[name].Visible = true; b.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    end)
    tabButtons[name] = b; y += 40
end

local function updateLanguage()
    local t = translations[currentLang]
    titleText.Text = t.title; godButton.Text = t.godBtn
    espColorLabel.Text = t.espColorLabel
    for _, rf in ipairs(refreshFuncs) do rf() end
    rejoinButton.Text = t.rejoinBtn; serverHopButton.Text = t.serverHopBtn
    for name, key in pairs(tabTextKeys) do tabButtons[name].Text = t[key] end
end

btnEnglish.MouseButton1Click:Connect(function() currentLang = "EN"; updateLanguage() end)
btnVietnamese.MouseButton1Click:Connect(function() currentLang = "VI"; updateLanguage() end)

-- ==========================================
-- TAB THỬ NGHIỆM: SPECTATE & CAMERA VIEW
-- ==========================================

local expTab = tabs.Experimental

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleSpectateButton"
toggleButton.Size = UDim2.new(0, 110, 0, 40)
toggleButton.Position = UDim2.new(0.02, 0, 0.48, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
toggleButton.Text = "👁️ Spectate"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = GLOBAL_FONT
toggleButton.TextSize = 14
toggleButton.Active = true
toggleButton.Draggable = true
toggleButton.ZIndex = 100
toggleButton.Visible = false
toggleButton.Parent = screenGui
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 2
toggleStroke.Color = Color3.fromRGB(80, 80, 255)
toggleStroke.Parent = toggleButton

createToggleRow(expTab, "specBtnToggle", spectating, function(state)
    spectating = state
    toggleButton.Visible = state
    if not state then
        pcall(function()
            if spectateConnection then spectateConnection:Disconnect(); spectateConnection = nil end
            local cam = Workspace.CurrentCamera
            if cam and player.Character then
                local myHum = player.Character:FindFirstChildOfClass("Humanoid")
                if myHum then cam.CameraSubject = myHum end
            end
        end)
    end
end)

local spectateFrame = Instance.new("Frame")
spectateFrame.Size = UDim2.new(0, 320, 0, 115)
spectateFrame.Position = UDim2.new(0.5, -160, 0.85, -55)
spectateFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
spectateFrame.BackgroundTransparency = 0.2
spectateFrame.BorderSizePixel = 0
spectateFrame.Visible = false
spectateFrame.ZIndex = 50
spectateFrame.Parent = screenGui
Instance.new("UICorner", spectateFrame).CornerRadius = UDim.new(0, 8)

local specStroke = Instance.new("UIStroke")
specStroke.Color = Color3.fromRGB(80, 80, 255)
specStroke.Thickness = 2
specStroke.Parent = spectateFrame

local specNameLabel = Instance.new("TextLabel")
specNameLabel.Size = UDim2.new(1, -90, 0, 34)
specNameLabel.Position = UDim2.new(0, 45, 0, 6)
specNameLabel.BackgroundTransparency = 1
specNameLabel.Text = "Player Name"
specNameLabel.TextColor3 = currentTextColor
specNameLabel.Font = GLOBAL_FONT
specNameLabel.TextSize = 13
specNameLabel.Parent = spectateFrame
table.insert(textElements, specNameLabel)

local specPrevBtn = Instance.new("TextButton")
specPrevBtn.Size = UDim2.new(0, 35, 0, 34)
specPrevBtn.Position = UDim2.new(0, 8, 0, 6)
specPrevBtn.BackgroundColor3 = currentThemeColor
specPrevBtn.Text = "<"
specPrevBtn.TextColor3 = currentTextColor
specPrevBtn.Font = GLOBAL_FONT
specPrevBtn.TextSize = 16
specPrevBtn.Parent = spectateFrame
Instance.new("UICorner", specPrevBtn).CornerRadius = UDim.new(0, 6)
table.insert(themeButtons, specPrevBtn); table.insert(textElements, specPrevBtn)

local specNextBtn = specPrevBtn:Clone()
specNextBtn.Position = UDim2.new(1, -43, 0, 6)
specNextBtn.Text = ">"
specNextBtn.Parent = spectateFrame
table.insert(themeButtons, specNextBtn); table.insert(textElements, specNextBtn)

local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(0, 160, 0, 28)
teleportBtn.Position = UDim2.new(0.5, -80, 0, 44)
teleportBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 210)
teleportBtn.Text = "🚀 Dịch Chuyển Tới"
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportBtn.Font = GLOBAL_FONT
teleportBtn.TextSize = 11
teleportBtn.Parent = spectateFrame
Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0, 5)

local specCloseBtn = Instance.new("TextButton")
specCloseBtn.Size = UDim2.new(0, 120, 0, 24)
specCloseBtn.Position = UDim2.new(0.5, -60, 0, 78)
specCloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
specCloseBtn.Text = "Đóng Spectate"
specCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
specCloseBtn.Font = GLOBAL_FONT
specCloseBtn.TextSize = 11
specCloseBtn.Parent = spectateFrame
Instance.new("UICorner", specCloseBtn).CornerRadius = UDim.new(0, 5)

local function getSpectateTargets()
    local targets = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p and p ~= player and p.Parent then
            table.insert(targets, p)
        end
    end
    return targets
end

local function updateSpectateCamera()
    pcall(function()
        local targets = getSpectateTargets()
        if #targets == 0 then
            specNameLabel.Text = "Không có người chơi khác!"
            return
        end
        if spectateIndex > #targets then spectateIndex = 1 end
        if spectateIndex < 1 then spectateIndex = #targets end

        local target = targets[spectateIndex]
        if not target then return end
        specNameLabel.Text = (target.DisplayName or target.Name) .. " (@" .. target.Name .. ")"

        local cam = Workspace.CurrentCamera
        if cam and target.Character then
            local hum = target.Character:FindFirstChildOfClass("Humanoid")
            if hum then cam.CameraSubject = hum end
        end
    end)
end

local function teleportToSpectateTarget()
    pcall(function()
        local targets = getSpectateTargets()
        local target = targets[spectateIndex]
        if not target then return end
        local targetRoot = target.Character and (target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Torso"))
        local myRoot = player.Character and (player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso"))
        if targetRoot and myRoot then myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3) end
    end)
end

local function toggleSpectateWindow(state)
    spectateFrame.Visible = state
    setBackpackVisible(not state)
    local cam = Workspace.CurrentCamera
    if not cam then return end

    if state then
        spectateIndex = 1
        updateSpectateCamera()
        if not spectateConnection then
            spectateConnection = RunService.RenderStepped:Connect(function()
                if not spectateFrame.Visible then return end
                pcall(function()
                    local targets = getSpectateTargets()
                    local target = targets[spectateIndex]
                    if target and target.Character then
                        local hum = target.Character:FindFirstChildOfClass("Humanoid")
                        if hum and cam.CameraSubject ~= hum then cam.CameraSubject = hum end
                    end
                end)
            end)
        end
    else
        if spectateConnection then spectateConnection:Disconnect(); spectateConnection = nil end
        if player.Character then
            local myHum = player.Character:FindFirstChildOfClass("Humanoid")
            if myHum then cam.CameraSubject = myHum end
        end
    end
end

toggleButton.MouseButton1Click:Connect(function() toggleSpectateWindow(not spectateFrame.Visible) end)
specPrevBtn.MouseButton1Click:Connect(function() spectateIndex = spectateIndex - 1; updateSpectateCamera() end)
specNextBtn.MouseButton1Click:Connect(function() spectateIndex = spectateIndex + 1; updateSpectateCamera() end)
teleportBtn.MouseButton1Click:Connect(teleportToSpectateTarget)
specCloseBtn.MouseButton1Click:Connect(function() toggleSpectateWindow(false) end)

local cameraLabel = Instance.new("TextLabel")
cameraLabel.Size = UDim2.new(1, 0, 0, 20); cameraLabel.BackgroundTransparency = 1
cameraLabel.TextColor3 = currentTextColor; cameraLabel.Font = GLOBAL_FONT; cameraLabel.TextSize = 11
cameraLabel.TextXAlignment = Enum.TextXAlignment.Left; cameraLabel.Parent = expTab
table.insert(textElements, cameraLabel)

local function refreshCamLabel()
    cameraLabel.Text = translations[currentLang]["cameraViewLabel"] or "Chỉnh Góc Nhìn Camera:"
end
refreshCamLabel()
table.insert(refreshFuncs, refreshCamLabel)

local function setCameraMode(mode)
    currentCameraMode = mode
    if cameraViewConnection then cameraViewConnection:Disconnect(); cameraViewConnection = nil end
    local cam = Workspace.CurrentCamera
    if not cam then return end

    if mode == "Default" then
        player.CameraMode = Enum.CameraMode.Classic
        cam.CameraType = Enum.CameraType.Custom
        if player.Character then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then cam.CameraSubject = hum end
        end
    elseif mode == "FirstPerson" then
        player.CameraMode = Enum.CameraMode.LockFirstPerson
    else
        player.CameraMode = Enum.CameraMode.Classic
        cam.CameraType = Enum.CameraType.Scriptable
        cameraViewConnection = RunService.RenderStepped:Connect(function()
            local char = player.Character
            local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head"))
            if not root or not cam then return end

            if currentCameraMode == "Shoulder" then
                cam.CFrame = CFrame.new(root.Position + Vector3.new(2.5, 2, 4), root.Position + Vector3.new(1, 0, -10))
            elseif currentCameraMode == "Side" then
                cam.CFrame = CFrame.new(root.Position + Vector3.new(8, 2, 0), root.Position)
            elseif currentCameraMode == "TopDown" then
                cam.CFrame = CFrame.new(root.Position + Vector3.new(0, 18, 0.1), root.Position)
            end
        end)
    end
end

local cameraButtonsData = {
    {Name = "Góc Nhìn 3 (Gốc)", Mode = "Default"},
    {Name = "Góc Nhìn 1", Mode = "FirstPerson"},
    {Name = "Góc Vai (ShiftLock)", Mode = "Shoulder"},
    {Name = "Góc Mặt Cạnh", Mode = "Side"},
    {Name = "Góc Trên Xuống", Mode = "TopDown"}
}

for _, data in ipairs(cameraButtonsData) do
    local btnRow = Instance.new("Frame"); btnRow.Size = UDim2.new(1, 0, 0, 28); btnRow.BackgroundTransparency = 1; btnRow.Parent = expTab
    local btn = Instance.new("TextButton"); btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundColor3 = currentThemeColor; btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT; btn.TextSize = 11; btn.Text = data.Name; btn.Parent = btnRow
    table.insert(themeButtons, btn); table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(function() setCameraMode(data.Mode) end)
end

-- Animation nút bấm
local function applyButtonAnimation(btn)
    if not btn or not btn:IsA("TextButton") then return end
    if btn:FindFirstChild("HHubScale") then return end
    local scale = Instance.new("UIScale"); scale.Name = "HHubScale"; scale.Scale = 1; scale.Parent = btn
    btn.MouseEnter:Connect(function() TweenService:Create(scale, TweenInfo.new(.12), {Scale = 1.05}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(scale, TweenInfo.new(.12), {Scale = 1}):Play() end)
    btn.MouseButton1Down:Connect(function() TweenService:Create(scale, TweenInfo.new(.08), {Scale = .92}):Play() end)
    btn.MouseButton1Up:Connect(function() TweenService:Create(scale, TweenInfo.new(.08), {Scale = 1.05}):Play() end)
end

for _, obj in ipairs(screenGui:GetDescendants()) do
    if obj:IsA("TextButton") then applyButtonAnimation(obj) end
end
screenGui.DescendantAdded:Connect(function(obj)
    if obj:IsA("TextButton") then task.defer(function() applyButtonAnimation(obj) end) end
end)

local isAnimating = false
minimizeButton.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
    local tween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        frame.Visible = false
        openUIButton.Visible = true
        openUIButton.Size = UDim2.fromOffset(0, 0)
        TweenService:Create(openUIButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(50, 50)}):Play()
        isAnimating = false
    end)
end)

openUIButton.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
    local tween = TweenService:Create(openUIButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        openUIButton.Visible = false
        frame.Visible = true
        frame.Size = UDim2.fromOffset(0, 0)
        TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(390, 320)}):Play()
        isAnimating = false
    end)
end)

closeButton.MouseButton1Click:Connect(function()
    if isAnimating then return end
    isAnimating = true
    local tween = TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.fromOffset(0, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        pcall(function() toggleSpectateWindow(false) end)
        pcall(function() setCameraMode("Default") end)
        pcall(function() toggleNoclip(false) end)
        pcall(function() toggleInvisibility(false) end)
        pcall(function() toggleFly(false) end)
        pcall(function() toggleInfJump(false) end)
        pcall(function() toggleFPSDisplay(false) end)
        pcall(function() toggleAutoPressButton(false) end)
        pcall(function() toggleFixLag(false) end)
        pcall(function() toggleHideMapAndOthers(false) end)
        pcall(function() toggleMuteAllSounds(false) end)
        if gravityConnection then gravityConnection:Disconnect(); gravityConnection = nil end
        Workspace.Gravity = 196.2
        espEnabled = false; updateESP()
        if walkConnection then walkConnection:Disconnect(); walkConnection = nil end
        if jumpConnection then jumpConnection:Disconnect(); jumpConnection = nil end
        tpEnabled = false
        pcall(function() screenGui:Destroy() end)
    end)
end)

updateLanguage()
frame.Visible = true
frame.Size = UDim2.fromOffset(1, 1)

task.defer(function()
    task.wait(0.05)
    TweenService:Create(frame, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(390, 320)}):Play()
end)

print("[H HUB] Antiban & Server Hop System Loaded Successfully!")
