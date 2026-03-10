--!strict
local UIService = {}

function UIService.convertToScale(guiObject: GuiObject)
    local parent = guiObject.Parent
    if not parent or not parent:IsA("GuiBase2d") then 
        warn("Object must be inside a GUI container to convert to scale.")
        return 
    end

    local parentSize = parent.AbsoluteSize
    local currentSize = guiObject.AbsoluteSize
    local currentPos = guiObject.AbsolutePosition - parent.AbsolutePosition

    -- The Math: New Scale = Pixels / ParentPixels
    guiObject.Size = UDim2.new(currentSize.X / parentSize.X, 0, currentSize.Y / parentSize.Y, 0)
    guiObject.Position = UDim2.new(currentPos.X / parentSize.X, 0, currentPos.Y / parentSize.Y, 0)
end

return UIService

