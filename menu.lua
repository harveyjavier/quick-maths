local scene = composer.newScene()

--------------------------------------------

-- forward declarations and other locals
local playBtn, optionsBtn

local function onPlayBtnRelease()
	composer.removeScene( "game" )
	composer.gotoScene( "game", "fade", 500 )
	return true
end

local function onOptionsBtnRelease()
	return true
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create/position logo/title image on upper-half of the screen
	local quickTxt = display.newText("QUICK", display.contentCenterX, display.contentCenterY - 90, "assets/fonts/GothamRnd-Bold.otf", 70)
	quickTxt:setTextColor(color.hex("de5347"))
	local mathTxt = display.newText("MATHS", display.contentCenterX, quickTxt.y + 60, "assets/fonts/GothamRnd-Bold.otf", 70)
	mathTxt:setTextColor(color.hex("16a05d"))

	playBtn = widget.newButton{
		label="PLAY NOW",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		font="assets/fonts/GothamRnd-Medium.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=159, height=45,
		onRelease = onPlayBtnRelease
	}
	playBtn.x = mathTxt.x
	playBtn.y = mathTxt.y + 80

	optionsBtn = widget.newButton{
		label="OPTIONS",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		font="assets/fonts/GothamRnd-Medium.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=159, height=45,
		onRelease = onOptionsBtnRelease
	}
	optionsBtn.x = playBtn.x
	optionsBtn.y = playBtn.y + 55
	
	-- all display objects must be inserted into group
	sceneGroup:insert( quickTxt )
	sceneGroup:insert( mathTxt )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( optionsBtn )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()
		playBtn = nil
	end

	if optionsBtn then
		optionsBtn:removeSelf()
		optionsBtn = nil
	end 
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene