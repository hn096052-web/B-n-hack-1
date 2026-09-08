-- ==========================================
-- H HUB AUTOFARM (FIXED & UPDATED WITH BG PARTICLES)
-- ==========================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Dọn dẹp GUI cũ nếu có
if playerGui:FindFirstChild("AutoFarmHubGui") then
    playerGui.AutoFarmHubGui:Destroy()
end

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

-- Trạng thái tính năng
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
local autoEquipEnabled = false

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

-- Cấu hình ESP & Màu
local selectedEspTarget = "Tất cả"
local espColor = Color3.fromRGB(255, 0, 0)
local currentThemeColor = Color3.fromRGB(35, 35, 45)
local currentTextColor = Color3.fromRGB(255, 255, 255)
local boardBgColor = Color3.fromRGB(20, 20, 25)
local particleColor = Color3.fromRGB(150, 150, 255)
local activeParticles = {}

local frozenPlayersTable = {} 
local currentLang = "VI" 

-- Quản lý Kết nối & Task
local noclipConnection, invisibleConnection, flyConnection
local walkConnection, jumpConnection, infJumpConnection
local freezeRayTask, fpsConnection, gravityConnection
local autoPressButtonTask, fixLagTask, fixLagChildConnection
local hideMapConnection, muteSoundsConnection, autoEquipTask
local originalHipHeight
local savedTransparencies = {}
local hiddenObjects = {} 
local mutedSounds = {}   

-- Theme UI Tables
local themeButtons = {}     
local textElements = {}     

-- Font chữ
local GLOBAL_FONT = Enum.Font.GothamBold

local translations = {
    EN = {
        title = "H HUB - AutoFarm",
        tabMain = "Main",
        tabEsp = "Players/ESP",
        tabMisc = "Settings",
        tabFixLag = "Fix Lag",
        tpSpd = "TP Speed (s):",
        walkSpd = "Walk Speed:",
        flySpd = "Fly Speed:",
        jumpSpd = "Jump Power:",
        gravSpd = "Gravity:",
        freezeRng = "Freeze Range:",
        clickDelayLabel = "Click Delay (s):",
        targetBtn = "Target: ",
        allTarget = "All",
        tpBtn = "Auto TP Coins",
        walkBtn = "Custom Speed",
        jumpBtn = "Custom Jump",
        flyBtn = "Fly Mode",
        gravBtn = "Custom Gravity",
        noclipBtn = "Noclip Pass-Wall",
        invisBtn = "Invisibility",
        infJumpBtn = "Infinite Jump",
        freezeBtn = "Auto Freeze Ray",
        autoEquipBtn = "Auto Equip Items",
        godBtn = "⚡ Open God Mode Panel",
        espBtn = "ESP Wallhack",
        fpsBtn = "Display FPS",
        autoPressRadiusLabel = "Click Button Range:",
        autoPressDelayLabel = "Click Button Delay (s):",
        autoPressBtn = "Auto Click Buttons",
        fixLagBtn = "Ultra Fix Lag (Max FPS)",
        hideMapBtn = "Hide Map & Players",
        muteSoundsBtn = "Mute Game Sounds",
        espColorLabel = "ESP Highlight Color:",
        themeLabel = "UI Button Color:",
        textLabel = "UI Text Color:",
        bgBoardLabel = "UI Board BG Color:",
        particleColorLabel = "BG Particle Color:",
        langLabel = "Language:",
        rejoinBtn = "Rejoin Server",
        serverHopBtn = "Server Hop",
        on = "ON",
        off = "OFF"
    },
    VI = {
        title = "H HUB - AutoFarm",
        tabMain = "Chính",
        tabEsp = "Người chơi/ESP",
        tabMisc = "Cài đặt",
        tabFixLag = "Fix Lag",
        tpSpd = "Tốc độ TP (giây):",
        walkSpd = "Tốc độ Đi bộ:",
        flySpd = "Tốc độ Bay:",
        jumpSpd = "Độ Cao Nhảy:",
        gravSpd = "Trọng Lực Game:",
        freezeRng = "Khoảng cách Freeze:",
        clickDelayLabel = "Tốc độ Click (giây):",
        targetBtn = "Mục tiêu: ",
        allTarget = "Tất cả",
        tpBtn = "Auto TP Nhặt Xu",
        walkBtn = "Chỉnh Tốc Độ Đi",
        jumpBtn = "Chỉnh Độ Nhảy",
        flyBtn = "Chế Độ Bay",
        gravBtn = "Trọng Lực Tùy Chỉnh",
        noclipBtn = "Đi Xuyên Tường (Noclip)",
        invisBtn = "Tàng Hình Nhìn Thấy",
        infJumpBtn = "Nhảy Vô Hạn",
        freezeBtn = "Tự Động Freeze Ray",
        autoEquipBtn = "Auto Mặc/Tháo Đồ",
        godBtn = "⚡ Bảng God Mode (Bất Tử)",
        espBtn = "ESP Nhìn Xuyên Tường",
        fpsBtn = "Hiển Thị FPS",
        autoPressRadiusLabel = "Bán kính Click Nút:",
        autoPressDelayLabel = "Tốc độ Click Nút (s):",
        autoPressBtn = "Auto Click Nút",
        fixLagBtn = "Siêu Giảm Lag (Max FPS)",
        hideMapBtn = "Ẩn Bản Đồ & Người Khác",
        muteSoundsBtn = "Tắt Âm Thanh Game",
        espColorLabel = "Màu ESP Xuyên Tường:",
        themeLabel = "Màu Nút Giao Diện:",
        textLabel = "Màu Chữ Giao Diện:",
        bgBoardLabel = "Màu Nền Bảng:",
        particleColorLabel = "Màu Hạt Nền Bay:",
        langLabel = "Ngôn ngữ / Language:",
        rejoinBtn = "Vào Lại Server",
        serverHopBtn = "Đổi Server Khác",
        on = "BẬT",
        off = "TẮT"
    }
}

-- ==========================================
-- LOGIC TÍNH NĂNG GAME
-- ==========================================
local itemsToUnequip = {"PieThrow", "SmallPotion", "GiantPotion", "GhostPotion", "Healing", "GravityPotion", "Bloxiade", "ClownBomb", "Slate", "WindPotion", "IcePotion", "Caltrops", "SlowDownGun", "GravityGun", "GravityDisruptor", "FreezeRay", "Bomb"}

