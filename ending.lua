ending = state()

function ending.load()
	endingtext = {
		"Everyone in both houses agreed with you!",
		"But the president still has final say.",
		"He can sign it or send it back to congress.",
		"Not doing anything can still veto the bill!",
		"But because everyone agreed on your bill,",
		"it became a law, congrats!",
		"",
		"",
		"",
		"Oh, wait, everyone changed there minds...",
		"Sorry better luck next time!"
	}
	love.graphics.setBackgroundColor(255,255,255)
end

function ending.keypressed(key)
	if (key == keyC[debatekey]) then
		state = mainmenu
		c_level = 1
	end
end

function ending.draw()
	love.graphics.draw(background)
	love.graphics.setFont(smallfont)
	love.graphics.setColor(0,0,0)
	for key,text in pairs(endingtext) do
		love.graphics.print(text,1,20*key)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(gamefont)
end