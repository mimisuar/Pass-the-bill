p_bulletImg = love.graphics.newImage("gfx/playerbullet.png")

pbullet = class:new()

function pbullet:init()
	self.x = players[1].x+15
	self.y = players[1].y+15
	self.dir = players[1].dir
	self.bbox = bbox:new(self.x,self.y,8,8)
	self.speed = 600
end

function pbullet:update(dt)
	if (self.dir == keyC[leftkey]) then
		self.x = self.x - self.speed*dt
	elseif (self.dir == keyC[rightkey]) then
		self.x = self.x + self.speed*dt
	elseif (self.dir == keyC[upkey]) then
		self.y = self.y - self.speed*dt
	elseif (self.dir == keyC[downkey]) then
		self.y = self.y + self.speed*dt
	end
	self.bbox:update(self.x,self.y,8,8)
	
	for key,value in pairs(walls) do
		if (self.bbox:check(value.bbox)) then
			removeent(p_bullets,self)
			return true
		end
	end
	
	for key,value in pairs(reps) do
		if (self.bbox:check(value.bbox)) then
			if (value.argued == 1) then
				removeent(p_bullets,self)
				value.argued = 2
				return true
			end
		end
	end
	
	for key,value in pairs(senators) do
		if (self.bbox:check(value.bbox)) then
			if (value.hp > 0) then
				removeent(p_bullets,self)
				value.hp = value.hp - 1
			end
		end
	end
end

function pbullet:draw()
	love.graphics.draw(p_bulletImg,self.x,self.y)
end