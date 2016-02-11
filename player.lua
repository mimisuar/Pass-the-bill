player = class:new()

function player:init(x,y)
	self.image = sprite:new("gfx/player.png",40,40)
	self.movingImg = 0.5
	self.stillImg = 0
	self.x = x
	self.y = y
	self.px = x
	self.py = y
	self.imgSpeed = self.stillImg
	self.speed = 0
	self.dir = "down"
	self.bbox = bbox:new(self.x+8,self.y+8,32,32)
end

function player:update(dt)
	self.image:newtime(self.imgSpeed)
	self.image:update(dt)
	
	self.px = self.x
	self.py = self.y
	
	if (self.dir == keyC[rightkey]) then
		self.x = self.x + self.speed*dt
		if (self:collwalls(1,0)) then self.speed = 0; self.x = self.px end
	elseif (self.dir == keyC[leftkey]) then
		self.x = self.x - self.speed*dt
		if (self:collwalls(-1,0)) then self.speed = 0; self.x = self.px end
	elseif (self.dir == keyC[downkey]) then
		self.y = self.y + self.speed*dt
		if (self:collwalls(0,1)) then self.speed = 0; self.y = self.py end
	elseif (self.dir == keyC[upkey]) then
		self.y = self.y - self.speed*dt
		if (self:collwalls(0,-1)) then self.speed = 0; self.y = self.py end
	end
	if (self.x > love.graphics.getWidth()/2) then
		cam.x = math.floor(self.x - love.graphics.getWidth()/2)
	end
	if (cam.x+cam.width > camstops[1].x) then
		cam.x = camstops[1].x - cam.width
	end
	self.bbox:update(self.x+16,self.y+8,10,28)
end

function player:keypressed(key)
	if (key == keyC[downkey] or key == keyC[upkey] or key == keyC[rightkey] or key == keyC[leftkey]) then
		self.speed = 400
		self.dir = key
	end
	if (key == keyC[debatekey]) then
		if (#p_bullets <= 5) then
			table.insert(p_bullets,pbullet:new())
		end
	end
	if (key == "escape") then
		state = mainmenu
	end
end

function player:keyreleased(key)
	if (key == self.dir) then
		self.speed = 0
	end
end

function player:draw()
	self.image:draw(self.x,self.y)
end

function player:collwalls(x,y)
	self.bbox:update(self.x+12+x,self.y+6+y,16,30)
	for key,value in pairs(walls) do
		if (self.bbox:check(value.bbox)) then
			return true
		end
	end
end