## Resource store all tags
@tool
class_name TagDictionary
extends Resource


## switch of push warning
var _allow_push_warning : bool = true

""" 
	# Use dictionary(as tree) to edit all tags.
	# Keys must be string, the value is string or null or child level dictionary(mean leaf_node, leaf_node , internal_node)
	# Because the value can set string or null , tag tree has two style.
	# Recommend use style 1 , because the structure is more clear( the value is null mean this key is leaf tag)
	# Every time you modify the tags, will check tags, and push warning if has something wrong, \
	# you can set [_allow_push_warning] to ban pushing warning
	# <---------------------------------CUTLINE------------------------------------>
	# Tag tree style 1 example:
	## -tags = {
	## 		"TopLevel0" : {
	##				"SecondLevel0" : {
	##									"ThirdLevel0": null,
	##									"ThirdLevel1": null,
	##								}
	##				"SecondLevel1" : null ,			
	##								
	##				},
	##		"TopLevel1" : null								
	## }									
	##	
	# The logic tag tree
	## -root
	## |-TopLevel0
	## ||-SecondLevel0
	## |||-ThirdLevel0
	## |||-ThirdLevel2
	## ||-SecondLevel1
	## |-TopLevel1
	
	## TODO
"""

## TODO : use custom editor to modify all the tags. 
## Because the godot tree is not good enough to custom item style so I use build_in dictionary to replace it

@export var tags : Dictionary = {}:
	set(new_tags):
		_on_tag_changed(new_tags)
		tags = new_tags
		pass


func _on_tag_changed( new_tags : Dictionary) -> void:
	_check_tags_recursively(new_tags,"")
	pass


func _check_tags_recursively(tag_dictionary : Dictionary , full_tag : String) -> void:
	for key in tag_dictionary.keys():
		var this_key_full_tag : String = full_tag
		
		## check if string
		if not key is  String:
			_push_warning("TagDictionary: _check_tags_recursively: Tag[%s] is not String."% key )
			continue

		## TOP Tag do not need add "."
		if this_key_full_tag == "":
			this_key_full_tag = key
		else:
			this_key_full_tag += "." + key
		
		if tag_dictionary[key] is Dictionary:
			_check_tags_recursively(tag_dictionary[key],this_key_full_tag)
		
		# if tag_dictionary[key] is Dictionary:
		elif tag_dictionary[key] == null:
			continue

		## not recommend to set a value is string, but it is allowed
		# if tag_dictionary[key] is Dictionary:
		# elif tag_dictionary[key] == null:
		elif tag_dictionary[key] is String:
			_push_warning("TagDictionary: _check_tags_recursively: Tag[%s] value is not null or Dictionary. \n \
			Please check your tags settings. It is allow but not recommend "% this_key_full_tag)
			continue

		## invalid type
		# if tag_dictionary[key] is Dictionary:
		# elif tag_dictionary[key] == null:	
		# elif tag_dictionary[key] is String:
		else:
			_push_warning("TagDictionary: _check_tags_recursively: Tag[%s] value is invalid type. Please check"% this_key_full_tag)
			continue
	return 
	

func _push_warning(warning_message : String) -> void:
	if _allow_push_warning:
		push_warning(warning_message)
	return 
