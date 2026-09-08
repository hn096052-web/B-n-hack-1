-- ==========================================
-- H HUB AUTOFARM (ULTRA FIX LAG + EXTREME OPTIMIZATION + UI ANIMATIONS)
-- ==========================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Dọn dẹp GUI cũ
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
local SoundService = game:GetService("SoundService")

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
local walkSpeed = 50 
local jumpPower = 35
local flySpeed = 25
local customGravity = 196.2
local coinName = "Coin"
local freezeRadius = 150 
local autoPressRadius = 15
local autoPressDelay = 0.1
local FREEZE_COOLDOWN = 6 
local SHOT_DELAY = 1 
local selectedTargetPlayer = nil 

-- Cấu hình ESP
local selectedEspTarget = "Tất cả"
local espColor = Color3.fromRGB(255, 0, 0)

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

-- Theme UI
local themeBackgrounds = {} 
local themeButtons = {}     
local textElements = {}     

-- Font chữ hiện đại
local GLOBAL_FONT = Enum.Font.GothamBold

local translations = {
    EN = {
        title = "H HUB - AutoFarm",
        tabMain = "Main",
        tabEsp = "Players/ESP",
        tabMisc = "Settings",
        tabFixLag = "Fix Lag",
        tpSpd = "TP Spd",
        walkSpd = "Walk Spd",
        flySpd = "Fly Spd",
        jumpSpd = "Jump Spd",
        gravSpd = "Gravity",
        freezeRng = "Freeze Rng",
        clickDelayLabel = "Click Delay (s)",
        targetBtn = "Target: ",
        allTarget = "All",
        tpBtn = "TP: ",
        walkBtn = "Speed: ",
        jumpBtn = "Jump: ",
        flyBtn = "Fly: ",
        gravBtn = "Grav: ",
        noclipBtn = "Noclip: ",
        invisBtn = "Invis: ",
        infJumpBtn = "Inf Jump: ",
        freezeBtn = "Auto Freeze: ",
        autoEquipBtn = "Auto Equip: ",
        godBtn = "God Mode Panel",
        espBtn = "ESP Wallhack: ",
        fpsBtn = "Display FPS: ",
        autoPressBtn = "Auto Click All (R: ",
        fixLagBtn = "Ultra Fix Lag (Max FPS): ",
        hideMapBtn = "Hide Map & Others: ",
        muteSoundsBtn = "Mute All Game Sounds: ",
        espColorLabel = "ESP Color:",
        themeLabel = "UI Theme Color:",
        textLabel = "Text Color:",
        langLabel = "Language:",
        rejoinBtn = "Rejoin Server",
        serverHopBtn = "Server Hop",
        refreshBtn = "Refresh Player List",
        selected = " (Selected)",
        on = "ON",
        off = "OFF"
    },
    VI = {
        title = "H HUB - AutoFarm",
        tabMain = "Chính",
        tabEsp = "Người chơi/ESP",
        tabMisc = "Cài đặt",
        tabFixLag = "Fix Lag",
        tpSpd = "Tốc độ TP",
        walkSpd = "Tốc độ Đi",
        flySpd = "Tốc độ Bay",
        jumpSpd = "Độ Nhảy",
        gravSpd = "Trọng lực",
        freezeRng = "Tầm Freeze",
        clickDelayLabel = "Tốc độ Click (s)",
        targetBtn = "Mục tiêu: ",
        allTarget = "Tất cả",
        tpBtn = "TP: ",
        walkBtn = "Tốc độ: ",
        jumpBtn = "Nhảy: ",
        flyBtn = "Fly: ",
        gravBtn = "Gravity: ",
        noclipBtn = "Noclip: ",
        invisBtn = "Tàng hình: ",
        infJumpBtn = "Nhảy Vô Hạn: ",
        freezeBtn = "Auto Freeze: ",
        autoEquipBtn = "Auto Trang Bị: ",
        godBtn = "Bảng God Mode",
        espBtn = "ESP Xuyên Tường: ",
        fpsBtn = "Hiện FPS: ",
        autoPressBtn = "Auto Click Tất Cả (R: ",
        fixLagBtn = "Siêu Tối Ưu (Max FPS): ",
        hideMapBtn = "Ẩn Map & Người Khác: ",
        muteSoundsBtn = "Tắt Tất Cả Âm Thanh: ",
        espColorLabel = "Màu sắc ESP:",
        themeLabel = "Chỉnh màu giao diện:",
        textLabel = "Chỉnh màu chữ:",
        langLabel = "Chọn ngôn ngữ:",
        rejoinBtn = "Vào lại Server",
        serverHopBtn = "Đổi Server (Hop)",
        refreshBtn = "Làm mới danh sách",
        selected = " (Đã chọn)",
        on = "BẬT",
        off = "TẮT"
    }
}

