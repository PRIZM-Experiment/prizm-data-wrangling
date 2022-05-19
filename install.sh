#!/bin/sh

# Deletes the any previously generated PRIZM metadatabase left in the repository's directory.
if [ -f metadatabase.db ] ; then
    rm metadatabase.db
fi

# Builds and populates the PRIZM metadatabase in one fell swoop.
sqlite3 < ./source/build.sql
