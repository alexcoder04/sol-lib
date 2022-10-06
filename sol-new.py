#!/usr/bin/env python3

import os
import sys
import tempfile

def die(msg: str = "An error occured") -> None:
    print(f"FATAL ERROR: {msg}")
    sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        die("not enough arguments")
    
    project_name = sys.argv[1]
    for c in ["/", "."]:
        if c in project_name:
            die("Disallowed chars in project name")
    
    os.mkdir(project_name)
    os.mkdir(f"{project_name}/components")
    os.mkdir(f"{project_name}/res")
    os.mkdir(f"{project_name}/res/data")
    with open(f"{project_name}/res/data/menu.yml", "w") as f:
        f.write("[]")
    with open(f"{project_name}/Makefile", "w") as f:
        f.write(f"""
SOL = {os.path.realpath(__file__)}/sol
UPLOADNSPIRE = uploadnspire
NAME = helloworld
TEMP_LUA = {tempfile.gettempdir()}/out.lua
OUT_FILE = {tempfile.gettempdir()}/$(NAME).tns

all: clean build upload

build:
	$(SOL) .
	luna $(TEMP_LUA) $(OUT_FILE)

clean:
	$(RM) $(TEMP_LUA) $(OUT_FILE)

upload:
	$(UPLOADNSPIRE) $(OUT_FILE)

""")
    with open(f"{project_name}/README.md", "w") as f:
        f.write("# helloworld application for the ti-nspire")
    with open(f"{project_name}/app.lua", "w") as f:
        f.write("""
hello_world_element = Components.Base.TextField:new()
hello_world_element.Label = "Hello World"

App:AddElement(hello_world_element)
""")
