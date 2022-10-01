#!/usr/bin/env python3

import os
import sys
import yaml

LUALIB = "/home/alex/Repos/sol/sol"

def die(msg):
    print(msg)
    sys.exit(1)

if len(sys.argv) < 2:
    die("no argument given")

project_root = sys.argv[1]

out = "/tmp/out.lua"
with open(out, "w") as fo:
    print("#include app.lua")
    with open(f"{LUALIB}/app.lua", "r") as fi:
        fo.write(fi.read())
    for file in os.listdir(f"{LUALIB}/components"):
        print(f"#include components/{file}")
        with open(f"{LUALIB}/components/{file}", "r") as fi:
            fo.write(fi.read())
    print("#include layout.lua")
    with open(f"{LUALIB}/layout.lua", "r") as fi:
        fo.write(fi.read())

    print("#process app.lua")
    with open(f"{project_root}/app.lua", "r") as fi:
        fo.write(fi.read())
    for file in os.listdir(f"{project_root}/components"):
        print(f"#process components/{file}")
        with open(f"{project_root}/components/{file}", "r") as f:
            comp = yaml.safe_load(f)
            comp_name = file.replace(".sc", "")
            lua_code = [
                f"Components.Custom.{comp_name} = Components.{comp['Inherit']}:new()",
                f"function Components.Custom.{comp_name}:new(o)",
                #f"  o = Components.{comp['Inherit']}:new()",
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
                elif type(comp[key]) == str:
                    value = f"\"{comp[key]}\""
                else:
                    value = comp[key]
                lua_code.append(f"  self.{key} = {value}")
            lua_code.append("  return o")
            lua_code.append("end")
        for line in lua_code:
            fo.write(line + "\n")
    print("#process layout.lua")
    with open(f"{project_root}/layout.lua", "r") as fi:
        fo.write(fi.read())
    print("#process init.lua")
    with open(f"{project_root}/init.lua", "r") as fi:
        fo.write(fi.read())

    print("#include events.lua")
    with open(f"{LUALIB}/events.lua", "r") as fi3:
        fo.write(fi3.read())
    print("#include run.lua")
    with open(f"{LUALIB}/run.lua", "r") as fi3:
        fo.write(fi3.read())