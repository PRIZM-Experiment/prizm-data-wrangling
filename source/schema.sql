--------------------------------
-- Metadatabase Schema for PRIZM
--------------------------------


-- -----------
-- Data Tables
-- -----------
CREATE TABLE DataDirectories
(
  data_directory         INTEGER NOT NULL,
  directory_address      TEXT    NOT NULL,
  data_category          INTEGER NOT NULL,
  hardware_configuration INTEGER NOT NULL,
  time_start             REAL    NOT NULL,
  time_stop              REAL    NOT NULL,
  directory_completeness BOOLEAN NOT NULL,

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

CREATE TABLE DataTypes
(
  data_file        INTEGER NOT NULL,
  file_name        TEXT    NOT NULL,
  file_alias       TEXT    NOT NULL,
  data_type        TEXT    NOT NULL,
  data_description TEXT    NOT NULL, 

  PRIMARY KEY (data_file)
);

CREATE TABLE DataFiles
(
  data_directory INTEGER NOT NULL,
  data_file      INTEGER NOT NULL,
  channel_group  INTEGER NOT NULL,
  data_integrity BOOLEAN NOT NULL,
  data_quality   BOOLEAN     NULL,

  FOREIGN KEY (data_directory) REFERENCES DataDirectories (data_directory),
  FOREIGN KEY (data_file) REFERENCES DataTypes (data_file),
  FOREIGN KEY (channel_group) REFERENCES ChannelGroupIndex (channel_group),

  PRIMARY KEY (data_directory, data_file)
);

CREATE TABLE DataNotes
(
  hardware_configuration INTEGER NOT NULL,
  data_directory         INTEGER     NULL,
  data_file              INTEGER     NULL,
  note_author            TEXT    NOT NULL,
  note_date              TEXT    NOT NULL,
  note_content           TEXT    NOT NULL,

  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),
  FOREIGN KEY (data_directory) REFERENCES DataDirectories (data_directory),
  FOREIGN KEY (data_file) REFERENCES DataTypes (data_file)
);


-- ---------------
-- Hardware Tables
-- ---------------
CREATE TABLE HardwareConfigurations
(
  hardware_configuration INTEGER NOT NULL,
  configuration_name     TEXT    NOT NULL,
  first_stage_group      INTEGER NOT NULL,
  second_stage_group     INTEGER NOT NULL,

  FOREIGN KEY (first_stage_group) REFERENCES FirstStageGroupIndex (first_stage_group),
  FOREIGN KEY (second_stage_group) REFERENCES SecondStageGroupIndex (second_stage_group),

  PRIMARY KEY (hardware_configuration)
);

CREATE TABLE ArrayElements
(
  array_element INTEGER NOT NULL,
  element_name  TEXT    NOT NULL,

  PRIMARY KEY (array_element)
);

CREATE TABLE FirstStageGroupIndex
(
  first_stage_group INTEGER NOT NULL,
  group_name        TEXT    NOT NULL,

  PRIMARY KEY (first_stage_group)
);

CREATE TABLE FirstStageGroups
(
  first_stage_group INTEGER NOT NULL,
  first_stage       INTEGER NOT NULL,

  FOREIGN KEY (first_stage_group) REFERENCES FirstStageGroupIndex (first_stage_group),
  FOREIGN KEY (first_stage) REFERENCES FirstStages (first_stage)
);

CREATE TABLE FirstStages
(
  first_stage        INTEGER NOT NULL,
  stage_name         TEXT    NOT NULL,
  array_element      INTEGER NOT NULL,
  component_grouping INTEGER NOT NULL,

  FOREIGN KEY (array_element) REFERENCES ArrayElements (array_element),
  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),

  PRIMARY KEY (first_stage)
);

CREATE TABLE SecondStageGroupIndex
(
  second_stage_group INTEGER NOT NULL,
  group_name         TEXT    NOT NULL,

  PRIMARY KEY (second_stage_group)
);

CREATE TABLE SecondStageGroups
(
  second_stage_group INTEGER NOT NULL,
  second_stage       INTEGER NOT NULL,

  FOREIGN KEY (second_stage_group) REFERENCES SecondStageGroupIndex (second_stage_group),
  FOREIGN KEY (second_stage) REFERENCES SecondStages (second_stage)
);

CREATE TABLE SecondStages
(
  second_stage       INTEGER NOT NULL,
  stage_name         TEXT    NOT NULL,
  component_grouping INTEGER NOT NULL,

  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),

  PRIMARY KEY (second_stage)
);

CREATE TABLE ChannelGroupIndex
(
  channel_group INTEGER NOT NULL,
  group_name    TEXT    NOT NULL,

  PRIMARY KEY (channel_group)
);

CREATE TABLE ChannelGroups
(
  channel_group       INTEGER NOT NULL,
  channel_orientation INTEGER NOT NULL,
  array_element       INTEGER NOT NULL,

  FOREIGN KEY (channel_group) REFERENCES ChannelGroupIndex (channel_group),
  FOREIGN KEY (channel_orientation) REFERENCES ChannelOrientations (channel_orientation),
  FOREIGN KEY (array_element) REFERENCES ArrayElements (array_element)
);

CREATE TABLE ChannelOrientations
(
  channel_orientation INTEGER NOT NULL,
  orientation_name    TEXT    NOT NULL,

  PRIMARY KEY (channel_orientation)
);

CREATE TABLE HardwareChannels
(
  hardware_configuration INTEGER NOT NULL,
  second_stage           INTEGER NOT NULL,
  component_group        INTEGER NOT NULL,
  channel_orientation    INTEGER NOT NULL,
  array_element          INTEGER NOT NULL,

  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),
  FOREIGN KEY (second_stage) REFERENCES SecondStages (second_stage),
  FOREIGN KEY (component_group) REFERENCES ComponentGroupIndex (component_group),
  FOREIGN KEY (channel_orientation) REFERENCES ChannelOrientations (channel_orientation),
  FOREIGN KEY (array_element) REFERENCES ArrayElements (array_element)
);

CREATE TABLE HardwareComponents
(
  hardware_component     INTEGER NOT NULL,
  component_model        TEXT    NOT NULL,
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
  grouping_name      TEXT    NOT NULL,

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
  array_element          INTEGER     NULL,
  first_stage            INTEGER     NULL,
  second_stage           INTEGER     NULL,
  component_grouping     INTEGER     NULL,
  component_group        INTEGER     NULL,
  hardware_component     INTEGER     NULL,
  note_author            TEXT    NOT NULL,
  note_date              TEXT    NOT NULL,
  note_content           TEXT    NOT NULL,

  FOREIGN KEY (hardware_configuration) REFERENCES HardwareConfigurations (hardware_configuration),
  FOREIGN KEY (array_element) REFERENCES ArrayElements (array_element),
  FOREIGN KEY (first_stage) REFERENCES FirstStages (first_stage),
  FOREIGN KEY (second_stage) REFERENCES SecondStages (second_stage),
  FOREIGN KEY (component_grouping) REFERENCES ComponentGroupingIndex (component_grouping),
  FOREIGN KEY (component_group) REFERENCES ComponentGroupIndex (component_group)
);
