-- ==========================================
-- H HUB AUTOFARM (UPDATED WITH SPECTATE & TP)
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
local espEnabled = false
local fpsEnabled = false
local gravityEnabled = false
local autoPressButtonEnabled = false
local fixLagEnabled = false
local hideMapOthersEnabled = false
local muteAllSoundsEnabled = false

-- Biến Spectate
local spectatingPlayer = nil
local spectateType = "Third" -- "First" hoặc "Third"
local spectateConnection = nil

-- Cấu hình mặc định
local tpSpeed = 0.15
local walkSpeed = 35 
local jumpPower = 75
local flySpeed = 100
local customGravity = 196.2
local coinName = "Coin"
local autoPressRadius = 15
local autoPressDelay = 0.1
local selectedEspTarget = "Tất cả"
local espColor = Color3.fromRGB(255, 0, 0)
local currentThemeColor = Color3.fromRGB(35, 35, 45)
local currentTextColor = Color3.fromRGB(255, 255, 255)
local currentLang = "VI" 

-- Quản lý Kết nối & Task
local noclipConnection, invisibleConnection, flyConnection
local walkConnection, jumpConnection, infJumpConnection
local fpsConnection, gravityConnection
local autoPressButtonTask, fixLagTask, fixLagChildConnection
local hideMapConnection, muteSoundsConnection
local originalHipHeight
local savedTransparencies = {}
local hiddenObjects = {} 
local mutedSounds = {}   

local themeButtons = {}     
local textElements = {}     
local GLOBAL_FONT = Enum.Font.GothamBold