local function toggleAutoEquip(state)
    autoEquipEnabled = state
    if autoEquipTask then task.cancel(autoEquipTask); autoEquipTask = nil end
    if autoEquipEnabled then
        autoEquipTask = task.spawn(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local equipEvent = ReplicatedStorage:WaitForChild("Equip", 5)
            if not equipEvent then return end
            while autoEquipEnabled do
                for _, item in ipairs(itemsToUnequip) do
                    if not autoEquipEnabled then break end
                    pcall(function() equipEvent:FireServer("UNEQUIP", item) end)
                    task.wait(0.03)
                end
                if not autoEquipEnabled then break end
                task.wait(0.2)
                for _, item in ipairs(itemsToUnequip) do
                    if not autoEquipEnabled then break end
                    pcall(function() equipEvent:FireServer("EQUIP", item) end)
                    task.wait(0.03)
                end
                if not autoEquipEnabled then break end
                task.wait(0.8) 
            end
        end)
    end
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
    if muteAllSoundsEnabled then
        for _, v in ipairs(game:GetDescendants()) do applyMuteToSound(v) end
        if not muteSoundsConnection then muteSoundsConnection = game.DescendantAdded:Connect(function(v) if muteAllSoundsEnabled then applyMuteToSound(v) end end) end
    else
        if muteSoundsConnection then muteSoundsConnection:Disconnect(); muteSoundsConnection = nil end
        for sound, origVol in pairs(mutedSounds) do if sound and sound.Parent then pcall(function() sound.Volume = origVol end) end end
        mutedSounds = {}
    end
end

local function isMySelfOrItem(obj)
    local char = player.Character
    if char and (obj == char or obj:IsDescendantOf(char)) then return true end
    local backpack = player:FindFirstChild("Backpack")
    if backpack and (obj == backpack or obj:IsDescendantOf(backpack)) then return true end
    if obj:IsA("Sky") or obj:IsA("Atmosphere") or obj:IsA("SunRaysEffect") or obj:IsA("BloomEffect") then return true end
    return false
end

local function applyHideToObject(v)
    if not hideMapOthersEnabled then return end
    if isMySelfOrItem(v) then return end
    pcall(function()
        if v:IsA("BasePart") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.LocalTransparencyModifier end
            v.LocalTransparencyModifier = 1
        elseif v:IsA("Decal") or v:IsA("Texture") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.Transparency end
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.Enabled end
            v.Enabled = false
        elseif v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
            if hiddenObjects[v] == nil then hiddenObjects[v] = v.Enabled end
            v.Enabled = false
        end
    end)
end

local function toggleHideMapAndOthers(state)
    hideMapOthersEnabled = state
    if hideMapOthersEnabled then
        for _, v in ipairs(Workspace:GetDescendants()) do applyHideToObject(v) end
        if not hideMapConnection then hideMapConnection = Workspace.DescendantAdded:Connect(function(v) if hideMapOthersEnabled then applyHideToObject(v) end end) end
    else
        if hideMapConnection then hideMapConnection:Disconnect(); hideMapConnection = nil end
        for obj, originalVal in pairs(hiddenObjects) do
            if obj and obj.Parent then
                pcall(function()
                    if obj:IsA("BasePart") then obj.LocalTransparencyModifier = originalVal
                    elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = originalVal
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = originalVal
                    elseif obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then obj.Enabled = originalVal end
                end)
            end
        end
        hiddenObjects = {}
    end
end

local function optimizePartExtreme(v)
    if not fixLagEnabled then return end
    pcall(function()
        if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 v.CastShadow = false
        elseif v:IsA("MeshPart") then v.Material = Enum.Material.SmoothPlastic v.Reflectance = 0 v.CastShadow = false v.TextureID = ""
        elseif v:IsA("SpecialMesh") then v.TextureId = ""
        elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1
        elseif v:IsA("SurfaceAppearance") then v:Destroy()
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Beam") then v.Enabled = false
        elseif v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") then v.Enabled = false
        elseif v:IsA("Explosion") then v.Visible = false end
    end)
end

local function toggleFixLag(state)
    fixLagEnabled = state
    if fixLagEnabled then
        pcall(function()
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.FogStart = 9e9
            Lighting.Brightness = 1
            local terrain = Workspace:FindFirstChildOfClass("Terrain")
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 0
                terrain.Decoration = false
            end
        end)
        for _, v in ipairs(game:GetDescendants()) do optimizePartExtreme(v) end
        if not fixLagChildConnection then fixLagChildConnection = game.DescendantAdded:Connect(function(v) if fixLagEnabled then optimizePartExtreme(v) end end) end
        if not fixLagTask then
            fixLagTask = task.spawn(function()
                while fixLagEnabled do
                    for _, v in ipairs(Workspace:GetDescendants()) do if not fixLagEnabled then break end optimizePartExtreme(v) end
                    task.wait(3)
                end
            end)
        end
    else
        if fixLagChildConnection then fixLagChildConnection:Disconnect(); fixLagChildConnection = nil end
        if fixLagTask then task.cancel(fixLagTask); fixLagTask = nil end
    end
end

local function rejoinServer()
    if #Players:GetPlayers() <= 1 then
        player:Kick("\n[H HUB] Đang kết nối lại Server...")
        task.wait()
        TeleportService:Teleport(game.PlaceId, player)
    else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player) end
end

local function serverHop()
    local placeId = game.PlaceId
    local serversUrl = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
    local function getServers(cursor)
        local url = serversUrl .. (cursor and ("&cursor=" .. cursor) or "")
        local success, result = pcall(function() return HttpService:JSONDecode(game:HttpGet(url)) end)
        if success and result and result.data then return result end return nil
    end
    task.spawn(function()
        local cursor = nil
        repeat
            local serverData = getServers(cursor)
            if serverData then
                cursor = serverData.nextPageCursor
                for _, server in ipairs(serverData.data) do
                    if server.id ~= game.JobId and server.playing < server.maxPlayers and server.playing > 0 then
                        TeleportService:TeleportToPlaceInstance(placeId, server.id, player)
                        return
                    end
                end
            end
            task.wait(0.5)
        until not cursor
        TeleportService:Teleport(placeId, player)
    end)
end