-- ==========================================
-- CÁC LOGIC CHỨC NĂNG BÊN TRONG (GIỮ NGUYÊN)
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
        elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 v:Destroy()
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
            Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; Lighting.FogStart = 9e9; Lighting.Brightness = 1; Lighting.Technology = Enum.Technology.Compatibility
            local terrain = Workspace:FindFirstChildOfClass("Terrain")
            if terrain then terrain.WaterWaveSize = 0 terrain.WaterWaveSpeed = 0 terrain.WaterReflectance = 0 terrain.WaterTransparency = 0 terrain.Decoration = false end
        end)
        for _, v in ipairs(game:GetDescendants()) do optimizePartExtreme(v) end
        if not fixLagChildConnection then fixLagChildConnection = game.DescendantAdded:Connect(function(v) if fixLagEnabled then optimizePartExtreme(v) end end) end
        if not fixLagTask then
            fixLagTask = task.spawn(function()
                while fixLagEnabled do
                    for _, v in ipairs(Workspace:GetDescendants()) do if not fixLagEnabled then break end optimizePartExtreme(v) end
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
                                local isNear = false
                                if v:IsA("BasePart") then isNear = (root.Position - v.Position).Magnitude <= autoPressRadius
                                elseif v:IsA("PVInstance") then isNear = (root.Position - v:GetPivot().Position).Magnitude <= autoPressRadius
                                elseif v.Parent and v.Parent:IsA("BasePart") then isNear = (root.Position - v.Parent.Position).Magnitude <= autoPressRadius end

                                if isNear then
                                    if v:IsA("ClickDetector") then fireclickdetector(v)
                                    elseif v:IsA("ProximityPrompt") then fireproximityprompt(v) end
                                end
                            end
                        end
                    end)
                    task.wait(autoPressDelay > 0 and autoPressDelay or 0.05)
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
                local camFlatCFrame = CFrame.lookAt(Vector3.zero, cam.CFrame.LookVector * Vector3.new(1, 0, 1))
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
    if selectedEspTarget == "Tất cả" then
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
                    if coin and coin.Parent then
                        rootPart.CFrame = CFrame.new(coin.Position + Vector3.new(0, 1, 0))
                        humanoid:Move(Vector3.new(1, 0, 0), true)
                        humanoid.Jump = false
                        task.wait(tpSpeed)
                    end
                end
            end
        end
        task.wait(tpSpeed > 0 and tpSpeed or 0.1)
    end
end
task.spawn(teleportLoop)

-- ==========================================
-- GIAO DIỆN GUI - PRO STYLING
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
table.insert(themeBackgrounds, openUIButton)
table.insert(textElements, openUIButton)

local openUICorner = Instance.new("UICorner")
openUICorner.CornerRadius = UDim.new(1, 0) -- Tròn xoe
openUICorner.Parent = openUIButton

local openUIStroke = Instance.new("UIStroke")
openUIStroke.Thickness = 2
openUIStroke.Color = Color3.fromRGB(80, 80, 255) -- Glow nhẹ
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
 
-- KHUNG CHÍNH (FRAME) - Đã nâng cấp Shadow & Transparent
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 390, 0, 310) -- Tăng size tí xíu cho rộng rãi
frame.Position = UDim2.new(0.5, -195, 0.5, -155)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
frame.Visible = true

-- Hiệu ứng nền Gradient Cuộn mượt
local gradientFrame = Instance.new("UIGradient")
gradientFrame.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 20)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(30, 25, 40)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 20))
}
gradientFrame.Rotation = 45
gradientFrame.Parent = frame

-- Animate gradient
task.spawn(function()
    local rot = 0
    while task.wait() do
        rot = rot + 0.5
        if rot >= 360 then rot = 0 end
        gradientFrame.Rotation = rot
    end
end)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- Shadow ảo cho Frame
local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(50, 50, 80)
frameStroke.Thickness = 2
frameStroke.Transparency = 0.5
frameStroke.Parent = frame
 
-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Parent = frame
table.insert(themeBackgrounds, titleBar)

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame") -- Che góc dưới để nối vuông vức với body
titleFix.Size = UDim2.new(1, 0, 0, 10)
titleFix.Position = UDim2.new(0, 0, 1, -10)
titleFix.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleFix.BackgroundTransparency = 0.3
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar
 
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 12, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "H HUB - Xtreme"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = GLOBAL_FONT
titleText.TextSize = 15
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar
table.insert(textElements, titleText)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 20)
minimizeButton.Position = UDim2.new(1, -65, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = GLOBAL_FONT
minimizeButton.TextSize = 20
minimizeButton.Parent = titleBar
table.insert(themeButtons, minimizeButton)

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 4)
minCorner.Parent = minimizeButton
 
-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 20)
closeButton.Position = UDim2.new(1, -32, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = GLOBAL_FONT
closeButton.TextSize = 14
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton
 
-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BackgroundTransparency = 0.5
sidebar.BorderSizePixel = 0
sidebar.Parent = frame
table.insert(themeBackgrounds, sidebar)

local sideCorner = Instance.new("UICorner")
sideCorner.CornerRadius = UDim.new(0, 8)
sideCorner.Parent = sidebar

local line = Instance.new("Frame")
line.Size = UDim2.new(0, 1, 1, 0)
line.Position = UDim2.new(1, 0, 0, 0)
line.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
line.BorderSizePixel = 0
line.Parent = sidebar

-- Container
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -111, 1, -30)
container.Position = UDim2.new(0, 111, 0, 30)
container.BackgroundTransparency = 1
container.Parent = frame

local tabs = {}
local tabNames = {"Main", "ESP", "FixLag", "Misc"}

for _, name in ipairs(tabNames) do
    local tabContent = Instance.new("Frame")
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = container
    tabs[name] = tabContent
end

-- MAIN TAB
local mainTab = tabs["Main"]
mainTab.Visible = true

