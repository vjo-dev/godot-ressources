extends Node2D

# https://www.youtube.com/watch?v=uhgswVkYp0o

var draggable : bool = false
var is_inside_dropable : bool = false
var body_ref : StaticBody2D
var offset : Vector2
var initialPos : Vector2


func _ready():
	pass


func _process(delta):
	if draggable:
		if Input.is_action_just_pressed("click"):
			initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Global.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			Global.is_dragging = false
			var tween = get_tree().create_tween()
			if is_inside_dropable:
				tween.tween_property(self, "position", body_ref.position, 0.2).set_ease(Tween.EASE_OUT)
				rotation = body_ref.rotation
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)


func _on_area_2d_mouse_entered() -> void:
	if not Global.is_dragging:  # make sure not currently dragging something
		draggable = true
		scale = Vector2.ONE * 1.05


func _on_area_2d_mouse_exited() -> void:
	if not Global.is_dragging:  # make sure not currently dragging something
		draggable = false
		scale = Vector2.ONE * 1.0


func _on_area_2d_body_entered(body : StaticBody2D) -> void:
	if body.is_in_group("droppable"):
		is_inside_dropable = true
		body.modulate = Color(Color.DARK_BLUE, 1)
		body_ref = body


func _on_area_2d_body_exited(body : StaticBody2D) -> void:
	if body.is_in_group("droppable"):
		is_inside_dropable = false
		body.modulate = Color(Color.BLUE, 0.7)
