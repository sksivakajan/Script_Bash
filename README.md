### Description

This **Bash script** automates the process of moving all files from the Desktop into a backup folder on the Desktop, while renaming each file to include a "backup" prefix along with the current date and time. The script can be scheduled to run at a specific time daily using `cron` (on Linux/macOS) or other scheduling tools.

#### Key Features:
1. **Checks and creates a backup folder**:
   - The script first checks if a folder named `backup` exists on the Desktop. If not, it creates one. This ensures that there's always a place to store the files.

2. **Moves and renames files**:
   - For every file on the Desktop (except the `backup` folder itself), the script moves the file into the `backup` folder and renames it by adding a prefix "backup" followed by the current date and time.

3. **Timestamp-based naming**:
   - The script generates a unique timestamp (`YYYY-MM-DD_HH-MM-SS`) for each file to avoid overwriting files and to keep track of when the backup was performed.

#### Use Case:
- **Backup Automation**: This script is useful for backing up your Desktop files automatically on a daily or regular basis, ensuring that no data is lost. You can set it up with `cron` to run at specific times, making the process completely hands-free.

#### Example of Output:
- A file called `report.pdf` on the Desktop, after the script runs, would be renamed to something like:
  ```
  backup_2024-08-28_10-30-45.pdf
  ```

#### How to Schedule (Linux/macOS):
1. Save the script as `backup_script.sh`.
2. Make it executable with `chmod +x backup_script.sh`.
3. Schedule it using `cron` to run at a specific time every day.

Example `crontab` entry to run at 6:00 AM daily:
```
0 6 * * * /path/to/backup_script.sh
```

This ensures that all files on the Desktop are backed up daily in a structured manner, with the filename indicating the exact backup time.




#!/bin/bash

# Define the desktop and backup folder paths
DESKTOP="$HOME/Desktop"
BACKUP_DIR="$DESKTOP/backup"


# Create the backup folder if it doesn't exist
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
    echo "Backup directory created."
fi

# Move all files from Desktop to the backup directory
for file in "$DESKTOP"/*; do
    # Check if the file is not the backup folder itself
    if [ "$file" != "$BACKUP_DIR" ]; then
         # Extract the file name and extension
        filename=$(basename "$file")
        extension="${filename##*.}"
        
        # Get the current date and time
        timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
        
        # Construct the new file name with "backup" and timestamp
        new_name="backup_${timestamp}.${extension}"
        
        # Move and rename the file
        mv "$file" "$BACKUP_DIR/$new_name"
        echo "Moved and renamed $filename to $new_name."
    fi
done

sleep 10

clear 