local colWidth = 0.235
local colGap = 0.015

local tpLabel = Instance.new("TextLabel")
tpLabel.Size = UDim2.new(colWidth, 0, 0, 14)
tpLabel.Position = UDim2.new(0 * (colWidth + colGap) + colGap, 0, 0, 8)
tpLabel.BackgroundTransparency = 1
tpLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
tpLabel.Font = GLOBAL_FONT
tpLabel.TextSize = 10
tpLabel.Parent = mainTab
table.insert(textElements, tpLabel)
 
local walkLabel = tpLabel:Clone()
walkLabel.Position = UDim2.new(1 * (colWidth + colGap) + colGap, 0, 0, 8)
walkLabel.Parent = mainTab

local jumpLabel = tpLabel:Clone()
jumpLabel.Position = UDim2.new(2 * (colWidth + colGap) + colGap, 0, 0, 8)
jumpLabel.Parent = mainTab

local flySpeedLabel = tpLabel:Clone()
flySpeedLabel.Position = UDim2.new(3 * (colWidth + colGap) + colGap, 0, 0, 8)
flySpeedLabel.Parent = mainTab

local tpBox = Instance.new("TextBox")
tpBox.Size = UDim2.new(colWidth, 0, 0, 24)
tpBox.Position = UDim2.new(0 * (colWidth + colGap) + colGap, 0, 0, 25)
tpBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
tpBox.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBox.Text = tostring(tpSpeed)
tpBox.Font = GLOBAL_FONT
tpBox.TextSize = 11
tpBox.Parent = mainTab
table.insert(themeButtons, tpBox)

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 4)
tpCorner.Parent = tpBox
 
tpBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(tpBox.Text)
        if val and val > 0 then tpSpeed = val else tpBox.Text = tostring(tpSpeed) end
    end
end)
 
local walkBox = tpBox:Clone()
walkBox.Position = UDim2.new(1 * (colWidth + colGap) + colGap, 0, 0, 25)
walkBox.Text = tostring(walkSpeed)
walkBox.Parent = mainTab
table.insert(themeButtons, walkBox)
 
walkBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(walkBox.Text)
        if val and val > 0 then
            walkSpeed = val
            if walkEnabled then
                local character = player.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.WalkSpeed = walkSpeed end
            end
        else walkBox.Text = tostring(walkSpeed) end
    end
end)

local jumpBox = tpBox:Clone()
jumpBox.Position = UDim2.new(2 * (colWidth + colGap) + colGap, 0, 0, 25)
jumpBox.Text = tostring(jumpPower)
jumpBox.Parent = mainTab
table.insert(themeButtons, jumpBox)

jumpBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(jumpBox.Text)
        if val and val > 0 then
            jumpPower = val
            if jumpEnabled then
                local character = player.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.UseJumpPower = true humanoid.JumpPower = jumpPower end
            end
        else jumpBox.Text = tostring(jumpPower) end
    end
end)

local flySpeedBox = tpBox:Clone()
flySpeedBox.Position = UDim2.new(3 * (colWidth + colGap) + colGap, 0, 0, 25)
flySpeedBox.Text = tostring(flySpeed)
flySpeedBox.Parent = mainTab
table.insert(themeButtons, flySpeedBox)

flySpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(flySpeedBox.Text)
        if val and val > 0 then flySpeed = val else flySpeedBox.Text = tostring(flySpeed) end
    end
end)

local function updateButtonVisual(btn, isOn)
    if isOn then
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 150, 80)}):Play()
    else
        TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}):Play()
    end
end

local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(colWidth, 0, 0, 26)
tpButton.Position = UDim2.new(0 * (colWidth + colGap) + colGap, 0, 0, 55)
tpButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.Font = GLOBAL_FONT
tpButton.TextSize = 11
tpButton.Parent = mainTab
table.insert(themeButtons, tpButton)
 
local tpBtnCorner = Instance.new("UICorner")
tpBtnCorner.CornerRadius = UDim.new(0, 4)
tpBtnCorner.Parent = tpButton
 
local walkButton = tpButton:Clone()
walkButton.Position = UDim2.new(1 * (colWidth + colGap) + colGap, 0, 0, 55)
walkButton.Parent = mainTab
table.insert(themeButtons, walkButton)

local jumpButton = tpButton:Clone()
jumpButton.Position = UDim2.new(2 * (colWidth + colGap) + colGap, 0, 0, 55)
jumpButton.Parent = mainTab
table.insert(themeButtons, jumpButton)

local flyButton = tpButton:Clone()
flyButton.Position = UDim2.new(3 * (colWidth + colGap) + colGap, 0, 0, 55)
flyButton.Parent = mainTab
table.insert(themeButtons, flyButton)

local quadWidth = 0.235
local quadGap = 0.015
local noclipButton = tpButton:Clone()
noclipButton.Size = UDim2.new(quadWidth, 0, 0, 26)
noclipButton.Position = UDim2.new(0 * (quadWidth + quadGap) + quadGap, 0, 0, 88)
noclipButton.Parent = mainTab
table.insert(themeButtons, noclipButton)

local invisButton = tpButton:Clone()
invisButton.Size = UDim2.new(quadWidth, 0, 0, 26)
invisButton.Position = UDim2.new(1 * (quadWidth + quadGap) + quadGap, 0, 0, 88)
invisButton.Parent = mainTab
table.insert(themeButtons, invisButton)

