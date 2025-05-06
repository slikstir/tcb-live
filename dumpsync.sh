#!/bin/bash

# CONFIG
HEROKU_APP="tcb-live"
DUMP_FILE="heroku_latest.dump"
DOCKER_CONTAINER="tcb-live-db-1"
DOCKER_DB="postgres"
DOCKER_USER="postgres"

# STEP 0: Capture new Heroku backup
echo "🎯 Capturing new backup on Heroku..."
heroku pg:backups:capture --app "$HEROKU_APP"

# STEP 1: Download the latest Heroku DB backup to host
echo "📦 Downloading Heroku DB backup..."
heroku pg:backups:download --app "$HEROKU_APP" --output "$DUMP_FILE"

if [ ! -f "$DUMP_FILE" ]; then
  echo "❌ Dump file not found. Exiting."
  exit 1
fi

# STEP 2: Copy the dump file into the Docker container
echo "🐳 Copying dump to Docker container..."
docker cp "$DUMP_FILE" "$DOCKER_CONTAINER":/tmp/"$DUMP_FILE"

# STEP 3: Drop and recreate DB inside Docker
echo "🔁 Dropping and recreating DB inside container..."
docker exec -u postgres "$DOCKER_CONTAINER" dropdb --if-exists "$DOCKER_DB"
docker exec -u postgres "$DOCKER_CONTAINER" createdb "$DOCKER_DB"

# STEP 4: Decompress and restore with psql
echo "📤 Restoring DB inside Docker container with psql..."
gunzip -c "$DUMP_FILE" | docker exec -i -u postgres "$DOCKER_CONTAINER" psql -d "$DOCKER_DB"

if [ $? -ne 0 ]; then
  echo "❌ Restore failed. Aborting."
  exit 1
fi



echo "✅ Done! Local Docker DB matches Heroku."