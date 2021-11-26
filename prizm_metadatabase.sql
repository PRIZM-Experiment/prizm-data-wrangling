-------------------------
-- Metadatabase for PRIZM
-------------------------
.open prizm_metadatabase.db


-- -----------
-- Data Tables
-- -----------
CREATE TABLE DataDirectories
(
  data_directory         TEXT    NOT NULL,
  data_category          INTEGER NOT NULL,
  time_start             INTEGER NOT NULL,
  time_stop              INTEGER NOT NULL,
  directory_completeness BOOL    NOT NULL,
  hardware_configuration INTEGER NOT NULL,

  FOREIGN KEY (data_category) REFERENCES DataCategories (data_category),
  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),

  PRIMARY KEY (data_directory)
);

CREATE TABLE DataCategories
(
  data_category INTEGER NOT NULL,
  category_name TEXT    NOT NULL,

  PRIMARY KEY (data_category)
);

CREATE TABLE DataFiles
(
  data_file  TEXT NOT NULL,
  data_label TEXT NOT NULL,
  data_type  TEXT NOT NULL,

  PRIMARY KEY (data_file)
);

CREATE TABLE DataQuality
(
  data_directory TEXT NOT NULL,
  data_file      TEXT NOT NULL,
  data_quality   BOOL NOT NULL,
  file_integrity BOOL NOT NULL,

  FOREIGN KEY (data_directory) REFERENCES DataDirectories (data_directory),
  FOREIGN KEY (data_file) REFERENCES DataFiles (data_file)
);

CREATE TABLE DataGroupIndex
(
  data_group INTEGER NOT NULL,

  PRIMARY KEY (data_group)
);

CREATE TABLE DataGroups
(
  data_group INTEGER NOT NULL,
  data_file  TEXT    NOT NULL,

  FOREIGN KEY (data_group) REFERENCES DataGroupIndex (data_group),
  FOREIGN KEY (data_file) REFERENCES DataFiles (data_file)
);

CREATE TABLE DataNotes
(
  data_directory TEXT NOT NULL,
  data_file      TEXT     NULL,
  note_author    TEXT NOT NULL,
  note_date      TEXT NOT NULL,
  note_content   TEXT NOT NULL,

  FOREIGN KEY (data_directory) REFERENCES DataDirectories (data_directory),
  FOREIGN KEY (data_file) REFERENCES DataFiles (data_file)
);


-- ---------------
-- Hardware Tables
-- ---------------
CREATE TABLE HardwareConfigurations
(
  hardware_configuration INTEGER NOT NULL,
  configuration_name     TEXT    NOT NULL,
  first_stage            INTEGER NOT NULL,
  second_stage           INTEGER NOT NULL,

  FOREIGN KEY (first_stage) REFERENCES FirstStages (first_stage),
  FOREIGN KEY (second_stage) REFERENCES SecondStages (second_stage),

  PRIMARY KEY (hardware_configuration)
);

CREATE TABLE FirstStages
(
  first_stage        INTEGER NOT NULL,
  stage_name         TEXT    NOT NULL,
  component_grouping INTEGER NOT NULL,

  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),

  PRIMARY KEY (first_stage)
);

CREATE TABLE SecondStages
(
  second_stage       INTEGER NOT NULL,
  stage_name         TEXT    NOT NULL,
  component_grouping INTEGER NOT NULL,

  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),

  PRIMARY KEY (second_stage)
);

CREATE TABLE ChannelOrientations
(
  channel_orientation INTEGER NOT NULL,
  orientation_name    TEXT    NOT NULL,

  PRIMARY KEY (channel_orientation)
);

CREATE TABLE HardwareChannels
(
  channel_orientation    INTEGER NOT NULL,
  hardware_configuration INTEGER NOT NULL,
  data_group             INTEGER NOT NULL,
  patch_group            INTEGER NOT NULL,
  calibration_group      INTEGER NOT NULL,
  component_group        INTEGER NOT NULL,

  FOREIGN KEY (channel_orientation) REFERENCES ChannelOrientations (channel_orientation),
  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),
  FOREIGN KEY (data_group) REFERENCES DataGroupIndex (data_group),
  FOREIGN KEY (patch_group) REFERENCES PatchGroupIndex (data_group),
  FOREIGN KEY (calibration_group) REFERENCES CalibrationGroupIndex (calibration_group),
  FOREIGN KEY (component_group) REFERENCES ComponentGroupIndex (component_group)
);

CREATE TABLE HardwareComponents
(
  hardware_component     INTEGER NOT NULL,
  component_name         TEXT    NOT NULL,
  component_manufacturer TEXT        NULL,
  component_description  TEXT        NULL,

  PRIMARY KEY (hardware_component)
);

CREATE TABLE ComponentGroupIndex
(
  component_group INTEGER NOT NULL,
  group_name      TEXT    NOT NULL,

  PRIMARY KEY (component_group)
);

CREATE TABLE ComponentGroups
(
  component_group    INTEGER NOT NULL,
  hardware_component INTEGER NOT NULL,
  component_position INTEGER NOT NULL,

  FOREIGN KEY (component_group) REFERENCES ComponentGroupIndex (component_group),
  FOREIGN KEY (hardware_component) REFERENCES HardwareComponents (hardware_component)
);

