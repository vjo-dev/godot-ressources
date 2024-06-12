extends Camera2D

@onready var view_size = get_viewport_rect().size
var zoom_z_speed : float = 0.05
var zoom_xy_speed : float = 25
var zoom_min : float = 1
var zoom_max : float = 2.0
var drag_speed : float = 1
var pan_margin : int = 150


func _ready():
	pass


func _input(event : InputEvent) -> void:
	# panning
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		self.position -= event.relative * drag_speed / zoom
	# zooming
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and zoom < Vector2.ONE * zoom_max:
			camera_zoom(true, get_viewport().get_mouse_position())
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and zoom > Vector2.ONE * zoom_min:
			camera_zoom(false, position)


func camera_zoom(dir : bool, pos : Vector2) -> void:
	if dir:
		zoom += Vector2.ONE * zoom_z_speed
		zoom = clamp(zoom, Vector2.ONE * zoom_min, Vector2.ONE * zoom_max)
		self.position = position.move_toward(pos - view_size / 2, zoom_xy_speed / zoom.x)
	else:
		zoom -= Vector2.ONE * zoom_z_speed
		zoom = clamp(zoom, Vector2.ONE * zoom_min, Vector2.ONE * zoom_max)
		self.position = position


func _set(property, value) -> bool:
	if property == "position":
		var delta = view_size - view_size / zoom
		var dx = int(delta.x / 2)
		var dy = int(delta.y / 2)
		position.x = clamp(value.x, -dx, dx)
		position.y = clamp(value.y, -dy, dy)
	return true
