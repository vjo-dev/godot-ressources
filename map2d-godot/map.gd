extends Sprite2D


func _ready():
	var map_size = texture.get_size()
	var viewport_size = get_viewport_rect().size
	scale = Vector2.ONE * min(viewport_size.x / map_size.x, viewport_size.y / map_size.y)
	position = Vector2.ZERO
