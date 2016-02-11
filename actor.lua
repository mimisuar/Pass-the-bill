actor = class:new()

function actor:init()
	function self:init(x,y) self.x=x;self.y=y end
	function self:draw() end
	function self:update(dt) end
	function self:keypressed(key) end
end