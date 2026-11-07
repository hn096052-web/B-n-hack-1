-- ==========================================
-- H HUB - RNG FIGHTS (FIXED & FULL AUTO ROLL)
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
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

local autoServerHopEnabled = false
local adminDetectorEnabled = true

local spectating = false
local spectateIndex = 1
local spectateConnection = nil
local currentCameraMode = "Default"
local cameraViewConnection = nil

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
        title = "H HUB - RNG Fights",
        tabMain = "Main", tabRoll = "Auto Roll", tabEsp = "ESP", tabFixLag = "Fix Lag", tabMisc = "Settings", tabExperimental = "Experimental",
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
        title = "H HUB - RNG Fights",
        tabMain = "Chính", tabRoll = "Auto Roll", tabEsp = "Người chơi/ESP", tabFixLag = "Fix Lag", tabMisc = "Cài đặt", tabExperimental = "Thử nghiệm",
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
-- HỆ THỐNG CẢNH BÁO CHỐNG BẤM NHẦM (WALK > 50 HOẶC JUMP > 30)
-- ==========================================

local banWarningPopup = Instance.new("Frame")
banWarningPopup.Size = UDim2.fromOffset(340, 150)
banWarningPopup.Position = UDim2.new(0.5, -170, 0.3, -75)
banWarningPopup.BackgroundColor3 = Color3.fromRGB(30, 20, 20)
banWarningPopup.BorderSizePixel = 0
banWarningPopup.Visible = false
banWarningPopup.ZIndex = 99999
banWarningPopup.Parent = screenGui
Instance.new("UICorner", banWarningPopup).CornerRadius = UDim.new(0, 10)
local bwStroke = Instance.new("UIStroke"); bwStroke.Color = Color3.fromRGB(255, 60, 60); bwStroke.Thickness = 2; bwStroke.Parent = banWarningPopup

local bwTitle = Instance.new("TextLabel")
bwTitle.Size = UDim2.new(1, 0, 0, 35)
bwTitle.BackgroundTransparency = 1
bwTitle.Text = "🚨 CẢNH BÁO NGUY HIỂM (ANTI-BAN)"
bwTitle.TextColor3 = Color3.fromRGB(255, 80, 80)
bwTitle.Font = GLOBAL_FONT
bwTitle.TextSize = 13
bwTitle.Parent = banWarningPopup

local bwDesc = Instance.new("TextLabel")
bwDesc.Size = UDim2.new(1, -20, 0, 55)
bwDesc.Position = UDim2.new(0, 10, 0, 35)
bwDesc.BackgroundTransparency = 1
bwDesc.Text = "Bạn đang chỉnh tốc độ hoặc độ cao vượt ngưỡng an toàn (>50 hoặc >30). Bạn có thể bị BAN! Bạn có muốn tiếp tục kích hoạt không?"
bwDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
bwDesc.Font = GLOBAL_FONT
bwDesc.TextSize = 11
bwDesc.TextWrapped = true
bwDesc.Parent = banWarningPopup

local bwBtnYes = Instance.new("TextButton")
bwBtnYes.Size = UDim2.new(0, 140, 0, 30)
bwBtnYes.Position = UDim2.new(0, 15, 1, -40)
bwBtnYes.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
bwBtnYes.Text = "Vẫn kích hoạt"
bwBtnYes.TextColor3 = Color3.fromRGB(255, 255, 255)
bwBtnYes.Font = GLOBAL_FONT
bwBtnYes.TextSize = 11
bwBtnYes.Parent = banWarningPopup
Instance.new("UICorner", bwBtnYes).CornerRadius = UDim.new(0, 6)

