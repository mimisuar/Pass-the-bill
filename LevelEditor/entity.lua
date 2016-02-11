gameobjects = {
	"player",
	"sen",
	"rep",
	"wall",
	"camstop"
}

gameimages = {
	love.graphics.newImage("gfx/player.png"),
	love.graphics.newImage("gfx/sen.png"),
	love.graphics.newImage("gfx/rep.png"),
	love.graphics.newImage("gfx/wall.png"),
	love.graphics.newImage("gfx/camstop.png")
}

function addentity(id,pos)
	local name = gameobjects[id] 
	local ent = {}
	ent.id = id
	ent.pos = pos
	for key,value in pairs(ents) do
		if (value.pos[1] == pos[1] and value.pos[2] == pos[2]) then
			return false
		end
	end
	table.insert(ents,ent)
end

function delentity(x,y)
	-- param is either a number or a table.
	for key,value in pairs(ents) do
		if (value.pos[1] == x and value.pos[2] == y) then
			table.remove(ents,key)
			break
		end
	end
end

function keeptabs()
	-- keep tabs on all of the motherfuckers --
	local n_player = 0 -- no more than 1
	local n_sens = 0 -- no more than 100
	local n_reps = 0 -- no more than 435
	local n_camstops = 0
	-- also, if there senators and represanitives! Only one at a time.
	for key,value in pairs(ents) do
		if (value.id == 1) then
			-- player protocol --
			n_player = n_player + 1
		end
		if (value.id == 2) then
			-- senator protocol --
			n_sens = n_sens + 1
		end
		if (value.id == 3) then
			n_reps = n_reps + 1
		end
		if (value.id == 5) then
			n_camstops = n_camstops + 1
		end
	end
	if (n_player > 1) then
		cantsavemsg = "Too many players!"
		cantsave = true
		return false
	end
	if (n_sens > 100) then
		cantsavemsg = "Too many senators!"
		cantsave = true
		return false
	end
	if (n_reps > 435) then
		cantsavemsg = "Too many reps!"
		cantsave = true
		return false
	end
	if (n_reps > 0 and n_sens > 0) then
		cantsavemsg = "Can only have reps OR sens"
		cantsave = true
		return false
	end
	if (n_camstops > 2) then
		cantsavemsg = "Too many cam stoppers!"
		cantsave = true
		return false
	end
	cantsavemsg = ""
	cantsave = false
end