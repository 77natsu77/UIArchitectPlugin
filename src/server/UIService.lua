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

function UIService.applyAspectRatio(guiObject: GuiObject)
    local absSize = guiObject.AbsoluteSize
    local ratio = absSize.X / absSize.Y
    
    local existing = guiObject:FindFirstChildOfClass("UIAspectRatioConstraint")
    local constraint = existing or Instance.new("UIAspectRatioConstraint")
    
    constraint.AspectRatio = ratio
    constraint.AspectType = Enum.AspectType.FitWithinMaxSize
    
    -- THE MATH FIX: Compare Width (X) and Height (Y)
    if absSize.Y > absSize.X then
        constraint.DominantAxis = Enum.DominantAxis.Height
    else
        constraint.DominantAxis = Enum.DominantAxis.Width
    end
    
    constraint.Parent = guiObject
    return constraint
end

function UIService.playSuccessEffect(guiObject: GuiObject)
    -- Create a temporary outline to show the fix was applied
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(0, 255, 127) -- Spring Green
    outline.Thickness = 3
    outline.Transparency = 0
    outline.Parent = guiObject
    
    -- Animate it fading out (A-Level Physics/Maths: Linear Interpolation)
    local TweenService = game:GetService("TweenService")
    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(outline, info, {Transparency = 1, Thickness = 8})
    
    tween:Play()
    tween.Completed:Connect(function()
        outline:Destroy()
    end)
end

return UIService

