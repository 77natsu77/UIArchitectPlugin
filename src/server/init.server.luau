local Selection = game:GetService("Selection")

Selection.SelectionChanged:Connect(function()
    local currentSelection = Selection:Get()
    local isUISelected = false
    
    for _, obj in currentSelection do
        if obj:IsA("GuiObject") then
            isUISelected = true
            break
        end
    end
    
    -- Next Step: Update your Button's "Enabled" or "Clickable" state here
    if isUISelected then
        print("Ready to architect some UI!")
    end
end)