CREATE TABLE ComponentGroupingIndex
(
  component_grouping INTEGER NOT NULL,

  PRIMARY KEY (component_grouping)
);

CREATE TABLE ComponentGroupings
(
  component_grouping INTEGER NOT NULL,
  component_group    INTEGER NOT NULL,

  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),
  FOREIGN KEY (component_group) REFERENCES ComponentGroupIndex (component_group)
);

CREATE TABLE HardwareNotes
(
  hardware_configuration INTEGER NOT NULL,
  first_stage            INTEGER     NULL,
  second_stage           INTEGER     NULL,
  component_grouping     INTEGER     NULL,
  component_group        INTEGER     NULL,
  hardware_component     INTEGER     NULL,
  note_author            TEXT    NOT NULL,
  note_date              TEXT    NOT NULL,
  note_content           TEXT    NOT NULL,

  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),
  FOREIGN KEY (first_stage) REFERENCES FirstStages (first_stage),
  FOREIGN KEY (second_stage) REFERENCES SecondStages (second_stage),
  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),
  FOREIGN KEY (component_group) REFERENCES ComponentGroupIndex (component_group)
);


-- ------------
-- Patch Tables
-- ------------
CREATE TABLE PatchDirectories
(
  patch_directory        TEXT    NOT NULL,
  patch_category         INTEGER NOT NULL,
  time_start             INTEGER NOT NULL,
  time_stop              INTEGER NOT NULL,
  hardware_configuration INTEGER NOT NULL,

  FOREIGN KEY (patch_category) REFERENCES PatchCategories (patch_category),
  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),

  PRIMARY KEY (patch_directory)
);

CREATE TABLE PatchCategories
(
  patch_category INTEGER NOT NULL,
  category_name  TEXT    NOT NULL,

  PRIMARY KEY (patch_category)
);

CREATE TABLE PatchFiles
(
  patch_file  TEXT NOT NULL,
  patch_label TEXT NOT NULL,
  data_type   TEXT NOT NULL,

  PRIMARY KEY (patch_file)
);

CREATE TABLE PatchGroupIndex
(
  patch_group INTEGER NOT NULL,

  PRIMARY KEY (patch_group)
);

CREATE TABLE PatchGroups
(
  patch_group INTEGER NOT NULL,
  patch_file  TEXT    NOT NULL,

  FOREIGN KEY (patch_group) REFERENCES PatchGroupIndex (patch_group),
  FOREIGN KEY (patch_file) REFERENCES PatchFiles (patch_file)
);

CREATE TABLE PatchNotes
(
  patch_directory TEXT NOT NULL,
  patch_file      TEXT     NULL,
  note_author     TEXT NOT NULL,
  note_date       TEXT NOT NULL,
  note_content    TEXT NOT NULL,

  FOREIGN KEY (patch_directory) REFERENCES PatchDirectories (patch_directory),
  FOREIGN KEY (patch_file) REFERENCES PatchFiles (patch_file)
);


-- ------------------
-- Calibration Tables
-- ------------------
CREATE TABLE CalibrationDirectories
(
  calibration_directory  TEXT    NOT NULL,
  calibration_category   INTEGER NOT NULL,
  time_stamp             INTEGER NOT NULL,
  directory_completeness BOOL    NOT NULL,
  hardware_configuration INTEGER NOT NULL,

  FOREIGN KEY (calibration_category) REFERENCES CalibrationCategories (calibration_category),
  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),

  PRIMARY KEY (calibration_directory)
);

CREATE TABLE CalibrationCategories
(
  calibration_category INTEGER NOT NULL,
  category_name        TEXT    NOT NULL,

  PRIMARY KEY (calibration_category)
);

CREATE TABLE CalibrationFiles
(
  calibration_file  TEXT NOT NULL,
  calibration_label TEXT NOT NULL,
  data_type         TEXT NOT NULL,

  PRIMARY KEY (calibration_file)
);

CREATE TABLE CalibrationQuality
(
  calibration_directory TEXT NOT NULL,
  calibration_file      TEXT NOT NULL,
  calibration_quality   BOOL NOT NULL,
  file_integrity        BOOL NOT NULL,
  nominal_value         REAL     NULL,

  FOREIGN KEY (calibration_directory) REFERENCES CalibrationDirectories (calibration_directory),
  FOREIGN KEY (calibration_file) REFERENCES CalibrationFiles (calibration_file)
);

CREATE TABLE CalibrationGroupIndex
(
  calibration_group INTEGER NOT NULL,

  PRIMARY KEY (calibration_group)
);

CREATE TABLE CalibrationGroups
(
  calibration_group INTEGER NOT NULL,
  calibration_file  TEXT    NOT NULL,

  FOREIGN KEY (calibration_group) REFERENCES CalibrationGroupIndex (calibration_group),
  FOREIGN KEY (calibration_file) REFERENCES CalibrationFiles (calibration_file)
);

CREATE TABLE CalibrationNotes
(
  calibration_directory TEXT NOT NULL,
  calibration_file      TEXT     NULL,
  note_author           TEXT NOT NULL,
  note_date             TEXT NOT NULL,
  note_content          TEXT NOT NULL,

  FOREIGN KEY (calibration_directory) REFERENCES CalibrationDirectories (calibration_directory),
  FOREIGN KEY (calibration_file) REFERENCES CalibrationFiles (calibration_file)
);