local bwBtnNo = Instance.new("TextButton")
bwBtnNo.Size = UDim2.new(0, 140, 0, 30)
bwBtnNo.Position = UDim2.new(1, -155, 1, -40)
bwBtnNo.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
bwBtnNo.Text = "Bỏ qua / Tắt"
bwBtnNo.TextColor3 = Color3.fromRGB(255, 255, 255)
bwBtnNo.Font = GLOBAL_FONT
bwBtnNo.TextSize = 11
bwBtnNo.Parent = banWarningPopup
Instance.new("UICorner", bwBtnNo).CornerRadius = UDim.new(0, 6)

local pendingActionCallback = nil
bwBtnYes.MouseButton1Click:Connect(function()
    banWarningPopup.Visible = false
    if pendingActionCallback then
        pendingActionCallback(true)
        pendingActionCallback = nil
    end
end)
bwBtnNo.MouseButton1Click:Connect(function()
    banWarningPopup.Visible = false
    pendingActionCallback = nil
end)

local function checkAndWarnLimit(val, isWalk, confirmCallback)
    if (isWalk and val > 50) or (not isWalk and val > 30) then
        pendingActionCallback = confirmCallback
        banWarningPopup.Visible = true
    else
        confirmCallback(true)
    end
end

-- ==========================================
-- HỆ THỐNG AUTO ROLL AN TOÀN (TỰ DÒ TÌM REMOTE)
-- ==========================================

local allAttacksList = {
    "Punch", "Slap", "Laser", "Shockwave", "Rage", "Get Out", "Streak", "Rapid Fire",
    "Phase", "Nope", "Party", "Rock", "UltraPunch", "Orbital Strike", "Nani", "Bounty",
    "Randomized", "Ultra Instinct", "Cloned", "Cyborg", "Time God", "360-NoScope",
    "Divinity", "SuperCharged", "Supernova", "Gravity", "Hacker", "D E A T H",
    "Singularity", "Eternal", "E R R O R", "Present", "Ghost", "Reverse", "Hellfire", "Reaper"
}

local autoRollActive = false
local selectedRollTargets = {} 
local rollSpeedDelay = 0.5

local function getGenerateAttackRemote()
    -- Tự động tìm kiếm RemoteEvent "GenerateAttack" trong toàn bộ ReplicatedStorage nếu đường dẫn thay đổi
    local found = ReplicatedStorage:FindFirstChild("GenerateAttack", true)
    if found and found:IsA("RemoteEvent") then return found end
    
    local eventsFolder = ReplicatedStorage:FindFirstChild("EventsFolder") or ReplicatedStorage:FindFirstChild("Events")
    if eventsFolder then
        local ev = eventsFolder:FindFirstChild("GenerateAttack")
        if ev and ev:IsA("RemoteEvent") then return ev end
    end
    return nil
end

local function fireRollServer(attackName)
    pcall(function()
        local remote = getGenerateAttackRemote()
        if remote then
            remote:FireServer(attackName or "Random")
        else
            -- Fallback theo cấu trúc bạn cung cấp
            local evFolder = ReplicatedStorage:FindFirstChild("EventsFolder")
            if evFolder then
                local gen = evFolder:FindFirstChild("GenerateAttack")
                if gen then gen:FireServer(attackName or "Random") end
            end
        end
    end)
end

local autoRollTask = nil
local function toggleAutoRoll(state)
    autoRollActive = state
    if state then
        if not autoRollTask then
            autoRollTask = task.spawn(function()
                while autoRollActive do
                    pcall(function()
                        fireRollServer("Random")
                    end)
                    task.wait(rollSpeedDelay)
                end
            end)
        end
    else
        if autoRollTask then
            task.cancel(autoRollTask)
            autoRollTask = nil
        end
    end
end

-- ==========================================
-- CÁC CHỨC NĂNG KHÁC (TP, ESP, Noclip,...)
-- ==========================================

local function setBackpackVisible(visible)
    pcall(function() StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, visible) end)
end

