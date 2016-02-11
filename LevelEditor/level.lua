level = {}

cantsave = true
cantsavemsg = ""

function level.load(levelname)
	ents = {}
	
	levelname = levelname..".lvl"
	
	if (not love.filesystem.exists(levelname)) then
		return false
	end
	
	print("loading")
	for line in love.filesystem.lines(levelname) do
		local vals = {}
		for val in line:gmatch("%S+") do table.insert(vals,val) end
		-- vals -- 
		--  id  --
		-- xpos --
		-- ypos --
		local id,xpos,ypos
		id = tonumber(vals[1])
		xpos = tonumber(vals[2])
		ypos = tonumber(vals[3])
		print(id.."\t"..xpos.."\t"..ypos)		
		addentity(id,{xpos,ypos})
	end
	print("loaded")
end

function level.save(levelname)
	-- basic save level --
	levelname = levelname..".lvl"
	if (cantsave) then return end
	print("saving")
	local f = love.filesystem.newFile(levelname,"w")
	for key,value in pairs(ents) do
		local eid,ex,ey
		eid = tostring(value.id)
		ex = tostring(value.pos[1])
		ey = tostring(value.pos[2])
		print(eid.." "..ex.." "..ey)
		ts = eid.." "..ex.." "..ey
		f:write(ts.."\n")
	end
	f:close()
	print("saved")
end