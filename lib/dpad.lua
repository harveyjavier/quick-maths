local M = {}

local padSize
local padImage
local padGroup
local padGraphic

local padButtonUp
local padButtonDown
local padButtonLeft
local padButtonRight

local padButtonUpLeft
local padButtonUpRight
local padButtonDownLeft
local padButtonDownRight

local centerX = display.contentCenterX
local centerY = display.contentCenterY
local originX = display.screenOriginX
local originY = display.screenOriginY
local width = display.actualContentWidth
local height = display.actualContentHeight

-- Set movement magnitudes
local movementX = 0
local movementY = 0

-- Movement property variables
M.isMoving = false
M.isMovingUp = false
M.isMovingDown = false
M.isMovingLeft = false
M.isMovingRight = false

------------------------------------------------------------------------
--
------------------------------------------------------------------------
local function setMovement( x, y )

	local updatedMovement = false

	-- Horizontal movement checks
	if movementX ~= x and x ~= nil then
		movementX = x
		updatedMovement = true
	end

	-- Vertical movement checks
	if movementY ~= y and y ~= nil then
		movementY = y
		updatedMovement = true
	end

	-- Since key events can fire multiple times with the same values,
	-- just return if nothing is actually changing.
	if not updatedMovement then
		return
	end

	-- If the player is moving along X - determine direction.
	if movementX ~= 0 then

		if movementX > 0 then
			M.isMovingRight = true
		else
			M.isMovingLeft = true
		end
	end

	-- If the player is moving along Y - determine direction.
	if movementY ~= 0 then

		if movementY > 0 then
			M.isMovingDown = true
		else
			M.isMovingUp = true
		end

	end

	-- Is the player moving or not?
	if movementX == 0 and movementY == 0 then
		M.isMoving = false
	else
		M.isMoving = true
	end

	-- If the player is not moving along X - reset left and right.
	if movementX == 0 then
		M.isMovingLeft = false
		M.isMovingRight = false
	end

	-- If the player is not moving along Y - reset up and down.
	if movementY == 0 then
		M.isMovingUp = false
		M.isMovingDown = false
	end

end

------------------------------------------------------------------------
--
------------------------------------------------------------------------
local function onTouchPad( event )

	local phase = event.phase
	local targetID = event.target.id

	if "began" == phase or "moved" == phase then

		if "up" == targetID then
			setMovement( 0, -1 )
		elseif "down" == targetID then
			setMovement( 0, 1 )
		elseif "left" == targetID then
			setMovement( -1, 0 )
		elseif "right" == targetID then
			setMovement( 1, 0 )
		elseif "up_left" == targetID then
			setMovement( -1, -1 )
		elseif "up_right" == targetID then
			setMovement( 1, -1 )
		elseif "down_left" == targetID then
			setMovement( -1, 1 )
		elseif "down_right" == targetID then
			setMovement( 1, 1 )
		elseif "padGraphic" == targetID then
			setMovement( 0, 0 )
		end

	elseif "ended" == phase or "cancelled"  == phase then

		if "up" == targetID or "down" == targetID then
			setMovement( nil, 0 )
		elseif "left" == targetID or "right" == targetID then
			setMovement( 0, nil )
		else
			setMovement( 0, 0 )
		end

	end

	return true

end

------------------------------------------------------------------------
-- Creates one of the invisible virtual D-pad buttons that lays on top 
-- the pad graphic.
------------------------------------------------------------------------
local function createPadButton( buttonID, offsetX, offsetY )

	local btn = display.newRect( padGroup,
		                         padGraphic.x + offsetX,
		                         padGraphic.y + offsetY,
		                         padSize/8,
		                         padSize/8 )

	btn:addEventListener( "touch", onTouchPad )
	btn.id = buttonID
	btn.isVisible = false
	btn.isHitTestable = true

	return btn

end

------------------------------------------------------------------------
-- Create a new D-pad or directional control pad.
------------------------------------------------------------------------
M.newDPad = function( size, image, alpha, enableDiagonalButtons )

	padSize = size
	padImage = image

	if alpha == nil then
		alpha = 1.0
	end

	if enableDiagonalButtons == nil then
		enableDiagonalButtons = true
	end

	padGroup = display.newGroup()

	-- Create the visuals for the on-screen D-pad.
	padGraphic = display.newImageRect( padGroup, padImage, padSize, padSize )
	padGraphic.x = originX + padSize/2 - 60
	padGraphic.y = height + originY - padSize/2 + 60
	padGraphic.alpha = alpha
	padGraphic.id = "padGraphic"
	padGraphic:addEventListener( "touch", onTouchPad )

	-- Create buttons for handling the D-pad input
	padButtonUp = createPadButton( "up", 0, padSize/-6 )
	padButtonDown = createPadButton( "down", 0, padSize/6 )
	padButtonLeft = createPadButton( "left", padSize/-6, 0 )
	padButtonRight = createPadButton( "right", padSize/6, 0 )

	if enableDiagonalButtons then

		padButtonUpLeft = createPadButton( "up_left", padSize/-6, padSize/-6 )
		padButtonUpRight = createPadButton( "up_right", padSize/6, padSize/-6 )
		padButtonDownLeft = createPadButton( "down_left", padSize/-6, padSize/6 )
		padButtonDownRight = createPadButton( "down_right", padSize/6, padSize/6 )

	end

	return M

end

function M.hidePad()
	padGraphic.isVisible = false
end

return M