local function toggleAutoPressButton(state)
    autoPressButtonEnabled = state
    if autoPressButtonEnabled then
        if not autoPressButtonTask then
            autoPressButtonTask = task.spawn(function()
                while autoPressButtonEnabled do
                    pcall(function()
                        local char = player.Character
                        local root = char and char:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, v in ipairs(Workspace:GetDescendants()) do
                                if not autoPressButtonEnabled then break end
                                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                                    local parent = v.Parent
                                    local pos = nil
                                    if parent then
                                        if parent:IsA("BasePart") then
                                            pos = parent.Position
                                        elseif parent:IsA("PVInstance") then
                                            pos = parent:GetPivot().Position
                                        end
                                    end
                                    if pos and (root.Position - pos).Magnitude <= autoPressRadius then
                                        if v:IsA("ClickDetector") then fireclickdetector(v)
                                        elseif v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(autoPressDelay > 0.05 and autoPressDelay or 0.1)
                end
            end)
        end
    else
        if autoPressButtonTask then task.cancel(autoPressButtonTask); autoPressButtonTask = nil end
    end
end

local function toggleNoclip(state)
    noclipEnabled = state
    local character = player.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if noclipEnabled then
        if humanoid and not originalHipHeight then originalHipHeight = humanoid.HipHeight; humanoid.HipHeight = originalHipHeight + 0.5 end
        if not noclipConnection then noclipConnection = RunService.Stepped:Connect(function() local char = player.Character if char then for _, part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end end) end
    else
        if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
        if humanoid and originalHipHeight then humanoid.HipHeight = originalHipHeight; originalHipHeight = nil end
        for _, part in ipairs(character:GetDescendants()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.CanCollide = true end end
    end
end

local function toggleInvisibility(state)
    invisibleEnabled = state
    local character = player.Character
    if not character then return end
    if invisibleEnabled then
        savedTransparencies = {}
        if not invisibleConnection then
            invisibleConnection = RunService.RenderStepped:Connect(function()
                local char = player.Character
                if char then
                    for _, child in ipairs(char:GetDescendants()) do
                        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then if not savedTransparencies[child] then savedTransparencies[child] = child.Transparency end child.Transparency = 1
                        elseif child:IsA("Decal") or child:IsA("Texture") then if not savedTransparencies[child] then savedTransparencies[child] = child.Transparency end child.Transparency = 1
                        elseif child:IsA("BillboardGui") or child:IsA("SurfaceGui") then child.Enabled = false end
                    end
                end
            end)
        end
    else
        if invisibleConnection then invisibleConnection:Disconnect(); invisibleConnection = nil end
        for child, transp in pairs(savedTransparencies) do if child and child.Parent then child.Transparency = transp end end
        for _, child in ipairs(character:GetDescendants()) do if child:IsA("BillboardGui") or child:IsA("SurfaceGui") then child.Enabled = true end end
        savedTransparencies = {}
    end
end

local function toggleFly(state)
    flyEnabled = state
    local character = player.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if flyEnabled then
        if not rootPart or not humanoid then return end
        humanoid.PlatformStand = true
        local bg = Instance.new("BodyGyro") bg.Name = "FlyGyro" bg.P = 9e4 bg.maxTorque = Vector3.new(9e4, 9e4, 9e4) bg.cframe = rootPart.CFrame bg.Parent = rootPart
        local bv = Instance.new("BodyVelocity") bv.Name = "FlyVelocity" bv.velocity = Vector3.new(0, 0, 0) bv.maxForce = Vector3.new(9e4, 9e4, 9e4) bv.Parent = rootPart
        if flyConnection then flyConnection:Disconnect() end
        flyConnection = RunService.RenderStepped:Connect(function()
            if not flyEnabled or not character or not character.Parent then if bg then bg:Destroy() end if bv then bv:Destroy() end return end
            local cam = Workspace.CurrentCamera
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                local lookFlat = cam.CFrame.LookVector * Vector3.new(1, 0, 1)
                local camFlatCFrame = lookFlat.Magnitude > 0.001 and CFrame.lookAt(Vector3.zero, lookFlat) or cam.CFrame
                local localMove = camFlatCFrame:VectorToObjectSpace(moveDir)
                local flyVector = (cam.CFrame.LookVector * -localMove.Z) + (cam.CFrame.RightVector * localMove.X)
                bv.velocity = flyVector * flySpeed bg.cframe = cam.CFrame
            else bv.velocity = Vector3.new(0, 0, 0) bg.cframe = cam.CFrame end
        end)
    else
        if flyConnection then flyConnection:Disconnect() flyConnection = nil end
        if rootPart then local bg = rootPart:FindFirstChild("FlyGyro") local bv = rootPart:FindFirstChild("FlyVelocity") if bg then bg:Destroy() end if bv then bv:Destroy() end end
        if humanoid then humanoid.PlatformStand = false end
    end
end

local function toggleInfJump(state)
    infJumpEnabled = state
    if infJumpEnabled then
        if not infJumpConnection then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                if infJumpEnabled then
                    local character = player.Character
                    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end)
        end
    else
        if infJumpConnection then infJumpConnection:Disconnect(); infJumpConnection = nil end
    end
end

local function createHighlight(character, targetPlayer)
    if not character then return end
    local head = character:FindFirstChild("Head")
    if head and not head:FindFirstChild("H_HUB_NameESP") then
        local billboard = Instance.new("BillboardGui") billboard.Name = "H_HUB_NameESP" billboard.Adornee = head billboard.Size = UDim2.new(0, 150, 0, 30) billboard.StudsOffset = Vector3.new(0, 2.5, 0) billboard.AlwaysOnTop = true
        local textLabel = Instance.new("TextLabel") textLabel.Parent = billboard textLabel.Size = UDim2.new(1, 0, 1, 0) textLabel.BackgroundTransparency = 1 textLabel.Text = targetPlayer.DisplayName .. " (@" .. targetPlayer.Name .. ")" textLabel.TextColor3 = espColor textLabel.TextStrokeTransparency = 0 textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0) textLabel.TextScaled = true textLabel.Font = GLOBAL_FONT
        billboard.Parent = head
    end
    local highlight = character:FindFirstChild("H_HUB_ESP")
    if not highlight then highlight = Instance.new("Highlight") highlight.Name = "H_HUB_ESP" highlight.Adornee = character highlight.FillTransparency = 0.5 highlight.OutlineColor = Color3.fromRGB(255, 255, 255) highlight.OutlineTransparency = 0 highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop highlight.Parent = character end
    highlight.FillColor = espColor
end

local function removeHighlight(character)
    if character then
        if character:FindFirstChild("H_HUB_ESP") then character.H_HUB_ESP:Destroy() end
        local head = character:FindFirstChild("Head")
        if head and head:FindFirstChild("H_HUB_NameESP") then head.H_HUB_NameESP:Destroy() end
    end
end

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do if p.Character then removeHighlight(p.Character) end end
    if not espEnabled then return end
    if selectedEspTarget == "Tất cả" or selectedEspTarget == "All" then
        for _, p in ipairs(Players:GetPlayers()) do if p ~= player and p.Character then createHighlight(p.Character, p) end end
    else
        for _, p in ipairs(Players:GetPlayers()) do if p ~= player and (p.Name == selectedEspTarget or p.DisplayName == selectedEspTarget) then if p.Character then createHighlight(p.Character, p) end break end end
    end
end

local function isPlayerInCooldown(targetPlayer)
    if not targetPlayer then return true end
    local lastShot = frozenPlayersTable[targetPlayer] or 0
    return (tick() - lastShot) < FREEZE_COOLDOWN
