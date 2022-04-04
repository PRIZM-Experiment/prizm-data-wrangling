#!/bin/sh

# Builds and populates the PRIZM metadatabase in one fell swoop.
sqlite3 < ./source/build.sql
