extends CharacterBody2D


@export var speed : float = 200;
@onready var animations : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	handle_input();
	update_animation();
	move_and_slide();


func handle_input() -> void:
	var dir = Input.get_axis("ui_left", "ui_right");
	velocity.x = dir * speed

func update_animation() -> void:
	if velocity.x == 0:
		animations.play("idle");
		return;
	
	animations.scale.x = sign(velocity.x);
	animations.play("walk");
