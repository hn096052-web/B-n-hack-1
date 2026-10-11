--========================================================--
--                    H HUB AUTOFARM                       --
--       AUTOFARM + ESP + SPECTATE + FIX LAG + SETTINGS   --
--                    FIXED / CLEANED                      --
--========================================================--

--========================================================--
-- SERVICES
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local StarterGui = game:GetService("StarterGui")

--========================================================--
-- PLAYER
--========================================================--

local player = Players.LocalPlayer

if not player then
    warn("[H HUB] LocalPlayer không tồn tại.")
    return
end

local playerGui = player:WaitForChild("PlayerGui", 10)

if not playerGui then
    warn("[H HUB] Không tìm thấy PlayerGui.")
    return
end

print("[H HUB] Player OK:", player.Name)

--========================================================--
-- XÓA GUI CŨ
--========================================================--

pcall(function()
    local oldGui = playerGui:FindFirstChild("AutoFarmHubGui")

    if oldGui then
        oldGui:Destroy()
        task.wait()
    end
end)

--========================================================--
-- CONFIG
--========================================================--

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

--========================================================--
-- STATES
--========================================================--

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

local spectating = false

local selectedTargetPlayer = nil
local selectedEspTarget = "Tất cả"

local currentLang = "VI"

--========================================================--
-- COLORS
--========================================================--

local espColor = Color3.fromRGB(255, 0, 0)
local currentThemeColor = Color3.fromRGB(35, 35, 45)
local currentTextColor = Color3.fromRGB(255, 255, 255)

--========================================================--
-- CONNECTIONS / TASKS
--========================================================--

local noclipConnection = nil
local invisibleConnection = nil
local flyConnection = nil
local walkConnection = nil
local jumpConnection = nil
local infJumpConnection = nil
local spectateConnection = nil
local fpsConnection = nil
local gravityConnection = nil
local freezeRayTask = nil
local autoPressButtonTask = nil
local fixLagTask = nil
local fixLagChildConnection = nil
local hideMapConnection = nil
local muteSoundsConnection = nil

local gradientRunning = true

local originalHipHeight = nil
local frozenPlayersTable = {}

local savedTransparencies = {}
local hiddenObjects = {}
local mutedSounds = {}

local themeButtons = {}
local textElements = {}
local refreshFuncs = {}

local GLOBAL_FONT = Enum.Font.GothamBold

--========================================================--
-- TRANSLATIONS
--========================================================--

local translations = {

    EN = {

        title = "H HUB - AutoFarm",

        tabMain = "Main",
        tabEsp = "Players/ESP",
        tabFixLag = "Fix Lag",
        tabMisc = "Settings",

        tpSpd = "TP Speed (s):",
        walkSpd = "Walk Speed:",
        flySpd = "Fly Speed:",
        jumpSpd = "Jump Power:",
        gravSpd = "Gravity:",
        freezeRng = "Freeze Range:",

        autoPressRadiusLabel = "Click Button Range:",
        autoPressDelayLabel = "Click Button Delay (s):",

        tpBtn = "Auto TP Coins",
        walkBtn = "Custom Speed",
        jumpBtn = "Custom Jump",
        flyBtn = "Fly Mode",
        gravBtn = "Custom Gravity",

        noclipBtn = "Noclip Pass-Wall",
        invisBtn = "Invisibility",
        infJumpBtn = "Infinite Jump",

        freezeBtn = "Auto Freeze Ray",
        autoEquipBtn = "Equip Items (Run Once)",

        godBtn = "⚡ Open God Mode Panel",

        espBtn = "ESP Wallhack",
        spectateBtn = "Spectate Player",
        tpToSpecBtn = "Teleport To Spectated Target",
        fpsBtn = "Display FPS",

        autoPressBtn = "Auto Click Buttons",

        fixLagBtn = "Ultra Fix Lag",
        hideMapBtn = "Hide Map & Players",
        muteSoundsBtn = "Mute Game Sounds",

        espColorLabel = "ESP Highlight Color:",
        boardColorLabel = "Board Background Color:",
        themeLabel = "UI Button Color:",
        textLabel = "UI Text Color:",
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
        tabFixLag = "Fix Lag",
        tabMisc = "Cài đặt",

        tpSpd = "Tốc độ TP (giây):",
        walkSpd = "Tốc độ Đi bộ:",
        flySpd = "Tốc độ Bay:",
        jumpSpd = "Độ Cao Nhảy:",
        gravSpd = "Trọng Lực Game:",
        freezeRng = "Khoảng cách Freeze:",

        autoPressRadiusLabel = "Bán kính Click Nút:",
        autoPressDelayLabel = "Tốc độ Click Nút (s):",

        tpBtn = "Auto TP Nhặt Xu",
        walkBtn = "Chỉnh Tốc Độ Đi",
        jumpBtn = "Chỉnh Độ Nhảy",
        flyBtn = "Chế Độ Bay",
        gravBtn = "Trọng Lực Tùy Chỉnh",

        noclipBtn = "Đi Xuyên Tường",
        invisBtn = "Tàng Hình",
        infJumpBtn = "Nhảy Vô Hạn",

        freezeBtn = "Tự Động Freeze Ray",
        autoEquipBtn = "Trang Bị Đồ",

        godBtn = "⚡ Bảng God Mode",

        espBtn = "ESP Nhìn Xuyên Tường",
        spectateBtn = "Xem Người Chơi",
        tpToSpecBtn = "Dịch Chuyển Tới Người Đang Xem",
        fpsBtn = "Hiển Thị FPS",

        autoPressBtn = "Auto Click Nút",

        fixLagBtn = "Siêu Giảm Lag",
        hideMapBtn = "Ẩn Bản Đồ & Người Khác",
        muteSoundsBtn = "Tắt Âm Thanh Game",

        espColorLabel = "Màu ESP:",
        boardColorLabel = "Màu Bảng Điều Khiển:",
        themeLabel = "Màu Nút Giao Diện:",
        textLabel = "Màu Chữ Giao Diện:",
        langLabel = "Ngôn ngữ:",

        rejoinBtn = "Vào Lại Server",
        serverHopBtn = "Đổi Server Khác",

        on = "BẬT",
        off = "TẮT"
    }
}

--========================================================--
-- GUI
--========================================================--

print("[H HUB] Đang tạo GUI...")

local screenGui = Instance.new("ScreenGui")

screenGui.Name = "AutoFarmHubGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

screenGui.Parent = playerGui

print("[H HUB] ScreenGui OK")

--========================================================--
-- UTILITY
--========================================================--

local function safeCall(fn)
    local ok, err = pcall(fn)

    if not ok then
        warn("[H HUB ERROR]", err)
    end

    return ok
end

local function disconnectConnection(connection)
    if connection then
        pcall(function()
            connection:Disconnect()
        end)
    end

    return nil
end

local function cancelTask(taskObject)
    if taskObject then
        pcall(function()
            task.cancel(taskObject)
        end)
    end

    return nil
end

--========================================================--
-- SPECTATE
--========================================================--

local spectateFrame = nil
local specNameLabel = nil
local spectateIndex = 1

local function getSpectateTargets()

    local targets = {}

    for _, p in ipairs(Players:GetPlayers()) do

        if p ~= player and p.Parent then
            table.insert(targets, p)
        end

    end

    return targets
end

local function updateSpectateCamera()

    safeCall(function()

        local targets = getSpectateTargets()

        if #targets == 0 then

            if specNameLabel then
                specNameLabel.Text = "Không có người chơi khác"
            end

            return
        end

        if spectateIndex > #targets then
            spectateIndex = 1
        end

        if spectateIndex < 1 then
            spectateIndex = #targets
        end

        local target = targets[spectateIndex]

        if not target then
            return
        end

        if specNameLabel then
            specNameLabel.Text =
                target.DisplayName ..
                " (@" ..
                target.Name ..
                ")"
        end

        local camera = Workspace.CurrentCamera

        if not camera then
            return
        end

        local character = target.Character

        if not character then
            return
        end

        local humanoid =
            character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            camera.CameraSubject = humanoid
        end

    end)

end

local function teleportToSpectatedTarget()

    safeCall(function()

        local targets = getSpectateTargets()

        if #targets == 0 then
            return
        end

        if spectateIndex > #targets then
            spectateIndex = 1
        end

        local target = targets[spectateIndex]

        if not target then
            return
        end

        local targetCharacter = target.Character
        local myCharacter = player.Character

        if not targetCharacter or not myCharacter then
            return
        end

        local targetRoot =
            targetCharacter:FindFirstChild("HumanoidRootPart")
            or targetCharacter:FindFirstChild("Torso")

        local myRoot =
            myCharacter:FindFirstChild("HumanoidRootPart")
            or myCharacter:FindFirstChild("Torso")

        if targetRoot and myRoot then
            myRoot.CFrame =
                targetRoot.CFrame *
                CFrame.new(0, 0, 3)
        end

    end)

end

local function setBackpackVisible(state)

    safeCall(function()
        StarterGui:SetCoreGuiEnabled(
            Enum.CoreGuiType.Backpack,
            state
        )
    end)

end

local updateSpectateToggleBtnText = nil

local function toggleSpectate(state)

    spectating = state

    if spectateFrame then
        spectateFrame.Visible = state
    end

    setBackpackVisible(not state)

    if updateSpectateToggleBtnText then
        updateSpectateToggleBtnText()
    end

    local camera = Workspace.CurrentCamera

    if not camera then
        return
    end

    if state then

        spectateIndex = 1

        updateSpectateCamera()

        if not spectateConnection then

            spectateConnection =
                RunService.RenderStepped:Connect(function()

                    if not spectating then
                        return
                    end

                    local targets =
                        getSpectateTargets()

                    if #targets == 0 then
                        return
                    end

                    if spectateIndex > #targets then
                        spectateIndex = 1
                    end

                    local target =
                        targets[spectateIndex]

                    if target and target.Character then

                        local hum =
                            target.Character:FindFirstChildOfClass(
                                "Humanoid"
                            )

                        if hum and camera.CameraSubject ~= hum then
                            camera.CameraSubject = hum
                        end

                    end

                end)

        end

    else

        spectateConnection =
            disconnectConnection(spectateConnection)

        local character = player.Character

        if character then

            local humanoid =
                character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                camera.CameraSubject = humanoid
            end

        end

    end

end

--========================================================--
-- SOUND MUTE
--========================================================--

