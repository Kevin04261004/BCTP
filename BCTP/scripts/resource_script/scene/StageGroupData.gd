# StageGroupData.gd
extends Resource
class_name StageGroupData

@export var normal_stages: Array[PackedScene]
@export var boss_stage: PackedScene

# 최소 진행해야 하는 일반 스테이지 수
@export var required_stage_count: int = 2
