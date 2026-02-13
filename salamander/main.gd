extends Node3D


@export var death_particles: PackedScene


func _ready() -> void:
	for child in get_tree().get_nodes_in_group("badguys"):
		var badguy = child as Badguy
		badguy.died.connect(_on_badguy_died.bind(badguy))


func _on_badguy_died(badguy: Badguy) -> void:
	var vfx = death_particles.instantiate() as GPUParticles3D
	add_child(vfx)
	vfx.one_shot = true
	vfx.emitting = true
	vfx.position = badguy.position
