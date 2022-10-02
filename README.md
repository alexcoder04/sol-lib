
# Sol

GUI application framework for the TI-nspire.

[Here](https://github.com/alexcoder04/sol-helloworld) you can find an example application.

## Why

Building GUI applications for TI-nspire using the stock Lua library from TI
is a pain, this is an attempt to make it easier and more comfortable.

## Your project structure

Your code has to be organized, no "throwing everything into one Lua file" anymore!
All the parts are then assembled and built into one `.tns` file by Sol.

 - `res` contains any non-code resources, e. g. images and data.
 - `res/data/menu.yml` is a native nspireOS-menu, written in YAML
 - `components` are re-usable blocks of your GUI which can inherit from base components, written in a custom YAML-based language
 - `init.lua` runs at start
 - `app.lua` is just metadata
 - `layout.lua` defines which components are included and in which order

```text
 |
 |-res
 | |-img
 | | |-...
 | |-data
 | | |-menu.yml
 | | |-...
 |-components
 | |-header.yml
 | |-text.yml
 | |-...
 |-init.lua
 |-app.lua
 |-layout.lua
```

## Roadmap / TODOs

 - [ ] more base components (input field, list, sublayouts, tabs)
 - [x] colorful components
 - [x] click events
 - [ ] component focus (tabbing, highlighting selected)
 - [x] menu api
 - [ ] about dialog using data from `app.lua`
 - [ ] handling images
 - [ ] handling JSON/YAML data in `res/data`
 - [x] paint hook, use raw `gc` functions
 - [x] persistent data storage
 - [ ] game canvas component using nspire physics api
 - [ ] compile-time optimization, deleting unused/empty functions and their calls
 - [ ] message box components imitating nspireOS's UI
 - [ ] 2D-editor component using nspire's built-in editor

## Naming

*Lua* (portuguese for "moon") -> *Sol* (portuguese for "sun")
