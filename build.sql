/*
sqlite3 < build.sql
*/

-- Initializes the metadatabase binary file.
.open metadatabase.db

-- Builds the metadatabase tables.
.read schema.sql

-- Populates the metadatabase.
.read metadata.sql
