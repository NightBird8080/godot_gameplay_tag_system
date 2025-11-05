# godot_gameplay_tag_system

#### [点击此处查看中文文档](./README_zh.md )

### Brief

- This project is inspired by the GameplayTag system from XE engine. It can be used alongside a GAS (Game Ability System) or serve as an aid for simpler gameplay mechanics.

- **Note: The project is still in development, and there may be significant changes in the future.**

### Project Purpose

- To implement a GameplayTag system similar to that of XE engine, facilitating the development of other gameplay systems that rely on a tag system.

### Installation

- Simply copy the files from the `addons` directory into your project's `addons` directory to start using the plugin.

### Usage

- TODO

### Known Issues and Planned Updates

- The editor for the master tag list currently uses the built-in Dictionary type for editing. It would be better to implement a custom tree editor in the future (though Godot has limited support for custom TreeItem implementation).

- Individual tags can be edited using the editor for selection. The plugin's Tag resource class can be used, or data of type StringName or String can be specified along with custom exported properties. However, the editor for tag **arrays** is challenging to implement. The current plan is to wrap the string in a Resource to enable tag array functionality, though a lighter-weight data structure would be preferable.

- The master Tags resource is stored within the plugin. A more elegant storage solution may be considered.

- Currently, there is no way to update other existing tags when the master tag list is modified.
