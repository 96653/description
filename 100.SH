#!/bin/bash

# Configuration
REPO_PATH="/c/Users/dbda/try/description"  # Use Unix-style path in Git Bash
DAYS_TO_FILL=50  # Total number of recent days to consider
START_DATE=$(date -d "$DAYS_TO_FILL days ago" +%s)

# Loop through each day
for ((i=0; i<DAYS_TO_FILL; i++)); do
    # Commit only on even days (0, 2, 4, ..., 48)
    if (( i % 2 == 0 )); then
        DATE=$(date -d "@$((START_DATE + i*86400))" +%Y-%m-%d)
        
        # Create dummy file
        echo "Fake commit for $DATE" > "$REPO_PATH/dummy.txt"
        
        # Add and commit
        cd "$REPO_PATH"
        git add .
        GIT_AUTHOR_DATE="$DATE 12:00:00" GIT_COMMITTER_DATE="$DATE 12:00:00" git commit -m "Fake commit on $DATE" --date "$DATE 12:00:00"
        
        # Remove dummy file
        rm "$REPO_PATH/dummy.txt"
    fi
done

# Push all commits
cd "$REPO_PATH"
git push origin main
