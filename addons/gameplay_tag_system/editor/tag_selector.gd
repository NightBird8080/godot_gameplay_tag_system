## Selector of tag
@tool
class_name TagSelector
extends ConfirmationDialog

signal selected(tag :StringName, confirm: bool)

@export_group("_internal_", "_")
@export var _tree: Tree
@export var _selected_label: Label
@export var _search_line_edit: LineEdit



var _tags : Dictionary = {}
var _tree_items :Dictionary[String,TreeItem]

var _selected : StringName =&"":
	set(value):
		_selected = value
		_selected_label.text = _selected
		get_ok_button().disabled = _selected.is_empty()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	confirmed.connect(_on_confirmed)
	_search_line_edit.text_changed.connect(_on_search_text_changed)
	_tree.item_activated.connect(_on_tree_item_activated)
	_tree.item_selected.connect(_on_tree_item_selected)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	

func setup(pre_value : String) -> void:
	## load tags resources
	if ResourceLoader.exists(GameplayTagSystem.TAGS_RESOURCE_PATH):
		var all_tags:TagDictionary = ResourceLoader.load(GameplayTagSystem.TAGS_RESOURCE_PATH)
		if all_tags == null:
			push_warning("TagSelector: setup: Tags resource not found.")
		else:
			_tags = all_tags.tags
		
	# TODO maybe build tree just after tags modified
	
	_tree_items.clear()
	_tree.clear()
	
	var root : TreeItem = _tree.create_item()
	root.set_text(0, "")
	root.set_metadata(0, "")
	root.set_tooltip_text(0, "")

	## recursively add tree node
	_add_tree_node_recursively(root, _tags)

	_selected = pre_value
	if _tree_items.get(pre_value) != null:
		# default one column
		_tree.set_selected(_tree_items[pre_value],0)
	
	_on_search_text_changed(_search_line_edit.text)
	popup_centered_ratio(0.6)
	pass
	
	
func _add_tree_node_recursively(parent : TreeItem , tags : Dictionary , full_tag : String = "") -> void :
	
	for key in tags.keys():
		var this_key_full_tag : String = full_tag
		if not key is  String:
			
			continue
		
		## 顶层Tag前不需要添加 "."
		## TOP Tag do not need add "."
		if this_key_full_tag == "":
			this_key_full_tag = key
		else:
			this_key_full_tag += "." + key
		
		## 对叶子节点进行操作
		var non_leaf_node : TreeItem = parent.create_child()
		non_leaf_node.set_text(0, key)
		non_leaf_node.set_metadata(0, this_key_full_tag)

		_tree_items[this_key_full_tag] = non_leaf_node
		## item.set_tooltip_text(0, tag)
		
		## 对非叶子节点进行递归
		if tags[key] is Dictionary:
			_add_tree_node_recursively(non_leaf_node, tags[key],this_key_full_tag)

		## process value == null, it not recommend
		# if tags[key] is Dictionary:
		elif tags[key] == null:

			continue
				
		## process value is string, the value is leaf
		# if tags[key] is Dictionary:
		# elif tags[key] == null:
		elif tags[key] is String:
			var leaf_node : TreeItem = non_leaf_node.create_child()
			leaf_node.set_text(0, tags[key])
			var leaf_tag : String = this_key_full_tag + "." + tags[key]
			leaf_node.set_metadata(0, leaf_tag)
			#_tree_items.push_back(leaf_node)
			_tree_items[leaf_tag] = leaf_node
			continue
	return

func _on_confirmed() -> void:
	if not _selected.is_empty():
		selected.emit(_selected, true)
		hide()

func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED:
		if not visible:
			selected.emit(&"", false)	
	
func _on_search_text_changed(search_text: String) -> void:
	for item in _tree_items.values():
		var tag : StringName= item.get_metadata(0) as StringName
		var visiblity : bool = false
		if search_text.is_empty() :
			visiblity = visiblity || true
		if tag.contains(search_text):
			visiblity = visiblity || true
		
		item.visible = visiblity
	return


func _on_tree_item_activated() -> void:
	var selected_item := _tree.get_selected()
	if not is_instance_valid(selected_item) or not selected_item.is_selectable(0):
		return
	selected.emit(_selected, true)
	hide()


func _on_tree_item_selected() -> void:
	_selected = _tree.get_selected().get_metadata(0) 
