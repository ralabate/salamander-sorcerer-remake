extends Area3D
class_name Badguy


signal died

var hitpoints = 5

@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("player_weapons"):
		animation_player.play("hit")
		hitpoints -= 1
		if hitpoints <= 0:
			await animation_player.animation_finished
			died.emit()
			queue_free()