local translations = {
    EN = {
        title = "H HUB - AutoFarm",
        tabMain = "Main",
        tabPlayers = "Players",
        tabEsp = "ESP",
        tabMisc = "Settings",
        tabFixLag = "Fix Lag",
        tpSpd = "TP Speed (s):",
        walkSpd = "Walk Speed:",
        flySpd = "Fly Speed:",
        jumpSpd = "Jump Power:",
        gravSpd = "Gravity:",
        clickDelayLabel = "Click Delay (s):",
        tpBtn = "Auto TP Coins",
        walkBtn = "Custom Speed",
        jumpBtn = "Custom Jump",
        flyBtn = "Fly Mode",
        gravBtn = "Custom Gravity",
        noclipBtn = "Noclip Pass-Wall",
        invisBtn = "Invisibility",
        infJumpBtn = "Infinite Jump",
        autoEquipBtn = "Equip Items (Run Once)", 
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
        boardColorLabel = "Board Background Color:", 
        themeLabel = "UI Button Color:",
        textLabel = "UI Text Color:",
        langLabel = "Language:",
        rejoinBtn = "Rejoin Server",
        serverHopBtn = "Server Hop",
        on = "BẬT",
        off = "TẮT"
    },
    VI = {
        title = "H HUB - AutoFarm",
        tabMain = "Chính",
        tabPlayers = "Người chơi",
        tabEsp = "ESP",
        tabMisc = "Cài đặt",
        tabFixLag = "Fix Lag",
        tpSpd = "Tốc độ TP (giây):",
        walkSpd = "Tốc độ Đi bộ:",
        flySpd = "Tốc độ Bay:",
        jumpSpd = "Độ Cao Nhảy:",
        gravSpd = "Trọng Lực Game:",
        clickDelayLabel = "Tốc độ Click (giây):",
        tpBtn = "Auto TP Nhặt Xu",
        walkBtn = "Chỉnh Tốc Độ Đi",
        jumpBtn = "Chỉnh Độ Nhảy",
        flyBtn = "Chế Độ Bay",
        gravBtn = "Trọng Lực Tùy Chỉnh",
        noclipBtn = "Đi Xuyên Tường (Noclip)",
        invisBtn = "Tàng Hình Nhìn Thấy",
        infJumpBtn = "Nhảy Vô Hạn",
        autoEquipBtn = "Trang Bị Đồ (Nhấn 1 Lần)", 
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
        boardColorLabel = "Màu Bảng Điều Khiển:", 
        themeLabel = "Màu Nút Giao Diện:",
        textLabel = "Màu Chữ Giao Diện:",
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

local allEquipItems = {
    "PieThrow", "SmallPotion", "GiantPotion", "GhostPotion", "Healing", "GravityPotion", 
    "Bloxiade", "ClownBomb", "Slate", "WindPotion", "IcePotion", "Caltrops", "SlowDownGun", 
    "GravityGun", "GravityDisruptor", "FreezeRay", "Bomb", "Jetpack", "DecoyDeploy", 
    "AprilShowers", "Balloon", "MarchingDrum", "Trumpet", "Trowel", "TeapotLauncher", 
    "BunchOfBalloons", "BangGun", "EpicJuice", "EpicSauce", "Ball", "Torch", "Cake", 
    "MoneyBag", "IceCreamCone", "Teddy", "Witch", "Watermelon", "Taco", "Bloxy", "Pizza", "Coco"
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
-- GIAO DIỆN GUI
-- ==========================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

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

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 390, 0, 320)
frame.Position = UDim2.new(0.5, -195, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
frame.Visible = true

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
        rot = rot + 0.5
        if rot >= 360 then rot = 0 end
        gradientFrame.Rotation = rot
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

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
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
minimizeButton.Parent = titleBar
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 4)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 28, 0, 22)
closeButton.Position = UDim2.new(1, -30, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = GLOBAL_FONT
closeButton.TextSize = 13
closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 4)

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 110, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
sidebar.BackgroundTransparency = 0.5
sidebar.BorderSizePixel = 0
sidebar.Parent = frame
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local line = Instance.new("Frame")
line.Size = UDim2.new(0, 1, 1, 0)
line.Position = UDim2.new(1, 0, 0, 0)
line.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
line.BorderSizePixel = 0
line.Parent = sidebar

local container = Instance.new("Frame")
container.Size = UDim2.new(1, -115, 1, -35)
container.Position = UDim2.new(0, 115, 0, 35)
container.BackgroundTransparency = 1
container.Parent = frame

local tabs = {}
local tabNames = {"Main", "Players", "ESP", "FixLag", "Misc"}

for _, name in ipairs(tabNames) do
    local tabScroll = Instance.new("ScrollingFrame")
    tabScroll.Size = UDim2.new(1, -5, 1, 0)
    tabScroll.BackgroundTransparency = 1
    tabScroll.BorderSizePixel = 0
    tabScroll.ScrollBarThickness = 4
    tabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabScroll.Visible = false
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
            if not isBtnOn then btn.BackgroundColor3 = currentThemeColor end
        end
    end
end

local function applyBoardColor(baseColor)
    local r, g, b = baseColor.R*255, baseColor.G*255, baseColor.B*255
    local darkColor = Color3.fromRGB(math.clamp(r-15, 0, 255), math.clamp(g-15, 0, 255), math.clamp(b-15, 0, 255))
    local lightColor = Color3.fromRGB(math.clamp(r+10, 0, 255), math.clamp(g+10, 0, 255), math.clamp(b+10, 0, 255))
    gradientFrame.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, darkColor),
        ColorSequenceKeypoint.new(0.50, lightColor),
        ColorSequenceKeypoint.new(1.00, darkColor)
    }
    sidebar.BackgroundColor3 = darkColor
    titleBar.BackgroundColor3 = Color3.fromRGB(math.clamp(r-20, 0, 255), math.clamp(g-20, 0, 255), math.clamp(b-20, 0, 255))
end

local function applyTextColor(color)
    currentTextColor = color
    for _, txt in ipairs(textElements) do
        if txt and txt.Parent then txt.TextColor3 = currentTextColor end
    end
end

local function createToggleRow(parentTab, labelKey, stateBool, callback)
    local frameRow = Instance.new("Frame")
    frameRow.Size = UDim2.new(1, 0, 0, 32)
    frameRow.BackgroundTransparency = 1
    frameRow.Parent = parentTab

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = currentThemeColor
    btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT
    btn.TextSize = 11
    btn.Parent = frameRow
    table.insert(themeButtons, btn)
    table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

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

local function createButtonRow(parentTab, labelKey, callback)
    local frameRow = Instance.new("Frame")
    frameRow.Size = UDim2.new(1, 0, 0, 32)
    frameRow.BackgroundTransparency = 1
    frameRow.Parent = parentTab

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = currentThemeColor
    btn.TextColor3 = currentTextColor
    btn.Font = GLOBAL_FONT
    btn.TextSize = 11
    btn.Parent = frameRow
    table.insert(themeButtons, btn)
    table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local function refreshText()
        local t = translations[currentLang]
        btn.Text = t[labelKey] or labelKey
    end
    refreshText()
    btn.MouseButton1Click:Connect(callback)
    return btn, refreshText
