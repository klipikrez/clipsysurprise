extends KinematicBody2D
class_name PongBall

var velocity: Vector2
var timer: float = 0.0
var default_gravity: float = 600
var gravity: float = default_gravity
var gravity_increment: float = 150.0
var bounces: int = 0

func _ready():
	velocity.x = (randi()%2*2-1)*250
	velocity.y = -40
	Global.ball = self
	
func _process(delta):
	timer -= delta
	velocity.y += gravity*delta
	move_and_slide(velocity, Vector2.UP)
	if timer < 0.0:
		for slide in range(get_slide_count()):
			var collision = get_slide_collision(slide)
			var collider = collision.collider
			if collider is PongPlayer:
				timer = 0.1
				bounces += 1
				print("da")
				velocity.x = collider.facing*(250+0.416*gravity_increment*bounces)+randf()*200-100
				velocity.y = -600
				gravity += gravity_increment
				break
