// Y Fractal generator by Syntaxxor
clear
Vector2 = {"x":0.0,"y":0.0}
newVec2 = function(x, y)
	v = new Vector2
	v.x = x
	v.y = y
	return v
end function
Vector2.add = function(other)
	return newVec2(self.x + other.x, self.y + other.y)
end function
Vector2.scale = function(s)
	return newVec2(self.x * s, self.y * s)
end function
vecFromDegrees = function(d)
	r = d * 0.017453
	return newVec2(cos(r), sin(r))
end function

Point = {"p":new Vector2,"r":0.0}
newPoint = function(p, r)
	point = new Point
	point.p = p
	point.r = r
	return point
end function

file.makedir("fractals")
branch_len = 128.0
branch_angle = 30.0
branch_scale = 0.8
iters = 12
gfx.color = color.brown
gfx.line gfx.width / 2.0, 0, gfx.width / 2.0, branch_len
queue = [newPoint(newVec2(gfx.width / 2.0, branch_len), 90.0)]
for i in range(1, iters)
	gfx.color = color.lerp(gfx.color, color.green, i / iters)
	branch_len = branch_len * branch_scale
	ql = queue.len
	for j in range(1, ql)
		point = queue.pull
		r = point.r + branch_angle
		d = vecFromDegrees(r)
		off = d.scale(branch_len)
		np = newPoint(off.add(point.p), r)
		queue.push(np)
		gfx.line point.p.x, point.p.y, np.p.x, np.p.y
		
		r = point.r - branch_angle
		d = vecFromDegrees(r)
		off = d.scale(branch_len)
		np = newPoint(off.add(point.p), r)
		queue.push(np)
		gfx.line point.p.x, point.p.y, np.p.x, np.p.y
	end for
	img = gfx.getImage(0, 0, gfx.width, gfx.height)
	file.saveImage("fractals/" + str(i) + ".png", img)
end for