end

local function createInputRow(parentTab, labelKey, defaultVal, callback)
    local frameRow = Instance.new("Frame")
    frameRow.Size = UDim2.new(1, 0, 0, 30)
    frameRow.BackgroundTransparency = 1
    frameRow.Parent = parentTab

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = currentTextColor
    lbl.Font = GLOBAL_FONT
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
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
    box.Parent = frameRow
    table.insert(themeButtons, box)
    table.insert(textElements, box)
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

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

local _, r16 = createButtonRow(mainTab, "autoEquipBtn", function() equipItemsOnce() end)
table.insert(refreshFuncs, r16)

local _, r17_1 = createInputRow(mainTab, "autoPressRadiusLabel", autoPressRadius, function(val) autoPressRadius = val end)
table.insert(refreshFuncs, r17_1)
local _, r17_2 = createInputRow(mainTab, "autoPressDelayLabel", autoPressDelay, function(val) autoPressDelay = val end)
table.insert(refreshFuncs, r17_2)
local _, r17 = createToggleRow(mainTab, "autoPressBtn", autoPressButtonEnabled, function(st) toggleAutoPressButton(st) end)
table.insert(refreshFuncs, r17)

local godRowFrame = Instance.new("Frame")
godRowFrame.Size = UDim2.new(1, 0, 0, 36)
godRowFrame.BackgroundTransparency = 1
godRowFrame.Parent = mainTab

local godButton = Instance.new("TextButton")
godButton.Size = UDim2.new(1, 0, 1, 0)
godButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
godButton.TextColor3 = Color3.fromRGB(255, 255, 255)
godButton.Font = GLOBAL_FONT
godButton.TextSize = 12
godButton.Text = "⚡ Bảng God Mode (Bất Tử)"
godButton.Parent = godRowFrame
Instance.new("UICorner", godButton).CornerRadius = UDim.new(0, 6)

godButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"))()
end)

-- ==========================================
-- TAB NGƯỜI CHƠI (PLAYERS & SPECTATE)
-- ==========================================
local playersTab = tabs["Players"]

