# ING...: 플레이어 프로토타입 제작
# TODO: 이동 및 애니메이션 제작
# TODO: 공격 만들기
# TODO: 체력 만들기
# TODO: 피격 만들기
# TODO: 죽음 만들기
# TODO: 카메라 만들기

# NEXT: 몬스터 AI 만들기
# TODO: AI제작
# TODO: 공격 만들기
# TODO: 체력 만들기
# TODO: 피격 만들기
# TODO: 죽음 만들기
# NEXT: 플레이어 및 몬스터 리펙토링 진행하기

extends CharacterBody2D

@onready var animations : AnimatedSprite2D = $AnimatedSprite2D;
@onready var attackArea : Area2D = $AttackArea;


@export var speed : float = 100;
@export var jumpVelocity : float = 400;

@export var walkAnimationSpeed : float = 50;
@export var CanMoveOnAir : bool = true;


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");

var dir : float = 0;
var isJump : bool = false;
var isAttack01 : bool = false;

func _physics_process(delta: float) -> void:
	apply_gravity(delta);
	handle_input();
	move();
	update_animation();
	move_and_slide();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_jump"):
		jump();
	if event.is_action_pressed("ui_attack"):
		attack();

func handle_input() -> void:
	dir = Input.get_axis("ui_left", "ui_right");

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta;
	elif isJump and is_on_floor() and velocity.y >= 0:
		isJump = false;
		animations.play("jump_end");

func move() -> void:
	if not CanMoveOnAir and isJump:
		return;
	if isAttack01:
		return;
	velocity.x = dir * speed;

# this func will call by input event;
func jump() -> void:
	if is_on_floor() and not isAttack01:
		velocity.y = -jumpVelocity;
		animations.play("jump_start");
		isJump = true;

func attack() -> void:
	if not isAttack01 and not isJump:
		animations.play("attack01");
		velocity.x = 0;
		isAttack01 = true;
		overlapAttackCollision();

func overlapAttackCollision() -> void:
	var areas = attackArea.get_overlapping_areas();
	
	for area in areas:
		var parentObj = area.get_parent();
		# 인터페이스 여부 판단 IDamaga
		print(parentObj.name);


func update_animation() -> void:
	if isJump:
		# jump_start가 끝났는지 확인 (프레임 기반)
		if animations.animation == "jump_start" and animations.frame >= animations.sprite_frames.get_frame_count("jump_start") - 1:
			animations.play("on_air")
		return
	
	if isAttack01:
		if animations.animation == "attack01" and animations.frame >= animations.sprite_frames.get_frame_count("attack01") - 1:
			isAttack01 = false;
		return
	
	if velocity.x == 0:
		animations.play("idle");
		return;
	
	# 좌우 반전
	animations.scale.x = sign(velocity.x);
	# 애니메이션 속도 조절
	animations.speed_scale = abs(velocity.x) / walkAnimationSpeed;
	animations.play("walk");
