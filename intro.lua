intro = state()

function intro.load()
	introtext = {
	"S 421999: the Lunch Break Bill",
	"Every student gets an hour break from school",
	"during lunch. ",
	"The committiee of education is EVIL and hates",
	"your bill! Luckily you have the magic power of ",
	"arguing! Much of the house has a new illness going",
	"around, so not all 435 members are going to be there. Strike!",
	"Press "..keyC[debatekey].." to continue."
	}
	love.graphics.setBackgroundColor(255,255,255)
end

function intro.keypressed(key)
	if (key == keyC[debatekey]) then
		state = game
		-- initilize game --
		levelload(levels[1])
	end
end

function intro.draw()
	love.graphics.draw(background)
	love.graphics.setFont(smallfont)
	love.graphics.setColor(0,0,0)
	for key,text in pairs(introtext) do
		love.graphics.print(text,1,20*key)
	end
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(gamefont)
end