end

local function getDirectTarget()
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, nil end
    if selectedTargetPlayer and selectedTargetPlayer.Parent then
        if not isPlayerInCooldown(selectedTargetPlayer) then
            local targetChar = selectedTargetPlayer.Character
            local targetRoot = targetChar and (targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso"))
            if targetRoot and (targetRoot.Position - myRoot.Position).Magnitude <= freezeRadius then return targetRoot, selectedTargetPlayer end
        end
        return nil, nil
    end
    local closestTarget, closestPlayer
    local shortestDistance = freezeRadius
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            if not isPlayerInCooldown(targetPlayer) then
                local targetChar = targetPlayer.Character
                local targetRoot = targetChar and (targetChar:FindFirstChild("HumanoidRootPart") or targetChar:FindFirstChild("Torso"))
                if targetRoot then
                    local distance = (targetRoot.Position - myRoot.Position).Magnitude
                    if distance <= shortestDistance then shortestDistance = distance closestTarget = targetRoot closestPlayer = targetPlayer end
                end
            end
        end
    end
    return closestTarget, closestPlayer
end

local function toggleFreezeRay(state)
    freezeRayEnabled = state
    if freezeRayEnabled then
        if not freezeRayTask then
            freezeRayTask = task.spawn(function()
                while freezeRayEnabled do
                    local targetPart, targetPlayerObj = getDirectTarget()
                    if targetPart and targetPlayerObj then
                        local character = player.Character
                        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                        local backpack = player:FindFirstChild("Backpack")
                        if character and humanoid then
                            local freezeRayTool = character:FindFirstChild("FreezeRay") or (backpack and backpack:FindFirstChild("FreezeRay"))
                            if freezeRayTool then
                                if freezeRayTool.Parent == backpack then humanoid:EquipTool(freezeRayTool) end
                                local fireEvent = freezeRayTool:FindFirstChild("FireEvent") or freezeRayTool:FindFirstChild("RemoteEvent")
                                if fireEvent then fireEvent:FireServer(targetPart.Position, targetPart) frozenPlayersTable[targetPlayerObj] = tick() end
                            end
                        end
                    end
                    task.wait(SHOT_DELAY)
                end
            end)
        end
    else
        if freezeRayTask then task.cancel(freezeRayTask); freezeRayTask = nil end
    end
end

local function findAllCoins()
    local coins = {}
    for _, part in ipairs(Workspace:GetDescendants()) do if part:IsA("BasePart") and part.Name == coinName then table.insert(coins, part) end end
    return coins
end

local function teleportLoop()
    while true do
        if tpEnabled then
            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if character and humanoid and rootPart then
                local coins = findAllCoins()
                for _, coin in ipairs(coins) do
                    if not tpEnabled then break end
                    pcall(function()
                        if coin and coin.Parent then
                            rootPart.CFrame = CFrame.new(coin.Position + Vector3.new(0, 1, 0))
                            humanoid:Move(Vector3.new(1, 0, 0), true)
                            humanoid.Jump = false
                        end
                    end)
                    task.wait(tpSpeed)
                end
            end
        end
        task.wait(tpSpeed > 0 and tpSpeed or 0.1)
    end
end
task.spawn(teleportLoop)

-- ==========================================
-- GIAO DIỆN GUI (KHÔNG TRÀN - CÓ BẢNG CUỘN)
-- ==========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Nút Thu Nhỏ Tròn Tròn (Mở UI)
local openUIButton = Instance.new("TextButton")
openUIButton.Size = UDim2.new(0, 50, 0, 50)
openUIButton.Position = UDim2.new(0.05, 0, 0.4, 0)
openUIButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
openUIButton.Text = "HUB"
openUIButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openUIButton.Font = GLOBAL_FONT
openUIButton.TextSize = 16
openUIButton.Visible = false
openUIButton.Active = true
openUIButton.Draggable = true
openUIButton.Parent = screenGui

local openUICorner = Instance.new("UICorner")
openUICorner.CornerRadius = UDim.new(1, 0)
openUICorner.Parent = openUIButton

local openUIStroke = Instance.new("UIStroke")
openUIStroke.Thickness = 2
openUIStroke.Color = Color3.fromRGB(80, 80, 255)
openUIStroke.Parent = openUIButton

-- FPS Button
local fpsButton = Instance.new("TextButton")
fpsButton.Name = "FPSDisplayButton"
fpsButton.Size = UDim2.new(0, 85, 0, 32)
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

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 6)
fpsCorner.Parent = fpsButton

local frameCount = 0
local lastUpdate = tick()

local function toggleFPSDisplay(state)
    fpsEnabled = state
    fpsButton.Visible = fpsEnabled
    if fpsEnabled then
        if not fpsConnection then
            fpsConnection = RunService.RenderStepped:Connect(function()
                frameCount = frameCount + 1
                local now = tick()
                if now - lastUpdate >= 1 then
                    local fps = math.floor(frameCount / (now - lastUpdate))
                    fpsButton.Text = "FPS: " .. tostring(fps)
                    if fps <= 15 then fpsButton.TextColor3 = Color3.fromRGB(255, 50, 50)
                    elseif fps <= 30 then fpsButton.TextColor3 = Color3.fromRGB(255, 200, 0)
                    else fpsButton.TextColor3 = Color3.fromRGB(50, 255, 50) end
                    frameCount = 0 lastUpdate = now
                end
            end)
        end
    else
        if fpsConnection then fpsConnection:Disconnect(); fpsConnection = nil end
    end
end

-- KHUNG CHÍNH (FRAME)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 390, 0, 320)
frame.Position = UDim2.new(0.5, -195, 0.5, -160)
frame.BackgroundColor3 = boardBgColor
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = screenGui
frame.Visible = true

-- Container chứa hạt nền
local particleContainer = Instance.new("Frame")
particleContainer.Name = "ParticleContainer"
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.ZIndex = 1
particleContainer.Parent = frame

local gradientFrame = Instance.new("UIGradient")
gradientFrame.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(30, 25, 40)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 20))
}
gradientFrame.Rotation = 45
gradientFrame.Parent = frame

task.spawn(function()
    local rot = 0
    while task.wait() do
        if not gradientFrame or not gradientFrame.Parent then break end
        rot = rot + 0.5
        if rot >= 360 then rot = 0 end
        gradientFrame.Rotation = rot
    end
end)

