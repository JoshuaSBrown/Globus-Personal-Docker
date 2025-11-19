#!/bin/env bash

if [ "$START_GLOBUS" = "true" ]; then
    echo "Starting Globus Connect Personal"
    source /home/gridftp/globus-connect-personal.sh
else
    source /home/gridftp/initialization.sh
fi

echo setup complete
