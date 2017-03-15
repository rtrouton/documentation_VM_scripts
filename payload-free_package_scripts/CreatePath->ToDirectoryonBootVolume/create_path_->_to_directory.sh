#!/bin/bash

# Create /path/to directory on boot volume

/bin/mkdir -p "$3/path/to"

# Set the /path/to directory to be world-writable.
# This is normally a very bad idea; do not do this
# on production machines.

/bin/chmod -R 777 "$3/path"

exit 0
