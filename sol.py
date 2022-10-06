#!/usr/bin/env python3

import os
import sys
import yaml

# TODO
LUALIB = "/home/alex/Repos/sol/sol"
OUT = "/tmp/out.lua"

def die(msg: str = "Something went wrong") -> None:
    print(f"FATAL ERROR: {msg}")
    sys.exit(1)

def append(filename: str, type_: str, fo) -> None:
    prefix = "."
    if type_ == "include":
        prefix = LUALIB
    if type_ == "process":
        prefix = project_root
    print(f"#{type_} {filename}")
    fo.write(f"\n-- BEGIN {type_}:{filename}")
    with open(f"{prefix}/{filename}", "r") as fi:
        fo.write(fi.read())
    fo.write(f"-- END {type_}:{filename}")

def compile_component(filename: str, fo) -> (str, list[str], str):
    print(f"#compile components/{file}")
    with open(f"{project_root}/components/{file}", "r") as f:
        comp = yaml.safe_load(f)
        comp_name = file.split(".")[0]
        lua_code = [
            f"\nComponents.Custom.{comp_name} = Components.{comp['Inherit']}:new()",
            f"function Components.Custom.{comp_name}:new(o)",
            f"  o = o or Components.{comp['Inherit']}:new(o)",
            "  setmetatable(o, self)",
            "  self.__index = self"
            ]
        for key in comp:
            if key == "Inherit":
                continue
            if key in ("Update", "OnClick"):
                lua_code.append(f"  function self:{key}() {comp[key]} end")
                continue
            if key == "Color" and type(comp[key]) != list:
                lua_code.append(f"  self.{key} = {comp[key]}")
                continue
            if type(comp[key]) == str:
                value = f"\"{comp[key]}\""
            elif type(comp[key]) == bool:
                value = str(comp[key]).lower()
            elif type(comp[key]) == list:
                value = str(comp[key]).replace("[", "{").replace("]", "}")
            else:
                value = comp[key]
            lua_code.append(f"  self.{key} = {value}")
        lua_code.append("  return o")
        lua_code.append("end")
    return comp_name, lua_code, comp["Inherit"]

def compile_menu(filename: str, fo) -> None:
    with open(filename, "r") as fi:
        menu = yaml.safe_load(fi)
        menu.append({
            "Id": "help",
            "Name": "Help",
            "Submenues": [
                {
                    "Id": "about",
                    "Name": "About",
                    "Function": "Library.Internal:ShowAboutDialog()"
                }
            ]
        })
        categories = []
        functions = []
        for cat in menu:
            submenues = []
            for sm in cat["Submenues"]:
                submenues.append(f"{{\"{sm['Name']}\", _menu_{cat['Id']}_{sm['Id']}}}")
            functions.append(f"function _menu_{cat['Id']}_{sm['Id']}() {sm['Function']} end")
            categories.append(f"{{\"{cat['Name']}\", {', '.join(submenues)}}}")
    fo.write(f"\n-- BEGIN compile:{filename}")
    for i in functions:
        fo.write("\n" + i)
    fo.write(f"\ntoolpalette.register({{{', '.join(categories)}}})")
    fo.write(f"-- END compile:{filename}")

def lua_escape(var, prefix):
    print(var, type(var))
    if type(var) == str:
        return f"\"{var}\""
    if type(var) == bool:
        return str(var).lower()
    if type(var) == list:
        return str(var).replace("[", "{").replace("]", "}")
    if type(var) == dict:
        return pydict_toluatable(var, f"{prefix}")
    return var

def pydict_toluatable(data: dict, prefix: str) -> str:
    lines = [f"\n{prefix} = {{}}"]
    for key in data:
        res = lua_escape(data[key], prefix)
        if type(res) == list:
            for i in res:
                lines.append(i)
            continue
        lines.append(f"\n{prefix}.{key} = {res}")
    return lines

def compile_data(filename: str, fo) -> None:
    print(f"#compile res/data/{filename}")
    with open(f"{project_root}/res/data/{filename}", "r") as fi:
        data = yaml.safe_load(fi)
        dname = filename.replace(".yml", "")
        fo.write(f"\n-- BEGIN compile:{filename}")
        for line in pydict_toluatable(data, f"App.Data.Const.{dname}"):
            fo.write(line)
        fo.write(f"\n-- END compile:{filename}")

def append_folder(filename: str, type_: str, fo) -> None:
    append(f"{filename}/_init.lua", type_, fo)
    for file in os.listdir(filename):
        if file == "_init.lua": continue
        append(f"{filename}/{file}", type_, fo)

def process_components(fo) -> None:
        components = []
        for file in os.listdir(f"{project_root}/components"):
            components.append(compile_component(file, fo))
        components_sorted = []
        loop_detector = 0
        while len(components) > 0:
            delete = []
            for c in components:
                if c[2].startswith("Base."):
                    components_sorted.append(c)
                    delete.append(c)
                    continue
                if c[2] in [f"Custom.{j[0]}" for j in components_sorted]:
                    components_sorted.append(c)
                    delete.append(c)
                    continue
            for c in delete:
                components.remove(c)
            loop_detector += 1
            if loop_detector > 99:
                die("Component inheritance loop deteted")
        for i in components_sorted:
            print(f"#sort components/{i[0]}")
            fo.write(f"\n-- BEGIN compile:components/{i[0]}")
            for line in i[1]:
                fo.write(line + "\n")
            fo.write(f"-- END compile:components/{i[0]}")

# __MAIN__
if __name__ == "__main__":
    if len(sys.argv) < 2:
        die("no argument given")
    project_root = sys.argv[1]

    with open(OUT, "w") as fo:
        # framework: main file
        append("app.lua", "include", fo)
        # framework: library
        append_folder(f"{LUALIB}/library", "include", fo)
        # framework: components
        append_folder(f"{LUALIB}/components", "include", fo)

        # project: data
        for file in os.listdir(f"{project_root}/res/data"):
            if file == "menu.yml":
                continue
            compile_data(file, fo)

        # project: components
        process_components(fo)
        # project: lua code
        for file in ["app.lua", "init.lua", "hooks.lua"]:
            append(file, "process", fo)
        # project: menu
        compile_menu("res/data/menu.yml", fo)

        # framework: events
        append("events.lua", "include", fo)
