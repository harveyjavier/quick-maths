local scene = composer.newScene()

--------------------------------------------

-- forward declarations and other locals
local gamestatus, score, time, t = "began", 0, 5, {}
local scoreTxt, timerTxt, problemTxt, gameoverTxt, endGameTxt1, endGameTxt2, scoreTxt1
local problems = {
	{level=1, problem = "1 - 0", answer=1},
	{level=1, problem = "1 + 1", answer=2},
	{level=1, problem = "2 x 1", answer=2},
	{level=1, problem = "6 ÷ 3", answer=2},
	{level=1, problem = "2 + 1", answer=3},
	{level=1, problem = "8 - 5", answer=3},
	{level=1, problem = "9 ÷ 3", answer=3},
	{level=1, problem = "2 + 2", answer=4},
	{level=1, problem = "2 x 2", answer=4},
	{level=1, problem = "8 ÷ 2", answer=4},
	{level=1, problem = "2 + 3", answer=5},
	{level=1, problem = "8 - 3", answer=5},
	{level=1, problem = "10 ÷ 2", answer=5},
	{level=1, problem = "3 + 3", answer=6},
	{level=1, problem = "8 - 2", answer=6},
	{level=1, problem = "2 x 3", answer=6},
	{level=1, problem = "4 + 3", answer=7},
	{level=1, problem = "10 - 3", answer=7},
	{level=1, problem = "7 ÷ 1", answer=7},
	{level=1, problem = "4 + 4", answer=8},
	{level=1, problem = "9 - 1", answer=8},
	{level=1, problem = "8 ÷ 1", answer=8},
	{level=1, problem = "7 + 2", answer=9},
	{level=1, problem = "3 x 3", answer=9},
	{level=1, problem = "9 ÷ 1", answer=9},
	{level=1, problem = "6 + 4", answer=10},
	{level=1, problem = "5 x 2", answer=10},
	{level=1, problem = "10 ÷ 1", answer=10},
}
local buttons = {}
local r = math.random(1, 28)
local playAgainBtn

local function endGame(type)
	gamestatus = "ended"
	scoreTxt.isVisible = false
	timerTxt.isVisible = false
	problemTxt.isVisible = false
	for i=0, #buttons do
		if buttons[i] then
			buttons[i]:removeSelf()
			buttons[i] = nil
		end 
	end
	if(type == "gameover") then endGameTxt1.text, endGameTxt2.text = "GAME", "OVER!" end
	if(type == "timeup") then endGameTxt1.text, endGameTxt2.text = "TIME", "UP!" end
	endGameTxt1.isVisible = true
	endGameTxt2.isVisible = true
	scoreTxt1.text = "your score: "..score
	scoreTxt1.isVisible = true
	playAgainBtn.isVisible = true
	exitBtn.isVisible = true
end

local function validate(ans)
	if(problems[r].answer == ans) then
		--print("correct!")
		time = 5
		score = score + 1
		r = math.random(1, 28)

		scoreTxt.text = tostring(score)
		timerTxt.text = tostring(time)
		problemTxt.text = problems[r].problem
	else
		endGame("gameover")
	end
end

local function onButton(event)
	if event.phase == "ended" then
		validate(tonumber(event.target.id))
	end
end