local allEquipItems = {
    "PieThrow","SmallPotion","GiantPotion","GhostPotion","Healing","GravityPotion",
    "Bloxiade","ClownBomb","Slate","WindPotion","IcePotion","Caltrops","SlowDownGun",
    "GravityGun","GravityDisruptor","FreezeRay","Bomb","Jetpack","DecoyDeploy"
}

local function equipItemsOnce()
    task.spawn(function()
        local equipEvent = ReplicatedStorage:FindFirstChild("Equip", true)
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

local hiddenObjects = {}
local mutedSounds = {}

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
    else
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
        end
    end)
end

local function toggleHideMapAndOthers(state)
    hideMapOthersEnabled = state
    if state then
        for _, v in ipairs(Workspace:GetDescendants()) do applyHideToObject(v) end
    else
        for obj, originalVal in pairs(hiddenObjects) do
            if obj and obj.Parent then
                pcall(function()
                    if obj:IsA("BasePart") then obj.LocalTransparencyModifier = originalVal end
                end)
            end
        end
        hiddenObjects = {}
    end
end

local function optimizePartExtreme(v)
    if not fixLagEnabled then return end
    pcall(function()
        if v:IsA("MeshPart") or v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0; v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end)
end

local function toggleFixLag(state)
    fixLagEnabled = state
    if state then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
        end)
        for _, v in ipairs(game:GetDescendants()) do optimizePartExtreme(v) end
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

local function serverHopFiltered()
    task.spawn(function()
        local placeId = game.PlaceId
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
        local ok, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
        if ok and result and result.data then
            for _, server in ipairs(result.data) do
                if server.id ~= game.JobId and server.playing >= 5 and server.playing < server.maxPlayers then
                    pcall(function() TeleportService:TeleportToPlaceInstance(placeId, server.id, player) end)
                    return
                end
            end
        end
        pcall(function() TeleportService:Teleport(placeId, player) end)
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
                                elseif v:IsA("PVInstance") then pos = v:GetPivot().Position end
                                
                                if pos and (root.Position - pos).Magnitude <= autoPressRadius then
                                    if v:IsA("ClickDetector") and fireclickdetector then fireclickdetector(v)
                                    elseif v:IsA("ProximityPrompt") and fireproximityprompt then fireproximityprompt(v) end
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    elseif autoPressButtonTask then
        task.cancel(autoPressButtonTask); autoPressButtonTask = nil
    end
end

local noclipConnection
local function toggleNoclip(state)
    noclipEnabled = state
    if state then
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
    end
end

local invisibleConnection
local function toggleInvisibility(state)
    invisibleEnabled = state
    if state then
        if not invisibleConnection then
            invisibleConnection = RunService.RenderStepped:Connect(function()
                local char = player.Character
                if char then
                    for _, child in ipairs(char:GetDescendants()) do
                        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                            child.Transparency = 1
                        end
                    end
                end
            end)
        end
    else
        if invisibleConnection then invisibleConnection:Disconnect(); invisibleConnection = nil end
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
            if rootPart:FindFirstChild("FlyGyro") then rootPart.FlyGyro:Destroy() end
            if rootPart:FindFirstChild("FlyVelocity") then rootPart.FlyVelocity:Destroy() end
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
        label.TextColor3 = espColor; label.TextStrokeTransparency = 0; label.TextScaled = true; label.Font = GLOBAL_FONT; label.Parent = billboard
        billboard.Parent = head
    end
    local highlight = character:FindFirstChild("H_HUB_ESP")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "H_HUB_ESP"; highlight.Adornee = character; highlight.FillTransparency = 0.5; highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; highlight.Parent = character
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
            createHighlight(p.Character, p)
        end
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
                        task.wait(math.max(tpSpeed, 0.05))
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- XÂY DỰNG GIAO DIỆN UI
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
Instance.new("UICorner", openUIButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", openUIButton).Thickness = 2

local fpsButton = Instance.new("TextButton")
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
Instance.new("UICorner", fpsButton).CornerRadius = UDim.new(0, 6)

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
                    frameCount, lastUpdate = 0, now
                end
            end)
        end
    elseif fpsConnection then
        fpsConnection:Disconnect(); fpsConnection = nil
    end
end

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(410, 340)
frame.Position = UDim2.new(0.5, -205, 0.5, -170)
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

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
local frameStroke = Instance.new("UIStroke"); frameStroke.Thickness = 2; frameStroke.Color = Color3.fromRGB(60, 60, 100); frameStroke.Transparency = 0.4; frameStroke.Parent = frame

local titleBar = Instance.new("Frame")
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
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 4)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(28, 22)
closeButton.Position = UDim2.new(1, -30, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = GLOBAL_FONT; closeButton.TextSize = 13; closeButton.ZIndex = 22; closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 4)

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
local tabNames = {"Main", "Roll", "ESP", "FixLag", "Misc", "Experimental"}
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

