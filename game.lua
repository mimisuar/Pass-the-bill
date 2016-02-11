-- this is the main game file --
game = state()

function game.load()
	c_level = 1
	levels = {"getting past the house","senators"}
end

function game.update(dt)
	for i=1,#game_ents do
		for key,value in pairs(game_ents[i]) do
			if (value.update) then
				value:update(dt)
			end
		end
	end
	-- check to see if the player beat the level --
	local beat = true
	for key,value in pairs(reps) do
		if (value.argued == 1) then 
			beat = false
			break 
		end
	end
	for key,value in pairs(senators) do
		if (value.hp > 0) then
			beat =  false
			break
		end
	end
	if (beat) then
		state = win
	end
end

function game.draw()
	love.graphics.push()
	love.graphics.translate(-cam.x,cam.y)
	for x=0,5 do
		love.graphics.draw(background,x*800,0)
	end
	for i=1,#game_ents do
		for key,value in pairs(game_ents[i]) do
			if (value.draw) then
				value:draw()
			end
		end
	end
	love.graphics.pop()
end

function game.keypressed(keyy)
	for i=1,#game_ents do
		for key,value in pairs(game_ents[i]) do
			if (value.keypressed) then
				value:keypressed(keyy)
			end
		end
	end
end

function game.keyreleased(keyy)
	for i=1,#game_ents do
		for key,value in pairs(game_ents[i]) do
			if (value.keyreleased) then
				value:keyreleased(keyy)
			end
		end
	end
end