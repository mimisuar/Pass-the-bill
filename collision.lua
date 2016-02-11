bbox = class:new()

function bbox:init(x,y,w,h,r,l,t,d)
	self.x = x
	self.y = y
	self.width = w
	self.height = h
	-- these things just help
end

bbox.update = bbox.init

function bbox:check(box)
	-- box being the other box
	
	if (self.x >= box.x and self.y >= box.y and self.x <= box.x+box.width and self.y <= box.y+box.height) then
		return true
	end
	
	if (self.x+self.width >= box.x and self.y >= box.y and self.x+self.width <= box.x+box.width and self.y <= box.y+box.height) then
		return true
	end
	
	if (self.x >= box.x and self.y+self.height >= box.y and self.x <= box.x+box.width and self.y+self.height <= box.y+box.height) then
		return true
	end
	
	if (self.x+self.width >= box.x and self.y+self.height >= box.y and self.x+self.width <= box.x+box.width and self.y+self.height <= box.y+box.height) then
		return true
	end
	
	if (box.x >= self.x and box.y >= self.y and box.x <= self.x+self.width and box.y <= self.y+self.height) then
		return true
	end
	
	if (box.x+box.width >= self.x and box.y+box.height >= self.y and box.x+box.width <= self.x+box.width and box.y+box.height <= self.y+self.height) then
		return true
	end
	
	return false
end   