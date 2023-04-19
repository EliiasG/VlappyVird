module collision

pub struct BoxCollider {
pub:
	x      f32
	y      f32
	width  u16
	height u16
}

pub fn colliding(a BoxCollider, b BoxCollider) bool {
	// top left
	start_x, start_y := b.x - a.width, b.y - a.height
	// bottom right
	end_x, end_y := b.x + b.width, b.y + b.height

	is_colliding_x := start_x < a.x && a.x < end_x
	is_colliding_y := start_y < a.y && a.y < end_y

	return is_colliding_x && is_colliding_y
}
