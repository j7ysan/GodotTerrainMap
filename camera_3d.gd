extends Camera3D

@onready var marker = get_parent()

var can_move = true
var zoom_increment = 10
var des_position = position

func _physics_process(delta):
	position = lerp(position, des_position, 25 * delta)

func _input(event):
	if (can_move):
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					des_position = position * 1.2
					increment_change()
				if event.button_index == MOUSE_BUTTON_WHEEL_UP:
					des_position = position * 0.825
					increment_change()
		if event is InputEventMouseMotion:
			if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
				marker.rotation.y -= event.relative.x/250
				marker.rotation.z += event.relative.y/250

func increment_change():
	zoom_increment = 10
