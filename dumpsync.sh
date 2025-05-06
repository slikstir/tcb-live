#!/bin/bash
set -euo pipefail

# CONFIGURATION
HEROKU_APP="tcb-live"
DUMP_FILE="heroku_latest.dump"
DOCKER_CONTAINER="tcb-live-db-1"
DOCKER_DB="tcb_live_development"
DOCKER_USER="postgres"

# STEP 0: Capture new backup from Heroku
echo "🎯 Capturing new backup on Heroku..."
heroku pg:backups:capture --app "$HEROKU_APP"

# STEP 1: Download backup
echo "📦 Downloading Heroku DB backup..."
heroku pg:backups:download --app "$HEROKU_APP" --output "$DUMP_FILE"

if [ ! -s "$DUMP_FILE" ]; then
  echo "❌ Download failed or file is empty. Exiting."
  exit 1
fi

# STEP 2: Copy dump into Docker container
echo "🐳 Copying dump to Docker container..."
docker cp "$DUMP_FILE" "$DOCKER_CONTAINER":/tmp/"$DUMP_FILE"

# STEP 3: Drop active connections and reset database
echo "🔁 Dropping active connections to $DOCKER_DB..."
docker exec -u "$DOCKER_USER" "$DOCKER_CONTAINER" psql -d postgres -c "
  SELECT pg_terminate_backend(pid)
  FROM pg_stat_activity
  WHERE datname = '$DOCKER_DB' AND pid <> pg_backend_pid();
"

echo "🔁 Dropping and recreating database..."
docker exec -u "$DOCKER_USER" "$DOCKER_CONTAINER" dropdb --if-exists "$DOCKER_DB"
docker exec -u "$DOCKER_USER" "$DOCKER_CONTAINER" createdb "$DOCKER_DB"

# STEP 4: Restore from custom-format dump using pg_restore
echo "📤 Restoring DB using pg_restore..."
docker exec -i -u "$DOCKER_USER" "$DOCKER_CONTAINER" pg_restore \
  --verbose --clean --no-acl --no-owner \
  -d "$DOCKER_DB" /tmp/"$DUMP_FILE"
  
# Optional: Clean up inside container
echo "🧼 Cleaning up..."
docker exec -u "$DOCKER_USER" "$DOCKER_CONTAINER" rm -f /tmp/"$DUMP_FILE"

echo "✅ Done! Local Docker DB now matches Heroku."
