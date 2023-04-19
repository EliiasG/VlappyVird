module rendering

import gg
import gamesim
import collision.rendering
import gx

pub interface Renderer {
	render(sim gamesim.GameSimulation)
}

struct CollisionRenderer {
	ctx gg.Context
}

fn (c &CollisionRenderer) render(sim gamesim.GameSimulation) {
	// bird
	rendering.render(c.ctx, sim.bird.get_collider(), gx.yellow)

	// pipes
	for p in sim.pipes {
		// top
		rendering.render(c.ctx, p.get_top_collider(), gx.green)
		// bottom
		rendering.render(c.ctx, p.get_bottom_collider(), gx.green)
	}
}

pub fn new_collider_renderer(ctx gg.Context) Renderer {
	return CollisionRenderer{
		ctx: ctx
	}
}
