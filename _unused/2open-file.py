#!/usr/bin/env python3
import sys
import subprocess

if len(sys.argv) == 1:
    print('argument(s): <filename>')
else:
    try:
        subprocess.check_call(["xdg-open", sys.argv[1]], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
        print('xdg-open <filename>')
    except:
        print('./<filename>')
        subprocess.call([f"./{sys.argv[1]}"], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
