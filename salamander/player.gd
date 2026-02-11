extends CharacterBody3D


const SPEED = 2.5

@onready var visual: MeshInstance3D = %Visual
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		animation_player.play("swipe")

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	if direction:
		visual.look_at(visual.global_position + direction, Vector3.UP)

	move_and_slide()
