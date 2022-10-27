
# Sol

GUI application framework for the TI-nspire. This repository is the "home" of the project
and contains all the Lua library code.

[Here](https://alexcoder04.github.io/sol-docs/) you can find the docs.

[Here](https://github.com/alexcoder04/sol-helloworld) you can find an example application.
And [here](https://github.com/alexcoder04/nclock22) is another one.

[These](https://github.com/alexcoder04/sol-tools) are the tools needed for developing applications with Sol.

## Why?

Building GUI applications for TI-nspire using the stock Lua library from TI
is a pain, this is an attempt to make it easier and more comfortable.

### Organized

Your code has to be organized, no "throwing everything into one Lua file" anymore!
All the parts are then assembled and built into one `.tns` file by [sol-tools](https://github.com/alexcoder04/sol-tools).
These tools are also downloading the required sol-lib Lua library version for you.

 - `init.lua` runs at start
 - `app.lua` is your main file where you define the app logic
 - `solproj.yml` is where app metadata goes
 - `components` are re-usable blocks of your GUI which can inherit from base components, written in YAML
 - `res` contains any non-code resources, e. g. images and data.
 - and so on...

## How to Use

Check out the [Quickstart guide](https://alexcoder04.github.io/sol-docs/quickstart.html).

## Roadmap / TODOs

 - [ ] more base components
   - [x] input field
   - [ ] canvas
   - [ ] list
   - [ ] sublayouts/containers
   - [ ] tabs
   - [ ] console
   - [ ] game canvas using physics api
   - [ ] 2D-editor using nspire's built-in editor
 - [x] colorful components
 - [x] click events
 - [x] component focus (tabbing, highlighting selected)
 - [x] menu api
 - [x] paint hook, use raw `gc` functions
 - [x] persistent data storage
 - [ ] message box components imitating nspireOS's UI
   - [x] basic support
   - [ ] theming
   - [ ] global theming through `MyLib`
 - [x] redraw on timer only if one of update functions returns true
 - [ ] schedule to do something at next redraw/update / imitating sleep function
   - [x] do at next update
   - [ ] do in specific time interval
 - [x] light/dark mode switching

## Naming

*Lua* (portuguese for "moon") -> *Sol* (portuguese for "sun")

## Credits

 - The dialog library module is based on the nSpaint GUI engine written by Loïc Pujet.
