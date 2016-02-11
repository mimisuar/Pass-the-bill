wall = class:new()

function wall:init(x,y)
	self.x = x
	self.y = y
	self.img = love.graphics.newImage("gfx/wall.png")
	self.bbox = bbox:new(self.x,self.y,40,40)
end

function wall:draw()
	love.graphics.draw(self.img,self.x,self.y)
end