extends CharacterBody2D


@export var SPEED = 300.0
const JUMP_VELOCITY = -400.0


#ONREADY
@onready var animation_player: AnimationPlayer = $PARAMETER/ANIMATION/AnimationPlayer
@onready var knight: Sprite2D = $Knight
@onready var point_light_2d: PointLight2D = $PointLight2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation(direction)
	move_and_slide()

func update_animation(dir):
	if dir == 0:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	if dir == -1 :
		knight.flip_h = true
	if dir == 1 :
		knight.flip_h = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("torch"):
		point_light_2d.visible = !point_light_2d.visible