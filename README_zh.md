# godot_gameplay_tag_system

### 简述

* 参照某幻引擎的GameplayTag系统。搭配GAS（game ability system）系统使用或者当做简单玩法的辅助。
* **注意：项目仍在开发阶段，后续可能会有重大变更**

### 项目目的

* 实现一个类似某幻引擎的GameplayTag系统，方便实现后续依赖tag系统的其他gameplay系统

### 安装

* 直接将addons目录下文件复制到你的工程addons目录下即可使用

### 使用

* TODO

### 已知缺陷和后续需要更新的功能

* 总Tag的编辑器目前是直接用内置的Dictionary类型来编辑的，后续最好可以直接使用自定义的树编辑器来实现（但是Godot对自定义TreeItem的支持度比较低）
* 单个Tag的编辑可以使用编辑器来选取，使用插件的Tag资源类可以，也可以指定StringName或String类型的数据+自定义导出属性实现。但是Tag**数组**的编辑器不太好写，暂定使用Resource资源封装一下字符串来实现Tag数组功能，但其实需要更轻量的数据结构。
* 总Tags的资源保存在插件内部，或许考虑有更优美的方式来存储。
* 总Tag更新之后没有办法更新现有的其他Tag