local function applyMuteToSound(sound)

    if not muteAllSoundsEnabled then
        return
    end

    if not sound:IsA("Sound") then
        return
    end

    safeCall(function()

        if mutedSounds[sound] == nil then
            mutedSounds[sound] = sound.Volume
        end

        sound.Volume = 0

    end)

end

local function toggleMuteAllSounds(state)

    muteAllSoundsEnabled = state

    if state then

        for _, obj in ipairs(game:GetDescendants()) do
            applyMuteToSound(obj)
        end

        muteSoundsConnection =
            disconnectConnection(muteSoundsConnection)

        muteSoundsConnection =
            game.DescendantAdded:Connect(function(obj)

                if muteAllSoundsEnabled then
                    applyMuteToSound(obj)
                end

            end)

    else

        muteSoundsConnection =
            disconnectConnection(muteSoundsConnection)

        for sound, originalVolume in pairs(mutedSounds) do

            if sound and sound.Parent then

                safeCall(function()
                    sound.Volume = originalVolume
                end)

            end

        end

        mutedSounds = {}

    end

end

--========================================================--
-- HIDE MAP
--========================================================--

local function isMySelfOrItem(obj)

    local character = player.Character

    if character then

        if obj == character
            or obj:IsDescendantOf(character) then

            return true
        end

    end

    local backpack = player:FindFirstChild("Backpack")

    if backpack then

        if obj == backpack
            or obj:IsDescendantOf(backpack) then

            return true
        end

    end

    if obj:IsA("Sky")
        or obj:IsA("Atmosphere")
        or obj:IsA("SunRaysEffect")
        or obj:IsA("BloomEffect") then

        return true
    end

    return false
end

local function applyHideToObject(obj)

    if not hideMapOthersEnabled then
        return
    end

    if isMySelfOrItem(obj) then
        return
    end

    safeCall(function()

        if obj:IsA("BasePart") then

            if hiddenObjects[obj] == nil then
                hiddenObjects[obj] =
                    obj.LocalTransparencyModifier
            end

            obj.LocalTransparencyModifier = 1

        elseif obj:IsA("Decal")
            or obj:IsA("Texture") then

            if hiddenObjects[obj] == nil then
                hiddenObjects[obj] = obj.Transparency
            end

            obj.Transparency = 1

        elseif obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Smoke")
            or obj:IsA("Fire")
            or obj:IsA("Sparkles") then

            if hiddenObjects[obj] == nil then
                hiddenObjects[obj] = obj.Enabled
            end

            obj.Enabled = false

        elseif obj:IsA("BillboardGui")
            or obj:IsA("SurfaceGui") then

            if hiddenObjects[obj] == nil then
                hiddenObjects[obj] = obj.Enabled
            end

            obj.Enabled = false

        end

    end)

end

local function toggleHideMapAndOthers(state)

    hideMapOthersEnabled = state

    if state then

        for _, obj in ipairs(Workspace:GetDescendants()) do
            applyHideToObject(obj)
        end

        hideMapConnection =
            disconnectConnection(hideMapConnection)

        hideMapConnection =
            Workspace.DescendantAdded:Connect(function(obj)

                if hideMapOthersEnabled then
                    applyHideToObject(obj)
                end

            end)

    else

        hideMapConnection =
            disconnectConnection(hideMapConnection)

        for obj, originalValue in pairs(hiddenObjects) do

            if obj and obj.Parent then

                safeCall(function()

                    if obj:IsA("BasePart") then

                        obj.LocalTransparencyModifier =
                            originalValue

                    elseif obj:IsA("Decal")
                        or obj:IsA("Texture") then

                        obj.Transparency =
                            originalValue

                    elseif obj:IsA("ParticleEmitter")
                        or obj:IsA("Trail")
                        or obj:IsA("Smoke")
                        or obj:IsA("Fire")
                        or obj:IsA("Sparkles") then

                        obj.Enabled =
                            originalValue

                    elseif obj:IsA("BillboardGui")
                        or obj:IsA("SurfaceGui") then

                        obj.Enabled =
                            originalValue

                    end

                end)

            end

        end

        hiddenObjects = {}

    end

end

--========================================================--
-- FIX LAG
--========================================================--

local function optimizePartExtreme(obj)

    if not fixLagEnabled then
        return
    end

    if not obj or not obj.Parent then
        return
    end

    safeCall(function()

        -- MeshPart phải đứng trước BasePart
        if obj:IsA("MeshPart") then

            obj.Material =
                Enum.Material.SmoothPlastic

            obj.Reflectance = 0
            obj.CastShadow = false

            pcall(function()
                obj.TextureID = ""
            end)

        elseif obj:IsA("BasePart") then

            obj.Material =
                Enum.Material.SmoothPlastic

            obj.Reflectance = 0
            obj.CastShadow = false

        elseif obj:IsA("SpecialMesh") then

            pcall(function()
                obj.TextureId = ""
            end)

        elseif obj:IsA("Decal")
            or obj:IsA("Texture") then

            obj.Transparency = 1

        elseif obj:IsA("SurfaceAppearance") then

            obj:Destroy()

        elseif obj:IsA("ParticleEmitter")
            or obj:IsA("Trail")
            or obj:IsA("Smoke")
            or obj:IsA("Fire")
            or obj:IsA("Sparkles")
            or obj:IsA("Beam") then

            obj.Enabled = false

        elseif obj:IsA("PostEffect") then

            obj.Enabled = false

        elseif obj:IsA("Explosion") then

            obj.Visible = false

        end

    end)

end

local function toggleFixLag(state)

    fixLagEnabled = state

    if state then

        safeCall(function()

            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.FogStart = 9e9
            Lighting.Brightness = 1

            pcall(function()
                Lighting.Technology =
                    Enum.Technology.Compatibility
            end)

            local terrain =
                Workspace:FindFirstChildOfClass("Terrain")

            if terrain then

                pcall(function()
                    terrain.WaterWaveSize = 0
                    terrain.WaterWaveSpeed = 0
                    terrain.WaterReflectance = 0
                    terrain.WaterTransparency = 0
                    terrain.Decoration = false
                end)

            end

        end)

        for _, obj in ipairs(game:GetDescendants()) do
            optimizePartExtreme(obj)
        end

        fixLagChildConnection =
            disconnectConnection(fixLagChildConnection)

        fixLagChildConnection =
            game.DescendantAdded:Connect(function(obj)

                if fixLagEnabled then
                    optimizePartExtreme(obj)
                end

            end)

        fixLagTask =
            cancelTask(fixLagTask)

        fixLagTask =
            task.spawn(function()

                while fixLagEnabled do

                    for _, obj in ipairs(Workspace:GetDescendants()) do

                        if not fixLagEnabled then
                            break
                        end

                        optimizePartExtreme(obj)

                    end

                    task.wait(2)

                end

            end)

    else

        fixLagChildConnection =
            disconnectConnection(fixLagChildConnection)

        fixLagTask =
            cancelTask(fixLagTask)

    end

end

--========================================================--
-- REJOIN / SERVER HOP
--========================================================--

local function rejoinServer()

    safeCall(function()

        TeleportService:Teleport(
            game.PlaceId,
            player
        )

    end)

end

local function serverHop()

    task.spawn(function()

        local placeId = game.PlaceId

        local baseUrl =
            "https://games.roblox.com/v1/games/"
            .. placeId
            .. "/servers/Public?sortOrder=Asc&limit=100"

        local cursor = nil

        while true do

            local url = baseUrl

            if cursor then
                url =
                    url ..
                    "&cursor=" ..
                    HttpService:UrlEncode(cursor)
            end

            local success, result =
                pcall(function()

                    return HttpService:JSONDecode(
                        game:HttpGet(url)
                    )

                end)

            if not success or not result then
                warn("[H HUB] Không lấy được danh sách server.")
                return
            end

            if result.data then

                for _, server in ipairs(result.data) do

                    if server.id
                        and server.id ~= game.JobId
                        and server.playing
                        and server.maxPlayers
                        and server.playing < server.maxPlayers
                        and server.playing > 0 then

                        TeleportService:TeleportToPlaceInstance(
                            placeId,
                            server.id,
                            player
                        )

                        return

                    end

                end

            end

            cursor = result.nextPageCursor

            if not cursor then
                break
            end

            task.wait(0.5)

        end

        TeleportService:Teleport(
            placeId,
            player
        )

    end)

end

--========================================================--
-- AUTO EQUIP
--========================================================--

local allEquipItems = {

    "PieThrow",
    "SmallPotion",
    "GiantPotion",
    "GhostPotion",
    "Healing",
    "GravityPotion",
    "Bloxiade",
    "ClownBomb",
    "Slate",
    "WindPotion",
    "IcePotion",
    "SlowDownGun",
    "GravityGun",
    "GravityDisruptor",
    "FreezeRay",
    "Bomb",
    "Jetpack",
    "DecoyDeploy",
    "AprilShowers",
    "Balloon",
    "MarchingDrum",
    "Trumpet",
    "Trowel",
    "TeapotLauncher",
    "BunchOfBalloons",
    "BangGun",
    "EpicJuice",
    "EpicSauce",
    "Ball",
    "Torch",
    "Cake",
    "MoneyBag",
    "IceCreamCone",
    "Teddy",
    "Witch",
    "Watermelon",
    "Taco",
    "Bloxy",
    "Pizza",
    "Coco"
}

local function equipItemsOnce()

    task.spawn(function()

        local ReplicatedStorage =
            game:GetService("ReplicatedStorage")

        local equipEvent =
            ReplicatedStorage:WaitForChild(
                "Equip",
                5
            )

        if not equipEvent then
            warn("[H HUB] Không tìm thấy Equip.")
            return
        end

        for _, item in ipairs(allEquipItems) do

            pcall(function()
                equipEvent:FireServer(
                    "UNEQUIP",
                    item
                )
            end)

            task.wait(0.08)

        end

        task.wait(0.3)

        for _, item in ipairs(allEquipItems) do

            pcall(function()
                equipEvent:FireServer(
                    "EQUIP",
                    item
                )
            end)

            task.wait(0.08)

        end

    end)

end

--========================================================--
-- AUTO CLICK
--========================================================--

