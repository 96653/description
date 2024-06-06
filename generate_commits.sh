#!/bin/bash

# Configuration
REPO_PATH="/c/Users/dbda/try/description"  # Windows Git Bash uses Unix-style paths
DAYS_TO_FILL=365  # Number of days to simulate commits
START_DATE=$(date -d "$DAYS_TO_FILL days ago" +%s)

# Loop through each day
for ((i=0; i<DAYS_TO_FILL; i++)); do
    DATE=$(date -d "@$((START_DATE + i*86400))" +%Y-%m-%d)
    
    # Create a dummy file
    echo "Fake commit for $DATE" > "$REPO_PATH/dummy.txt"
    
    # Add and commit the changes
    cd "$REPO_PATH"
    git add .
    GIT_AUTHOR_DATE="$DATE 12:00:00" GIT_COMMITTER_DATE="$DATE 12:00:00" git commit -m "Fake commit on $DATE" --date "$DATE 12:00:00"
    
    # Remove dummy file
    rm "$REPO_PATH/dummy.txt"
done

# Push all commits
cd "$REPO_PATH"
git push origin main
