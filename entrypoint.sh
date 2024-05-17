#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Check for pending migrations and run them if any exist
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:setup

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

# sudo docker exec -it dog_breeds_web_1  bash

