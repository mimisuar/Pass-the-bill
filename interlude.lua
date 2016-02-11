inter = state()

function inter.load()
	intertext = {
		"Yes! The House of Represenatives didn't stand a chance!",
		"You didn't need to get ALL of them just a majority, but better safe than sorry.",
		"Senate, on the other hand, REALLY hates your idea, so they must",
		"be even eviler than the House of Reps.",
		"All 100 of them are here, so you only need 51.",
		"Get all 100 just to be safe.",
		"Remember: the president can still veto the bill.",
		"Press "..keyC[debatekey].." to continue"
	}
	love.graphics.setBackgroundColor(255,255,255)
end

function inter.keypressed(key)
	if (key == keyC[debatekey]) then
		state = game
		-- initilize game --
		levelload(levels[2])
	end
end

function inter.draw()
	love.graphics.draw(background)
	love.graphics.setFont(smallfont)
	love.graphics.setColor(0,0,0)
	for key,text in pairs(intertext) do
		love.graphics.print(text,0,20*key)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(gamefont)
end