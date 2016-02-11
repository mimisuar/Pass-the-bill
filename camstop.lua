camstop = class:new()

function camstop:init(x,y)
	self.x = x
	self.y = y
	self.bbox = bbox:new(x,y,40,40)
end