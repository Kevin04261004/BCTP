# World.gd
extends Node2D
class_name WorldLoader

@export var stage_groups: Array[StageGroupData]

var current_stage: Node

var current_group_index: int = 0
var current_normal_index: int = 0

var shuffled_normal_stages: Array[PackedScene]

func _ready():
	start_group()

# TODO: 제거.
func _unhandled_input(event):
	# 디버그용
	if event.is_action_pressed("ui_debug_next_stage"):
		load_next_stage()

func start_group():

	if current_group_index >= stage_groups.size():
		game_clear()
		return

	var group := stage_groups[current_group_index]

	shuffled_normal_stages = group.normal_stages.duplicate()
	shuffled_normal_stages.shuffle()

	current_normal_index = 0

	load_next_stage()

func load_next_stage():

	if current_group_index >= stage_groups.size():
		game_clear()
		return

	var group := stage_groups[current_group_index]

	var playable_stage_count = min(group.required_stage_count, shuffled_normal_stages.size())

	# 일반 스테이지 진행
	if current_normal_index < playable_stage_count:

		var stage_scene := shuffled_normal_stages[current_normal_index]

		current_normal_index += 1

		load_stage(stage_scene)
		return

	# 보스 스테이지 존재 시 진행
	if group.boss_stage != null:

		# 아직 보스를 안 갔을 때
		if current_normal_index == playable_stage_count:

			current_normal_index += 1

			load_stage(group.boss_stage)
			return

	# 다음 그룹 이동
	current_group_index += 1

	start_group()

func load_stage(stage_scene: PackedScene):

	assert(stage_scene != null,
		"[World] stage_scene is null.")

	if current_stage != null:
		current_stage.queue_free()

	current_stage = stage_scene.instantiate()

	add_child(current_stage)

func game_clear():
	print("GAME CLEAR")
