extends Node
class_name PlayerController

var controlled_character: Character

func possess(character: Character):
	assert(character != null, "[PlayerController] character is null.")
	controlled_character = character
