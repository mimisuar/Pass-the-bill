function love.load(arg)
	love.filesystem.setIdentity("pass the bill")
	local icon = love.image.newImageData("gfx/icon.png")
	love.window.setIcon(icon)
	require "class"
	require "collision"
	require "sprite"
	strtable = require "Tserial"
	require "mainmenu"
	require "keys"
	require "camera"
	require "player"
	require "game"
	require "intro"
	require "wall"
	require "rep"
	require "sen"
	require "camstop"
	require "playerbullet"
	require "enemybullet" 
	require "interlude"
	require "ending"
	
	--love._openConsole()
	
	inUserMode = false -- checks to see if you are in the main story
	
	background = love.graphics.newCanvas(800,400)
	local tile = love.graphics.newImage("gfx/tile.png")
	love.graphics.setCanvas(background)
	for x=0,(800),40 do
		for y=0, 400,40 do
			love.graphics.draw(tile,x,y)
		end
	end
	love.graphics.setCanvas()
	
	titleimage = love.graphics.newImage("gfx/title.png")
	
	gamefont = love.graphics.newFont("gfx/minecraftia.ttf",32)
	smallfont = love.graphics.newFont("gfx/minecraftia.ttf",14)
	
	mainmenu.load()
	keysmenu.load()
	game.load()
	intro.load()
	inter.load()
	ending.load()
	win.load()
	
	pause = state()
	function pause.draw()
		love.graphics.draw(titleimage)
	end
	prevstate = mainmenu
	
	cam = camera:new()
	
	state = mainmenu
end

function love.draw()
	state.draw()
	
end

function love.update(dt)
	state.update(dt)
end

function love.keypressed(key)
	state.keypressed(key)
end

function love.keyreleased(key)
	state.keyreleased(key)
end

function love.focus(f)
	if (not f) then
		prevstate = state
		state = pause
		love.window.setTitle("GAME PAUSED")
	else
		state = prevstate
		love.window.setTitle("Pass the Bill")
	end
end

function state()
	-- create a blank state so you can override any function --
	local t = {}
	t.load = function()end
	t.update = function()end
	t.draw = function()end
	t.keypressed = function()end
	t.keyreleased = function()end
	return t
end

function levelload(levelname)
	-- load a level appropriatly, because the loader for the editor is a POS
	walls = {}
	players = {}
	senators = {}
	reps = {}
	camstops = {}
	p_bullets = {}
	e_bullets = {}
	cam.x = 0
	cam.y = 0
	game_ents = {walls,p_bullets,e_bullets,senators,reps,players,camstops}
	for line in love.filesystem.lines(levelname..".lvl") do
		vars = {}
		for var in line:gmatch("%w+") do table.insert(vars,tonumber(var)) end
		if (vars[1] == 1) then
			local a = player:new(vars[2],vars[3])
			table.insert(players,a)
		elseif (vars[1] == 2) then
			local a = sen:new(vars[2],vars[3])
			table.insert(senators,a)
		elseif (vars[1] == 3) then
			local a = repr:new(vars[2],vars[3])
			table.insert(reps,a)
		elseif (vars[1] == 4) then
			local a = wall:new(vars[2],vars[3])
			table.insert(walls,a)
		elseif (vars[1] == 5) then
			local a = camstop:new(vars[2],vars[3])
			table.insert(camstops,a)
		else
			error("Corrupt level file!")
		end
	end
end

function removeent(list,ent)
	for key,value in pairs(list) do
		if (value == ent) then
			table.remove(list,key)
			print(#list)
			print("ent removed")
		end
	end
end

win = state()

function win.load()
	wintext = "You got them all to \nagree with your bill!"
end

function win.draw()
	love.graphics.draw(background)
	love.graphics.setColor(0,0,0)
	love.graphics.print(wintext)
	love.graphics.print("Press space to continue", 100,200)
	love.graphics.setColor(255,255,255)
end

function win.keypressed(key)
	if (key == " ") then
		if (isUserMode) then 
			state = mainmenu
		else
			state = game
			c_level = c_level +1
			if (c_level == 2) then
				state = inter
			end
			if (c_level == 3) then
				state = ending
				return false
			end
			levelload(levels[c_level])
		end
	end
end

gameover = state()

function gameover.draw()
	love.graphics.draw(background)
	love.graphics.setColor(0,0,0)
	love.graphics.print("No! The president vetoed the bill,\n get back in there\nAnd make sure he passes it!\n\n[Press space to return to \nthe main menu.]\n[Press r to try again.",20,20)
	love.graphics.setColor(255,255,255)
end

function gameover.keypressed(key)
	if key == " " then
		state = mainmenu
	end
	if (key == "r") then
		levelload(levels[c_level])
		state = game
	end
end