-- HIỆU ỨNG HẠT NỀN BAY TỪ DƯỚI LÊN TỚI ĐỈNH BẢNG
task.spawn(function()
    while task.wait(0.25) do
        if frame and frame.Parent and frame.Visible then
            local size = math.random(3, 8)
            local posX = math.random(2, 98) / 100
            local speed = math.random(35, 65) / 10

            local p = Instance.new("Frame")
            p.Size = UDim2.new(0, size, 0, size)
            p.Position = UDim2.new(posX, 0, 1, 5)
            p.BackgroundColor3 = particleColor
            p.BackgroundTransparency = math.random(2, 5) / 10
            p.BorderSizePixel = 0
            p.ZIndex = 1
            p.Parent = particleContainer

            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(1, 0)
            pCorner.Parent = p

            table.insert(activeParticles, p)

            local tween = TweenService:Create(p, TweenInfo.new(speed, Enum.EasingStyle.Linear), {
                Position = UDim2.new(posX + (math.random(-10, 10) / 100), 0, -0.1, 0),
                BackgroundTransparency = 1
            })
            tween:Play()
            tween.Completed:Connect(function()
                for idx, item in ipairs(activeParticles) do
                    if item == p then
                        table.remove(activeParticles, idx)
                        break
                    end
                end
                p:Destroy()
            end)
        elseif not screenGui or not screenGui.Parent then
            break
        end
    end
end)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(60, 60, 100)
frameStroke.Thickness = 2
frameStroke.Transparency = 0.4
frameStroke.Parent = frame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "H HUB - AutoFarm"
titleText.TextColor3 = currentTextColor
titleText.Font = GLOBAL_FONT
titleText.TextSize = 15
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.ZIndex = 2
titleText.Parent = titleBar
table.insert(textElements, titleText)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 28, 0, 22)
minimizeButton.Position = UDim2.new(1, -62, 0, 6)
minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = GLOBAL_FONT
minimizeButton.TextSize = 20
minimizeButton.ZIndex = 2
minimizeButton.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 4)
minCorner.Parent = minimizeButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 28, 0, 22)
closeButton.Position = UDim2.new(1, -30, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = GLOBAL_FONT
closeButton.TextSize = 13
closeButton.ZIndex = 2
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BackgroundTransparency = 0.5
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 2
sidebar.Parent = frame

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 8)
sideCorner.Parent = sidebar

local line = Instance.new("Frame")
line.Size = UDim2.new(0, 1, 1, 0)
line.Position = UDim2.new(1, 0, 0, 0)
line.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
line.BorderSizePixel = 0
line.ZIndex = 2
line.Parent = sidebar

-- Container
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -115, 1, -35)
container.Position = UDim2.new(0, 115, 0, 35)
container.BackgroundTransparency = 1
container.ZIndex = 2
container.Parent = frame

-- TẠO TAB DẠNG SCROLLING FRAME
local tabs = {}
local tabNames = {"Main", "ESP", "FixLag", "Misc"}

for _, name in ipairs(tabNames) do
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Size = UDim2.new(1, -5, 1, 0)
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.ScrollBarThickness = 4
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabScroll.Visible = false
    tabScroll.ZIndex = 2
    tabScroll.Parent = container
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout.Parent = tabScroll
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 6)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.PaddingLeft = UDim.new(0, 2)
    padding.PaddingRight = UDim.new(0, 6)
    padding.Parent = tabScroll
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        tabScroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
    end)
    
    tabs[name] = tabScroll
end

-- ==========================================
-- HÀM MÀU SẮC & CẬP NHẬT TRẠNG THÁI
-- ==========================================

local function updateButtonVisual(btn, isOn)
    if isOn then
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 160, 85)}):Play()
    else
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = currentThemeColor}):Play()
    end
end

local function applyThemeColor(color)
    currentThemeColor = color
    for _, btn in ipairs(themeButtons) do
        if btn and btn.Parent then
            local isBtnOn = btn:GetAttribute("IsOnState")
            if not isBtnOn then
                btn.BackgroundColor3 = currentThemeColor
            end
        end
    end
end

local function applyTextColor(color)
    currentTextColor = color
    for _, txt in ipairs(textElements) do
        if txt and txt.Parent then
            txt.TextColor3 = currentTextColor
        end
    end
end

local function applyBoardBgColor(color)
    boardBgColor = color
    frame.BackgroundColor3 = boardBgColor
    gradientFrame.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, boardBgColor),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(math.min(boardBgColor.R * 255 + 20, 255), math.min(boardBgColor.G * 255 + 20, 255), math.min(boardBgColor.B * 255 + 20, 255))),
        ColorSequenceKeypoint.new(1.00, boardBgColor)
    }
end

local function applyParticleColor(color)
    particleColor = color
    for _, p in ipairs(activeParticles) do
        if p and p.Parent then
            p.BackgroundColor3 = particleColor
        end
    end
end

local function createToggleRow(parentTab, labelKey, stateBool, callback)
    local frameRow = Instance.new("Frame")
    frameRow.Size = UDim2.new(1, 0, 0, 32)
    frameRow.BackgroundTransparency = 1
    frameRow.ZIndex = 2
    frameRow.Parent = parentTab

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = currentThemeColor
    btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT
    btn.TextSize = 11
    btn.ZIndex = 2
    btn.Parent = frameRow
    table.insert(themeButtons, btn)
    table.insert(textElements, btn)

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local function refreshStateText()
        local t = translations[currentLang]
        local statusStr = stateBool and (" [" .. t.on .. "]") or (" [" .. t.off .. "]")
        btn.Text = (t[labelKey] or labelKey) .. statusStr
        btn:SetAttribute("IsOnState", stateBool)
        updateButtonVisual(btn, stateBool)
    end

    btn.MouseButton1Click:Connect(function()
        stateBool = not stateBool
        refreshStateText()
        callback(stateBool)
    end)

    refreshStateText()
    return btn, refreshStateText
end

local function createInputRow(parentTab, labelKey, defaultVal, callback)
    local frameRow = Instance.new("Frame")
    frameRow.Size = UDim2.new(1, 0, 0, 30)
    frameRow.BackgroundTransparency = 1
    frameRow.ZIndex = 2
    frameRow.Parent = parentTab

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = currentTextColor
    lbl.Font = GLOBAL_FONT
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 2
    lbl.Parent = frameRow
    table.insert(textElements, lbl)

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.38, 0, 1, 0)
    box.Position = UDim2.new(0.62, 0, 0, 0)
    box.BackgroundColor3 = currentThemeColor
    box.TextColor3 = currentTextColor
    box.Font = GLOBAL_FONT
    box.TextSize = 11
    box.Text = tostring(defaultVal)
    box.ZIndex = 2
    box.Parent = frameRow
    table.insert(themeButtons, box)
    table.insert(textElements, box)

    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = box

    box.FocusLost:Connect(function(enter)
        local val = tonumber(box.Text)
        if val then callback(val) else box.Text = tostring(defaultVal) end
    end)

    local function refreshLabel()
        local t = translations[currentLang]
        lbl.Text = t[labelKey] or labelKey
    end
    refreshLabel()

    return frameRow, refreshLabel
