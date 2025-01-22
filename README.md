# GeForce NOW Mac Stutter-Free Launcher

This project provides a reliable solution to improve the performance of **GeForce NOW** on macOS by managing the AWDL (Apple Wireless Direct Link) network interface. By disabling AWDL when GeForce NOW is running and re-enabling it when the application is closed, the tool eliminates potential network interference, ensuring a smoother gaming experience.

---

## What It Does
- **Disables AWDL**: When GeForce NOW starts, it disables AWDL (used by features like AirDrop and Handoff) to prevent network interference.
- **Re-enables AWDL**: Once GeForce NOW exits, AWDL is re-enabled to restore full functionality of macOS features.
- **Purpose**: AWDL can cause latency and instability during gaming. This tool provides an automated solution to address these issues.

---

## How to Set It Up

### 1. **Download the Tool**
Clone the repository to your local system:
```bash
git clone <https://github.com/ComicBit/Geforce-Now-Mac-stutter-free-Launcher>
cd Geforce-Now-Mac-stutter-free-Launcher
```

### 2. **Make the Script Executable**
Ensure the script has the necessary permissions to run:
```bash
chmod +x script.sh
```

### 3. **Set Up Non-Interactive Execution**
To allow the script to execute system commands without prompting for a password:
```bash
EDITOR=nano sudo visudo
```
Add the following lines, replacing `yourusername` with your macOS username:
```bash
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 down
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 up
```

### 4. **Configure the Launch Agent**
Move the `com.geforcenow.awdlcontrol.plist` file to the appropriate directory:
```bash
cp com.geforcenow.awdlcontrol.plist ~/Library/LaunchAgents/
```

Edit the `.plist` file to include the **full path** to the `script.sh` file. Open it with a text editor and replace `/path/to/the/script.sh` with the exact location of the script on your system. For example:
```xml
<string>/Users/yourusername/Geforce-Now-Mac-stutter-free-Launcher/script.sh</string>
```
Ensure the path matches the location where the script is saved.

---

### 5. **Activate the Launch Agent**
Load the Launch Agent to enable automatic execution:
```bash
launchctl load ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```
Verify that it is active:
```bash
launchctl list | grep com.geforcenow.awdlcontrol
```

---

## How It Works
When GeForce NOW launches:
1. The **Launch Agent** detects the application startup and runs the script.
2. The script disables AWDL to prevent network interference.
3. When GeForce NOW is closed, the script re-enables AWDL to restore full system functionality.

---

## Uninstalling
If you no longer require this tool:
1. Unload the Launch Agent:
```bash
launchctl unload ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```
2. Remove the files:
```bash
rm ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
rm /path/to/your/script.sh
```
3. Revert the `sudoers` file changes:
```bash
EDITOR=nano sudo visudo
```
Delete the lines added for `ifconfig` commands.

---

## Troubleshooting

### 1. **Launch Agent Not Running**
- Check if the Launch Agent is loaded:
```bash
launchctl list | grep com.geforcenow.awdlcontrol
```
- Verify the script path in the `.plist` file is correct.

### 2. **Password Prompts for `sudo`**
- Ensure the `sudoers` file includes the necessary lines for non-interactive execution.

### 3. **AWDL Not Disabling or Enabling**
- Test the commands manually:
```bash
sudo ifconfig awdl0 down
sudo ifconfig awdl0 up
```
If these commands fail, check macOS security settings such as System Integrity Protection.

### 4. **Verify Script Functionality**
To check if the script is working correctly, run the following command in the terminal:
```bash
ifconfig awdl0
```
- When GeForce NOW is open, the output should include `status: inactive`.
- When GeForce NOW is closed, the output should include `status: active`.

---

This tool provides an automated, efficient solution for reducing latency and network issues while using GeForce NOW on macOS. For any further issues or improvements, consult the project repository. Enjoy smoother gaming!
