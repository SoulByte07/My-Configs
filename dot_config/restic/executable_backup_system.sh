#!/bin/bash

# --- Configuration ---
# REPLACE 'youruser' with your actual username!
USER_HOME="/home/soul"
EXCLUDE_FILE="$USER_HOME/.config/restic/excludes.txt"
PASSWORD_FILE="$USER_HOME/.config/restic/password"
REPO="rclone:Gdrive:restic-fedora-soul-backup"

# Btrfs Settings
SOURCE_SUBVOL="/home"
SNAPSHOT_NAME="backup_snap"
# The path where the snapshot will temporarily exist
SNAPSHOT_PATH="/home/.snapshots/$SNAPSHOT_NAME"

# --- 1. Create a Read-Only Snapshot ---
echo "❄️  Freezing filesystem (Snapshot)..."
# We create the snapshot inside /home/.snapshots (create this dir if it doesn't exist)
if [ ! -d "/home/.snapshots" ]; then mkdir -p /home/.snapshots; fi

# Delete old snapshot if it wasn't cleaned up properly last time
if [ -d "$SNAPSHOT_PATH" ]; then sudo btrfs subvolume delete "$SNAPSHOT_PATH"; fi

sudo btrfs subvolume snapshot -r $SOURCE_SUBVOL $SNAPSHOT_PATH

# --- 2. Run Encrypted Backup ---
echo "🚀 Starting Upload to Google Drive..."

# Note: We backup '.' relative to the snapshot so paths in the backup look clean
cd $SNAPSHOT_PATH

restic -r $REPO --password-file $PASSWORD_FILE backup . \
  --tag "fedora-automated" \
  --exclude-file $EXCLUDE_FILE

# --- 3. Cleanup ---
echo "🧹 Cleaning up snapshot..."
cd / # Move out of the directory so we can delete it
sudo btrfs subvolume delete $SNAPSHOT_PATH

# --- 4. Prune Old Backups ---
echo "✂️  Pruning old history..."
restic -r $REPO --password-file $PASSWORD_FILE forget \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 6 \
  --prune

echo "✅ Backup Complete!"