end

-- ==========================================
-- TAB CHÍNH (MAIN TAB)
-- ==========================================
local mainTab = tabs["Main"]
mainTab.Visible = true

local refreshFuncs = {}

local _, r1 = createInputRow(mainTab, "tpSpd", tpSpeed, function(val) tpSpeed = val end)
table.insert(refreshFuncs, r1)
local _, r2 = createToggleRow(mainTab, "tpBtn", tpEnabled, function(st) tpEnabled = st end)
table.insert(refreshFuncs, r2)

local _, r3 = createInputRow(mainTab, "walkSpd", walkSpeed, function(val)
    walkSpeed = val
    if walkEnabled and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
    end
end)
table.insert(refreshFuncs, r3)
local _, r4 = createToggleRow(mainTab, "walkBtn", walkEnabled, function(st)
    walkEnabled = st
    if walkEnabled then
        if walkConnection then walkConnection:Disconnect() end
        walkConnection = RunService.RenderStepped:Connect(function()
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = walkSpeed end
        end)
    else
        if walkConnection then walkConnection:Disconnect(); walkConnection = nil end
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = 16 end
    end
end)
table.insert(refreshFuncs, r4)

local _, r5 = createInputRow(mainTab, "jumpSpd", jumpPower, function(val)
    jumpPower = val
    if jumpEnabled and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
        player.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
        player.Character:FindFirstChildOfClass("Humanoid").JumpPower = jumpPower
    end
end)
table.insert(refreshFuncs, r5)
local _, r6 = createToggleRow(mainTab, "jumpBtn", jumpEnabled, function(st)
    jumpEnabled = st
    if jumpEnabled then
        if jumpConnection then jumpConnection:Disconnect() end
        jumpConnection = RunService.RenderStepped:Connect(function()
            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.UseJumpPower = true hum.JumpPower = jumpPower end
        end)
    else
        if jumpConnection then jumpConnection:Disconnect(); jumpConnection = nil end
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = 50 end
    end
end)
table.insert(refreshFuncs, r6)

local _, r7 = createInputRow(mainTab, "flySpd", flySpeed, function(val) flySpeed = val end)
table.insert(refreshFuncs, r7)
local _, r8 = createToggleRow(mainTab, "flyBtn", flyEnabled, function(st) toggleFly(st) end)
table.insert(refreshFuncs, r8)

local _, r9 = createInputRow(mainTab, "gravSpd", customGravity, function(val) customGravity = val if gravityEnabled then Workspace.Gravity = customGravity end end)
table.insert(refreshFuncs, r9)
local _, r10 = createToggleRow(mainTab, "gravBtn", gravityEnabled, function(st)
    gravityEnabled = st
    if gravityEnabled then
        if gravityConnection then gravityConnection:Disconnect() end
        gravityConnection = RunService.RenderStepped:Connect(function() Workspace.Gravity = customGravity end)
    else
        if gravityConnection then gravityConnection:Disconnect(); gravityConnection = nil end
        Workspace.Gravity = 196.2
    end
end)
table.insert(refreshFuncs, r10)

local _, r11 = createToggleRow(mainTab, "noclipBtn", noclipEnabled, function(st) toggleNoclip(st) end)
table.insert(refreshFuncs, r11)
local _, r12 = createToggleRow(mainTab, "invisBtn", invisibleEnabled, function(st) toggleInvisibility(st) end)
table.insert(refreshFuncs, r12)
local _, r13 = createToggleRow(mainTab, "infJumpBtn", infJumpEnabled, function(st) toggleInfJump(st) end)
table.insert(refreshFuncs, r13)

local _, r14 = createInputRow(mainTab, "freezeRng", freezeRadius, function(val) freezeRadius = val end)
table.insert(refreshFuncs, r14)
local _, r15 = createToggleRow(mainTab, "freezeBtn", freezeRayEnabled, function(st) toggleFreezeRay(st) end)
table.insert(refreshFuncs, r15)

local _, r16 = createToggleRow(mainTab, "autoEquipBtn", autoEquipEnabled, function(st) toggleAutoEquip(st) end)
table.insert(refreshFuncs, r16)

local _, r17_1 = createInputRow(mainTab, "autoPressRadiusLabel", autoPressRadius, function(val) autoPressRadius = val end)
table.insert(refreshFuncs, r17_1)
local _, r17_2 = createInputRow(mainTab, "autoPressDelayLabel", autoPressDelay, function(val) autoPressDelay = val end)
table.insert(refreshFuncs, r17_2)
local _, r17 = createToggleRow(mainTab, "autoPressBtn", autoPressButtonEnabled, function(st) toggleAutoPressButton(st) end)
table.insert(refreshFuncs, r17)

-- NÚT GOD MODE
local godRowFrame = Instance.new("Frame")
godRowFrame.Size = UDim2.new(1, 0, 0, 36)
godRowFrame.BackgroundTransparency = 1
godRowFrame.ZIndex = 2
godRowFrame.Parent = mainTab

local godButton = Instance.new("TextButton")
godButton.Size = UDim2.new(1, 0, 1, 0)
godButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
godButton.TextColor3 = Color3.fromRGB(255, 255, 255)
godButton.Font = GLOBAL_FONT
godButton.TextSize = 12
godButton.Text = "⚡ Bảng God Mode (Bất Tử)"
godButton.ZIndex = 2
godButton.Parent = godRowFrame

local godCorner = Instance.new("UICorner")
godCorner.CornerRadius = UDim.new(0, 6)
godCorner.Parent = godButton

godButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))()
end)

-- ==========================================
-- TAB PLAYERS / ESP
-- ==========================================
local espTab = tabs["ESP"]

local _, rEsp = createToggleRow(espTab, "espBtn", espEnabled, function(st) espEnabled = st updateESP() end)
table.insert(refreshFuncs, rEsp)

local _, rFps = createToggleRow(espTab, "fpsBtn", fpsEnabled, function(st) toggleFPSDisplay(st) end)
table.insert(refreshFuncs, rFps)

local espColorLabel = Instance.new("TextLabel")
espColorLabel.Size = UDim2.new(1, 0, 0, 20)
espColorLabel.BackgroundTransparency = 1
espColorLabel.TextColor3 = currentTextColor
espColorLabel.Font = GLOBAL_FONT
espColorLabel.TextSize = 11
espColorLabel.TextXAlignment = Enum.TextXAlignment.Left
espColorLabel.ZIndex = 2
espColorLabel.Parent = espTab
table.insert(textElements, espColorLabel)

