module rendering

import collision
import gg

pub fn render(ctx gg.Context, collider collision.BoxCollider, color gg.Color) {
	ctx.draw_rect_filled(collider.x, collider.y, collider.width, collider.height, color)
}
