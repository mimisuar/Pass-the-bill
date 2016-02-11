sen = class:new()

function sen:init(x,y)
	self.x = x
	self.y = y
	self.hp = 1
	self.dir = "left"
	self.img = sprite:new("gfx/sen.png",40,40)
	self.interval = 2
	self.argued = 1
	self.bbox = bbox:new(self.x,self.y,40,40)
	self.mybullet = nil
end

function sen:update(dt)
	if (self.hp <= 0) then return end
	if (self.interval < 0) then
		self.interval = self.interval - dt
	else
		self.interval = 2
		if (not self.mybullet) then
			self.mybullet = ebullet:new(self)
			table.insert(e_bullets,self.mybullet)
		end
	end
	
	if (players[1].x > self.x) then
		self.dir = "right"
	else
		self.dir = "left"
	end
	
end

function sen:draw()
	if (self.hp <= 0) then self.argued = 2 end
	self.img:draw(self.x,self.y,self.argued)
end