local espColorPalette = Instance.new("Frame")
espColorPalette.Size = UDim2.new(1, 0, 0, 28)
espColorPalette.BackgroundTransparency = 1
espColorPalette.ZIndex = 2
espColorPalette.Parent = espTab

local espColors = {
    Color3.fromRGB(255, 50, 50),
    Color3.fromRGB(50, 255, 50),
    Color3.fromRGB(50, 150, 255),
    Color3.fromRGB(255, 255, 50),
    Color3.fromRGB(255, 50, 255),
    Color3.fromRGB(255, 255, 255)
}

for i, col in ipairs(espColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.ZIndex = 2
    cBtn.Parent = espColorPalette

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function() espColor = col updateESP() end)
end

-- ==========================================
-- TAB FIX LAG
-- ==========================================
local fixLagTab = tabs["FixLag"]

local _, rLag1 = createToggleRow(fixLagTab, "fixLagBtn", fixLagEnabled, function(st) toggleFixLag(st) end)
table.insert(refreshFuncs, rLag1)

local _, rLag2 = createToggleRow(fixLagTab, "hideMapBtn", hideMapOthersEnabled, function(st) toggleHideMapAndOthers(st) end)
table.insert(refreshFuncs, rLag2)

local _, rLag3 = createToggleRow(fixLagTab, "muteSoundsBtn", muteAllSoundsEnabled, function(st) toggleMuteAllSounds(st) end)
table.insert(refreshFuncs, rLag3)

-- ==========================================
-- TAB SETTINGS / MISC (CÀI ĐẶT)
-- ==========================================
local miscTab = tabs["Misc"]

-- Chỉnh màu nút UI
local themeLabel = Instance.new("TextLabel")
themeLabel.Size = UDim2.new(1, 0, 0, 18)
themeLabel.BackgroundTransparency = 1
themeLabel.TextColor3 = currentTextColor
themeLabel.Font = GLOBAL_FONT
themeLabel.TextSize = 11
themeLabel.TextXAlignment = Enum.TextXAlignment.Left
themeLabel.ZIndex = 2
themeLabel.Parent = miscTab
table.insert(textElements, themeLabel)

local themePalette = Instance.new("Frame")
themePalette.Size = UDim2.new(1, 0, 0, 28)
themePalette.BackgroundTransparency = 1
themePalette.ZIndex = 2
themePalette.Parent = miscTab

local uiThemeColors = {
    Color3.fromRGB(35, 35, 45),
    Color3.fromRGB(50, 40, 80),
    Color3.fromRGB(30, 60, 90),
    Color3.fromRGB(70, 30, 40),
    Color3.fromRGB(30, 70, 50)
}

for i, col in ipairs(uiThemeColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.ZIndex = 2
    cBtn.Parent = themePalette

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function() applyThemeColor(col) end)
end

-- Chỉnh màu chữ UI
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 18)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = currentTextColor
textLabel.Font = GLOBAL_FONT
textLabel.TextSize = 11
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.ZIndex = 2
textLabel.Parent = miscTab
table.insert(textElements, textLabel)

local textPalette = Instance.new("Frame")
textPalette.Size = UDim2.new(1, 0, 0, 28)
textPalette.BackgroundTransparency = 1
textPalette.ZIndex = 2
textPalette.Parent = miscTab

local uiTextColors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 220, 100),
    Color3.fromRGB(100, 255, 200),
    Color3.fromRGB(255, 150, 200)
}

for i, col in ipairs(uiTextColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.ZIndex = 2
    cBtn.Parent = textPalette

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function() applyTextColor(col) end)
end

-- Chỉnh màu nền bảng HUB
local bgBoardLabel = Instance.new("TextLabel")
bgBoardLabel.Size = UDim2.new(1, 0, 0, 18)
bgBoardLabel.BackgroundTransparency = 1
bgBoardLabel.TextColor3 = currentTextColor
bgBoardLabel.Font = GLOBAL_FONT
bgBoardLabel.TextSize = 11
bgBoardLabel.TextXAlignment = Enum.TextXAlignment.Left
bgBoardLabel.ZIndex = 2
bgBoardLabel.Parent = miscTab
table.insert(textElements, bgBoardLabel)

local bgBoardPalette = Instance.new("Frame")
bgBoardPalette.Size = UDim2.new(1, 0, 0, 28)
bgBoardPalette.BackgroundTransparency = 1
bgBoardPalette.ZIndex = 2
bgBoardPalette.Parent = miscTab

local uiBoardColors = {
    Color3.fromRGB(20, 20, 25),
    Color3.fromRGB(15, 20, 35),
    Color3.fromRGB(25, 15, 35),
    Color3.fromRGB(35, 15, 20),
    Color3.fromRGB(15, 30, 25)
}

for i, col in ipairs(uiBoardColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.ZIndex = 2
    cBtn.Parent = bgBoardPalette

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function() applyBoardBgColor(col) end)
end

-- Chỉnh màu Hạt Bay Nền
local particleColorLabel = Instance.new("TextLabel")
particleColorLabel.Size = UDim2.new(1, 0, 0, 18)
particleColorLabel.BackgroundTransparency = 1
particleColorLabel.TextColor3 = currentTextColor
particleColorLabel.Font = GLOBAL_FONT
particleColorLabel.TextSize = 11
particleColorLabel.TextXAlignment = Enum.TextXAlignment.Left
particleColorLabel.ZIndex = 2
particleColorLabel.Parent = miscTab
table.insert(textElements, particleColorLabel)

local particlePalette = Instance.new("Frame")
particlePalette.Size = UDim2.new(1, 0, 0, 28)
particlePalette.BackgroundTransparency = 1
particlePalette.ZIndex = 2
particlePalette.Parent = miscTab

local uiParticleColors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 100, 200),
    Color3.fromRGB(255, 220, 100),
    Color3.fromRGB(180, 100, 255)
}

for i, col in ipairs(uiParticleColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.ZIndex = 2
    cBtn.Parent = particlePalette

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function() applyParticleColor(col) end)
end

-- Chọn ngôn ngữ & Server buttons
local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1, 0, 0, 18)
langLabel.BackgroundTransparency = 1
langLabel.TextColor3 = currentTextColor
langLabel.Font = GLOBAL_FONT
langLabel.TextSize = 11
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.ZIndex = 2
langLabel.Parent = miscTab
table.insert(textElements, langLabel)

local langFrame = Instance.new("Frame")
langFrame.Size = UDim2.new(1, 0, 0, 30)
langFrame.BackgroundTransparency = 1
langFrame.ZIndex = 2
langFrame.Parent = miscTab

