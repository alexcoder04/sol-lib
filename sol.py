#!/usr/bin/env python3

import os
import sys
import yaml

LUALIB = "/home/alex/Repos/sol/sol"

def die(msg: str = "Something went wrong") -> None:
    print(f"FATAL ERROR: {msg}")
    sys.exit(1)

def append(filename, type_, fo):
    prefix = "."
    if type_ == "include":
        prefix = LUALIB
    if type_ == "process":
        prefix = project_root
    print(f"#{type_} {filename}")
    with open(f"{prefix}/{filename}", "r") as fi:
        fo.write(fi.read())

def compile_scl(filename, fo):
    print(f"#compile components/{file}")
    with open(f"{project_root}/components/{file}", "r") as f:
        comp = yaml.safe_load(f)
        comp_name = file.split(".")[0]
        lua_code = [
            f"Components.Custom.{comp_name} = Components.{comp['Inherit']}:new()",
            f"function Components.Custom.{comp_name}:new(o)",
            "  o = o or {}",
            "  setmetatable(o, self)",
            "  self.__index = self"
            ]
        for key in comp:
            if key == "Inherit":
                continue
            if key == "Update":
                lua_code.append(f"  function self:Update() {comp['Update']} end")
                continue
            if type(comp[key]) == str:
                value = f"\"{comp[key]}\""
            else:
                value = comp[key]
            lua_code.append(f"  self.{key} = {value}")
        lua_code.append("  return o")
        lua_code.append("end")
    for line in lua_code:
        fo.write(line + "\n")

if len(sys.argv) < 2:
    die("no argument given")
project_root = sys.argv[1]

out = "/tmp/out.lua"
with open(out, "w") as fo:
    append("app.lua", "include", fo)
    append("components/_init.lua", "include", fo)
    for file in os.listdir(f"{LUALIB}/components"):
        if file == "_init.lua":
            continue
        append(f"components/{file}", "include", fo)
    append("layout.lua", "include", fo)

    append("app.lua", "process", fo)
    for file in os.listdir(f"{project_root}/components"):
        compile_scl(file, fo)
    append("layout.lua", "process", fo)
    append("init.lua", "process", fo)

    append("events.lua", "include", fo)
    append("run.lua", "include", fo)
