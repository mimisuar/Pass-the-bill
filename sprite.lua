sprite = class:new()

function sprite:init(img,framewidth,frameheight,xo,yo,startX,startY,mFrame)
	self.img = love.graphics.newImage(img)
	self.width = framewidth
	self.height = frameheight
	
	self.origin = {}
	self.origin.x = xo or 0
	self.origin.y = yo or 0
	self.frames = {}
	self.frame = 1
	
	local iW = self.img:getWidth()
	local iH = self.img:getHeight()
	local fpr,fpc = iW/framewidth,iH/frameheight
	
	startX = startX or 0
	startY = startY or 0
	mFrame = mFrame or fpr * fpc
	
	local tFrames = {}
	
	local i,j = 0,0
	
	for i=0,fpr do
		if i >= fpr then
			i = 0
			j = j + 1
		end
		
		if j >= fpc then
			break
		end
		
		if mFrame == 0 then
			mFrame = 0
		end
		
		local quad = love.graphics.newQuad((i*framewidth)+startX,(j*frameheight)+startY,framewidth,frameheight,iW,iH)
		table.insert(tFrames,quad)
		mFrame = mFrame - 1
	end
	
	local cFrame = 1
	for key,value in pairs(tFrames) do
		if value == nil then
			break
		end
		
		if value then
			self.frames[cFrame] = value
		end
		
		cFrame = cFrame + 1
	end
	
	print(#self.frames)
	
	-- finally set some timer things. --
	self.dly = 1
	self.timer = 1
	self.maxFrame = #self.frames
	print(self.maxFrame)
end

function sprite:update(dt)
	if (self.dly == 0) then return end
	self.timer = self.timer - dt
	if (self.timer < 0) then
		self.timer = self.dly
		self.frame = self.frame + 1
		if (self.frame > self.maxFrame) then
			self.frame = 1
			if (love.animationend) then
				love.animationend(self)
			end
		end
	end
end

function sprite:newtime(time)
	self.dly = time
	self.timer = time
end

function sprite:draw(x,y,frame,r,sx,sy,ox,oy,kx,ky)
	frame = frame or self.frame
	r = r or 0
	sx = sx or 1
	sy = sy or 1
	ox = ox or self.origin.x
	oy = oy or self.origin.y
	kx = kx or 0
	ky = ky or 0
	
	love.graphics.draw(self.img,self.frames[frame],x,y,r,sx,sy,ox,kx,ky)
end