local function onEndGameBtn(event)
	if event.phase == "ended" then
		if event.target.id == "playAgain" then
			composer.removeScene( "game" )
			composer.gotoScene( "game", "fade", 500 )
		end
		if event.target.id == "exit" then
			composer.removeScene( "menu" )
			composer.gotoScene( "menu", "fade", 500 )
		end
	end
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local sceneGroup = self.view

	scoreTxt = display.newText("score: "..tostring(score), display.contentCenterX, 0, "assets/fonts/GothamRnd-Bold.otf", 30)
	scoreTxt.y = display.screenOriginY + scoreTxt.height - 17
	scoreTxt:setTextColor(color.hex("16a05d"))

	timerTxt = display.newText(tostring(time), display.contentCenterX, display.contentCenterY - 150, "assets/fonts/GothamRnd-Bold.otf", 40)
	timerTxt:setTextColor(color.hex("16a05d"))

	problemTxt = display.newText(problems[r].problem, display.contentCenterX, timerTxt.y + 60, "assets/fonts/GothamRnd-Bold.otf", 60)
	problemTxt:setTextColor(color.hex("de5347"))

	buttons[1] = widget.newButton{
		label="1",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "1",
		onEvent = onButton
	}
	buttons[1].x = problemTxt.x - 100
	buttons[1].y = problemTxt.y + 70

	buttons[2] = widget.newButton{
		label="2",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "2",
		onEvent = onButton
	}
	buttons[2].x = problemTxt.x
	buttons[2].y = problemTxt.y + 70

	buttons[3] = widget.newButton{
		label="3",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "3",
		onEvent = onButton
	}
	buttons[3].x = problemTxt.x + 100
	buttons[3].y = problemTxt.y + 70

	buttons[4] = widget.newButton{
		label="4",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "4",
		onEvent = onButton
	}
	buttons[4].x = problemTxt.x - 100
	buttons[4].y = buttons[1].y + 50

	buttons[5] = widget.newButton{
		label="5",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "5",
		onEvent = onButton
	}
	buttons[5].x = problemTxt.x
	buttons[5].y = buttons[1].y + 50

	buttons[6] = widget.newButton{
		label="6",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=26,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "6",
		onEvent = onButton
	}
	buttons[6].x = problemTxt.x + 100
	buttons[6].y = buttons[1].y + 50

	buttons[7] = widget.newButton{
		label="7",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "7",
		onEvent = onButton
	}
	buttons[7].x = problemTxt.x - 100
	buttons[7].y = buttons[4].y + 50

	buttons[8] = widget.newButton{
		label="8",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "8",
		onEvent = onButton
	}
	buttons[8].x = problemTxt.x
	buttons[8].y = buttons[4].y + 50

	buttons[9] = widget.newButton{
		label="9",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=26,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "9",
		onEvent = onButton
	}
	buttons[9].x = problemTxt.x + 100
	buttons[9].y = buttons[4].y + 50

	buttons[10] = widget.newButton{
		label="10",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		fontSize=23,
		font="assets/fonts/GothamRnd-Bold.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=95, height=40,
		id = "10",
		onEvent = onButton
	}
	buttons[10].x = problemTxt.x
	buttons[10].y = buttons[7].y + 50

	endGameTxt1 = display.newText("", display.contentCenterX, display.contentCenterY - 100, "assets/fonts/GothamRnd-Bold.otf", 65)
	endGameTxt1:setTextColor(color.hex("de5347"))
	endGameTxt1.isVisible = false

	endGameTxt2 = display.newText("", display.contentCenterX, endGameTxt1.y + 55, "assets/fonts/GothamRnd-Bold.otf", 65)
	endGameTxt2:setTextColor(color.hex("de5347"))
	endGameTxt2.isVisible = false

	scoreTxt1 = display.newText("", display.contentCenterX, endGameTxt2.y + 55, "assets/fonts/GothamRnd-Bold.otf", 35)
	scoreTxt1:setTextColor(color.hex("16a05d"))
	scoreTxt1.isVisible = false

	playAgainBtn = widget.newButton{
		label="PLAY AGAIN",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		font="assets/fonts/GothamRnd-Medium.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=159, height=45,
		id = "playAgain",
		onEvent = onEndGameBtn
	}
	playAgainBtn.x = scoreTxt1.x
	playAgainBtn.y = scoreTxt1.y + 60
	playAgainBtn.isVisible = false

	exitBtn = widget.newButton{
		label="EXIT",
		labelColor = { default={color.hex("ffffff")}, over={color.hex("ffffff")} },
		font="assets/fonts/GothamRnd-Medium.otf",
		defaultFile="assets/img/4c8bf5.png",
		overFile="assets/img/de5347.png",
		width=159, height=45,
		id = "exit",
		onEvent = onEndGameBtn
	}
	exitBtn.x = playAgainBtn.x
	exitBtn.y = playAgainBtn.y + 55
	exitBtn.isVisible = false

	sceneGroup:insert(scoreTxt)
	sceneGroup:insert(timerTxt)
	sceneGroup:insert(problemTxt)
	for i=1, #buttons do
		sceneGroup:insert(buttons[i])
	end
	sceneGroup:insert(endGameTxt1)
	sceneGroup:insert(endGameTxt2)
	sceneGroup:insert(scoreTxt1)
	sceneGroup:insert(playAgainBtn)
	sceneGroup:insert(exitBtn)
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

		function t:timer( event )
			if gamestatus == "ended" then
				timer.cancel( event.source )
			else
			    time = time - 1
			    timerTxt.text = tostring(time)
			    if time == 0 then
			    	timer.cancel( event.source )
		    		endGame("timeup")
			    end
			end
		end
		timer.performWithDelay( 300, t, 0 )
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

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view

	for i=1, #buttons do
		if buttons[i] then
			buttons[i]:removeSelf()
			buttons[i] = nil
		end 
	end

	if playAgainBtn then
		playAgainBtn:removeSelf()
		playAgainBtn = nil
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