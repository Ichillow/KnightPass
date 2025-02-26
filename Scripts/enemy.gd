extends CharacterBody2D


@export var max_speed = 3000
@export var normal_speed = 2000
var current_speed : float

var direction = 1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var body: Sprite2D = $body
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var ray_cast_2d : RayCast2D = $RayCast2D

@export var special = false
@export var special_color : Color




func _ready():
	animation_player.play("walk")
	current_speed = normal_speed
	if special:
		current_speed = max_speed
		body.modulate = special_color

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * current_speed * delta
	set_direction()
	move_and_slide()


func set_direction():
	if is_instance_valid(ray_cast_2d.get_collider()):
		var collide = ray_cast_2d.get_collider()
		if collide.is_in_group("tilemap") :
			if direction == 1:
				direction = -1
				ray_cast_2d.target_position = Vector2(-10, 0)
				body.flip_h = true
			else :
				direction = 1
				ray_cast_2d.target_position = Vector2(10, 0)
				body.flip_h = false


func _on_kill_player_body_entered(other_body):
	if other_body.name == "player":
		call_deferred("reload_scene")


func reload_scene():
	get_tree().reload_current_scene()


func _on_kill_enemy_body_entered(_body:Node2D) :
	if _body.name == "player" :
		animation_player.play("death")
		# _body.call_deferred("add_coin")
		# _body.call_deferred("add_score", 10)


func _on_animation_player_animation_finished(anim_name:StringName):
	if anim_name == "death":
		queue_free()