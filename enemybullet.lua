e_bulletImg = love.graphics.newImage("gfx/enemybullet.png")

ebullet = class:new()

function ebullet:init(senget)
	self.x = senget.x+20
	self.y = senget.y+20
	self.dir = senget.dir
	self.speed = 600
	
	
	self.bbox = bbox:new(self.x,self.y,8,8)
	self.assignment = senget
end

function ebullet:update(dt)
	
	self.bbox:update(self.x,self.y,8,8)
	
	if (self.dir == "down") then
		self.y = self.y + self.speed*dt
	elseif (self.dir == "up") then
		self.y = self.y - self.speed*dt
	elseif (self.dir == "left") then
		self.x = self.x - self.speed*dt
	elseif (self.dir == "right") then
		self.x = self.x + self.speed*dt
	end
	
	for key,value in pairs(walls) do
		if (self.bbox:check(value.bbox)) then
			removeent(e_bullets,self)
			self.assignment.mybullet = nil
			return true
		end
	end
	
	if (self.bbox:check(players[1].bbox)) then
		state = gameover
	end
end

function ebullet:draw()
	love.graphics.draw(e_bulletImg,self.x,self.y)
end