local infJumpButton = tpButton:Clone()
infJumpButton.Size = UDim2.new(quadWidth, 0, 0, 26)
infJumpButton.Position = UDim2.new(2 * (quadWidth + quadGap) + quadGap, 0, 0, 88)
infJumpButton.Parent = mainTab
table.insert(themeButtons, infJumpButton)

local gravityButton = tpButton:Clone()
gravityButton.Size = UDim2.new(quadWidth, 0, 0, 26)
gravityButton.Position = UDim2.new(3 * (quadWidth + quadGap) + quadGap, 0, 0, 88)
gravityButton.Parent = mainTab
table.insert(themeButtons, gravityButton)

local gravLabel = tpLabel:Clone()
gravLabel.Size = UDim2.new(0.31, 0, 0, 14)
gravLabel.Position = UDim2.new(0, 4, 0, 120)
gravLabel.Parent = mainTab

local gravBox = tpBox:Clone()
gravBox.Size = UDim2.new(0.31, 0, 0, 26)
gravBox.Position = UDim2.new(0, 4, 0, 136)
gravBox.Text = tostring(customGravity)
gravBox.Parent = mainTab
table.insert(themeButtons, gravBox)

gravBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(gravBox.Text)
        if val then 
            customGravity = val
            if gravityEnabled then Workspace.Gravity = customGravity end
        else gravBox.Text = tostring(customGravity) end
    end
end)

local freezeRangeLabel = tpLabel:Clone()
freezeRangeLabel.Size = UDim2.new(0, 20, 0, 14)
freezeRangeLabel.Position = UDim2.new(0.33, 0, 0, 120)
freezeRangeLabel.Parent = mainTab

local freezeRangeBox = tpBox:Clone()
freezeRangeBox.Size = UDim2.new(0.2, 0, 0, 26)
freezeRangeBox.Position = UDim2.new(0.33, 0, 0, 136)
freezeRangeBox.Text = tostring(freezeRadius)
freezeRangeBox.Parent = mainTab
table.insert(themeButtons, freezeRangeBox)

freezeRangeBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(freezeRangeBox.Text)
        if val and val > 0 then freezeRadius = val else freezeRangeBox.Text = tostring(freezeRadius) end
    end
end)

local freezeButton = tpButton:Clone()
freezeButton.Size = UDim2.new(0.44, 0, 0, 26)
freezeButton.Position = UDim2.new(0.54, 0, 0, 136)
freezeButton.Parent = mainTab
table.insert(themeButtons, freezeButton)

-- NÚT AUTO TRANG BỊ
local autoEquipBtnToggle = tpButton:Clone()
autoEquipBtnToggle.Size = UDim2.new(1, -12, 0, 26)
autoEquipBtnToggle.Position = UDim2.new(0, 4, 0, 168)
autoEquipBtnToggle.Parent = mainTab
table.insert(themeButtons, autoEquipBtnToggle)

autoEquipBtnToggle.MouseButton1Click:Connect(function()
    toggleAutoEquip(not autoEquipEnabled)
    updateButtonVisual(autoEquipBtnToggle, autoEquipEnabled)
    updateLanguage()
end)

local autoPressBtnToggle = tpButton:Clone()
autoPressBtnToggle.Size = UDim2.new(0.8, -8, 0, 26)
autoPressBtnToggle.Position = UDim2.new(0, 4, 0, 200)
autoPressBtnToggle.Parent = mainTab
table.insert(themeButtons, autoPressBtnToggle)

local autoPressRadiusBox = tpBox:Clone()
autoPressRadiusBox.Size = UDim2.new(0.2, 0, 0, 26)
autoPressRadiusBox.Position = UDim2.new(0.8, 0, 0, 200)
autoPressRadiusBox.Text = tostring(autoPressRadius)
autoPressRadiusBox.Parent = mainTab
table.insert(themeButtons, autoPressRadiusBox)

local autoPressDelayBox = tpBox:Clone()
autoPressDelayBox.Size = UDim2.new(0.32, 0, 0, 26)
autoPressDelayBox.Position = UDim2.new(0.66, 0, 0, 232)
autoPressDelayBox.Text = tostring(autoPressDelay)
autoPressDelayBox.Parent = mainTab
table.insert(themeButtons, autoPressDelayBox)

local targetSelectBtn = tpButton:Clone()
targetSelectBtn.Size = UDim2.new(1, -12, 0, 26)
targetSelectBtn.Position = UDim2.new(0, 4, 0, 264)
targetSelectBtn.Parent = mainTab
table.insert(themeButtons, targetSelectBtn)

local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(1, -12, 0, 80)
playerListFrame.Position = UDim2.new(0, 4, 0, 292)
playerListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
playerListFrame.BorderSizePixel = 0
playerListFrame.Visible = false
playerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
playerListFrame.ScrollBarThickness = 4
playerListFrame.ZIndex = 20
playerListFrame.Parent = mainTab

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Padding = UDim.new(0, 4)
playerListLayout.Parent = playerListFrame

-- Hàm Cập nhật Text Language chung
local updateLanguage

autoPressRadiusBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(autoPressRadiusBox.Text)
        if val and val > 0 then autoPressRadius = val updateLanguage() else autoPressRadiusBox.Text = tostring(autoPressRadius) end
    end