local function setInventoryVisible(visible)
    pcall(function()
        local backpackGui = playerGui:FindFirstChild("Backpack")
        if backpackGui then backpackGui.Enabled = visible end
        for _, gui in ipairs(playerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and (string.find(string.lower(gui.Name), "backpack") or string.find(string.lower(gui.Name), "inventory") or string.find(string.lower(gui.Name), "hotbar")) then
                gui.Enabled = visible
            end
        end
    end)
end

local function stopSpectate()
    spectatingPlayer = nil
    if spectateConnection then
        spectateConnection:Disconnect()
        spectateConnection = nil
    end
    local cam = Workspace.CurrentCamera
    if cam and player and player.Character then
        local myHum = player.Character:FindFirstChildOfClass("Humanoid")
        if myHum then cam.CameraSubject = myHum end
    end
    setInventoryVisible(true)
end

local function startSpectate(targetPlayer, viewType)
    spectatingPlayer = targetPlayer
    spectateType = viewType or "Third"
    
    -- Ẩn kho đồ khi xem người chơi
    setInventoryVisible(false)
    
    if spectateConnection then spectateConnection:Disconnect() end
    spectateConnection = RunService.RenderStepped:Connect(function()
        pcall(function()
            if not spectatingPlayer or not spectatingPlayer.Parent or not spectatingPlayer.Character then
                stopSpectate()
                return
            end
            local cam = Workspace.CurrentCamera
            local char = spectatingPlayer.Character
            local hum = char:FindFirstChildOfClass("Humanoid")
            local head = char:FindFirstChild("Head")
            
            if spectateType == "First" and head then
                cam.CameraType = Enum.CameraType.Scriptable
                cam.CFrame = head.CFrame + Vector3.new(0, 0.5, 0)
            else
                cam.CameraType = Enum.CameraType.Custom
                if hum then cam.CameraSubject = hum end
            end
        end)
    end)
end

local function teleportToPlayer(targetPlayer)
    pcall(function()
        if targetPlayer and targetPlayer.Character then
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot and myRoot then
                myRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end)
end

local function refreshPlayersList()
    for _, child in ipairs(playersTab:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    -- Nút dừng spectate nếu đang xem
    if spectatingPlayer then
        local stopRow = Instance.new("Frame")
        stopRow.Size = UDim2.new(1, 0, 0, 32)
        stopRow.BackgroundTransparency = 1
        stopRow.Parent = playersTab
        
        local stopBtn = Instance.new("TextButton")
        stopBtn.Size = UDim2.new(1, 0, 1, 0)
        stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        stopBtn.Font = GLOBAL_FONT
        stopBtn.TextSize = 12
        stopBtn.Text = "🛑 Dừng Xem (Thoát Spectate)"
        stopBtn.Parent = stopRow
        Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)
        
        stopBtn.MouseButton1Click:Connect(function()
            stopSpectate()
            refreshPlayersList()
        end)
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local pFrame = Instance.new("Frame")
            pFrame.Size = UDim2.new(1, 0, 0, 42)
            pFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
            pFrame.Parent = playersTab
            Instance.new("UICorner", pFrame).CornerRadius = UDim.new(0, 6)
            
            local nameLbl = Instance.new("TextLabel")
            nameLbl.Size = UDim2.new(0.45, 0, 1, 0)
            nameLbl.Position = UDim2.new(0, 8, 0, 0)
            nameLbl.BackgroundTransparency = 1
            nameLbl.TextColor3 = currentTextColor
            nameLbl.Font = GLOBAL_FONT
            nameLbl.TextSize = 11
            nameLbl.Text = p.DisplayName
            nameLbl.TextXAlignment = Enum.TextXAlignment.Left
            nameLbl.Parent = pFrame
            table.insert(textElements, nameLbl)
            
            -- Nút Góc nhìn thứ 3
            local spec3Btn = Instance.new("TextButton")
            spec3Btn.Size = UDim2.new(0, 52, 0, 26)
            spec3Btn.Position = UDim2.new(0.46, 0, 0.5, -13)
            spec3Btn.BackgroundColor3 = (spectatingPlayer == p and spectateType == "Third") and Color3.fromRGB(45, 160, 85) or currentThemeColor
            spec3Btn.TextColor3 = currentTextColor
            spec3Btn.Font = GLOBAL_FONT
            spec3Btn.TextSize = 10
            spec3Btn.Text = "GN 3"
            spec3Btn.Parent = pFrame
            table.insert(themeButtons, spec3Btn)
            table.insert(textElements, spec3Btn)
            Instance.new("UICorner", spec3Btn).CornerRadius = UDim.new(0, 4)
            
            spec3Btn.MouseButton1Click:Connect(function()
                startSpectate(p, "Third")
                refreshPlayersList()
            end)
            
            -- Nút Góc nhìn thứ nhất
            local spec1Btn = Instance.new("TextButton")
            spec1Btn.Size = UDim2.new(0, 52, 0, 26)
            spec1Btn.Position = UDim2.new(0.66, 0, 0.5, -13)
            spec1Btn.BackgroundColor3 = (spectatingPlayer == p and spectateType == "First") and Color3.fromRGB(45, 160, 85) or currentThemeColor
            spec1Btn.TextColor3 = currentTextColor
            spec1Btn.Font = GLOBAL_FONT
            spec1Btn.TextSize = 10
            spec1Btn.Text = "GN 1"
            spec1Btn.Parent = pFrame
            table.insert(themeButtons, spec1Btn)
            table.insert(textElements, spec1Btn)
            Instance.new("UICorner", spec1Btn).CornerRadius = UDim.new(0, 4)
            
            spec1Btn.MouseButton1Click:Connect(function()
                startSpectate(p, "First")
                refreshPlayersList()
            end)
            
            -- Nút Dịch chuyển tới (TP)
            local tpBtn = Instance.new("TextButton")
            tpBtn.Size = UDim2.new(0, 46, 0, 26)
            tpBtn.Position = UDim2.new(0.86, 0, 0.5, -13)
            tpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
            tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            tpBtn.Font = GLOBAL_FONT
            tpBtn.TextSize = 10
            tpBtn.Text = "TP"
            tpBtn.Parent = pFrame
            Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 4)
            
            tpBtn.MouseButton1Click:Connect(function()
                teleportToPlayer(p)
            end)
        end
    end
