extends CharacterBody3D


@export var speed = 2.5
@export var push_back = 0.75

@onready var visual: MeshInstance3D = %Visual
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sword_area: Area3D = %SwordArea


func _physics_process(_delta: float) -> void:
	if animation_player.current_animation == "swipe":
		velocity = visual.transform.basis.z * push_back
		move_and_slide()
		return

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	if direction:
		visual.look_at(visual.global_position + direction, Vector3.UP)

	if Input.is_action_just_pressed("ui_accept"):
		animation_player.play("swipe")

	move_and_slide()
