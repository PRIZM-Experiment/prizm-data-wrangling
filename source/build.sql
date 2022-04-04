-- Initializes the metadatabase binary file.
.open metadatabase.db

-- Builds the metadatabase tables.
.read ./source/schema.sql

-- Populates the metadatabase.
.read ./source/metadata.sql
