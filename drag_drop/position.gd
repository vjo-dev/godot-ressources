extends StaticBody2D

# https://www.youtube.com/watch?v=uhgswVkYp0o

func _ready():
	modulate = Color(Color.BLUE, 0.7)


func _process(delta):
	if Global.is_dragging:
		visible = true
	else:
		visible = false