local function toggleAutoPressButton(state)

    autoPressButtonEnabled = state

    if state then

        autoPressButtonTask =
            cancelTask(autoPressButtonTask)

        autoPressButtonTask =
            task.spawn(function()

                while autoPressButtonEnabled do

                    safeCall(function()

                        local character =
                            player.Character

                        local root =
                            character
                            and character:FindFirstChild(
                                "HumanoidRootPart"
                            )

                        if not root then
                            return
                        end

                        for _, obj in ipairs(
                            Workspace:GetDescendants()
                        ) do

                            if not autoPressButtonEnabled then
                                break
                            end

                            local near = false

                            if obj:IsA("BasePart") then

                                near =
                                    (
                                        root.Position -
                                        obj.Position
                                    ).Magnitude
                                    <= autoPressRadius

                            elseif obj:IsA("PVInstance") then

                                near =
                                    (
                                        root.Position -
                                        obj:GetPivot().Position
                                    ).Magnitude
                                    <= autoPressRadius

                            elseif obj.Parent
                                and obj.Parent:IsA("BasePart") then

                                near =
                                    (
                                        root.Position -
                                        obj.Parent.Position
                                    ).Magnitude
                                    <= autoPressRadius

                            end

                            if near then

                                -- Chỉ gọi nếu môi trường có API
                                if obj:IsA("ClickDetector") then

                                    if typeof(
                                        fireclickdetector
                                    ) == "function" then

                                        pcall(function()
                                            fireclickdetector(obj)
                                        end)

                                    end

                                elseif obj:IsA("ProximityPrompt") then

                                    if typeof(
                                        fireproximityprompt
                                    ) == "function" then

                                        pcall(function()
                                            fireproximityprompt(obj)
                                        end)

                                    end

                                end

                            end

                        end

                    end)

                    task.wait(
                        math.max(
                            tonumber(autoPressDelay) or 0.1,
                            0.05
                        )
                    )

                end

            end)

    else

        autoPressButtonTask =
            cancelTask(autoPressButtonTask)

    end

end

--========================================================--
-- NOCLIP
--========================================================--

local function toggleNoclip(state)

    noclipEnabled = state

    local character = player.Character

    if not character then
        return
    end

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    if state then

        if humanoid and not originalHipHeight then

            originalHipHeight =
                humanoid.HipHeight

            humanoid.HipHeight =
                originalHipHeight + 0.5

        end

        noclipConnection =
            disconnectConnection(noclipConnection)

        noclipConnection =
            RunService.Stepped:Connect(function()

                local char = player.Character

                if not char then
                    return
                end

                for _, part in ipairs(
                    char:GetDescendants()
                ) do

                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end

                end

            end)

    else

        noclipConnection =
            disconnectConnection(noclipConnection)

        if humanoid and originalHipHeight then

            humanoid.HipHeight =
                originalHipHeight

            originalHipHeight = nil

        end

        for _, part in ipairs(
            character:GetDescendants()
        ) do

            if part:IsA("BasePart")
                and part.Name ~= "HumanoidRootPart" then

                part.CanCollide = true

            end

        end

    end

end

--========================================================--
-- INVISIBILITY
--========================================================--

local function toggleInvisibility(state)

    invisibleEnabled = state

    local character = player.Character

    if not character then
        return
    end

    if state then

        savedTransparencies = {}

        invisibleConnection =
            disconnectConnection(invisibleConnection)

        invisibleConnection =
            RunService.RenderStepped:Connect(function()

                local char = player.Character

                if not char then
                    return
                end

                for _, obj in ipairs(
                    char:GetDescendants()
                ) do

                    if obj:IsA("BasePart")
                        and obj.Name ~= "HumanoidRootPart" then

                        if savedTransparencies[obj] == nil then
                            savedTransparencies[obj] =
                                obj.Transparency
                        end

                        obj.Transparency = 1

                    elseif obj:IsA("Decal")
                        or obj:IsA("Texture") then

                        if savedTransparencies[obj] == nil then
                            savedTransparencies[obj] =
                                obj.Transparency
                        end

                        obj.Transparency = 1

                    elseif obj:IsA("BillboardGui")
                        or obj:IsA("SurfaceGui") then

                        obj.Enabled = false

                    end

                end

            end)

    else

        invisibleConnection =
            disconnectConnection(invisibleConnection)

        for obj, transparency in pairs(
            savedTransparencies
        ) do

            if obj and obj.Parent then

                pcall(function()
                    obj.Transparency = transparency
                end)

            end

        end

        for _, obj in ipairs(
            character:GetDescendants()
        ) do

            if obj:IsA("BillboardGui")
                or obj:IsA("SurfaceGui") then

                obj.Enabled = true

            end

        end

        savedTransparencies = {}

    end

end

--========================================================--
-- FLY
--========================================================--

local function toggleFly(state)

    flyEnabled = state

    local character = player.Character

    if not character then
        return
    end

    local root =
        character:FindFirstChild(
            "HumanoidRootPart"
        )

    local humanoid =
        character:FindFirstChildOfClass("Humanoid")

    if not root or not humanoid then
        return
    end

    if state then

        local oldGyro =
            root:FindFirstChild("H_HUB_FlyGyro")

        local oldVelocity =
            root:FindFirstChild("H_HUB_FlyVelocity")

        if oldGyro then
            oldGyro:Destroy()
        end

        if oldVelocity then
            oldVelocity:Destroy()
        end

        humanoid.PlatformStand = true

        local bg = Instance.new("BodyGyro")

        bg.Name = "H_HUB_FlyGyro"
        bg.P = 90000
        bg.MaxTorque =
            Vector3.new(
                90000,
                90000,
                90000
            )

        bg.CFrame = root.CFrame
        bg.Parent = root

        local bv = Instance.new("BodyVelocity")

        bv.Name = "H_HUB_FlyVelocity"

        bv.MaxForce =
            Vector3.new(
                90000,
                90000,
                90000
            )

        bv.Velocity = Vector3.zero
        bv.Parent = root

        flyConnection =
            disconnectConnection(flyConnection)

        flyConnection =
            RunService.RenderStepped:Connect(function()

                if not flyEnabled
                    or not character.Parent then

                    if bg then
                        bg:Destroy()
                    end

                    if bv then
                        bv:Destroy()
                    end

                    return

                end

                local camera =
                    Workspace.CurrentCamera

                if not camera then
                    return
                end

                local move =
                    humanoid.MoveDirection

                local look =
                    camera.CFrame.LookVector

                local right =
                    camera.CFrame.RightVector

                local flatLook =
                    Vector3.new(
                        look.X,
                        0,
                        look.Z
                    )

                local flatRight =
                    Vector3.new(
                        right.X,
                        0,
                        right.Z
                    )

                if flatLook.Magnitude > 0 then
                    flatLook =
                        flatLook.Unit
                end

                if flatRight.Magnitude > 0 then
                    flatRight =
                        flatRight.Unit
                end

                local flyVector =
                    Vector3.zero

                if move.Magnitude > 0 then

                    flyVector =
                        flatRight * move.X
                        +
                        flatLook * move.Z

                end

                bv.Velocity =
                    flyVector * flySpeed

                bg.CFrame =
                    camera.CFrame

            end)

    else

        flyConnection =
            disconnectConnection(flyConnection)

        local bg =
            root:FindFirstChild(
                "H_HUB_FlyGyro"
            )

        local bv =
            root:FindFirstChild(
                "H_HUB_FlyVelocity"
            )

        if bg then
            bg:Destroy()
        end

        if bv then
            bv:Destroy()
        end

        humanoid.PlatformStand = false

    end

end

--========================================================--
-- INFINITE JUMP
--========================================================--

local function toggleInfJump(state)

    infJumpEnabled = state

    if state then

        infJumpConnection =
            disconnectConnection(
                infJumpConnection
            )

        infJumpConnection =
            UserInputService.JumpRequest:Connect(
                function()

                    if not infJumpEnabled then
                        return
                    end

                    local character =
                        player.Character

                    local humanoid =
                        character
                        and character:FindFirstChildOfClass(
                            "Humanoid"
                        )

                    if humanoid then

                        humanoid:ChangeState(
                            Enum.HumanoidStateType.Jumping
                        )

                    end

                end
            )

    else

        infJumpConnection =
            disconnectConnection(
                infJumpConnection
            )

    end

end

--========================================================--
-- ESP
--========================================================--

local function removeHighlight(character)

    if not character then
        return
    end

    local highlight =
        character:FindFirstChild(
            "H_HUB_ESP"
        )

    if highlight then
        highlight:Destroy()
    end

    local head =
        character:FindFirstChild("Head")

    if head then

        local billboard =
            head:FindFirstChild(
                "H_HUB_NameESP"
            )

        if billboard then
            billboard:Destroy()
        end

    end

end

local function createHighlight(
    character,
    targetPlayer
)

    if not character
        or not targetPlayer then

        return
    end

    local head =
        character:FindFirstChild("Head")

    if head then

        local billboard =
            head:FindFirstChild(
                "H_HUB_NameESP"
            )

        if not billboard then

            billboard =
                Instance.new("BillboardGui")

            billboard.Name =
                "H_HUB_NameESP"

            billboard.Adornee = head

            billboard.Size =
                UDim2.new(
                    0,
                    180,
                    0,
                    30
                )

            billboard.StudsOffset =
                Vector3.new(
                    0,
                    2.5,
                    0
                )

            billboard.AlwaysOnTop = true

            local label =
                Instance.new("TextLabel")

            label.Name =
                "NameLabel"

            label.Size =
                UDim2.fromScale(
                    1,
                    1
                )

            label.BackgroundTransparency = 1

            label.Text =
                targetPlayer.DisplayName
                ..
                " (@"
                ..
                targetPlayer.Name
                ..
                ")"

            label.TextColor3 =
                espColor

            label.TextStrokeTransparency = 0

            label.TextStrokeColor3 =
                Color3.new(
                    0,
                    0,
                    0
                )

            label.TextScaled = true
            label.Font = GLOBAL_FONT

            label.Parent = billboard

            billboard.Parent = head

        else

            local label =
                billboard:FindFirstChild(
                    "NameLabel"
                )

            if label then
                label.TextColor3 =
                    espColor
            end

        end

    end

    local highlight =
        character:FindFirstChild(
            "H_HUB_ESP"
        )

    if not highlight then

        highlight =
            Instance.new("Highlight")

        highlight.Name =
            "H_HUB_ESP"

        highlight.Adornee =
            character

        highlight.FillTransparency =
            0.5

        highlight.OutlineTransparency =
            0

        highlight.OutlineColor =
            Color3.new(
                1,
                1,
                1
            )

        highlight.DepthMode =
            Enum.HighlightDepthMode.AlwaysOnTop

        highlight.Parent =
            character

    end

    highlight.FillColor =
        espColor

