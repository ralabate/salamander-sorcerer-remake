extends CharacterBody3D


const SPEED = 2.5

@onready var visual: MeshInstance3D = %Visual
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sword_area: Area3D = %SwordArea


func _ready() -> void:
	sword_area.body_entered.connect(_on_body_entered_sword_area)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		animation_player.play("swipe")

	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and animation_player.current_animation != "swipe":
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	if direction:
		visual.look_at(visual.global_position + direction, Vector3.UP)

	move_and_slide()


func _on_body_entered_sword_area(body: Node3D) -> void:
	if not body.is_in_group("badguys"):
		return

	var rigid_body = body as RigidBody3D
	rigid_body.apply_impulse(body.transform.basis.z * 10.0)
