extends Area3D
class_name Badguy


signal died


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("player_weapons"):
		died.emit()
		queue_free()
