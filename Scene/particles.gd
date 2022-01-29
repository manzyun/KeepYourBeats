extends Node2D

func explosion():
	$CPUParticles2D.emitting = true
	$CPUParticles2D/CPUParticles2D.emitting = true
