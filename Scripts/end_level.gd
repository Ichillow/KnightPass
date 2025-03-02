extends Area2D


@export var scene : String
@export var hide_sprite : bool = false
@export var Amount_coin_need : int = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ui: CanvasLayer = $UI

func _ready():
	if !hide_sprite:
		animated_sprite_2d.visible = true
		animated_sprite_2d.play("idle")




func _on_body_entered(body:Node2D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file(scene)
