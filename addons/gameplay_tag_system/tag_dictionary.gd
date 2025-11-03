@tool
class_name TagDictionary
extends Resource

const TAG_ALAIS := &"tag"

#func _get_property_list() -> Array[Dictionary]:
#	var ret :Array[Dictionary] = [
#	{
#		 name = TAG_ALAIS,
#		 type = TYPE_STRING_NAME,
#		 hint = PROPERTY_HINT_NONE,
#		 hint_string = "TagEdit",
#		 usage = PROPERTY_USAGE_EDITOR,
#	}, 
#	]
#	return ret

@export var tags : Dictionary = {}
