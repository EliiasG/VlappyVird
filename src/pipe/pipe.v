module pipe

import collision

pub const (
	width       = u16(35)
	height      = u16(4096) // 2^12
	hole_height = u16(100)
	speed       = f32(3.5)
)

pub struct Pipe {
pub mut:
	x f32
	y f32
}

pub fn (mut p Pipe) update() {
	p.x -= pipe.speed
}

pub fn (p &Pipe) get_top_collider() collision.BoxCollider {
	return collision.BoxCollider{
		x: p.x
		y: p.y - pipe.hole_height / 2 - pipe.height
		width: pipe.width
		height: pipe.height
	}
}

pub fn (p &Pipe) get_bottom_collider() collision.BoxCollider {
	return collision.BoxCollider{
		x: p.x
		y: p.y + pipe.hole_height / 2
		width: pipe.width
		height: pipe.height
	}
}