end)

autoPressDelayBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(autoPressDelayBox.Text)
        if val and val >= 0 then autoPressDelay = val else autoPressDelayBox.Text = tostring(autoPressDelay) end
    end
end)

autoPressBtnToggle.MouseButton1Click:Connect(function()
    autoPressButtonEnabled = not autoPressButtonEnabled
    updateButtonVisual(autoPressBtnToggle, autoPressButtonEnabled)
    toggleAutoPressButton(autoPressButtonEnabled)
    updateLanguage()
end)

local function refreshPlayerList()
    for _, child in ipairs(playerListFrame:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    local t = translations[currentLang]
    local allBtn = Instance.new("TextButton")
    allBtn.Size = UDim2.new(1, -8, 0, 24)
    allBtn.BackgroundColor3 = (selectedTargetPlayer == nil) and Color3.fromRGB(80, 80, 150) or Color3.fromRGB(40, 40, 50)
    allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    allBtn.Font = GLOBAL_FONT
    allBtn.TextSize = 11
    allBtn.Text = "[ " .. t.allTarget .. " ]"
    allBtn.ZIndex = 21
    local btnCorner = Instance.new("UICorner") btnCorner.CornerRadius = UDim.new(0, 4) btnCorner.Parent = allBtn
    allBtn.Parent = playerListFrame

    allBtn.MouseButton1Click:Connect(function()
        selectedTargetPlayer = nil
        playerListFrame.Visible = false
        updateLanguage()
    end)

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -8, 0, 24)
            pBtn.BackgroundColor3 = (selectedTargetPlayer == p) and Color3.fromRGB(80, 80, 150) or Color3.fromRGB(40, 40, 50)
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Font = GLOBAL_FONT
            pBtn.TextSize = 11
            pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            pBtn.ZIndex = 21
            local bCorner = Instance.new("UICorner") bCorner.CornerRadius = UDim.new(0, 4) bCorner.Parent = pBtn
            pBtn.Parent = playerListFrame

            pBtn.MouseButton1Click:Connect(function()
                selectedTargetPlayer = p
                playerListFrame.Visible = false
                updateLanguage()
            end)
        end
    end
    playerListFrame.CanvasSize = UDim2.new(0, 0, 0, playerListLayout.AbsoluteContentSize.Y + 10)
end

targetSelectBtn.MouseButton1Click:Connect(function()
    playerListFrame.Visible = not playerListFrame.Visible
    if playerListFrame.Visible then refreshPlayerList() end
end)


-- ESP TAB
local espTab = tabs["ESP"]

local espBtnToggle = tpButton:Clone()
espBtnToggle.Size = UDim2.new(1, -16, 0, 30)
espBtnToggle.Position = UDim2.new(0, 8, 0, 10)
espBtnToggle.Parent = espTab
table.insert(themeButtons, espBtnToggle)

local fpsBtnToggle = tpButton:Clone()
fpsBtnToggle.Size = UDim2.new(1, -16, 0, 30)
fpsBtnToggle.Position = UDim2.new(0, 8, 0, 50)
fpsBtnToggle.Parent = espTab
table.insert(themeButtons, fpsBtnToggle)

local espColorText = Instance.new("TextLabel")
espColorText.Size = UDim2.new(1, -16, 0, 20)
espColorText.Position = UDim2.new(0, 8, 0, 90)
espColorText.BackgroundTransparency = 1
espColorText.TextColor3 = Color3.fromRGB(255, 255, 255)
espColorText.Font = GLOBAL_FONT
espColorText.TextSize = 12
espColorText.TextXAlignment = Enum.TextXAlignment.Left
espColorText.Parent = espTab
table.insert(textElements, espColorText)

local espColorPalette = Instance.new("Frame")
espColorPalette.Size = UDim2.new(1, -16, 0, 30)
espColorPalette.Position = UDim2.new(0, 8, 0, 115)
espColorPalette.BackgroundTransparency = 1
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
    cBtn.Size = UDim2.new(0, 30, 0, 30)
    cBtn.Position = UDim2.new(0, (i - 1) * 36, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.Parent = espColorPalette

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function() espColor = col updateESP() end)
end

local espTargetSelectBtn = tpButton:Clone()
espTargetSelectBtn.Size = UDim2.new(1, -16, 0, 30)
espTargetSelectBtn.Position = UDim2.new(0, 8, 0, 160)
espTargetSelectBtn.Parent = espTab
table.insert(themeButtons, espTargetSelectBtn)

local espPlayerListFrame = playerListFrame:Clone()
espPlayerListFrame.Position = UDim2.new(0, 8, 0, 195)
espPlayerListFrame.Parent = espTab

