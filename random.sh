#!/bin/bash

# Store the provided image tags in a multi-line string.
# Each line from your input is included here.
# The commas will be processed to separate individual tags.
all_image_tags="1.27.5, mainline, 1, 1.27, latest, 1.27.5-bookworm, mainline-bookworm, 1-bookworm, 1.27-bookworm, bookworm
1.27.5-perl, mainline-perl, 1-perl, 1.27-perl, perl, 1.27.5-bookworm-perl, mainline-bookworm-perl, 1-bookworm-perl, 1.27-bookworm-perl, bookworm-perl
1.27.5-otel, mainline-otel, 1-otel, 1.27-otel, otel, 1.27.5-bookworm-otel, mainline-bookworm-otel, 1-bookworm-otel, 1.27-bookworm-otel, bookworm-otel
1.27.5-alpine, mainline-alpine, 1-alpine, 1.27-alpine, alpine, 1.27.5-alpine3.21, mainline-alpine3.21, 1-alpine3.21, 1.27-alpine3.21, alpine3.21
1.27.5-alpine-perl, mainline-alpine-perl, 1-alpine-perl, 1.27-alpine-perl, alpine-perl, 1.27.5-alpine3.21-perl, mainline-alpine3.21-perl, 1-alpine3.21-perl, 1.27-alpine3.21-perl, alpine3.21-perl
1.27.5-alpine-slim, mainline-alpine-slim, 1-alpine-slim, 1.27-alpine-slim, alpine-slim, 1.27.5-alpine3.21-slim, stable-alpine3.21-slim, 1.28-alpine3.21-slim, alpine3.21-slim
1.27.5-alpine-otel, mainline-alpine-otel, 1-alpine-otel, 1.27-alpine-otel, alpine-otel, 1.27.5-alpine3.21-otel, mainline-alpine3.21-otel, 1-bookworm-otel, 1.27-bookworm-otel, alpine3.21-otel
1.28.0, stable, 1.28, 1.28.0-bookworm, stable-bookworm, 1.28-bookworm
1.28.0-perl, stable-perl, 1.28-perl, 1.28.0-bookworm-perl, stable-bookworm-perl, 1.28-bookworm-perl
1.28.0-otel, stable-otel, 1.28-otel, 1.28-bookworm-otel, stable-bookworm-otel, 1.28-bookworm-otel
1.28.0-alpine, stable-alpine, 1.28-alpine, 1.28.0-alpine3.21, stable-alpine3.21, 1.28-alpine3.21
1.28.0-alpine-perl, stable-alpine-perl, 1.28-alpine-perl, 1.28.0-alpine3.21-perl, stable-alpine3.21-perl, 1.28-alpine3.21-perl
1.28.0-alpine-slim, stable-alpine-slim, 1.28-alpine-slim, 1.28.0-alpine3.21-slim, stable-alpine3.21-slim, 1.28-alpine3.21-slim
1.28.0-alpine-otel, stable-alpine-otel, 1.28-alpine-otel, 1.28.0-alpine3.21-otel, stable-alpine3.21-otel, 1.28-alpine3.21-otel
"

# Process the input string:
# 1. Replace all commas with newlines (`tr ',' '\n'`)
# 2. Use sed to remove any leading or trailing whitespace from each line (`sed 's/^[[:space:]]*//;s/[[:space:]]*$//'`)
# 3. Use grep to remove any entirely empty lines that might result (`grep -v '^$'`)
# The output is a list of tags, one per line.
processed_tags=$(echo "$all_image_tags" | tr ',' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | grep -v '^$')

# Initialize an empty array
tag_array=()

# Read the processed tags line by line into the array.
# This method is compatible with older bash versions.
# IFS= read -r: Prevents leading/trailing whitespace trimming and backslash interpretation by read.
# <<< "$processed_tags": Uses a here-string to feed the multi-line string into the while loop.
while IFS= read -r tag; do
  # Append the current line (tag) to the array
  tag_array+=("$tag")
done <<< "$processed_tags"

# Get the number of tags in the array.
num_tags=${#tag_array[@]}

# Check if the array is empty.
if [ "$num_tags" -eq 0 ]; then
  echo "Error: No image tags were found after processing the input." >&2
  exit 1
fi

# Generate a random index.
# $RANDOM provides a random integer.
# We use the modulo operator (%) to get a number between 0 and num_tags - 1.
random_index=$((RANDOM % num_tags))

# Select the tag at the random index from the array.
selected_tag="${tag_array[random_index]}"

# Print the randomly selected tag.
echo "$selected_tag"