local function createFeatureWithPlusButton(parent, labelText, onToggleCallback)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.Parent = parent
    
    local btn = Instance.new("TextButton"); btn.Size = UDim2.new(1, -38, 1, 0)
    btn.BackgroundColor3 = currentThemeColor; btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT; btn.TextSize = 11; btn.Parent = row
    table.insert(themeButtons, btn); table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local plusBtn = Instance.new("TextButton"); plusBtn.Size = UDim2.fromOffset(30, 30)
    plusBtn.Position = UDim2.new(1, -32, 0, 1); plusBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
    plusBtn.Text = "+"; plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = GLOBAL_FONT; plusBtn.TextSize = 14; plusBtn.Parent = row
    Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 6)

    local currentState = false
    local function refreshBtnText()
        btn.Text = labelText .. (currentState and " [ON]" or " [OFF]")
        updateButtonVisual(btn, currentState)
    end

    btn.MouseButton1Click:Connect(function()
        currentState = not currentState
        refreshBtnText()
        onToggleCallback(currentState)
    end)
    refreshBtnText()

    plusBtn.MouseButton1Click:Connect(function()
        local floatBtn = Instance.new("TextButton")
        floatBtn.Size = UDim2.fromOffset(120, 35)
        floatBtn.Position = UDim2.new(0.2, math.random(0, 200), 0.2, math.random(0, 200))
        floatBtn.BackgroundColor3 = currentState and Color3.fromRGB(45, 160, 85) or currentThemeColor
        floatBtn.TextColor3 = currentTextColor
        floatBtn.Font = GLOBAL_FONT
        floatBtn.TextSize = 11
        floatBtn.Text = labelText
        floatBtn.Active = true
        floatBtn.Draggable = true
        floatBtn.ZIndex = 500
        floatBtn.Parent = screenGui
        Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(0, 6)
        Instance.new("UIStroke", floatBtn).Color = Color3.fromRGB(255, 255, 255)

        floatBtn.MouseButton1Click:Connect(function()
            currentState = not currentState
            floatBtn.BackgroundColor3 = currentState and Color3.fromRGB(45, 160, 85) or currentThemeColor
            onToggleCallback(currentState)
        end)
    end)
end

local function createToggleRow(parent, labelKey, stateBool, callback)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.Parent = parent
    local btn = Instance.new("TextButton"); btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundColor3 = currentThemeColor; btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT; btn.TextSize = 11; btn.Parent = row
    table.insert(themeButtons, btn); table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    local function refresh()
        local t = translations[currentLang]
        btn.Text = (t[labelKey] or labelKey) .. (stateBool and " [" .. t.on .. "]" or " [" .. t.off .. "]")
        updateButtonVisual(btn, stateBool)
    end
    btn.MouseButton1Click:Connect(function() stateBool = not stateBool; refresh(); callback(stateBool) end)
    refresh()
    return btn, refresh
end