end

local function updateESP()

    for _, p in ipairs(
        Players:GetPlayers()
    ) do

        if p.Character then
            removeHighlight(
                p.Character
            )
        end

    end

    if not espEnabled then
        return
    end

    if selectedEspTarget == "Tất cả"
        or selectedEspTarget == "All" then

        for _, p in ipairs(
            Players:GetPlayers()
        ) do

            if p ~= player
                and p.Character then

                createHighlight(
                    p.Character,
                    p
                )

            end

        end

    else

        for _, p in ipairs(
            Players:GetPlayers()
        ) do

            if p ~= player
                and (
                    p.Name == selectedEspTarget
                    or p.DisplayName == selectedEspTarget
                ) then

                if p.Character then

                    createHighlight(
                        p.Character,
                        p
                    )

                end

                break

            end

        end

    end

end

Players.PlayerAdded:Connect(function(p)

    p.CharacterAdded:Connect(function()

        task.wait(1)

        if espEnabled then
            updateESP()
        end

    end)

end)

Players.PlayerRemoving:Connect(function()

    if espEnabled then
        task.defer(updateESP)
    end

end)

--========================================================--
-- FREEZE RAY
--========================================================--

local function isPlayerInCooldown(target)

    if not target then
        return true
    end

    local lastShot =
        frozenPlayersTable[target]
        or 0

    return (
        tick() - lastShot
    ) < FREEZE_COOLDOWN

end

local function getDirectTarget()

    local character =
        player.Character

    local root =
        character
        and character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not root then
        return nil, nil
    end

    if selectedTargetPlayer
        and selectedTargetPlayer.Parent then

        if isPlayerInCooldown(
            selectedTargetPlayer
        ) then

            return nil, nil

        end

        local targetCharacter =
            selectedTargetPlayer.Character

        local targetRoot =
            targetCharacter
            and (
                targetCharacter:FindFirstChild(
                    "HumanoidRootPart"
                )
                or targetCharacter:FindFirstChild(
                    "Torso"
                )
            )

        if targetRoot then

            local distance =
                (
                    targetRoot.Position -
                    root.Position
                ).Magnitude

            if distance <= freezeRadius then
                return targetRoot,
                    selectedTargetPlayer
            end

        end

        return nil, nil

    end

    local closestRoot = nil
    local closestPlayer = nil
    local shortestDistance = freezeRadius

    for _, target in ipairs(
        Players:GetPlayers()
    ) do

        if target ~= player
            and not isPlayerInCooldown(target) then

            local targetCharacter =
                target.Character

            local targetRoot =
                targetCharacter
                and (
                    targetCharacter:FindFirstChild(
                        "HumanoidRootPart"
                    )
                    or targetCharacter:FindFirstChild(
                        "Torso"
                    )
                )

            if targetRoot then

                local distance =
                    (
                        targetRoot.Position -
                        root.Position
                    ).Magnitude

                if distance <= shortestDistance then

                    shortestDistance =
                        distance

                    closestRoot =
                        targetRoot

                    closestPlayer =
                        target

                end

            end

        end

    end

    return closestRoot,
        closestPlayer

end

local function toggleFreezeRay(state)

    freezeRayEnabled = state

    if state then

        freezeRayTask =
            cancelTask(freezeRayTask)

        freezeRayTask =
            task.spawn(function()

                while freezeRayEnabled do

                    local targetPart,
                        targetPlayerObj =
                        getDirectTarget()

                    if targetPart
                        and targetPlayerObj then

                        local character =
                            player.Character

                        local humanoid =
                            character
                            and character:FindFirstChildOfClass(
                                "Humanoid"
                            )

                        local backpack =
                            player:FindFirstChild(
                                "Backpack"
                            )

                        if character
                            and humanoid then

                            local tool =
                                character:FindFirstChild(
                                    "FreezeRay"
                                )
                                or (
                                    backpack
                                    and backpack:FindFirstChild(
                                        "FreezeRay"
                                    )
                                )

                            if tool then

                                if backpack
                                    and tool.Parent == backpack then

                                    pcall(function()
                                        humanoid:EquipTool(tool)
                                    end)

                                end

                                local fireEvent =
                                    tool:FindFirstChild(
                                        "FireEvent"
                                    )
                                    or tool:FindFirstChild(
                                        "RemoteEvent"
                                    )

                                if fireEvent
                                    and fireEvent:IsA(
                                        "RemoteEvent"
                                    ) then

                                    pcall(function()

                                        fireEvent:FireServer(
                                            targetPart.Position,
                                            targetPart
                                        )

                                    end)

                                    frozenPlayersTable[
                                        targetPlayerObj
                                    ] = tick()

                                end

                            end

                        end

                    end

                    task.wait(
                        math.max(
                            SHOT_DELAY,
                            0.1
                        )
                    )

                end

            end)

    else

        freezeRayTask =
            cancelTask(
                freezeRayTask
            )

    end

end

--========================================================--
-- COINS / AUTO TP
--========================================================--

local function findAllCoins()

    local coins = {}

    for _, obj in ipairs(
        Workspace:GetDescendants()
    ) do

        if obj:IsA("BasePart")
            and obj.Name == coinName then

            table.insert(
                coins,
                obj
            )

        end

    end

    return coins

end

local function startTeleportLoop()

    task.spawn(function()

        while screenGui
            and screenGui.Parent do

            if tpEnabled then

                local character =
                    player.Character

                local humanoid =
                    character
                    and character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                local root =
                    character
                    and character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if character
                    and humanoid
                    and root then

                    local coins =
                        findAllCoins()

                    for _, coin in ipairs(
                        coins
                    ) do

                        if not tpEnabled then
                            break
                        end

                        if coin
                            and coin.Parent then

                            root.CFrame =
                                CFrame.new(
                                    coin.Position
                                    + Vector3.new(
                                        0,
                                        1,
                                        0
                                    )
                                )

                            humanoid:Move(
                                Vector3.new(
                                    1,
                                    0,
                                    0
                                ),
                                true
                            )

                            humanoid.Jump = false

                            task.wait(
                                math.max(
                                    tpSpeed,
                                    0.05
                                )
                            )

                        end

                    end

                end

            end

            task.wait(
                math.max(
                    tpSpeed,
                    0.05
                )
            )

        end

    end)

end

--========================================================--
-- GUI HELPERS
--========================================================--

local function updateButtonVisual(
    button,
    isOn
)

    if not button then
        return
    end

    if isOn then

        button.BackgroundColor3 =
            Color3.fromRGB(
                45,
                160,
                85
            )

    else

        button.BackgroundColor3 =
            currentThemeColor

    end

end

local function applyThemeColor(color)

    currentThemeColor =
        color

    for _, button in ipairs(
        themeButtons
    ) do

        if button
            and button.Parent then

            local isOn =
                button:GetAttribute(
                    "IsOnState"
                )

            if not isOn then
                button.BackgroundColor3 =
                    currentThemeColor
            end

        end

    end

end

local function applyTextColor(color)

    currentTextColor =
        color

    for _, obj in ipairs(
        textElements
    ) do

        if obj
            and obj.Parent then

            obj.TextColor3 =
                currentTextColor

        end

    end

end

--========================================================--
-- MAIN FRAME
--========================================================--

local frame =
    Instance.new("Frame")

frame.Name =
    "MainFrame"

frame.Size =
    UDim2.new(
        0,
        390,
        0,
        320
    )

frame.Position =
    UDim2.new(
        0.5,
        -195,
        0.5,
        -160
    )

frame.BackgroundColor3 =
    Color3.fromRGB(
        20,
        20,
        25
    )

frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = true

frame.Parent =
    screenGui

--========================================================--
-- GRADIENT
--========================================================--

local gradientFrame =
    Instance.new("UIGradient")

gradientFrame.Color =
    ColorSequence.new({

        ColorSequenceKeypoint.new(
            0,
            Color3.fromRGB(
                15,
                15,
                20
            )
        ),

        ColorSequenceKeypoint.new(
            0.5,
            Color3.fromRGB(
                30,
                25,
                40
            )
        ),

        ColorSequenceKeypoint.new(
            1,
            Color3.fromRGB(
                15,
                15,
                20
            )
        )

    })

gradientFrame.Rotation = 45
gradientFrame.Parent = frame

task.spawn(function()

    local rotation = 0

    while gradientRunning
        and screenGui
        and screenGui.Parent do

        rotation += 0.5

        if rotation >= 360 then
            rotation = 0
        end

        if gradientFrame
            and gradientFrame.Parent then

            gradientFrame.Rotation =
                rotation

        end

        task.wait(0.03)

    end

end)

--========================================================--
-- FRAME STYLE
--========================================================--

local corner =
    Instance.new("UICorner")

corner.CornerRadius =
    UDim.new(
        0,
        8
    )

corner.Parent =
    frame

local frameStroke =
    Instance.new("UIStroke")

frameStroke.Color =
    Color3.fromRGB(
        60,
        60,
        100
    )

frameStroke.Thickness = 2
frameStroke.Transparency = 0.4
frameStroke.Parent = frame

--========================================================--
-- TITLE BAR
--========================================================--

local titleBar =
    Instance.new("Frame")

titleBar.Size =
    UDim2.new(
        1,
        0,
        0,
        35
    )

titleBar.BackgroundColor3 =
    Color3.fromRGB(
        10,
        10,
        15
    )

titleBar.BackgroundTransparency =
    0.3

titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local titleCorner =
    Instance.new("UICorner")

titleCorner.CornerRadius =
    UDim.new(
        0,
        8
    )

titleCorner.Parent =
    titleBar

local titleText =
    Instance.new("TextLabel")

titleText.Size =
    UDim2.new(
        1,
        -70,
        1,
        0
    )

titleText.Position =
    UDim2.new(
        0,
        12,
        0,
        0
    )

titleText.BackgroundTransparency = 1
titleText.Text = "H HUB - AutoFarm"
titleText.TextColor3 =
    currentTextColor

titleText.Font =
    GLOBAL_FONT

titleText.TextSize = 15

titleText.TextXAlignment =
    Enum.TextXAlignment.Left

titleText.Parent =
    titleBar

table.insert(
    textElements,
    titleText
)

--========================================================--
-- MINIMIZE
--========================================================--

local minimizeButton =
    Instance.new("TextButton")

minimizeButton.Size =
    UDim2.new(
        0,
        28,
        0,
        22
    )

