# CharacterManager.gd
extends Singleton
class_name CharacterManager

@export var entities: Node
@export var player_controller: PlayerController
@export var camera_controller: CameraController
@export var playable_characters: Array[PackedScene]

var current_character: Character

func _ready():
	super()
	spawn_default_character()

func spawn_default_character():
	assert(
		playable_characters.size() > 0,
		"[CharacterManager] No playable characters."
	)

	change_character(0)

func change_character(index: int):
	if index < 0:
		return

	if index >= playable_characters.size():
		return

	if current_character != null:
		current_character.queue_free()

	var character_scene: PackedScene = (playable_characters[index])
	var character: Character = (character_scene.instantiate())

	entities.add_child(character)
	current_character = character
	player_controller.possess(character)
	camera_controller.follow(character)

func get_player() -> Character:
	return current_character
