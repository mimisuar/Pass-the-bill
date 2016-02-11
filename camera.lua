camera = class:new()

--[[
the camera works by using love.graphics.translate and what ever the x/y coords are of the camera.
--]]

function camera:init(x,y)
	self.x = x or 0
	self.y = y or 0
	self.width = love.graphics.getWidth()
	self.height = love.graphics.getHeight()
	self.pX = 0
	self.pY = 0
	self.bbox = bbox:new(self.x,self.y,love.graphics.getWidth(),love.graphics.getHeight())
end

function camera:move(xx,yy)
	local pX = self.x
	self.x = xx
	self.y = yy
end

function camera:set()
	love.graphics.push()
	love.graphics.translate(self.x,self.y)
end

function camera:unset()
	love.graphics.pop()
end