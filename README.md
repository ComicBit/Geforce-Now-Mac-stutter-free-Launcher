# GeForce NOW AWDL Control Daemon

This repository contains a script and Launch Agent configuration for macOS to automatically disable the AWDL interface (`awdl0`) when GeForce NOW is launched and re-enable it when the application exits. This setup resolves potential network issues on macOS when using GeForce NOW.

## Features
- Automatically disables `awdl0` when GeForce NOW launches.
- Re-enables `awdl0` when GeForce NOW exits.
- Lightweight and efficient, using macOS `launchd` for event-driven execution.

---

## Requirements
1. **macOS**: Tested on macOS Monterey and later.
2. **Administrative Privileges**: Required to disable and enable `awdl0`.
3. **Basic Terminal Knowledge**: For initial setup.

---

## Setup Instructions

### Step 1: Clone the Repository
Clone the repository to your local system:
```bash
git clone <repository_url>
cd <repository_name>
```

### Step 2: Configure the Script
Ensure the script (`script.sh`) is executable:
```bash
chmod +x script.sh
```
Edit the script if necessary to adjust paths or configurations.

### Step 3: Update `sudoers` for Non-Interactive Execution
Allow the script to execute `sudo ifconfig` without requiring a password:
```bash
EDITOR=nano sudo visudo
```
Add the following line, replacing `yourusername` with your macOS username:
```bash
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 down
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 up
```

### Step 4: Install the Launch Agent
Copy the Launch Agent configuration file to the appropriate directory:
```bash
cp com.geforcenow.awdlcontrol.plist ~/Library/LaunchAgents/
```
Ensure the `.plist` file has the correct permissions:
```bash
chmod 644 ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```

### Step 5: Load the Launch Agent
Load the Launch Agent to activate it:
```bash
launchctl load ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```
Verify it is loaded:
```bash
launchctl list | grep com.geforcenow.awdlcontrol
```

---

## Uninstallation
1. Unload the Launch Agent:
```bash
launchctl unload ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
```
2. Remove the files:
```bash
rm ~/Library/LaunchAgents/com.geforcenow.awdlcontrol.plist
rm /path/to/your/script.sh
```
3. Optionally, remove the `sudoers` entry by editing the `sudoers` file:
```bash
EDITOR=nano sudo visudo
```
Remove the line:
```bash
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 down
yourusername ALL=(ALL) NOPASSWD: /sbin/ifconfig awdl0 up
```

---

## Notes
- Ensure you replace `/path/to/your/script.sh` with the actual path to your script.
- The Launch Agent relies on `launchd` and macOS-specific features; it is not cross-platform.

---

## Troubleshooting
### Issue: Launch Agent Doesn’t Trigger the Script
- Check if the Launch Agent is loaded:
```bash
launchctl list | grep com.geforcenow.awdlcontrol
```
- Verify the logs for errors.
- Ensure the script runs correctly when executed manually.

### Issue: Check if the script is correctly working
- Check if the Launch Agent is loaded:
```bash
ifconfig awdl0
```
- When Geforce Now is running it should show status: inactive and status: active when the app is closed.

### Issue: `sudo ifconfig` Requires a Password
- Double-check the `sudoers` configuration.
- Ensure the script is run by the correct user.

### Issue: AWDL Interface Not Disabling/Enabling
- Verify `ifconfig awdl0 down` works manually.
- Check if System Integrity Protection (SIP) is interfering:
```bash
csrutil status