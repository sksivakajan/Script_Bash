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
