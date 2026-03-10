--!strict
local Selection = game:GetService("Selection")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local UIService = require(script.Modules.UIService)

-- 1. Plugin Toolbar Setup
local toolbar = plugin:CreateToolbar("UI Architect")
local FixButton = toolbar:CreateButton("Fix Selection", "Convert to Scale & Lock Ratio", "rbxassetid://4458901833")

-- 2. Selection Handling
local function updateButtonState()
    local currentSelection = Selection:Get()
    local isUISelected = false
    
    for _, obj in currentSelection do
        if obj:IsA("GuiObject") then
            isUISelected = true
            break
        end
    end
    
    -- This makes the button "Grey out" if no UI is selected
    FixButton.Enabled = isUISelected
end

Selection.SelectionChanged:Connect(updateButtonState)

-- 3. The Main Action
FixButton.Click:Connect(function()
    local selected = Selection:Get()
    
    -- Check if we actually have something to do
    if #selected == 0 then return end
    
    ChangeHistoryService:SetWaypoint("UIFixStart")
    
    for _, obj in selected do
        if obj:IsA("GuiObject") then
            -- We run our 3-step professional polish
            UIService.pixelToScale(obj)
            UIService.applyAspectRatio(obj)
            UIService.playSuccessEffect(obj)
        end
    end
    
    ChangeHistoryService:SetWaypoint("UIFixEnd")
    print("UI Architect: Selection Processed Successfully.")
end)

-- Initialize the button state on startup
updateButtonState()