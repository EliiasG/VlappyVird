module main

import gamesim
import gamesim.rendering
import gg
import gx
import math.fractions

[heap]
struct MainState {
mut:
	sim        gamesim.GameSimulation
	ctx        &gg.Context = unsafe { nil }
	old_flap   bool
	dead       bool = true
	col_rend   rendering.Renderer
	score_rend rendering.Renderer
}

fn main() {
	mut state := &MainState{
		sim: gamesim.new_sim()
	}
	state.ctx = gg.new_context(
		bg_color: gx.rgb(174, 198, 255)
		create_window: true
		width: gamesim.width
		height: gamesim.height
		window_title: 'V FlappyBird'
		// font_path: 'assets/SquaresBold.otff'
		frame_fn: frame
		user_data: state
	)
	state.col_rend = rendering.new_collider_renderer(state.ctx)
	state.score_rend = rendering.new_score_renderer(state.ctx)
	state.ctx.run()
}

fn frame(mut state MainState) {
	state.ctx.begin()

	// equal to space being pressed
	flap_key := state.ctx.pressed_keys[' '[0]]
	// equal to space just being pressed
	flap := flap_key && !state.old_flap
	state.old_flap = flap_key

	// no matter what end drawing at end
	defer {
		state.ctx.end()
	}

	// render game
	state.col_rend.render(state.sim)
	state.score_rend.render(state.sim)

	// paused when dead
	if state.dead {
		if flap {
			state.sim = gamesim.new_sim()
			state.dead = false
		} else {
			return
		}
	}

	println('score: ${state.sim.score}')

	// returns true if died
	state.dead = state.sim.update(flap)
}
