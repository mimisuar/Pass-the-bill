keysmenu = state()

function keysmenu.load()
	keyC = {
	"left",
	"right",
	"up",
	"down",
	"x"
	}
	
	-- map the keys! --
	leftkey = 1
	rightkey = 2
	upkey = 3
	downkey = 4
	debatekey = 5
	
	if (love.filesystem.exists("keys.data")) then
		local s,f
		f = love.filesystem.newFile("keys.data","r")
		s = f:read()
		keyC = strtable.unpack(s)
	else
		local s,f
		s = strtable.pack(keyC)
		f = love.filesystem.newFile("keys.data","w")
		f:write(s)
		f:close()
	end
	
	key_ops = {
	"Left: ",
	"Right: ",
	"Up: ",
	"Down: ",
	"Debate: "
	}
	key_sel = 1
	keyISSEL = false
end

function keysmenu.keypressed(key)
	if (key == "down" and not keyISSEL) then
		key_sel = key_sel + 1
		if (key_sel > #key_ops) then
			key_sel = 1
		end
	end
	if (key == "up" and not keyISSEL) then
		key_sel = key_sel - 1
		if (key_sel < 1) then
			key_sel = #key_ops
		end
	end
	if (key == "escape" and not keyISSEL) then
		local s,f
		f = love.filesystem.newFile("keys.data","w")
		s = strtable.pack(keyC)
		f:write(s)
		f:close()
		state = mainmenu
	end
	if (keyISSEL) then
		if (key == "backspace") then
			keyC[key_sel] = ""
		else
			keyC[key_sel] = key:lower()
			key = ""
		end
		keyISSEL = false
	end
	if (key == " " or key == "return" and not keyISSEL) then
		keyISSEL = true
	end
end

function keysmenu.draw()
	love.graphics.draw(background)
	love.graphics.draw(titleimage)
	for key,value in pairs(key_ops) do
		local cursor
		if (key_sel == key) then
			cursor = ">"
		else 
			cursor = " "
		end
		love.graphics.setColor(0,0,0)
		love.graphics.print(cursor..value:upper()..keyC[key]:upper(),20,120+30*key)
		love.graphics.print("PRESS ESCAPE TO SAVE SETTINGS",20,320)
		love.graphics.print("PRESS BACKSPACE TO CLEAR SETTING",20,360)
		love.graphics.setColor(255,255,255)
	end
end