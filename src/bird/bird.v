module bird

import collision

pub const (
	flap_power = f32(10)
	gravity    = f32(.15)
	drag       = f32(.05)
	x_offset   = u16(20)
	size       = u16(12)
)

pub struct Bird {
pub mut:
	y        f32
	velocity f32
}

pub fn (mut b Bird) flap() {
	b.velocity -= bird.flap_power
}

pub fn (mut b Bird) update() {
	// apply velocity
	b.y += b.velocity
	// apply gravity
	b.velocity += bird.gravity
	// apply drag
	b.velocity *= 1 - bird.drag
}

pub fn (b Bird) get_collider() collision.BoxCollider {
	return collision.BoxCollider{
		x: bird.x_offset
		y: b.y
		width: bird.size
		height: bird.size
	}
}
