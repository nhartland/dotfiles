import json
import subprocess

output = subprocess.run(["yabai","-m","query","--displays"],capture_output=True,text=True)
output_text = output.stdout.strip()
output_json = json.loads(output_text)


for display_config in output_json:
    width = (display_config["frame"]["w"])

    for space in display_config["spaces"]:
        if width >= 1920.0:
            subprocess.run(["yabai","-m","config","--space", str(space), "window_gap","128"])
            subprocess.run(["yabai","-m","config","--space", str(space), "top_padding","128"])
            subprocess.run(["yabai","-m","config","--space", str(space), "bottom_padding","128"])
            subprocess.run(["yabai","-m","config","--space", str(space), "left_padding","128"])
            subprocess.run(["yabai","-m","config","--space", str(space), "right_padding","128"])
        else:
            subprocess.run(["yabai","-m","config","--space", str(space), "window_gap","5"])
            subprocess.run(["yabai","-m","config","--space", str(space), "top_padding","20"])
            subprocess.run(["yabai","-m","config","--space", str(space), "bottom_padding","20"])
            subprocess.run(["yabai","-m","config","--space", str(space), "left_padding","20"])
            subprocess.run(["yabai","-m","config","--space", str(space), "right_padding","20"])