minimizeButton.Position =
    UDim2.new(
        1,
        -62,
        0,
        6
    )

minimizeButton.BackgroundColor3 =
    Color3.fromRGB(
        45,
        45,
        55
    )

minimizeButton.Text = "-"
minimizeButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

minimizeButton.Font =
    GLOBAL_FONT

minimizeButton.TextSize = 20

minimizeButton.Parent =
    titleBar

Instance.new(
    "UICorner",
    minimizeButton
).CornerRadius =
    UDim.new(
        0,
        4
    )

--========================================================--
-- CLOSE
--========================================================--

local closeButton =
    Instance.new("TextButton")

closeButton.Size =
    UDim2.new(
        0,
        28,
        0,
        22
    )

closeButton.Position =
    UDim2.new(
        1,
        -30,
        0,
        6
    )

closeButton.BackgroundColor3 =
    Color3.fromRGB(
        200,
        50,
        50
    )

closeButton.Text = "X"

closeButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

closeButton.Font =
    GLOBAL_FONT

closeButton.TextSize = 13

closeButton.Parent =
    titleBar

Instance.new(
    "UICorner",
    closeButton
).CornerRadius =
    UDim.new(
        0,
        4
    )

--========================================================--
-- SIDEBAR
--========================================================--

local sidebar =
    Instance.new("Frame")

sidebar.Size =
    UDim2.new(
        0,
        110,
        1,
        -35
    )

sidebar.Position =
    UDim2.new(
        0,
        0,
        0,
        35
    )

sidebar.BackgroundColor3 =
    Color3.fromRGB(
        15,
        15,
        20
    )

sidebar.BackgroundTransparency =
    0.5

sidebar.BorderSizePixel = 0
sidebar.Parent = frame

Instance.new(
    "UICorner",
    sidebar
).CornerRadius =
    UDim.new(
        0,
        8
    )

--========================================================--
-- CONTAINER
--========================================================--

local container =
    Instance.new("Frame")

container.Size =
    UDim2.new(
        1,
        -115,
        1,
        -35
    )

container.Position =
    UDim2.new(
        0,
        115,
        0,
        35
    )

container.BackgroundTransparency = 1
container.Parent = frame

--========================================================--
-- TABS
--========================================================--

local tabs = {}

local tabNames = {
    "Main",
    "ESP",
    "FixLag",
    "Misc"
}

for _, name in ipairs(tabNames) do

    local scrolling =
        Instance.new("ScrollingFrame")

    scrolling.Name =
        name .. "Tab"

    scrolling.Size =
        UDim2.new(
            1,
            -5,
            1,
            0
        )

    scrolling.BackgroundTransparency = 1
    scrolling.BorderSizePixel = 0

    scrolling.ScrollBarThickness = 4

    scrolling.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    scrolling.Visible = false
    scrolling.Parent = container

    local layout =
        Instance.new("UIListLayout")

    layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    layout.Padding =
        UDim.new(
            0,
            8
        )

    layout.Parent =
        scrolling

    local padding =
        Instance.new("UIPadding")

    padding.PaddingTop =
        UDim.new(
            0,
            6
        )

    padding.PaddingBottom =
        UDim.new(
            0,
            10
        )

    padding.PaddingLeft =
        UDim.new(
            0,
            2
        )

    padding.PaddingRight =
        UDim.new(
            0,
            6
        )

    padding.Parent =
        scrolling

    layout:GetPropertyChangedSignal(
        "AbsoluteContentSize"
    ):Connect(function()

        scrolling.CanvasSize =
            UDim2.new(
                0,
                0,
                0,
                layout.AbsoluteContentSize.Y + 15
            )

    end)

    tabs[name] =
        scrolling

end

--========================================================--
-- ROW CREATION
--========================================================--

local function createToggleRow(
    parent,
    key,
    initialState,
    callback
)

    local row =
        Instance.new("Frame")

    row.Size =
        UDim2.new(
            1,
            0,
            0,
            32
        )

    row.BackgroundTransparency = 1
    row.Parent = parent

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.fromScale(
            1,
            1
        )

    button.BackgroundColor3 =
        currentThemeColor

    button.TextColor3 =
        currentTextColor

    button.Font =
        GLOBAL_FONT

    button.TextSize = 11
    button.Parent = row

    table.insert(
        themeButtons,
        button
    )

    table.insert(
        textElements,
        button
    )

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    local state =
        initialState

    local function refresh()

        local t =
            translations[currentLang]

        local status =
            state
            and (" [" .. t.on .. "]")
            or (" [" .. t.off .. "]")

        button.Text =
            (
                t[key]
                or key
            )
            ..
            status

        button:SetAttribute(
            "IsOnState",
            state
        )

        updateButtonVisual(
            button,
            state
        )

    end

    button.MouseButton1Click:Connect(
        function()

            state = not state

            refresh()

            callback(state)

        end
    )

    refresh()

    return button, refresh

end

local function createButtonRow(
    parent,
    key,
    callback
)

    local row =
        Instance.new("Frame")

    row.Size =
        UDim2.new(
            1,
            0,
            0,
            32
        )

    row.BackgroundTransparency = 1
    row.Parent = parent

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.fromScale(
            1,
            1
        )

    button.BackgroundColor3 =
        currentThemeColor

    button.TextColor3 =
        currentTextColor

    button.Font =
        GLOBAL_FONT

    button.TextSize = 11

    button.Parent =
        row

    table.insert(
        themeButtons,
        button
    )

    table.insert(
        textElements,
        button
    )

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    local function refresh()

        button.Text =
            translations[currentLang][key]
            or key

    end

    refresh()

    button.MouseButton1Click:Connect(
        callback
    )

    return button, refresh

end

