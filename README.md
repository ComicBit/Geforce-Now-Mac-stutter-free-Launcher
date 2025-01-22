# GeForce NOW Mac stutter free launcher

This project is like a traffic controller for your Mac’s network. It ensures smoother gameplay on **GeForce NOW** by temporarily switching off a little-known "hidden network" (called **AWDL**) that can cause hiccups, and turns it back on when you’re done gaming. Think of it as flipping a switch for better performance!

---

## What It Does
- **Pauses AWDL**: When you start GeForce NOW, it pauses AWDL (a network interface for things like AirDrop and Handoff).
- **Restarts AWDL**: When you close GeForce NOW, it restarts AWDL so everything works like normal.
- **Why This Matters**: AWDL can sometimes create interference, making games laggy or unstable on macOS. This tool prevents that.

---

## How to Set It Up

### 1. **Download the Tool**
Grab the tool from the GitHub repository:
```bash
git clone <https://github.com/ComicBit/Geforce-Now-Mac-stutter-free-Launcher>
cd Geforce-Now-Mac-stutter-free-Launcher
```

### 2. **Make the Script Work**
Turn on permissions for the script:
```bash
chmod +x script.sh
```

### 3. **Set Up No-Password Mode**
The script uses some commands that need administrative permissions. We’ll make it smoother by skipping the password prompt for this task:
```bash
EDITOR=nano sudo visudo
```
Add this line (replacing `yourusername` with your Mac’s username):
```bash
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 down
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 up
```

### 4. **Link It to Your System**
Move the `com.geforcenow.awdlcontrol.plist` file to your Mac's system folder:
```bash
cp com.geforcenow.awdlcontrol.plist ~/Library/LaunchAgents/
```

Now, open the `.plist` file and edit it to include the **correct path** to `script.sh`. Make sure the file points exactly where you saved the script.

---

### 5. **Activate the Tool**
Start the tool so it runs automatically:
```bash
launchctl load ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```
Check if it’s active:
```bash
launchctl list | grep com.geforcenow.awdlcontrol
```

---

## How It Works
When GeForce NOW launches:
1. The **Launch Agent** detects it and runs the script.
2. The script pauses AWDL, cutting out potential interference.
3. When GeForce NOW closes, the script restarts AWDL.

---

## Uninstalling
If you decide you no longer need this:
1. Stop the tool:
```bash
launchctl unload ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```
2. Delete the files:
```bash
rm ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
rm /path/to/your/script.sh
```
3. Clean up the password-free setup:
```bash
EDITOR=nano sudo visudo
```
Remove the two lines you added earlier for `ifconfig`.

---

## Common Issues & Fixes

### 1. **It’s Not Working**
- Check if it’s running:
```bash
launchctl list | grep com.geforcenow.awdlcontrol
```
- Look for typos in the `.plist` file or the script path.

### 2. **Still Asking for Password**
- Double-check you added the right lines in the `sudoers` file.

### 3. **AWDL Doesn’t Turn Off**
- Test the command manually:
```bash
sudo ifconfig awdl0 down
```
If it doesn’t work, your macOS settings (like System Integrity Protection) might need adjustments.

---

This tool is a simple yet effective fix for smoother GeForce NOW gaming on macOS. It’s like having a smart assistant manage your network in the background. Happy gaming! 🎮
