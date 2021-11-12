-------------------------
-- Metadatabase for PRIZM
-------------------------

-- -------------------
-- PRIZM Metadatabase
-- ------------------
.open prizm_metadatabase.db

-- --------------------
-- Specifications Table
-- --------------------
CREATE TABLE Specifications
(
  instrument            TEXT    NOT NULL ,
  site                  TEXT    NOT NULL ,
  ew_channel_convention INTEGER NOT NULL ,
  ns_channel_convention INTEGER NOT NULL
);

-- -----------------
-- Directories Table
-- -----------------
CREATE TABLE Directories
(
  directory_address      TEXT    NOT NULL ,
  data_category          TEXT    NOT NULL ,
  time_start             INTEGER NOT NULL ,
  time_stop              INTEGER NOT NULL ,
  directory_completeness BOOL    NULL ,

  PRIMARY KEY (directory_address) ,

  CHECK (data_category = "Antenna" OR
         data_category = "Switch" OR
         data_category = "Temperature" OR
         data_category = "Patch")
);

-- -----------
-- Files Table
-- -----------
CREATE TABLE Files
(
  file_name     TEXT    NOT NULL ,
  file_alias    TEXT    NOT NULL ,
  data_channels INTEGER NOT NULL ,
  data_type     TEXT    NOT NULL ,

  PRIMARY KEY (file_name)
);

-- ----------
-- Data Table
-- ----------
CREATE TABLE Data
(
  directory_address TEXT NOT NULL ,
  file_name         TEXT NOT NULL ,
  data_quality      BOOL NULL ,
  file_integrity    BOOL NULL ,

  FOREIGN KEY (directory_address) REFERENCES Directories (directory_address) ,
  FOREIGN KEY (file_name) REFERENCES Files (file_name) ,

  PRIMARY KEY (directory_address, file_name)
);

-- -----------
-- Notes Table
-- -----------
CREATE TABLE Notes
(
  directory_address TEXT NOT NULL ,
  file_name         TEXT NULL ,
  note_author       TEXT NOT NULL ,
  note_date         TEXT NOT NULL ,
  note_content      TEXT NOT NULL ,

  FOREIGN KEY (directory_address) REFERENCES Directories (directory_address) ,
  FOREIGN KEY (file_name) REFERENCES Files (file_name)
);
