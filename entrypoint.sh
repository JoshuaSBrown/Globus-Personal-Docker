#!/bin/env bash

if [ "$START_GLOBUS" = "true" ]; then
    echo "Starting Globus Connect Personal"
    source ./globus-connect-personal.sh
else
    source ./initialization.sh
fi

echo setup complete
