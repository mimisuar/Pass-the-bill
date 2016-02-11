function love.load(args)
	love.filesystem.setIdentity("LevelEditor")
	love.window.setTitle("Pass the Bill LE")
	require "class"
	require "entity"
	require "level"
	
	love.window.setMode(800,400)
	
	--love._openConsole()
	
	ents = {}
	
	-- initilize the different entities --
	c_entity = 1
	
	cam = {}
	cam.x = 0
	cam.y = 0
	love.keyboard.setKeyRepeat(true)
	gettingtextinput = false
	lvlname = ""
end

function love.update(dt)
	keeptabs()
end

function love.textinput(text)
	if (gettingtextinput) then
		lvlname = lvlname..text
	end
end

function love.keypressed(key)
	if (key == "tab") then
		if (gettingtextinput) then
			gettingtextinput = false
		else
			gettingtextinput = true
		end
	end
	if (key == "backspace") then
		lvlname = lvlname:sub(1,lvlname:len()-1)
	end
	if (gettingtextinput) then return end
	local n = tonumber(key)
	if (not n) then n = 0 end
	if (n >= 1 and n <= 5) then
		c_entity = n
	end
	if (key == "s") then
		level.save(lvlname)
	end
	if (key == "l") then
		level.load(lvlname)
	end
	if (key == "right") then
		cam.x = cam.x - 40
	end
	if (key == "left") then
		cam.x = cam.x + 40
	end
	if (key == "c") then
		ents = {}
	end
end

function love.mousepressed(x,y,button)
	if (gettingtextinput) then return end
	local mx,my
	if (cam.x < 0) then
		mx = x+math.abs(cam.x)
	else
		mx = x-math.abs(cam.x)
	end
	my = y
	while (mx % 40 ~= 0) do
		mx = mx - 1
	end
	while (my % 40 ~= 0) do
		my = my - 1
	end
	if (button == "l") then
		addentity(c_entity,{mx,my})
	end
	if (button == "r") then
		delentity(mx,my)
	end
end

function love.draw()
	
	love.graphics.push()
	love.graphics.translate(cam.x,cam.y)
	
	for key,value in pairs(ents) do
		love.graphics.draw(gameimages[value.id],value.pos[1],value.pos[2])
	end
	love.graphics.pop()
	love.graphics.print(gameobjects[c_entity],0,0)
	
	love.graphics.print(cantsavemsg,0,16)
	love.graphics.print(lvlname,0,32)
end