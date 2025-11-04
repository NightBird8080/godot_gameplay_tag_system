## Custom property editor for tag 
@tool
class_name EditPropertySingleTag
extends EditorProperty


var _tag_button := Button.new()

var _selector: Window



func _init() -> void:
	pass


func setup(selector: Window ) -> void:
	_selector = selector
	_init_button()

	
func _init_button()->void:
	var hbox := HBoxContainer.new()
	hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	add_child(hbox)

	_tag_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_tag_button.text_overrun_behavior = TextServer.OVERRUN_TRIM_CHAR
	_tag_button.pressed.connect(_on_tag_button_pressed)
	hbox.add_child(_tag_button)

	var clear_btn := Button.new()
	clear_btn.icon = EditorInterface.get_base_control().get_theme_icon("clear", &"LineEdit")
	clear_btn.tooltip_text = "Clear"
	clear_btn.pressed.connect(_on_clear_btn_pressed)
	hbox.add_child(clear_btn)

func _set_read_only(read_only: bool) -> void:
	_tag_button.disabled = read_only


func _update_property() -> void:
	var obj := get_edited_object()
	var prop := get_edited_property()
	var v := obj.get(prop)
	
	_tag_button.text = v
	_tag_button.tooltip_text = "Tag: " + _tag_button.text



func _on_tag_button_pressed() -> void:
	var obj := get_edited_object()
	var prop := get_edited_property()
	var v := obj.get(prop)

	if typeof(v) in [TYPE_STRING, TYPE_STRING_NAME]:
		_selector.setup( v )
	else:
		assert(false)
		return

	var result := await _selector.selected as Array
	var selected := result[0] as StringName
	var confirm := result[1] as bool

	if confirm:
		emit_changed(prop, selected)


func _on_clear_btn_pressed() -> void:
	var obj := get_edited_object()
	var prop := get_edited_property()
	var v := obj.get(prop)

	emit_changed(prop, &"")
		
