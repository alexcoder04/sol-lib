
# Sol

GUI application framework for the TI-nspire. This repository is the "home" of the project
and contains all the Lua library code.

[Here](https://alexcoder04.github.io/sol-docs/) you can find the docs.

[Here](https://github.com/alexcoder04/sol-helloworld) you can find an example application.

[These](https://github.com/alexcoder04/sol-tools) are the tools needed for developing applications with Sol.

## Why?

Building GUI applications for TI-nspire using the stock Lua library from TI
is a pain, this is an attempt to make it easier and more comfortable.

## Your project structure

Your code has to be organized, no "throwing everything into one Lua file" anymore!
All the parts are then assembled and built into one `.tns` file by [sol-tools](https://github.com/alexcoder04/sol-tools).

 - `res` contains any non-code resources, e. g. images and data.
 - `res/data/menu.yml` is a native nspireOS-menu, written in YAML
 - `components` are re-usable blocks of your GUI which can inherit from base components, written in YAML
 - `init.lua` runs at start
 - `app.lua` is your main file where you define what is your application about

```text
 |
 |--res
 |  |--img
 |  |  |--...
 |  |--data
 |  |  |--menu.yml
 |  |  |--...
 |--components
 |  |--header.yml
 |  |--text.yml
 |  |--...
 |--init.lua
 |--app.lua
```

## Roadmap / TODOs

 - [ ] more base components
   - [ ] input field
   - [ ] list
   - [ ] sublayouts
   - [ ] tabs
   - [ ] console
   - [ ] game canvas using physics api
   - [ ] 2D-editor using nspire's built-in editor
 - [x] colorful components
 - [x] click events
 - [ ] component focus (tabbing, highlighting selected)
 - [x] menu api
 - [x] paint hook, use raw `gc` functions
 - [x] persistent data storage
 - [ ] message box components imitating nspireOS's UI
 - [ ] redraw on timer only if one of update functions returns true
 - [x] rename `Library` to `Lib`
 - [ ] schedule to do something at next redraw/update / imitating sleep function

## Naming

*Lua* (portuguese for "moon") -> *Sol* (portuguese for "sun")