local function createInputRow(
    parent,
    key,
    defaultValue,
    callback
)

    local row =
        Instance.new("Frame")

    row.Size =
        UDim2.new(
            1,
            0,
            0,
            30
        )

    row.BackgroundTransparency = 1
    row.Parent = parent

    local label =
        Instance.new("TextLabel")

    label.Size =
        UDim2.new(
            0.58,
            0,
            1,
            0
        )

    label.BackgroundTransparency = 1

    label.TextColor3 =
        currentTextColor

    label.Font =
        GLOBAL_FONT

    label.TextSize = 11

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.Parent =
        row

    table.insert(
        textElements,
        label
    )

    local box =
        Instance.new("TextBox")

    box.Size =
        UDim2.new(
            0.38,
            0,
            1,
            0
        )

    box.Position =
        UDim2.new(
            0.62,
            0,
            0,
            0
        )

    box.BackgroundColor3 =
        currentThemeColor

    box.TextColor3 =
        currentTextColor

    box.Font =
        GLOBAL_FONT

    box.TextSize = 11

    box.Text =
        tostring(
            defaultValue
        )

    box.ClearTextOnFocus = false

    box.Parent =
        row

    table.insert(
        themeButtons,
        box
    )

    table.insert(
        textElements,
        box
    )

    Instance.new(
        "UICorner",
        box
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    box.FocusLost:Connect(
        function()

            local value =
                tonumber(
                    box.Text
                )

            if value then

                callback(value)

            else

                box.Text =
                    tostring(
                        defaultValue
                    )

            end

        end
    )

    local function refresh()

        label.Text =
            translations[currentLang][key]
            or key

    end

    refresh()

    return row, refresh

end

--========================================================--
-- MAIN TAB
--========================================================--

local mainTab =
    tabs["Main"]

mainTab.Visible = true

local _, r1 =
    createInputRow(
        mainTab,
        "tpSpd",
        tpSpeed,
        function(value)

            tpSpeed =
                math.max(
                    value,
                    0.05
                )

        end
    )

table.insert(
    refreshFuncs,
    r1
)

local _, r2 =
    createToggleRow(
        mainTab,
        "tpBtn",
        tpEnabled,
        function(state)

            tpEnabled = state

        end
    )

table.insert(
    refreshFuncs,
    r2
)

local _, r3 =
    createInputRow(
        mainTab,
        "walkSpd",
        walkSpeed,
        function(value)

            walkSpeed =
                math.max(
                    value,
                    0
                )

        end
    )

table.insert(
    refreshFuncs,
    r3
)

local _, r4 =
    createToggleRow(
        mainTab,
        "walkBtn",
        walkEnabled,
        function(state)

            walkEnabled = state

            walkConnection =
                disconnectConnection(
                    walkConnection
                )

            if state then

                walkConnection =
                    RunService.RenderStepped:Connect(
                        function()

                            local character =
                                player.Character

                            local humanoid =
                                character
                                and character:FindFirstChildOfClass(
                                    "Humanoid"
                                )

                            if humanoid then
                                humanoid.WalkSpeed =
                                    walkSpeed
                            end

                        end
                    )

            else

                local character =
                    player.Character

                local humanoid =
                    character
                    and character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if humanoid then
                    humanoid.WalkSpeed = 16
                end

            end

        end
    )

table.insert(
    refreshFuncs,
    r4
)

local _, r5 =
    createInputRow(
        mainTab,
        "jumpSpd",
        jumpPower,
        function(value)

            jumpPower =
                math.max(
                    value,
                    0
                )

        end
    )

table.insert(
    refreshFuncs,
    r5
)

local _, r6 =
    createToggleRow(
        mainTab,
        "jumpBtn",
        jumpEnabled,
        function(state)

            jumpEnabled = state

            jumpConnection =
                disconnectConnection(
                    jumpConnection
                )

            if state then

                jumpConnection =
                    RunService.RenderStepped:Connect(
                        function()

                            local character =
                                player.Character

                            local humanoid =
                                character
                                and character:FindFirstChildOfClass(
                                    "Humanoid"
                                )

                            if humanoid then

                                humanoid.UseJumpPower =
                                    true

                                humanoid.JumpPower =
                                    jumpPower

                            end

                        end
                    )

            else

                local character =
                    player.Character

                local humanoid =
                    character
                    and character:FindFirstChildOfClass(
                        "Humanoid"
                    )

                if humanoid then
                    humanoid.JumpPower = 50
                end

            end

        end
    )

table.insert(
    refreshFuncs,
    r6
)

local _, r7 =
    createInputRow(
        mainTab,
        "flySpd",
        flySpeed,
        function(value)

            flySpeed =
                math.max(
                    value,
                    1
                )

        end
    )

table.insert(
    refreshFuncs,
    r7
)

local _, r8 =
    createToggleRow(
        mainTab,
        "flyBtn",
        flyEnabled,
        function(state)

            toggleFly(state)

        end
    )

table.insert(
    refreshFuncs,
    r8
)

local _, r9 =
    createInputRow(
        mainTab,
        "gravSpd",
        customGravity,
        function(value)

            customGravity =
                math.max(
                    value,
                    0
                )

        end
    )

table.insert(
    refreshFuncs,
    r9
)

local _, r10 =
    createToggleRow(
        mainTab,
        "gravBtn",
        gravityEnabled,
        function(state)

            gravityEnabled = state

            gravityConnection =
                disconnectConnection(
                    gravityConnection
                )

            if state then

                gravityConnection =
                    RunService.RenderStepped:Connect(
                        function()

                            Workspace.Gravity =
                                customGravity

                        end
                    )

            else

                Workspace.Gravity =
                    196.2

            end

        end
    )

table.insert(
    refreshFuncs,
    r10
)

local _, r11 =
    createToggleRow(
        mainTab,
        "noclipBtn",
        noclipEnabled,
        function(state)

            toggleNoclip(state)

        end
    )

table.insert(
    refreshFuncs,
    r11
)

local _, r12 =
    createToggleRow(
        mainTab,
        "invisBtn",
        invisibleEnabled,
        function(state)

            toggleInvisibility(state)

        end
    )

table.insert(
    refreshFuncs,
    r12
)

local _, r13 =
    createToggleRow(
        mainTab,
        "infJumpBtn",
        infJumpEnabled,
        function(state)

            toggleInfJump(state)

        end
    )

table.insert(
    refreshFuncs,
    r13
)

local _, r14 =
    createInputRow(
        mainTab,
        "freezeRng",
        freezeRadius,
        function(value)

            freezeRadius =
                math.max(
                    value,
                    1
                )

        end
    )

table.insert(
    refreshFuncs,
    r14
)

local _, r15 =
    createToggleRow(
        mainTab,
        "freezeBtn",
        freezeRayEnabled,
        function(state)

            toggleFreezeRay(state)

        end
    )

table.insert(
    refreshFuncs,
    r15
)

local _, r16 =
    createButtonRow(
        mainTab,
        "autoEquipBtn",
        function()

            equipItemsOnce()

        end
    )

table.insert(
    refreshFuncs,
    r16
)

local _, r17 =
    createInputRow(
        mainTab,
        "autoPressRadiusLabel",
        autoPressRadius,
        function(value)

            autoPressRadius =
                math.max(
                    value,
                    1
                )

        end
    )

table.insert(
    refreshFuncs,
    r17
)

local _, r18 =
    createInputRow(
        mainTab,
        "autoPressDelayLabel",
        autoPressDelay,
        function(value)

            autoPressDelay =
                math.max(
                    value,
                    0.05
                )

        end
    )

table.insert(
    refreshFuncs,
    r18
)

local _, r19 =
    createToggleRow(
        mainTab,
        "autoPressBtn",
        autoPressButtonEnabled,
        function(state)

            toggleAutoPressButton(state)

        end
    )

table.insert(
    refreshFuncs,
    r19
)

--========================================================--
-- GOD BUTTON
--========================================================--

local godRow =
    Instance.new("Frame")

godRow.Size =
    UDim2.new(
        1,
        0,
        0,
        36
    )

godRow.BackgroundTransparency = 1
godRow.Parent = mainTab

local godButton =
    Instance.new("TextButton")

godButton.Size =
    UDim2.fromScale(
        1,
        1
    )

godButton.BackgroundColor3 =
    Color3.fromRGB(
        180,
        40,
        40
    )

godButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

godButton.Font =
    GLOBAL_FONT

godButton.TextSize = 12

godButton.Text =
    "⚡ Bảng God Mode"

godButton.Parent =
    godRow

Instance.new(
    "UICorner",
    godButton
).CornerRadius =
    UDim.new(
        0,
        6
    )

godButton.MouseButton1Click:Connect(
    function()

        safeCall(function()

            loadstring(
                game:HttpGet(
                    "https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/God%20Mode%20Script%20Universal"
                )
            )()

        end)

    end
)

--========================================================--
-- ESP TAB
--========================================================--

local espTab =
    tabs["ESP"]

local _, r20 =
    createToggleRow(
        espTab,
        "espBtn",
        espEnabled,
        function(state)

            espEnabled =
                state

            updateESP()

        end
    )

table.insert(
    refreshFuncs,
    r20
)

local _, r21 =
    createToggleRow(
        espTab,
        "spectateBtn",
        spectating,
        function(state)

            toggleSpectate(state)

        end
    )

updateSpectateToggleBtnText =
    r21

table.insert(
    refreshFuncs,
    r21
)

local _, r22 =
    createButtonRow(
        espTab,
        "tpToSpecBtn",
        function()

            teleportToSpectatedTarget()

        end
    )

table.insert(
    refreshFuncs,
    r22
)

--========================================================--
-- FPS
--========================================================--

local fpsButton =
    Instance.new("TextButton")

fpsButton.Name =
    "FPSDisplayButton"

fpsButton.Size =
    UDim2.new(
        0,
        85,
        0,
        32
    )

fpsButton.Position =
    UDim2.new(
        1,
        -95,
        0.1,
        0
    )

fpsButton.BackgroundColor3 =
    Color3.fromRGB(
        20,
        20,
        20
    )

fpsButton.Text =
    "FPS: --"

fpsButton.TextColor3 =
    Color3.fromRGB(
        50,
        255,
        50
    )

fpsButton.Font =
    GLOBAL_FONT

fpsButton.TextSize = 14

fpsButton.Visible = false
fpsButton.Active = true
fpsButton.Draggable = true
fpsButton.Parent =
    screenGui

Instance.new(
    "UICorner",
    fpsButton
).CornerRadius =
    UDim.new(
        0,
        6
    )

local frameCount = 0
local lastUpdate = tick()

local function toggleFPSDisplay(state)

    fpsEnabled =
        state

    fpsButton.Visible =
        state

    fpsConnection =
        disconnectConnection(
            fpsConnection
        )

    if not state then
        return
    end

    frameCount = 0
    lastUpdate = tick()

    fpsConnection =
        RunService.RenderStepped:Connect(
            function()

                frameCount += 1

                local now =
                    tick()

                local elapsed =
                    now - lastUpdate

                if elapsed >= 1 then

                    local fps =
                        math.floor(
                            frameCount /
                            elapsed
                        )

                    fpsButton.Text =
                        "FPS: "
                        ..
                        tostring(fps)

                    if fps <= 15 then

                        fpsButton.TextColor3 =
                            Color3.fromRGB(
                                255,
                                50,
                                50
                            )

                    elseif fps <= 30 then

                        fpsButton.TextColor3 =
                            Color3.fromRGB(
                                255,
                                200,
                                0
                            )

                    else

                        fpsButton.TextColor3 =
                            Color3.fromRGB(
                                50,
                                255,
                                50
                            )

                    end

                    frameCount = 0
                    lastUpdate = now

                end

            end
        )

end

local _, r23 =
    createToggleRow(
        espTab,
        "fpsBtn",
        fpsEnabled,
        function(state)

            toggleFPSDisplay(state)

        end
    )

table.insert(
    refreshFuncs,
    r23
)

--========================================================--
-- ESP COLOR
--========================================================--

local espColorLabel =
    Instance.new("TextLabel")

espColorLabel.Size =
    UDim2.new(
        1,
        0,
        0,
        20
    )

espColorLabel.BackgroundTransparency = 1
espColorLabel.TextColor3 =
    currentTextColor

espColorLabel.Font =
    GLOBAL_FONT

espColorLabel.TextSize = 11

espColorLabel.TextXAlignment =
    Enum.TextXAlignment.Left

espColorLabel.Text =
    translations.VI.espColorLabel

espColorLabel.Parent =
    espTab

table.insert(
    textElements,
    espColorLabel
)

local espPalette =
    Instance.new("Frame")

espPalette.Size =
    UDim2.new(
        1,
        0,
        0,
        28
    )

espPalette.BackgroundTransparency = 1
espPalette.Parent =
    espTab

local espColors = {

    Color3.fromRGB(
        255,
        50,
        50
    ),

    Color3.fromRGB(
        50,
        255,
        50
    ),

    Color3.fromRGB(
        50,
        150,
        255
    ),

    Color3.fromRGB(
        255,
        255,
        50
    ),

    Color3.fromRGB(
        255,
        50,
        255
    ),

    Color3.fromRGB(
        255,
        255,
        255
    )

}

for i, color in ipairs(
    espColors
) do

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.new(
            0,
            28,
            0,
            28
        )

    button.Position =
        UDim2.new(
            0,
            (i - 1) * 34,
            0,
            0
        )

    button.BackgroundColor3 =
        color

    button.Text = ""

    button.Parent =
        espPalette

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    button.MouseButton1Click:Connect(
        function()

            espColor =
                color

            updateESP()

        end
    )

end

--========================================================--
-- SPECTATE HUD
--========================================================--

spectateFrame =
    Instance.new("Frame")

spectateFrame.Name =
    "SpectateFrame"

spectateFrame.Size =
    UDim2.new(
        0,
        320,
        0,
        115
    )

spectateFrame.Position =
    UDim2.new(
        0.5,
        -160,
        0.85,
        -55
    )

spectateFrame.BackgroundColor3 =
    Color3.fromRGB(
        15,
        15,
        20
    )

spectateFrame.BackgroundTransparency =
    0.2

spectateFrame.BorderSizePixel = 0
spectateFrame.Visible = false

spectateFrame.Parent =
    screenGui

Instance.new(
    "UICorner",
    spectateFrame
).CornerRadius =
    UDim.new(
        0,
        8
    )

local spectateStroke =
    Instance.new("UIStroke")

spectateStroke.Color =
    Color3.fromRGB(
        80,
        80,
        255
    )

spectateStroke.Thickness = 2
spectateStroke.Parent =
    spectateFrame

specNameLabel =
    Instance.new("TextLabel")

specNameLabel.Size =
    UDim2.new(
        1,
        -90,
        0,
        34
    )

specNameLabel.Position =
    UDim2.new(
        0,
        45,
        0,
        6
    )

specNameLabel.BackgroundTransparency = 1
specNameLabel.Text =
    "Player Name"

specNameLabel.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

specNameLabel.Font =
    GLOBAL_FONT

specNameLabel.TextSize = 13

specNameLabel.Parent =
    spectateFrame

local prevButton =
    Instance.new("TextButton")

prevButton.Size =
    UDim2.new(
        0,
        35,
        0,
        34
    )

prevButton.Position =
    UDim2.new(
        0,
        8,
        0,
        6
    )

prevButton.BackgroundColor3 =
    Color3.fromRGB(
        40,
        40,
        50
    )

prevButton.Text = "<"

prevButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

prevButton.Font =
    GLOBAL_FONT

prevButton.TextSize = 16

prevButton.Parent =
    spectateFrame

Instance.new(
    "UICorner",
    prevButton
).CornerRadius =
    UDim.new(
        0,
        6
    )

local nextButton =
    Instance.new("TextButton")

nextButton.Size =
    UDim2.new(
        0,
        35,
        0,
        34
    )

nextButton.Position =
    UDim2.new(
        1,
        -43,
        0,
        6
    )

nextButton.BackgroundColor3 =
    Color3.fromRGB(
        40,
        40,
        50
    )

nextButton.Text = ">"

nextButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

nextButton.Font =
    GLOBAL_FONT

nextButton.TextSize = 16

nextButton.Parent =
    spectateFrame

Instance.new(
    "UICorner",
    nextButton
).CornerRadius =
    UDim.new(
        0,
        6
    )

local tpSpecButton =
    Instance.new("TextButton")

tpSpecButton.Size =
    UDim2.new(
        0,
        160,
        0,
        28
    )

tpSpecButton.Position =
    UDim2.new(
        0.5,
        -80,
        0,
        44
    )

tpSpecButton.BackgroundColor3 =
    Color3.fromRGB(
        45,
        120,
        210
    )

tpSpecButton.Text =
    "🚀 Dịch Chuyển Tới"

tpSpecButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

tpSpecButton.Font =
    GLOBAL_FONT

tpSpecButton.TextSize = 11

tpSpecButton.Parent =
    spectateFrame

Instance.new(
    "UICorner",
    tpSpecButton
).CornerRadius =
    UDim.new(
        0,
        5
    )

local closeSpecButton =
    Instance.new("TextButton")

closeSpecButton.Size =
    UDim2.new(
        0,
        120,
        0,
        24
    )

closeSpecButton.Position =
    UDim2.new(
        0.5,
        -60,
        0,
        78
    )

closeSpecButton.BackgroundColor3 =
    Color3.fromRGB(
        200,
        50,
        50
    )

closeSpecButton.Text =
    "Đóng Spectate"

closeSpecButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

closeSpecButton.Font =
    GLOBAL_FONT

closeSpecButton.TextSize = 11

closeSpecButton.Parent =
    spectateFrame

Instance.new(
    "UICorner",
    closeSpecButton
).CornerRadius =
    UDim.new(
        0,
        5
    )

prevButton.MouseButton1Click:Connect(
    function()

        spectateIndex -= 1
        updateSpectateCamera()

    end
)

nextButton.MouseButton1Click:Connect(
    function()

        spectateIndex += 1
        updateSpectateCamera()

    end
)

tpSpecButton.MouseButton1Click:Connect(
    function()

        teleportToSpectatedTarget()

    end
)

closeSpecButton.MouseButton1Click:Connect(
    function()

        toggleSpectate(false)

    end
)

--========================================================--
-- FIX LAG TAB
--========================================================--

local fixLagTab =
    tabs["FixLag"]

local _, r24 =
    createToggleRow(
        fixLagTab,
        "fixLagBtn",
        fixLagEnabled,
        function(state)

            toggleFixLag(state)

        end
    )

table.insert(
    refreshFuncs,
    r24
)

local _, r25 =
    createToggleRow(
        fixLagTab,
        "hideMapBtn",
        hideMapOthersEnabled,
        function(state)

            toggleHideMapAndOthers(
                state
            )

        end
    )

table.insert(
    refreshFuncs,
    r25
)

local _, r26 =
    createToggleRow(
        fixLagTab,
        "muteSoundsBtn",
        muteAllSoundsEnabled,
        function(state)

            toggleMuteAllSounds(
                state
            )

        end
    )

table.insert(
    refreshFuncs,
    r26
)

--========================================================--
-- MISC TAB
--========================================================--

local miscTab =
    tabs["Misc"]

local function createLabel(
    parent,
    text
)

    local label =
        Instance.new("TextLabel")

    label.Size =
        UDim2.new(
            1,
            0,
            0,
            18
        )

    label.BackgroundTransparency = 1
    label.TextColor3 =
        currentTextColor

    label.Font =
        GLOBAL_FONT

    label.TextSize = 11

    label.TextXAlignment =
        Enum.TextXAlignment.Left

    label.Text =
        text

    label.Parent =
        parent

    table.insert(
        textElements,
        label
    )

    return label

end

local boardColorLabel =
    createLabel(
        miscTab,
        translations.VI.boardColorLabel
    )

local boardPalette =
    Instance.new("Frame")

boardPalette.Size =
    UDim2.new(
        1,
        0,
        0,
        28
    )

boardPalette.BackgroundTransparency = 1
boardPalette.Parent =
    miscTab

local boardColors = {

    Color3.fromRGB(
        20,
        20,
        25
    ),

    Color3.fromRGB(
        40,
        20,
        20
    ),

    Color3.fromRGB(
        20,
        40,
        20
    ),

    Color3.fromRGB(
        20,
        25,
        40
    ),

    Color3.fromRGB(
        40,
        30,
        20
    )

}

local function applyBoardColor(
    color
)

    local r =
        math.floor(
            color.R * 255
        )

    local g =
        math.floor(
            color.G * 255
        )

    local b =
        math.floor(
            color.B * 255
        )

    local dark =
        Color3.fromRGB(
            math.clamp(
                r - 15,
                0,
                255
            ),
            math.clamp(
                g - 15,
                0,
                255
            ),
            math.clamp(
                b - 15,
                0,
                255
            )
        )

    local light =
        Color3.fromRGB(
            math.clamp(
                r + 10,
                0,
                255
            ),
            math.clamp(
                g + 10,
                0,
                255
            ),
            math.clamp(
                b + 10,
                0,
                255
            )
        )

    gradientFrame.Color =
        ColorSequence.new({

            ColorSequenceKeypoint.new(
                0,
                dark
            ),

            ColorSequenceKeypoint.new(
                0.5,
                light
            ),

            ColorSequenceKeypoint.new(
                1,
                dark
            )

        })

    sidebar.BackgroundColor3 =
        dark

    titleBar.BackgroundColor3 =
        dark

end

for i, color in ipairs(
    boardColors
) do

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.new(
            0,
            28,
            0,
            28
        )

    button.Position =
        UDim2.new(
            0,
            (i - 1) * 34,
            0,
            0
        )

    button.BackgroundColor3 =
        color

    button.Text = ""

    button.Parent =
        boardPalette

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    button.MouseButton1Click:Connect(
        function()

            applyBoardColor(
                color
            )

        end
    )

end

local themeLabel =
    createLabel(
        miscTab,
        translations.VI.themeLabel
    )

local themePalette =
    Instance.new("Frame")

themePalette.Size =
    UDim2.new(
        1,
        0,
        0,
        28
    )

themePalette.BackgroundTransparency = 1
themePalette.Parent =
    miscTab

local themeColors = {

    Color3.fromRGB(
        35,
        35,
        45
    ),

    Color3.fromRGB(
        50,
        40,
        80
    ),

    Color3.fromRGB(
        30,
        60,
        90
    ),

    Color3.fromRGB(
        70,
        30,
        40
    ),

    Color3.fromRGB(
        30,
        70,
        50
    )

}

for i, color in ipairs(
    themeColors
) do

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.new(
            0,
            28,
            0,
            28
        )

    button.Position =
        UDim2.new(
            0,
            (i - 1) * 34,
            0,
            0
        )

    button.BackgroundColor3 =
        color

    button.Text = ""

    button.Parent =
        themePalette

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    button.MouseButton1Click:Connect(
        function()

            applyThemeColor(
                color
            )

        end
    )

end

local textLabel =
    createLabel(
        miscTab,
        translations.VI.textLabel
    )

local textPalette =
    Instance.new("Frame")

textPalette.Size =
    UDim2.new(
        1,
        0,
        0,
        28
    )

textPalette.BackgroundTransparency = 1
textPalette.Parent =
    miscTab

local textColors = {

    Color3.fromRGB(
        255,
        255,
        255
    ),

    Color3.fromRGB(
        255,
        220,
        100
    ),

    Color3.fromRGB(
        100,
        255,
        200
    ),

    Color3.fromRGB(
        255,
        150,
        200
    )

}

for i, color in ipairs(
    textColors
) do

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.new(
            0,
            28,
            0,
            28
        )

    button.Position =
        UDim2.new(
            0,
            (i - 1) * 34,
            0,
            0
        )

    button.BackgroundColor3 =
        color

    button.Text = ""

    button.Parent =
        textPalette

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    button.MouseButton1Click:Connect(
        function()

            applyTextColor(
                color
            )

        end
    )

end

--========================================================--
-- LANGUAGE
--========================================================--

local langLabel =
    createLabel(
        miscTab,
        translations.VI.langLabel
    )

local langFrame =
    Instance.new("Frame")

langFrame.Size =
    UDim2.new(
        1,
        0,
        0,
        30
    )

langFrame.BackgroundTransparency = 1
langFrame.Parent =
    miscTab

local englishButton =
    Instance.new("TextButton")

englishButton.Size =
    UDim2.new(
        0.48,
        0,
        1,
        0
    )

englishButton.BackgroundColor3 =
    currentThemeColor

englishButton.Text =
    "English"

englishButton.TextColor3 =
    currentTextColor

englishButton.Font =
    GLOBAL_FONT

englishButton.TextSize = 11
englishButton.Parent =
    langFrame

Instance.new(
    "UICorner",
    englishButton
).CornerRadius =
    UDim.new(
        0,
        6
    )

table.insert(
    themeButtons,
    englishButton
)

table.insert(
    textElements,
    englishButton
)

local vietnameseButton =
    englishButton:Clone()

vietnameseButton.Position =
    UDim2.new(
        0.52,
        0,
        0,
        0
    )

vietnameseButton.Text =
    "Tiếng Việt"

vietnameseButton.Parent =
    langFrame

table.insert(
    themeButtons,
    vietnameseButton
)

table.insert(
    textElements,
    vietnameseButton
)

--========================================================--
-- SERVER BUTTONS
--========================================================--

local serverFrame =
    Instance.new("Frame")

serverFrame.Size =
    UDim2.new(
        1,
        0,
        0,
        32
    )

serverFrame.BackgroundTransparency = 1
serverFrame.Parent =
    miscTab

local rejoinButton =
    englishButton:Clone()

rejoinButton.Size =
    UDim2.new(
        0.48,
        0,
        1,
        0
    )

rejoinButton.Position =
    UDim2.new(
        0,
        0,
        0,
        0
    )

rejoinButton.Text =
    translations.VI.rejoinBtn

rejoinButton.Parent =
    serverFrame

table.insert(
    themeButtons,
    rejoinButton
)

table.insert(
    textElements,
    rejoinButton
)

local serverHopButton =
    englishButton:Clone()

serverHopButton.Size =
    UDim2.new(
        0.48,
        0,
        1,
        0
    )

serverHopButton.Position =
    UDim2.new(
        0.52,
        0,
        0,
        0
    )

serverHopButton.Text =
    translations.VI.serverHopBtn

serverHopButton.Parent =
    serverFrame

table.insert(
    themeButtons,
    serverHopButton
)

table.insert(
    textElements,
    serverHopButton
)

rejoinButton.MouseButton1Click:Connect(
    rejoinServer
)

serverHopButton.MouseButton1Click:Connect(
    serverHop
)

--========================================================--
-- LANGUAGE UPDATE
--========================================================--

local tabButtons = {}

local function updateLanguage()

    local t =
        translations[currentLang]

    titleText.Text =
        t.title

    godButton.Text =
        t.godBtn

    espColorLabel.Text =
        t.espColorLabel

    boardColorLabel.Text =
        t.boardColorLabel

    themeLabel.Text =
        t.themeLabel

    textLabel.Text =
        t.textLabel

    langLabel.Text =
        t.langLabel

    rejoinButton.Text =
        t.rejoinBtn

    serverHopButton.Text =
        t.serverHopBtn

    for _, refresh in ipairs(
        refreshFuncs
    ) do

        pcall(refresh)

    end

    if tabButtons.Main then
        tabButtons.Main.Text =
            t.tabMain
    end

    if tabButtons.ESP then
        tabButtons.ESP.Text =
            t.tabEsp
    end

    if tabButtons.FixLag then
        tabButtons.FixLag.Text =
            t.tabFixLag
    end

    if tabButtons.Misc then
        tabButtons.Misc.Text =
            t.tabMisc
    end

end

englishButton.MouseButton1Click:Connect(
    function()

        currentLang = "EN"

        updateLanguage()

    end
)

vietnameseButton.MouseButton1Click:Connect(
    function()

        currentLang = "VI"

        updateLanguage()

    end
)

--========================================================--
-- SIDEBAR BUTTONS
--========================================================--

local yOffset = 10

for i, name in ipairs(
    tabNames
) do

    local button =
        Instance.new("TextButton")

    button.Size =
        UDim2.new(
            1,
            -16,
            0,
            32
        )

    button.Position =
        UDim2.new(
            0,
            8,
            0,
            yOffset
        )

    button.BackgroundColor3 =
        i == 1
        and Color3.fromRGB(
            70,
            70,
            90
        )
        or Color3.fromRGB(
            30,
            30,
            40
        )

    button.TextColor3 =
        currentTextColor

    button.Font =
        GLOBAL_FONT

    button.TextSize = 11
    button.Parent =
        sidebar

    table.insert(
        textElements,
        button
    )

    Instance.new(
        "UICorner",
        button
    ).CornerRadius =
        UDim.new(
            0,
            6
        )

    button.MouseButton1Click:Connect(
        function()

            for _, tab in pairs(
                tabs
            ) do

                tab.Visible = false

            end

            for _, otherButton in pairs(
                tabButtons
            ) do

                otherButton.BackgroundColor3 =
                    Color3.fromRGB(
                        30,
                        30,
                        40
                    )

            end

            tabs[name].Visible =
                true

            button.BackgroundColor3 =
                Color3.fromRGB(
                    70,
                    70,
                    90
                )

        end
    )

    tabButtons[name] =
        button

    yOffset += 40

end

--========================================================--
-- OPEN BUTTON
--========================================================--

local openUIButton =
    Instance.new("TextButton")

openUIButton.Name =
    "OpenHHubButton"

openUIButton.Size =
    UDim2.new(
        0,
        50,
        0,
        50
    )

openUIButton.Position =
    UDim2.new(
        0.05,
        0,
        0.4,
        0
    )

openUIButton.BackgroundColor3 =
    Color3.fromRGB(
        25,
        25,
        30
    )

openUIButton.Text =
    "HUB"

openUIButton.TextColor3 =
    Color3.new(
        1,
        1,
        1
    )

openUIButton.Font =
    GLOBAL_FONT

openUIButton.TextSize = 16

openUIButton.Visible = false
openUIButton.Active = true
openUIButton.Draggable = true

openUIButton.Parent =
    screenGui

Instance.new(
    "UICorner",
    openUIButton
).CornerRadius =
    UDim.new(
        1,
        0
    )

local openStroke =
    Instance.new("UIStroke")

openStroke.Thickness = 2

openStroke.Color =
    Color3.fromRGB(
        80,
        80,
        255
    )

openStroke.Parent =
    openUIButton

--========================================================--
-- MINIMIZE
--========================================================--

minimizeButton.MouseButton1Click:Connect(
    function()

        local tween =
            TweenService:Create(
                frame,
                TweenInfo.new(
                    0.3,
                    Enum.EasingStyle.Back,
                    Enum.EasingDirection.In
                ),
                {
                    Size =
                        UDim2.new(
                            0,
                            0,
                            0,
                            0
                        )
                }
            )

        tween:Play()

        tween.Completed:Wait()

        frame.Visible = false

        openUIButton.Visible = true

        openUIButton.Size =
            UDim2.new(
                0,
                50,
                0,
                50
            )

    end
)

--========================================================--
-- OPEN
--========================================================--

openUIButton.MouseButton1Click:Connect(
    function()

        openUIButton.Visible = false

        frame.Visible = true

        frame.Size =
            UDim2.new(
                0,
                0,
                0,
                0
            )

        TweenService:Create(
            frame,
            TweenInfo.new(
                0.4,
                Enum.EasingStyle.Back,
                Enum.EasingDirection.Out
            ),
            {
                Size =
                    UDim2.new(
                        0,
                        390,
                        0,
                        320
                    )
            }
        ):Play()

    end
)

--========================================================--
-- CLOSE / CLEANUP
--========================================================--

local function cleanupHHub()

    gradientRunning = false

    tpEnabled = false

    toggleNoclip(false)
    toggleInvisibility(false)
    toggleFly(false)
    toggleInfJump(false)
    toggleFreezeRay(false)
    toggleFPSDisplay(false)
    toggleAutoPressButton(false)
    toggleFixLag(false)
    toggleHideMapAndOthers(false)
    toggleMuteAllSounds(false)
    toggleSpectate(false)

    walkConnection =
        disconnectConnection(
            walkConnection
        )

    jumpConnection =
        disconnectConnection(
            jumpConnection
        )

    gravityConnection =
        disconnectConnection(
            gravityConnection
        )

    if player.Character then

        local humanoid =
            player.Character:FindFirstChildOfClass(
                "Humanoid"
            )

        if humanoid then

            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50

        end

    end

    Workspace.Gravity = 196.2

    espEnabled = false

    updateESP()

    if screenGui then
        screenGui:Destroy()
    end

end

closeButton.MouseButton1Click:Connect(
    cleanupHHub
)

--========================================================--
-- BUTTON SCALE EFFECT
--========================================================--

for _, obj in ipairs(
    screenGui:GetDescendants()
) do

    if obj:IsA("TextButton") then

        local scale =
            Instance.new("UIScale")

        scale.Scale = 1
        scale.Parent = obj

        obj.MouseEnter:Connect(
            function()

                TweenService:Create(
                    scale,
                    TweenInfo.new(
                        0.12
                    ),
                    {
                        Scale = 1.03
                    }
                ):Play()

            end
        )

        obj.MouseLeave:Connect(
            function()

                TweenService:Create(
                    scale,
                    TweenInfo.new(
                        0.12
                    ),
                    {
                        Scale = 1
                    }
                ):Play()

            end
        )

        obj.MouseButton1Down:Connect(
            function()

                TweenService:Create(
                    scale,
                    TweenInfo.new(
                        0.08
                    ),
                    {
                        Scale = 0.95
                    }
                ):Play()

            end
        )

        obj.MouseButton1Up:Connect(
            function()

                TweenService:Create(
                    scale,
                    TweenInfo.new(
                        0.08
                    ),
                    {
                        Scale = 1.03
                    }
                ):Play()

            end
        )

    end

end

--========================================================--
-- CHARACTER RESPAWN HANDLER
--========================================================--

player.CharacterAdded:Connect(
    function()

        task.wait(1)

        if walkEnabled then

            local character =
                player.Character

            local humanoid =
                character
                and character:FindFirstChildOfClass(
                    "Humanoid"
                )

            if humanoid then
                humanoid.WalkSpeed =
                    walkSpeed
            end

        end

        if jumpEnabled then

            local character =
                player.Character

            local humanoid =
                character
                and character:FindFirstChildOfClass(
                    "Humanoid"
                )

            if humanoid then

                humanoid.UseJumpPower =
                    true

                humanoid.JumpPower =
                    jumpPower

            end

        end

        if espEnabled then
            updateESP()
        end

    end
)

--========================================================--
-- START
--========================================================--

updateLanguage()

-- Đảm bảo tab đầu tiên hiện
for name, tab in pairs(tabs) do

    tab.Visible =
        name == "Main"

end

-- Đảm bảo frame có kích thước thật
frame.Visible = true

frame.Size =
    UDim2.new(
        0,
        0,
        0,
        0
    )

local showTween =
    TweenService:Create(
        frame,
        TweenInfo.new(
            0.5,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size =
                UDim2.new(
                    0,
                    390,
                    0,
                    320
                )
        }
    )

showTween:Play()

-- Auto TP loop
startTeleportLoop()

print("==========================================")
print("[H HUB] GUI HOÀN TẤT")
print("[H HUB] ScreenGui:", screenGui:GetFullName())
print("[H HUB] MainFrame:", frame:GetFullName())
print("[H HUB] H HUB đã khởi động thành công!")
print("==========================================")