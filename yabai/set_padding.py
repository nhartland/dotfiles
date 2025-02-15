import json
import subprocess

# Query yabai for displays
output = subprocess.run(["yabai", "-m", "query", "--displays"], capture_output=True, text=True)
displays = json.loads(output.stdout.strip())

# Query yabai for spaces
output = subprocess.run(["yabai", "-m", "query", "--spaces"], capture_output=True, text=True)
spaces = json.loads(output.stdout.strip())

# Build commands for configuring each space based on its display
commands = []
for display in displays:
    width = display["frame"]["w"]

    # Set padding based on screen width
    if width >= 1920:
        padding, gap = "128", "128"
    else:
        padding, gap = "20", "5"

    # Apply settings to each space on this display
    for space in spaces:
        if space["display"] == display["index"]:
            commands.extend([
                f"yabai -m config --space {space['index']} window_gap {gap}",
                f"yabai -m config --space {space['index']} top_padding {padding}",
                f"yabai -m config --space {space['index']} bottom_padding {padding}",
                f"yabai -m config --space {space['index']} left_padding {padding}",
                f"yabai -m config --space {space['index']} right_padding {padding}"
            ])

# Execute all yabai commands
if commands:
    subprocess.run("; ".join(commands), shell=True)