local function createButtonRow(parent, labelKey, callback)
    local row = Instance.new("Frame"); row.Size = UDim2.new(1, 0, 0, 32); row.BackgroundTransparency = 1; row.Parent = parent
    local btn = Instance.new("TextButton"); btn.Size = UDim2.fromScale(1, 1)
    btn.BackgroundColor3 = currentThemeColor; btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT; btn.TextSize = 11; btn.Parent = row
    table.insert(themeButtons, btn); table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback)
    return btn
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
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then callback(val) else box.Text = tostring(defaultVal) end
    end)
    lbl.Text = translations[currentLang][labelKey] or labelKey
    return row
end

local mainTab = tabs.Main; mainTab.Visible = true

createInputRow(mainTab, "tpSpd", tpSpeed, function(v) tpSpeed = v end)
createFeatureWithPlusButton(mainTab, "Auto TP Nhặt Xu", function(v) tpEnabled = v end)

createInputRow(mainTab, "walkSpd", walkSpeed, function(v)
    checkAndWarnLimit(v, true, function(allowed)
        if allowed then
            walkSpeed = v
            if walkEnabled then
                local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if h then h.WalkSpeed = v end
            end
        end
    end)
end)

local walkConnection
createFeatureWithPlusButton(mainTab, "Chỉnh Tốc Độ Đi", function(v)
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

createInputRow(mainTab, "jumpSpd", jumpPower, function(v)
    checkAndWarnLimit(v, false, function(allowed)
        if allowed then
            jumpPower = v
            local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if jumpEnabled and h then h.UseJumpPower = true; h.JumpPower = v end
        end
    end)
end)

local jumpConnection
createFeatureWithPlusButton(mainTab, "Chỉnh Độ Nhảy", function(v)
    jumpEnabled = v
    if jumpConnection then jumpConnection:Disconnect(); jumpConnection = nil end
    if v then
        jumpConnection = RunService.RenderStepped:Connect(function()
            local h = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if h then h.UseJumpPower = true; h.JumpPower = jumpPower end
        end)
    end
end)

createFeatureWithPlusButton(mainTab, "Chế Độ Bay", toggleFly)
createFeatureWithPlusButton(mainTab, "Đi Xuyên Tường (Noclip)", toggleNoclip)
createFeatureWithPlusButton(mainTab, "Tàng Hình Nhìn Thấy", toggleInvisibility)
createFeatureWithPlusButton(mainTab, "Nhảy Vô Hạn", toggleInfJump)
createFeatureWithPlusButton(mainTab, "Tự Động Freeze Ray", toggleFreezeRay)
createButtonRow(mainTab, "autoEquipBtn", equipItemsOnce)
createFeatureWithPlusButton(mainTab, "Auto Click Nút", toggleAutoPressButton)

-- TAB AUTO ROLL
local rollTab = tabs.Roll
createFeatureWithPlusButton(rollTab, "Bật Auto Roll (Liên tục)", toggleAutoRoll)

local arrowToggleBtn = Instance.new("TextButton")
arrowToggleBtn.Size = UDim2.new(1, 0, 0, 36)
arrowToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
arrowToggleBtn.TextColor3 = currentTextColor
arrowToggleBtn.Font = GLOBAL_FONT
arrowToggleBtn.TextSize = 12
arrowToggleBtn.Text = "Mở Bảng Chọn Sức Mạnh [ ^ ]"
arrowToggleBtn.Parent = rollTab
Instance.new("UICorner", arrowToggleBtn).CornerRadius = UDim.new(0, 6)

local attackSelectorFrame = Instance.new("ScrollingFrame")
attackSelectorFrame.Size = UDim2.new(1, 0, 0, 180)
attackSelectorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
attackSelectorFrame.BackgroundTransparency = 0.2
attackSelectorFrame.BorderSizePixel = 0
attackSelectorFrame.ScrollBarThickness = 4
attackSelectorFrame.CanvasSize = UDim2.new()
attackSelectorFrame.Visible = false
attackSelectorFrame.Parent = rollTab

local asLayout = Instance.new("UIListLayout"); asLayout.SortOrder = Enum.SortOrder.LayoutOrder; asLayout.Padding = UDim.new(0, 4); asLayout.Parent = attackSelectorFrame
asLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    attackSelectorFrame.CanvasSize = UDim2.new(0, 0, 0, asLayout.AbsoluteContentSize.Y + 10)
end)

