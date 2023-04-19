module gamesim

import bird
import pipe
import collision
import rand

pub const (
	width          = u16(800)
	height         = u16(400)
	pipe_distance  = u16(500)
	pipe_variation = f32(200)
	pipe_amount    = width / pipe_distance + 1
	pipe_reset_x   = pipe_amount * pipe_distance
)

[noinit]
pub struct GameSimulation {
pub mut:
	bird  bird.Bird
	pipes []pipe.Pipe
	score u64
}

pub fn (mut s GameSimulation) update(flap bool) bool {
	s.bird.update()

	for mut p in s.pipes {
		p.update()
		// is within point range
		if p.x >= bird.x_offset && p.x < bird.x_offset + pipe.speed {
			s.score++
		}

		// death checks
		bird_col := s.bird.get_collider()
		if collision.colliding(bird_col, p.get_top_collider()) {
			return true
		}
		if collision.colliding(bird_col, p.get_bottom_collider()) {
			return true
		}

		// reset pipe
		if p.x < -pipe.width {
			p.x = gamesim.pipe_reset_x
			p.y = random_height()
		}
	}
	if flap {
		s.bird.flap()
	}

	return false
}

pub fn new_sim() GameSimulation {
	return GameSimulation{
		bird: bird.Bird{
			y: gamesim.height / 2
		}
		pipes: []pipe.Pipe{len: int(gamesim.pipe_amount), init: pipe.Pipe{
			x: gamesim.pipe_reset_x - index * gamesim.pipe_distance + gamesim.width / 2
			y: random_height()
		}}
		score: 0
	}
}

pub fn random_height() f32 {
	return rand.f32_in_range(gamesim.height / 2 - gamesim.pipe_variation / 2, gamesim.height / 2 +
		gamesim.pipe_variation / 2) or { 0 }
}