end

Players.PlayerAdded:Connect(function() refreshPlayersList() end)
Players.PlayerRemoving:Connect(function() refreshPlayersList() end)
refreshPlayersList()

-- ==========================================
-- TAB ESP, FIXLAG & MISC
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
espColorLabel.Parent = espTab
table.insert(textElements, espColorLabel)

local espColorPalette = Instance.new("Frame")
espColorPalette.Size = UDim2.new(1, 0, 0, 28)
espColorPalette.BackgroundTransparency = 1
espColorPalette.Parent = espTab

local espColors = {
    Color3.fromRGB(255, 50, 50), Color3.fromRGB(50, 255, 50), Color3.fromRGB(50, 150, 255),
    Color3.fromRGB(255, 255, 50), Color3.fromRGB(255, 50, 255), Color3.fromRGB(255, 255, 255)
}

for i, col in ipairs(espColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.Parent = espColorPalette
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)
    cBtn.MouseButton1Click:Connect(function() espColor = col updateESP() end)
end

local fixLagTab = tabs["FixLag"]
local _, rLag1 = createToggleRow(fixLagTab, "fixLagBtn", fixLagEnabled, function(st) toggleFixLag(st) end)
table.insert(refreshFuncs, rLag1)
local _, rLag2 = createToggleRow(fixLagTab, "hideMapBtn", hideMapOthersEnabled, function(st) toggleHideMapAndOthers(st) end)
table.insert(refreshFuncs, rLag2)
local _, rLag3 = createToggleRow(fixLagTab, "muteSoundsBtn", muteAllSoundsEnabled, function(st) toggleMuteAllSounds(st) end)
table.insert(refreshFuncs, rLag3)

local miscTab = tabs["Misc"]
local boardColorLabelObj = Instance.new("TextLabel")
boardColorLabelObj.Size = UDim2.new(1, 0, 0, 18)
boardColorLabelObj.BackgroundTransparency = 1
boardColorLabelObj.TextColor3 = currentTextColor
boardColorLabelObj.Font = GLOBAL_FONT
boardColorLabelObj.TextSize = 11
boardColorLabelObj.TextXAlignment = Enum.TextXAlignment.Left
boardColorLabelObj.Parent = miscTab
table.insert(textElements, boardColorLabelObj)

local boardPalette = Instance.new("Frame")
boardPalette.Size = UDim2.new(1, 0, 0, 28)
boardPalette.BackgroundTransparency = 1
boardPalette.Parent = miscTab

local uiBoardColors = {Color3.fromRGB(20, 20, 25), Color3.fromRGB(40, 20, 20), Color3.fromRGB(20, 40, 20), Color3.fromRGB(20, 25, 40), Color3.fromRGB(40, 30, 20)}
for i, col in ipairs(uiBoardColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.Parent = boardPalette
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)
    cBtn.MouseButton1Click:Connect(function() applyBoardColor(col) end)
end

local themeLabel = Instance.new("TextLabel")
themeLabel.Size = UDim2.new(1, 0, 0, 18)
themeLabel.BackgroundTransparency = 1
themeLabel.TextColor3 = currentTextColor
themeLabel.Font = GLOBAL_FONT
themeLabel.TextSize = 11
themeLabel.TextXAlignment = Enum.TextXAlignment.Left
themeLabel.Parent = miscTab
table.insert(textElements, themeLabel)

local themePalette = Instance.new("Frame")
themePalette.Size = UDim2.new(1, 0, 0, 28)
themePalette.BackgroundTransparency = 1
themePalette.Parent = miscTab

local uiThemeColors = {Color3.fromRGB(35, 35, 45), Color3.fromRGB(50, 40, 80), Color3.fromRGB(30, 60, 90), Color3.fromRGB(70, 30, 40), Color3.fromRGB(30, 70, 50)}
for i, col in ipairs(uiThemeColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.Parent = themePalette
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)
    cBtn.MouseButton1Click:Connect(function() applyThemeColor(col) end)
end

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 18)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = currentTextColor
textLabel.Font = GLOBAL_FONT
textLabel.TextSize = 11
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = miscTab
table.insert(textElements, textLabel)

