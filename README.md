
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
 | | |-...
 |-components
 | |-header.scl
 | |-text.scl
 | |-...
 |-init.lua
 |-app.lua
 |-layout.lua
```

## Roadmap / TODOs

 - [ ] more base components (input field, list, sublayouts, tabs)
 - [ ] colorful components
 - [ ] click events
 - [ ] component focus (tabbing, highlighting selected)
 - [ ] menu api
 - [ ] about dialog using data from `app.lua`
 - [ ] handling images
 - [ ] handling JSON/YAML data in `res/data`
 - [ ] "raw hooks", allow to inject Lua code into events/on.paint
 - [ ] data storage api (using variables)
 - [ ] game canvas component using nspire physics api

## Naming

*Lua* (portuguese for "moon") -> *Sol* (portuguese for "sun")
