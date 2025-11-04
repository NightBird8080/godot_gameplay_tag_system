@tool
class_name GameplayTagSystem
extends EditorPlugin

## Default tags resource path, tag_selector will use it
const TAGS_RESOURCE_PATH: StringName = "res://addons/gameplay_tag_system/all_tags.tres"

const TAG_SELECTOR_PATH :String = "editor/tag_selector.tscn"

const EDIT_SINGLE_TAG_PROPERTY_PATH: String = "editor/edit_property_single_tag.gd"



var _selector :Window
var _inspector_plugin : EditorInspectorPluginTag

class EditorInspectorPluginTag extends EditorInspectorPlugin:
	var _selector: Window
	func _init(selector: Window) -> void:
		_selector = selector

	func _can_handle(object) -> bool:
		return true

	func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: PropertyUsageFlags, wide: bool) -> bool:
		const TAG_EDIT_PREFIX :  String= "Tag"

		var select_tag : bool= hint_string.begins_with(TAG_EDIT_PREFIX)
		
		if !select_tag :
			return false
	
		match type:
			TYPE_STRING,TYPE_STRING_NAME:
				var prop_edit : EditPropertySingleTag = preload(EDIT_SINGLE_TAG_PROPERTY_PATH).new()
				prop_edit.setup(_selector)
				add_property_editor(name, prop_edit)
				return true
			_:
				return false

		return false



func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	_selector = preload(TAG_SELECTOR_PATH).instantiate()
	add_child(_selector)
	
	_inspector_plugin = EditorInspectorPluginTag.new(_selector)
	add_inspector_plugin(_inspector_plugin)

	pass


func _exit_tree() -> void:

	remove_inspector_plugin(_inspector_plugin)
	# Clean-up of the plugin goes here.
	pass