local function refreshEspPlayerList()
    for _, child in ipairs(espPlayerListFrame:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    local t = translations[currentLang]
    local allBtn = Instance.new("TextButton")
    allBtn.Size = UDim2.new(1, -8, 0, 24)
    allBtn.BackgroundColor3 = (selectedEspTarget == "Tất cả") and Color3.fromRGB(80, 80, 150) or Color3.fromRGB(40, 40, 50)
    allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    allBtn.Font = GLOBAL_FONT
    allBtn.TextSize = 11
    allBtn.Text = "[ " .. t.allTarget .. " ]"
    local bCorner = Instance.new("UICorner") bCorner.CornerRadius = UDim.new(0, 4) bCorner.Parent = allBtn
    allBtn.Parent = espPlayerListFrame

    allBtn.MouseButton1Click:Connect(function()
        selectedEspTarget = "Tất cả"
        espPlayerListFrame.Visible = false
        updateLanguage() updateESP()
    end)

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(1, -8, 0, 24)
            pBtn.BackgroundColor3 = (selectedEspTarget == p.Name) and Color3.fromRGB(80, 80, 150) or Color3.fromRGB(40, 40, 50)
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Font = GLOBAL_FONT
            pBtn.TextSize = 11
            pBtn.Text = p.DisplayName .. " (@" .. p.Name .. ")"
            local bCorner2 = Instance.new("UICorner") bCorner2.CornerRadius = UDim.new(0, 4) bCorner2.Parent = pBtn
            pBtn.Parent = espPlayerListFrame

            pBtn.MouseButton1Click:Connect(function()
                selectedEspTarget = p.Name
                espPlayerListFrame.Visible = false
                updateLanguage() updateESP()
            end)
        end
    end
    local layout = espPlayerListFrame:FindFirstChildOfClass("UIListLayout")
    if layout then espPlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10) end
end

espTargetSelectBtn.MouseButton1Click:Connect(function()
    espPlayerListFrame.Visible = not espPlayerListFrame.Visible
    if espPlayerListFrame.Visible then refreshEspPlayerList() end
end)

espBtnToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    updateButtonVisual(espBtnToggle, espEnabled)
    updateLanguage() updateESP()
end)

fpsBtnToggle.MouseButton1Click:Connect(function()
    fpsEnabled = not fpsEnabled
    updateButtonVisual(fpsBtnToggle, fpsEnabled)
    toggleFPSDisplay(fpsEnabled)
    updateLanguage()
end)


-- FIX LAG TAB
local fixLagTab = tabs["FixLag"]

local fixLagBtnToggle = tpButton:Clone()
fixLagBtnToggle.Size = UDim2.new(1, -16, 0, 30)
fixLagBtnToggle.Position = UDim2.new(0, 8, 0, 15)
fixLagBtnToggle.Parent = fixLagTab
table.insert(themeButtons, fixLagBtnToggle)

fixLagBtnToggle.MouseButton1Click:Connect(function()
    fixLagEnabled = not fixLagEnabled
    updateButtonVisual(fixLagBtnToggle, fixLagEnabled)
    toggleFixLag(fixLagEnabled)
    updateLanguage()
end)

local hideMapBtnToggle = tpButton:Clone()
hideMapBtnToggle.Size = UDim2.new(1, -16, 0, 30)
hideMapBtnToggle.Position = UDim2.new(0, 8, 0, 55)
hideMapBtnToggle.Parent = fixLagTab
table.insert(themeButtons, hideMapBtnToggle)

hideMapBtnToggle.MouseButton1Click:Connect(function()
    hideMapOthersEnabled = not hideMapOthersEnabled
    updateButtonVisual(hideMapBtnToggle, hideMapOthersEnabled)
    toggleHideMapAndOthers(hideMapOthersEnabled)
    updateLanguage()
end)

local muteSoundsBtnToggle = tpButton:Clone()
muteSoundsBtnToggle.Size = UDim2.new(1, -16, 0, 30)
muteSoundsBtnToggle.Position = UDim2.new(0, 8, 0, 95)
muteSoundsBtnToggle.Parent = fixLagTab
table.insert(themeButtons, muteSoundsBtnToggle)

muteSoundsBtnToggle.MouseButton1Click:Connect(function()
    muteAllSoundsEnabled = not muteAllSoundsEnabled
    updateButtonVisual(muteSoundsBtnToggle, muteAllSoundsEnabled)
    toggleMuteAllSounds(muteAllSoundsEnabled)
    updateLanguage()
end)


-- MISC TAB (SETTINGS)
local miscTab = tabs["Misc"]

local themeLabel = Instance.new("TextLabel")
themeLabel.Size = UDim2.new(1, -16, 0, 20)
themeLabel.Position = UDim2.new(0, 8, 0, 10)
themeLabel.BackgroundTransparency = 1
themeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
themeLabel.Font = GLOBAL_FONT
themeLabel.TextSize = 12
themeLabel.TextXAlignment = Enum.TextXAlignment.Left
themeLabel.Parent = miscTab

local langLabel = themeLabel:Clone()
langLabel.Position = UDim2.new(0, 8, 0, 50)
langLabel.Parent = miscTab

local btnEnglish = Instance.new("TextButton")
btnEnglish.Size = UDim2.new(0.48, 0, 0, 30)
btnEnglish.Position = UDim2.new(0, 8, 0, 75)
btnEnglish.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
btnEnglish.TextColor3 = Color3.fromRGB(255, 255, 255)
btnEnglish.Font = GLOBAL_FONT
btnEnglish.TextSize = 12
btnEnglish.Parent = miscTab
table.insert(themeButtons, btnEnglish)

local engCorner = Instance.new("UICorner")
engCorner.CornerRadius = UDim.new(0, 6)
engCorner.Parent = btnEnglish

local btnVietnamese = btnEnglish:Clone()
btnVietnamese.Position = UDim2.new(0.52, 0, 0, 75)
btnVietnamese.Parent = miscTab
table.insert(themeButtons, btnVietnamese)

