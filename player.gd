extends CharacterBody2D
class_name Player

var sprite_down: CompressedTexture2D = load("res://arcar-front.png")
var sprite_up: CompressedTexture2D = load("res://arcar-back.png")
var sprite_left: CompressedTexture2D = load("res://arcar_left.png")
var sprite_right: CompressedTexture2D = load("res://arcar_right.png")
var sprite_left_down: CompressedTexture2D = load("res://arcar_left_down.png")
var sprite_left_up: CompressedTexture2D = load("res://arcar_left_up.png")
var sprite_right_down: CompressedTexture2D = load("res://arcar_right_down.png")
var sprite_right_up: CompressedTexture2D = load("res://arcar_right_up.png")

var SPEED: int = 200

# Player Input Stream - Movement
func _process(delta: float) -> void:
	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down")).normalized()
	velocity = direction * SPEED
	
	# Handle frames of the arcar sprite directionally
	if velocity.x < 0 and velocity.y > 0:
		$Sprite2D.texture = sprite_left_down
	elif velocity.x < 0 and velocity.y < 0:
		$Sprite2D.texture = sprite_left_up
	elif velocity.x > 0 and velocity.y > 0:
		$Sprite2D.texture = sprite_right_down
	elif velocity.x > 0 and velocity.y < 0:
		$Sprite2D.texture = sprite_right_up
	elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
		$Sprite2D.texture = sprite_left
	elif velocity.x > 0 and abs(velocity.x) > abs(velocity.y):
		$Sprite2D.texture = sprite_right
	elif velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
		$Sprite2D.texture = sprite_up
	elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
		$Sprite2D.texture = sprite_down
	
	move_and_slide()