local btnEnglish = Instance.new("TextButton")
btnEnglish.Size = UDim2.new(0.48, 0, 1, 0)
btnEnglish.BackgroundColor3 = currentThemeColor
btnEnglish.TextColor3 = currentTextColor
btnEnglish.Font = GLOBAL_FONT
btnEnglish.TextSize = 11
btnEnglish.Text = "English"
btnEnglish.ZIndex = 2
btnEnglish.Parent = langFrame
table.insert(themeButtons, btnEnglish)
table.insert(textElements, btnEnglish)

local engCorner = Instance.new("UICorner")
engCorner.CornerRadius = UDim.new(0, 6)
engCorner.Parent = btnEnglish

local btnVietnamese = Instance.new("TextButton")
btnVietnamese.Size = UDim2.new(0.48, 0, 1, 0)
btnVietnamese.Position = UDim2.new(0.52, 0, 0, 0)
btnVietnamese.BackgroundColor3 = currentThemeColor
btnVietnamese.TextColor3 = currentTextColor
btnVietnamese.Font = GLOBAL_FONT
btnVietnamese.TextSize = 11
btnVietnamese.Text = "Tiếng Việt"
btnVietnamese.ZIndex = 2
btnVietnamese.Parent = langFrame
table.insert(themeButtons, btnVietnamese)
table.insert(textElements, btnVietnamese)

local vieCorner = Instance.new("UICorner")
vieCorner.CornerRadius = UDim.new(0, 6)
vieCorner.Parent = btnVietnamese

local serverFrame = Instance.new("Frame")
serverFrame.Size = UDim2.new(1, 0, 0, 32)
serverFrame.BackgroundTransparency = 1
serverFrame.ZIndex = 2
serverFrame.Parent = miscTab

local rejoinButton = Instance.new("TextButton")
rejoinButton.Size = UDim2.new(0.48, 0, 1, 0)
rejoinButton.Position = UDim2.new(0, 0, 0, 0)
rejoinButton.BackgroundColor3 = currentThemeColor
rejoinButton.TextColor3 = currentTextColor
rejoinButton.Font = GLOBAL_FONT
rejoinButton.TextSize = 11
rejoinButton.ZIndex = 2
rejoinButton.Parent = serverFrame
table.insert(themeButtons, rejoinButton)
table.insert(textElements, rejoinButton)

local rejoinCorner = Instance.new("UICorner")
rejoinCorner.CornerRadius = UDim.new(0, 6)
rejoinCorner.Parent = rejoinButton

local serverHopButton = Instance.new("TextButton")
serverHopButton.Size = UDim2.new(0.48, 0, 1, 0)
serverHopButton.Position = UDim2.new(0.52, 0, 0, 0)
serverHopButton.BackgroundColor3 = currentThemeColor
serverHopButton.TextColor3 = currentTextColor
serverHopButton.Font = GLOBAL_FONT
serverHopButton.TextSize = 11
serverHopButton.ZIndex = 2
serverHopButton.Parent = serverFrame
table.insert(themeButtons, serverHopButton)
table.insert(textElements, serverHopButton)

local hopCorner = Instance.new("UICorner")
hopCorner.CornerRadius = UDim.new(0, 6)
hopCorner.Parent = serverHopButton

rejoinButton.MouseButton1Click:Connect(rejoinServer)
serverHopButton.MouseButton1Click:Connect(serverHop)

local function updateLanguage()
    local t = translations[currentLang]
    titleText.Text = t.title
    godButton.Text = t.godBtn
    espColorLabel.Text = t.espColorLabel
    themeLabel.Text = t.themeLabel
    textLabel.Text = t.textLabel
    bgBoardLabel.Text = t.bgBoardLabel
    particleColorLabel.Text = t.particleColorLabel
    langLabel.Text = t.langLabel
    rejoinButton.Text = t.rejoinBtn
    serverHopButton.Text = t.serverHopBtn

    for _, rf in ipairs(refreshFuncs) do
        rf()
    end
end

btnEnglish.MouseButton1Click:Connect(function() currentLang = "EN" updateLanguage() end)
btnVietnamese.MouseButton1Click:Connect(function() currentLang = "VI" updateLanguage() end)

local tabButtons = {}
local yOffset = 10
for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 32)
    btn.Position = UDim2.new(0, 8, 0, yOffset)
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(70, 70, 90) or Color3.fromRGB(30, 30, 40)
    btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT
    btn.TextSize = 11
    btn.ZIndex = 2
    btn.Parent = sidebar
    table.insert(textElements, btn)

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, b in pairs(tabButtons) do TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play() end
        tabs[name].Visible = true
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 90)}):Play()
    end)

    tabButtons[name] = btn
    yOffset = yOffset + 40
end

local function updateSidebarTabNames()
    local t = translations[currentLang]
    tabButtons["Main"].Text = t.tabMain
    tabButtons["ESP"].Text = t.tabEsp
    tabButtons["FixLag"].Text = t.tabFixLag
    tabButtons["Misc"].Text = t.tabMisc
end

for _, btn in ipairs(screenGui:GetDescendants()) do
    if btn:IsA("TextButton") then
        local scale = Instance.new("UIScale")
        scale.Parent = btn
        btn.MouseEnter:Connect(function() TweenService:Create(scale, TweenInfo.new(0.12), {Scale = 1.03}):Play() end)
        btn.MouseLeave:Connect(function() TweenService:Create(scale, TweenInfo.new(0.12), {Scale = 1.0}):Play() end)
        btn.MouseButton1Down:Connect(function() TweenService:Create(scale, TweenInfo.new(0.08), {Scale = 0.95}):Play() end)
        btn.MouseButton1Up:Connect(function() TweenService:Create(scale, TweenInfo.new(0.08), {Scale = 1.03}):Play() end)
    end
end

minimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.25)
    frame.Visible = false
    openUIButton.Visible = true
    TweenService:Create(openUIButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0,50,0,50)}):Play()
end)

openUIButton.MouseButton1Click:Connect(function()
    TweenService:Create(openUIButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.15)
    openUIButton.Visible = false
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 390, 0, 320)}):Play()
end)

closeButton.MouseButton1Click:Connect(function()
    toggleNoclip(false) toggleInvisibility(false) toggleFly(false) toggleInfJump(false) toggleFreezeRay(false) toggleFPSDisplay(false) toggleAutoPressButton(false) toggleFixLag(false) toggleHideMapAndOthers(false) toggleMuteAllSounds(false) toggleAutoEquip(false)
    if gravityConnection then gravityConnection:Disconnect() gravityConnection = nil end Workspace.Gravity = 196.2
    espEnabled = false updateESP()
    if walkConnection then walkConnection:Disconnect() walkConnection = nil end
    if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
    tpEnabled = false
    screenGui:Destroy()
end)

updateSidebarTabNames()
updateLanguage()

frame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 390, 0, 320)}):Play()