local rejoinButton = btnEnglish:Clone()
rejoinButton.Position = UDim2.new(0, 8, 0, 115)
rejoinButton.Parent = miscTab
table.insert(themeButtons, rejoinButton)

local serverHopButton = btnVietnamese:Clone()
serverHopButton.Position = UDim2.new(0.52, 0, 0, 115)
serverHopButton.Parent = miscTab
table.insert(themeButtons, serverHopButton)

local godButton = tpButton:Clone()
godButton.Size = UDim2.new(1, -16, 0, 35)
godButton.Position = UDim2.new(0, 8, 0, 170)
godButton.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
godButton.Parent = miscTab

godButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))()
end)

rejoinButton.MouseButton1Click:Connect(rejoinServer)
serverHopButton.MouseButton1Click:Connect(serverHop)

btnEnglish.MouseButton1Click:Connect(function() currentLang = "EN" updateLanguage() end)
btnVietnamese.MouseButton1Click:Connect(function() currentLang = "VI" updateLanguage() end)

-- Navigation Buttons
local tabButtons = {}
local yOffset = 10
for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 32)
    btn.Position = UDim2.new(0, 8, 0, yOffset)
    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(70, 70, 90) or Color3.fromRGB(35, 35, 45)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = GLOBAL_FONT
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Center
    btn.Parent = sidebar
    table.insert(themeButtons, btn)

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do t.Visible = false end
        for _, b in pairs(tabButtons) do TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play() end
        tabs[name].Visible = true
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 90)}):Play()
        
        -- Animation trượt nhẹ cho tab
        tabs[name].Position = UDim2.new(0, 20, 0, 0)
        tabs[name].GroupTransparency = 1
        TweenService:Create(tabs[name], TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0}):Play()
    end)

    tabButtons[name] = btn
    yOffset = yOffset + 40
end

updateLanguage = function()
    local t = translations[currentLang]
    
    titleText.Text = t.title
    tabButtons["Main"].Text = t.tabMain
    tabButtons["ESP"].Text = t.tabEsp
    tabButtons["FixLag"].Text = t.tabFixLag
    tabButtons["Misc"].Text = t.tabMisc
    
    tpLabel.Text = t.tpSpd
    walkLabel.Text = t.walkSpd
    jumpLabel.Text = t.jumpSpd
    flySpeedLabel.Text = t.flySpd
    gravLabel.Text = t.gravSpd
    freezeRangeLabel.Text = t.freezeRng
    -- autoPressDelayLabel.Text = t.clickDelayLabel
    espColorText.Text = t.espColorLabel
    
    local targetName = selectedTargetPlayer and selectedTargetPlayer.DisplayName or t.allTarget
    targetSelectBtn.Text = t.targetBtn .. targetName
    
    local espTargetName = (selectedEspTarget == "Tất cả") and t.allTarget or selectedEspTarget
    espTargetSelectBtn.Text = t.targetBtn .. espTargetName
    
    tpButton.Text = t.tpBtn .. (tpEnabled and t.on or t.off)
    walkButton.Text = t.walkBtn .. (walkEnabled and t.on or t.off)
    jumpButton.Text = t.jumpBtn .. (jumpEnabled and t.on or t.off)
    flyButton.Text = t.flyBtn .. (flyEnabled and t.on or t.off)
    gravityButton.Text = t.gravBtn .. (gravityEnabled and t.on or t.off)
    noclipButton.Text = t.noclipBtn .. (noclipEnabled and t.on or t.off)
    invisButton.Text = t.invisBtn .. (invisibleEnabled and t.on or t.off)
    infJumpButton.Text = t.infJumpBtn .. (infJumpEnabled and t.on or t.off)
    freezeButton.Text = t.freezeBtn .. (freezeRayEnabled and t.on or t.off)
    autoEquipBtnToggle.Text = t.autoEquipBtn .. (autoEquipEnabled and t.on or t.off)
    godButton.Text = t.godBtn
    espBtnToggle.Text = t.espBtn .. (espEnabled and t.on or t.off)
    fpsBtnToggle.Text = t.fpsBtn .. (fpsEnabled and t.on or t.off)
    fixLagBtnToggle.Text = t.fixLagBtn .. (fixLagEnabled and t.on or t.off)
    hideMapBtnToggle.Text = t.hideMapBtn .. (hideMapOthersEnabled and t.on or t.off)
    muteSoundsBtnToggle.Text = t.muteSoundsBtn .. (muteAllSoundsEnabled and t.on or t.off)
    
    autoPressBtnToggle.Text = t.autoPressBtn .. tostring(autoPressRadius) .. "): " .. (autoPressButtonEnabled and t.on or t.off)
    
    themeLabel.Text = t.themeLabel
    langLabel.Text = t.langLabel
    rejoinButton.Text = t.rejoinBtn
    serverHopButton.Text = t.serverHopBtn
    
    if currentLang == "EN" then
        btnEnglish.Text = "English" .. t.selected
        btnVietnamese.Text = "Tiếng Việt"
        updateButtonVisual(btnEnglish, true) updateButtonVisual(btnVietnamese, false)
    else
        btnEnglish.Text = "English"
        btnVietnamese.Text = "Tiếng Việt" .. t.selected
        updateButtonVisual(btnEnglish, false) updateButtonVisual(btnVietnamese, true)
    end
end

