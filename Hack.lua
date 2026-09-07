-- ==========================================
-- BỔ SUNG: BẬT HOTBAR 10 SLOT (PC GUI FOR MOBILE)
-- ==========================================

local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

local function enablePCHotbar()
    pcall(function()
        -- Ép bật thanh Backpack chuẩn của Roblox PC
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
    end)
end

-- Tạo giao diện nút bấm chọn nhanh 10 slot cho điện thoại
local function createMobileHotbarUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CustomMobileHotbar"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.9, 0, 0, 40)
    frame.Position = UDim2.new(0.05, 0, 0.88, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = screenGui

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 4)
    layout.Parent = frame

    -- Tạo 10 slot bấm nhanh tương ứng từ phím 1 đến 0
    for i = 1, 10 do
        local slotBtn = Instance.new("TextButton")
        slotBtn.Size = UDim2.new(0.09, 0, 1, 0)
        slotBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        slotBtn.BackgroundTransparency = 0.3
        slotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        slotBtn.Font = Enum.Font.SourceSansBold
        slotBtn.TextSize = 14
        slotBtn.Text = tostring(i % 10)
        slotBtn.Parent = frame

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = slotBtn

        -- Logic trang bị item ở vị trí slot tương ứng
        slotBtn.MouseButton1Click:Connect(function()
            local backpack = player:FindFirstChild("Backpack")
            local char = player.Character
            if backpack and char then
                local items = backpack:GetChildren()
                if items[i] and items[i]:IsA("Tool") then
                    char:FindFirstChildOfClass("Humanoid"):EquipTool(items[i])
                end
            end
        end)
    end
end

enablePCHotbar()
createMobileHotbarUI()