local textPalette = Instance.new("Frame")
textPalette.Size = UDim2.new(1, 0, 0, 28)
textPalette.BackgroundTransparency = 1
textPalette.Parent = miscTab

local uiTextColors = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 220, 100), Color3.fromRGB(100, 255, 200), Color3.fromRGB(255, 150, 200)}
for i, col in ipairs(uiTextColors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 28, 0, 28)
    cBtn.Position = UDim2.new(0, (i - 1) * 34, 0, 0)
    cBtn.BackgroundColor3 = col
    cBtn.Text = ""
    cBtn.Parent = textPalette
    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 6)
    cBtn.MouseButton1Click:Connect(function() applyTextColor(col) end)
end

local langLabel = Instance.new("TextLabel")
langLabel.Size = UDim2.new(1, 0, 0, 18)
langLabel.BackgroundTransparency = 1
langLabel.TextColor3 = currentTextColor
langLabel.Font = GLOBAL_FONT
langLabel.TextSize = 11
langLabel.TextXAlignment = Enum.TextXAlignment.Left
langLabel.Parent = miscTab
table.insert(textElements, langLabel)

local langFrame = Instance.new("Frame")
langFrame.Size = UDim2.new(1, 0, 0, 30)
langFrame.BackgroundTransparency = 1
langFrame.Parent = miscTab

local btnEnglish = Instance.new("TextButton")
btnEnglish.Size = UDim2.new(0.48, 0, 1, 0)
btnEnglish.BackgroundColor3 = currentThemeColor
btnEnglish.TextColor3 = currentTextColor
btnEnglish.Font = GLOBAL_FONT
btnEnglish.TextSize = 11
btnEnglish.Text = "English"
btnEnglish.Parent = langFrame
table.insert(themeButtons, btnEnglish)
table.insert(textElements, btnEnglish)
Instance.new("UICorner", btnEnglish).CornerRadius = UDim.new(0, 6)

local btnVietnamese = btnEnglish:Clone()
btnVietnamese.Position = UDim2.new(0.52, 0, 0, 0)
btnVietnamese.Text = "Tiếng Việt"
btnVietnamese.Parent = langFrame
table.insert(themeButtons, btnVietnamese)
table.insert(textElements, btnVietnamese)

local serverFrame = Instance.new("Frame")
serverFrame.Size = UDim2.new(1, 0, 0, 32)
serverFrame.BackgroundTransparency = 1
serverFrame.Parent = miscTab

local rejoinButton = btnEnglish:Clone()
rejoinButton.Size = UDim2.new(0.48, 0, 1, 0)
rejoinButton.Position = UDim2.new(0, 0, 0, 0)
rejoinButton.Parent = serverFrame
table.insert(themeButtons, rejoinButton)
table.insert(textElements, rejoinButton)

local serverHopButton = btnVietnamese:Clone()
serverHopButton.Size = UDim2.new(0.48, 0, 1, 0)
serverHopButton.Position = UDim2.new(0.52, 0, 0, 0)
serverHopButton.Parent = serverFrame
table.insert(themeButtons, serverHopButton)
table.insert(textElements, serverHopButton)

rejoinButton.MouseButton1Click:Connect(rejoinServer)
serverHopButton.MouseButton1Click:Connect(serverHop)

local function updateLanguage()
    local t = translations[currentLang]
    titleText.Text = t.title
    godButton.Text = t.godBtn
    espColorLabel.Text = t.espColorLabel
    boardColorLabelObj.Text = t.boardColorLabel 
    themeLabel.Text = t.themeLabel
    textLabel.Text = t.textLabel
    langLabel.Text = t.langLabel
    rejoinButton.Text = t.rejoinBtn
    serverHopButton.Text = t.serverHopBtn

    for _, rf in ipairs(refreshFuncs) do rf() end
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
    btn.Parent = sidebar
    table.insert(textElements, btn)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

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
    tabButtons["Players"].Text = t.tabPlayers
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
    stopSpectate()
    toggleNoclip(false) toggleInvisibility(false) toggleFly(false) toggleInfJump(false) toggleFPSDisplay(false) toggleAutoPressButton(false) toggleFixLag(false) toggleHideMapAndOthers(false) toggleMuteAllSounds(false)
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
