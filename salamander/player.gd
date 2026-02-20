extends CharacterBody3D


@export var speed = 2.5
@export var push_back = 0.75

@onready var mando = %Mando
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sword_area: Area3D = %SwordArea


func _physics_process(_delta: float) -> void:
	if animation_player.current_animation == "swipe":
		velocity = -mando.transform.basis.z * push_back
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
		mando.look_at(mando.global_position - direction, Vector3.UP)
		#visual.look_at(visual.global_position + direction, Vector3.UP)

	if Input.is_action_just_pressed("ui_accept"):
		mando.is_attacking = true
		animation_player.play("swipe")
	else:
		mando.is_attacking = false

	move_and_slide()