arrowToggleBtn.MouseButton1Click:Connect(function()
    attackSelectorFrame.Visible = not attackSelectorFrame.Visible
    arrowToggleBtn.Text = attackSelectorFrame.Visible and "Đóng Bảng Chọn Sức Mạnh [ v ]" or "Mở Bảng Chọn Sức Mạnh [ ^ ]"
end)

for _, attName in ipairs(allAttacksList) do
    local attRow = Instance.new("Frame"); attRow.Size = UDim2.new(1, 0, 0, 28); attRow.BackgroundTransparency = 1; attRow.Parent = attackSelectorFrame

    local nameBtn = Instance.new("TextButton"); nameBtn.Size = UDim2.new(1, 0, 1, 0)
    nameBtn.BackgroundColor3 = currentThemeColor; nameBtn.TextColor3 = currentTextColor; nameBtn.Font = GLOBAL_FONT; nameBtn.TextSize = 11
    nameBtn.Text = "🎲 Bấm để Roll ngay: " .. attName
    nameBtn.Parent = attRow
    Instance.new("UICorner", nameBtn).CornerRadius = UDim.new(0, 4)

    nameBtn.MouseButton1Click:Connect(function()
        fireRollServer(attName)
    end)
end

-- ESP Tab
local espTab = tabs.ESP
createFeatureWithPlusButton(espTab, "ESP Nhìn Xuyên Tường", function(v) espEnabled = v; updateESP() end)
createFeatureWithPlusButton(espTab, "Hiển Thị FPS", toggleFPSDisplay)

-- Fix Lag Tab
local fixTab = tabs.FixLag
createFeatureWithPlusButton(fixTab, "Siêu Giảm Lag (Max FPS)", toggleFixLag)
createFeatureWithPlusButton(fixTab, "Ẩn Bản Đồ & Người Khác", toggleHideMapAndOthers)
createFeatureWithPlusButton(fixTab, "Tắt Âm Thanh Game", toggleMuteAllSounds)

-- Misc Tab
local miscTab = tabs.Misc
createButtonRow(miscTab, "rejoinBtn", rejoinServer)
createButtonRow(miscTab, "serverHopBtn", serverHopFiltered)

-- Experimental Tab
local expTab = tabs.Experimental
createToggleRow(expTab, "specBtnToggle", spectating, function(state) spectating = state end)

-- Sidebar Navigation
local tabButtons = {}
local y = 10
for i, name in ipairs(tabNames) do
    local b = Instance.new("TextButton"); b.Size = UDim2.new(1, -16, 0, 32); b.Position = UDim2.new(0, 8, 0, y)
    b.BackgroundColor3 = i == 1 and Color3.fromRGB(70, 70, 90) or Color3.fromRGB(30, 30, 40)
    b.TextColor3 = currentTextColor; b.Font = GLOBAL_FONT; b.TextSize = 11; b.Parent = sidebar
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, other in pairs(tabButtons) do other.BackgroundColor3 = Color3.fromRGB(30, 30, 40) end
        tabs[name].Visible = true; b.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    end)
    tabButtons[name] = b; y += 40
    b.Text = name
end

minimizeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    openUIButton.Visible = true
end)

openUIButton.MouseButton1Click:Connect(function()
    openUIButton.Visible = false
    frame.Visible = true
end)

closeButton.MouseButton1Click:Connect(function()
    pcall(function() screenGui:Destroy() end)
end)

frame.Visible = true
print("[H HUB] Fix Loaded Successfully!")
