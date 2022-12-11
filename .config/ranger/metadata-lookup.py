#!/usr/bin/env python3

'''
ranger preview_script that looks up and prints metadata for the current
file, then calls scope.sh to print the file preview under the metadata info

add to rc.conf:
set preview_script ~/.config/ranger/metadata-lookup.py
map zS chain set preview_script ~/.config/ranger/scope.sh; reload_cwd
map zM chain set preview_script ~/.config/ranger/metadata-lookup.py; reload_cwd
'''

import sys
import subprocess
import json
import yaml
from os.path import exists

# 1. Print metadata if found
mdfile = ".metadata.json"
if exists(mdfile):
    try:
        fname = sys.argv[1].split("/")[-1]
        with open(mdfile, "r") as rf:
            data = json.load(rf)
            if fname in data:
                print("*** METADATA ***\n")
                print(yaml.dump(data[fname]))
                print("****************\n\n", flush=True)
    except Exception as e:
        print(f"Metadata read error: {e}")
        print("****************\n\n", flush=True)

# 2. Call scope.sh to print file preview
args = '" "'.join(sys.argv[1:])
call_scope_cmd = f"~/.config/ranger/scope.sh \"{args}\""
subprocess.run(f"{call_scope_cmd}", shell=True)