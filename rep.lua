repr = class:new()

function repr:init(x,y)
	self.x = x
	self.y = y
	self.img = sprite:new("gfx/rep.png",40,40)
	self.img:newtime(0)
	self.argued = 1
	self.bbox = bbox:new(self.x,self.y,40,40)
end

function repr:draw()
	self.img:draw(math.floor(self.x),math.floor(self.y),self.argued)
end