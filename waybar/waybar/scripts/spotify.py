#!/usr/bin/python3
import subprocess
import time

def get_metadata():
    try:
        status = subprocess.run(["playerctl", "--player=spotify", "status"], capture_output=True, text=True).stdout.strip()
        artist = subprocess.run(["playerctl", "--player=spotify", "metadata", "artist"], capture_output=True, text=True).stdout.strip()
        title = subprocess.run(["playerctl", "--player=spotify", "metadata", "title"], capture_output=True, text=True).stdout.strip()

        if status == "Playing":
            return f"<span color='#1ed760'></span>  {artist} - {title}"
        elif status == "Paused":
            return f"<span color='#1ed760'></span> 󰏤 {artist} - {title}"
        else:
            return ""
    except Exception as e:
        return "No i coś się zjabłao"

def main():
    metadata = get_metadata()
    print(metadata, flush=True)

if __name__ == "__main__":
    main()