-- ANIMATION CHO TẤT CẢ CÁC NÚT (HOVER & CLICK)
local function addHoverAnimationToAllButtons()
    for _, btn in ipairs(screenGui:GetDescendants()) do
        if btn:IsA("TextButton") then
            -- Thêm UIScale để phóng to mượt mà
            local scale = Instance.new("UIScale")
            scale.Parent = btn
            
            btn.MouseEnter:Connect(function()
                TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {Scale = 1.05}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {Scale = 1.0}):Play()
            end)
            btn.MouseButton1Down:Connect(function()
                TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Bounce), {Scale = 0.9}):Play()
            end)
            btn.MouseButton1Up:Connect(function()
                TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Bounce), {Scale = 1.05}):Play()
            end)
        end
    end
end
addHoverAnimationToAllButtons()

-- Logic Click Các Nút
tpButton.MouseButton1Click:Connect(function() tpEnabled = not tpEnabled updateButtonVisual(tpButton, tpEnabled) updateLanguage() end)
walkButton.MouseButton1Click:Connect(function()
    walkEnabled = not walkEnabled updateButtonVisual(walkButton, walkEnabled) updateLanguage()
    if walkEnabled then if walkConnection then walkConnection:Disconnect() end walkConnection = RunService.RenderStepped:Connect(function() local character = player.Character local humanoid = character and character:FindFirstChildOfClass("Humanoid") if humanoid then humanoid.WalkSpeed = walkSpeed end end)
    else if walkConnection then walkConnection:Disconnect() end walkConnection = nil local character = player.Character local humanoid = character and character:FindFirstChildOfClass("Humanoid") if humanoid then humanoid.WalkSpeed = 16 end end
end)
jumpButton.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled updateButtonVisual(jumpButton, jumpEnabled) updateLanguage()
    if jumpEnabled then if jumpConnection then jumpConnection:Disconnect() end jumpConnection = RunService.RenderStepped:Connect(function() local character = player.Character local humanoid = character and character:FindFirstChildOfClass("Humanoid") if humanoid then humanoid.UseJumpPower = true humanoid.JumpPower = jumpPower end end)
    else if jumpConnection then jumpConnection:Disconnect() end jumpConnection = nil local character = player.Character local humanoid = character and character:FindFirstChildOfClass("Humanoid") if humanoid then humanoid.JumpPower = 50 end end
end)
flyButton.MouseButton1Click:Connect(function() flyEnabled = not flyEnabled updateButtonVisual(flyButton, flyEnabled) updateLanguage() toggleFly(flyEnabled) end)
gravityButton.MouseButton1Click:Connect(function()
    gravityEnabled = not gravityEnabled updateButtonVisual(gravityButton, gravityEnabled) updateLanguage()
    if gravityEnabled then if gravityConnection then gravityConnection:Disconnect() end gravityConnection = RunService.RenderStepped:Connect(function() Workspace.Gravity = customGravity end)
    else if gravityConnection then gravityConnection:Disconnect() end gravityConnection = nil Workspace.Gravity = 196.2 end
end)
noclipButton.MouseButton1Click:Connect(function() noclipEnabled = not noclipEnabled updateButtonVisual(noclipButton, noclipEnabled) updateLanguage() toggleNoclip(noclipEnabled) end)
invisButton.MouseButton1Click:Connect(function() invisibleEnabled = not invisibleEnabled updateButtonVisual(invisButton, invisibleEnabled) updateLanguage() toggleInvisibility(invisibleEnabled) end)
infJumpButton.MouseButton1Click:Connect(function() infJumpEnabled = not infJumpEnabled updateButtonVisual(infJumpButton, infJumpEnabled) updateLanguage() toggleInfJump(infJumpEnabled) end)
freezeButton.MouseButton1Click:Connect(function() freezeRayEnabled = not freezeRayEnabled updateButtonVisual(freezeButton, freezeRayEnabled) updateLanguage() toggleFreezeRay(freezeRayEnabled) end)

-- MINIMIZE MƯỢT MÀ BẰNG TWEEN
minimizeButton.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.3)
    frame.Visible = false
    openUIButton.Visible = true
    openUIButton.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(openUIButton, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0,50,0,50)}):Play()
end)

openUIButton.MouseButton1Click:Connect(function()
    TweenService:Create(openUIButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.2)
    openUIButton.Visible = false
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 390, 0, 310)}):Play()
end)

closeButton.MouseButton1Click:Connect(function()
    toggleNoclip(false) toggleInvisibility(false) toggleFly(false) toggleInfJump(false) toggleFreezeRay(false) toggleFPSDisplay(false) toggleAutoPressButton(false) toggleFixLag(false) toggleHideMapAndOthers(false) toggleMuteAllSounds(false) toggleAutoEquip(false)
    if gravityConnection then gravityConnection:Disconnect() gravityConnection = nil end Workspace.Gravity = 196.2
    espEnabled = false updateESP()
    if walkConnection then walkConnection:Disconnect() walkConnection = nil end
    if jumpConnection then jumpConnection:Disconnect() jumpConnection = nil end
    tpEnabled = false
    
    -- Hiệu ứng tắt
    TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    task.wait(0.3)
    screenGui:Destroy()
end)
 
updateLanguage()

-- Hiện UI lên với hiệu ứng khởi động
frame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 390, 0, 310)}):Play()
