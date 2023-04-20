module rendering

import gg
import gamesim
import collision.rendering
import gx

pub interface Renderer {
	render(sim &gamesim.GameSimulation)
}

pub fn new_collider_renderer(ctx &gg.Context) Renderer {
	return CollisionRenderer{
		ctx: ctx
	}
}

pub fn new_score_renderer(ctx &gg.Context) Renderer {
	return ScoreRenderer{
		ctx: ctx
	}
}

struct CollisionRenderer {
	ctx &gg.Context
}

fn (r &CollisionRenderer) render(sim &gamesim.GameSimulation) {
	// bird
	rendering.render(r.ctx, sim.bird.get_collider(), gx.yellow)

	// pipes
	for p in sim.pipes {
		// top
		rendering.render(r.ctx, p.get_top_collider(), gx.green)
		// bottom
		rendering.render(r.ctx, p.get_bottom_collider(), gx.green)
	}
}

struct ScoreRenderer {
	ctx &gg.Context
}

fn (r &ScoreRenderer) render(sim &gamesim.GameSimulation) {
	// config
	text_cfg := gx.TextCfg{
		size: 32
		align: .center
	}

	// draw text
	r.ctx.draw_text(gamesim.width / 2, 0, '${sim.score}', text_cfg)
}
