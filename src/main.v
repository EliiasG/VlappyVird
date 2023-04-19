module main

import gamesim
import gamesim.rendering
import gg
import gx

[heap]
struct MainState {
mut:
	sim      gamesim.GameSimulation
	ctx      &gg.Context = unsafe { nil }
	old_flap bool
	dead     bool = true
	rend     rendering.Renderer
}

fn main() {
	mut state := &MainState{
		sim: gamesim.new_sim()
	}
	state.ctx = gg.new_context(
		bg_color: gx.rgb(174, 198, 255)
		width: gamesim.width
		height: gamesim.height
		window_title: 'Set Pixels'
		frame_fn: frame
		user_data: state
	)
	state.rend = rendering.new_collider_renderer(state.ctx)
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
	state.rend.render(state.sim)

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
