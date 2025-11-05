# godot_gameplay_tag_system

#### [点击此处查看中文文档](./README_zh.md )

### Brief

- This project is inspired by the GameplayTag system from XE engine. It can be used alongside a GAS (Game Ability System) or serve as an aid for simpler gameplay mechanics.

- **Note: The project is still in development, and there may be significant changes in the future.**

- This project is implemented based on [Daylily-Zeleen/Godot-DTag: A simple tag mechanism like GameplayTag in UE.](https://github.com/Daylily-Zeleen/Godot-DTag). Following the MIT License, I have adapted the original project to better suit our specific use cases. I also extend my sincere thanks to [Daylily-Zeleen (忘忧の)](https://github.com/Daylily-Zeleen) for their foundational work.The License of the original project is at the end of the document.

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

### License of the original project

MIT License

Copyright (c) 2025 忘忧の

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
