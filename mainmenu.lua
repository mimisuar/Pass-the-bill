mainmenu = state()

function mainmenu.load()
	menu_ops = {
	"Play game",
	"Controls",
	"Quit"}
	
	menu_sel = 1
end

function mainmenu.keypressed(key)
	if (key == "down") then
		menu_sel = menu_sel + 1
		if (menu_sel > #menu_ops) then
			menu_sel = 1
		end
	elseif (key == "up") then
		menu_sel = menu_sel - 1
		if (menu_sel < 1) then
			menu_sel = #menu_ops
		end
	end
	
	if (key == " " or key == "return") then
		local cmd = menu_ops[menu_sel]:lower()
		if (cmd == "play game") then
			state = intro
		elseif (cmd == "controls") then
			state = keysmenu
		elseif (cmd == "quit") then
			love.event.quit()
		end
	end
end

function mainmenu.draw()
	love.graphics.draw(background)
	love.graphics.setFont(gamefont)
	love.graphics.draw(titleimage)
	love.graphics.setColor(0,0,0)
	for key,value in pairs(menu_ops) do
		cursor = "  "
		if (menu_ops[menu_sel] == value) then
			cursor = ">"
		end
		love.graphics.print(cursor..value,300,220+40*key)
	end
	love.graphics.setColor(255,255,255)
end