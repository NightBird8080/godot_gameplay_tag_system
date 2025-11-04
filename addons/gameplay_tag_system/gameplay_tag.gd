
## Tag class, contains some basic functions for Tag, such as comparison,partial matching, full matching, etc.\
## It has both static functions and object functions. \
## The essence of the Tag class is a StringName, because Godot has poor support for structure, so resources are used instead.
## Or you can just use the StringName or String as tag export with [@export_custom(PROPERTY_HINT_NONE, "Tag")], and define StringName style func set.
class_name GameplayTag
extends Resource

const TAG_NAME: String = "Tag"
## Tag actual value.
@export_custom(PROPERTY_HINT_NONE, "Tag") 
var value :StringName = &""

func _get_property_list() -> Array[Dictionary]:
	return [
		{
			"name": TAG_NAME,
			"type": TYPE_STRING_NAME,
			"usage": PROPERTY_USAGE_EDITOR | PROPERTY_USAGE_STORAGE,
			"hint": PROPERTY_HINT_NONE,
			"hint_string " : "GameplayTag"
		},
	]

## [tag] is a substring of [tag_to_match]
func partial_match(tag_to_match : GameplayTag) -> bool:
	return partial_match_by_string_name(value, tag_to_match.value)
	
## [tag] equals [tag_to_compare]
func full_match(tag_to_match : GameplayTag) -> bool:
	return full_match_by_string_name(value, tag_to_match.value)


## [tag] is a substring of [tag_to_match]
static func partial_match_by_tag( tag :GameplayTag, tag_to_match : GameplayTag)->bool:
	return partial_match_by_string_name(tag.value, tag_to_match.value)


## [tag] equals [tag_to_compare]
static func full_match_by_tag(tag : GameplayTag, tag_to_compare:GameplayTag)->bool:
	return full_match_by_string_name(tag.value, tag_to_compare.value)
	
## [tag] equals [tag_to_compare], same as [partial_match_by_tag]
static func equals(tag : GameplayTag, tag_to_compare:GameplayTag)->bool:
	return tag.value == tag_to_compare.value
	
## [tag] is a substring of [tag_to_match]
static func partial_match_by_string_name( tag:StringName, tag_to_match:StringName)->bool:
	## 如果tag_to_match的长度小于tag的长度，则匹配失败
	if tag_to_match.length() < tag.length():
		return false

	## 如果两个标签完全相同，则匹配成功
	if tag == tag_to_match:
		return true

	var tag_to_match_string : String = tag_to_match

	## 如果tag是tag_to_match的前缀，并且下一个字符是'.'，则匹配成功
	if tag_to_match.begins_with(tag) and tag_to_match.length() > tag.length() and tag_to_match_string[tag.length()] == '.':
		return true
	
	return false

## [tag] equals [tag_to_compare]
static func full_match_by_string_name(tag:StringName, tag_to_compare:StringName)->bool:
	return tag == tag_to_compare
