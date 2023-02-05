extends KinematicBody2D
class_name PongPlayer

var jump_height = 600.0
var speed: float = 400
export(int) var facing = 1

export(bool) var player_control = true

var velocity: Vector2

func _process(delta):
	if player_control:
		var move = Input.get_axis("move_left","move_right")
		var jump = Input.is_action_just_pressed("jump")
		velocity.x = move*speed
		if jump and is_on_floor():
			velocity.y -= jump_height
	else:
		var ball = Global.ball
		if ball:
			if ball.position.x + ball.velocity.x * 0.1 > position.x:
				velocity.x = speed
			else:
				velocity.x = -speed
			if abs(ball.position.y - position.y) < 300 and is_on_floor() and ball.position.x > 512:
				velocity.y -= jump_height 
	velocity.y += 1000*delta
	velocity = move_and_slide(velocity,Vector2.UP)
