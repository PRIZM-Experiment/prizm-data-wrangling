/*
.read metadata.sql
*/

---------------------
-- Metadata for PRIZM
---------------------
.open metadatabase.db


-- --------
-- Hardware
-- --------
INSERT INTO HardwareConfigurations(hardware_configuration, configuration_name, first_stage_group, second_stage_group)
VALUES(0, 'M18', 0, 0);

INSERT INTO ArrayElements(array_element, element_name)
VALUES(0, '70');
INSERT INTO ArrayElements(array_element, element_name)
VALUES(1, '100');

INSERT INTO FirstStageGroupIndex(first_stage_group, group_name)
VALUES(0, 'M18-FS-G');

INSERT INTO FirstStageGroups(first_stage_group, first_stage)
VALUES(0, 0);
INSERT INTO FirstStageGroups(first_stage_group, first_stage)
VALUES(0, 1);

INSERT INTO FirstStages(first_stage, stage_name, array_element, component_grouping)
VALUES(0, 'M18-FS-70', 0, 0);
INSERT INTO FirstStages(first_stage, stage_name, array_element, component_grouping)
VALUES(1, 'M18-FS-100', 1, 0);

INSERT INTO SecondStageGroupIndex(second_stage_group, group_name)
VALUES(0, 'M18-SS-G');

INSERT INTO SecondStageGroups(second_stage_group, second_stage)
VALUES(0, 0);

INSERT INTO SecondStages(second_stage, stage_name, component_grouping)
VALUES(0, 'M18-SS', 0, 1);

INSERT INTO ChannelOrientations(channel_orientation, orientation_name)
VALUES(0, 'EW');
INSERT INTO ChannelOrientations(channel_orientation, orientation_name)
VALUES(1, 'NS');

INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(0, 'VAT-3+', 'Mini-Circuits', '3 dB Fixed Attenuator, DC - 6000 MHz, 50 Ohm.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(1, '6A', 'APITech Inmet', '3 dB Fixed Coaxial Attenuator, SMA Models A, DC - 6000 MHz.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(2, 'SLP-200+', 'Mini-Circuits', 'Lumped LC Low Pass Filter, DC - 190 MHz, 50 Ohm.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(3, 'SHP-25+', 'Mini-Circuits', 'Lumped LC High Pass Filter, 27.5 MHz - 800 MHz.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(4, 'ZX60-33LN-S+', 'Mini-Circuits', 'Low Noise Amplifier, 50 MHz to 3 GHz.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(5, 'CCR-39S860', 'Teledyne', 'Coaxial Latching Switch, SP6T, 28 VDC.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(6, 'WEA101', 'WanTcom', '20 dB Low Noise Amplifier, 20 MHz - 500 MHz.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(7, 'ANNE-50+', 'Mini-Circuits', '50 Ohm Termination, DC - 18000 MHz.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(8, '?', '?', '100 Ohm Calibration Source.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(9, '?', '?', 'Noise Calibration Source.');
INSERT INTO HardwareComponents(hardware_component, component_model, component_manufacturer, component_description)
VALUES(10, 'HIbiscus', 'RhoTech and Pinion & Adams', 'HIbiscus Four-Square Antenna.');

INSERT INTO ComponentGroupIndex(component_group, group_name)
VALUES(0, 'M18-RFC-G');

INSERT INTO ComponentGroups(component_group, hardware_component, component_position)
VALUES(0, 1, 0);
INSERT INTO ComponentGroups(component_group, hardware_component, component_position)
VALUES(0, 2, 1);
INSERT INTO ComponentGroups(component_group, hardware_component, component_position)
VALUES(0, 3, 2);
INSERT INTO ComponentGroups(component_group, hardware_component, component_position)
VALUES(0, 1, 3);
INSERT INTO ComponentGroups(component_group, hardware_component, component_position)
VALUES(0, 4, 4);

INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(0, 'EW-70');
INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(1, 'NS-70');
INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(2, 'EW+NS-70');
INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(3, 'EW-100');
INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(4, 'NS-100');
INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(5, 'EW+NS-100');
INSERT INTO ChannelGroupIndex(channel_group, group_name)
VALUES(6, 'EW+NS-70+100');

INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(0, 0, 0);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(1, 1, 0);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(2, 0, 0);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(2, 1, 0);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(3, 0, 1);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(4, 1, 1);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(5, 0, 1);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(5, 1, 1);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(6, 0, 0);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(6, 1, 0);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(6, 0, 1);
INSERT INTO ChannelGroups(channel_group, channel_orientation, array_element)
VALUES(6, 1, 1);

INSERT INTO HardwareChannels(hardware_configuration, second_stage, component_group, channel_orientation, array_element)
VALUES(0, 0, 0, 0, 0);
INSERT INTO HardwareChannels(hardware_configuration, second_stage, component_group, channel_orientation, array_element)
VALUES(0, 0, 0, 1, 0);
INSERT INTO HardwareChannels(hardware_configuration, second_stage, component_group, channel_orientation, array_element)
VALUES(0, 0, 0, 0, 1);
INSERT INTO HardwareChannels(hardware_configuration, second_stage, component_group, channel_orientation, array_element)
VALUES(0, 0, 0, 1, 1);

-- TODO: Populate the ComponentGroupings and ComponentGroupingIndex tables. (Need a more complete list of hardware components first!)


-- ----
-- Data
-- ----

INSERT INTO DataCategories(data_category, category_name)
VALUES(0, 'Antenna');
INSERT INTO DataCategories(data_category, category_name)
VALUES(1, 'Switch');
INSERT INTO DataCategories(data_category, category_name)
VALUES(2, 'Temperature');

INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(0, 'pol0.scio', 'pol0', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(1, 'pol1.scio', 'pol1', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(2, 'cross_real.scio', 'cross_real', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(3, 'cross_imag.scio', 'cross_imag', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(4, 'acc_cnt1.raw', 'acc_cnt1', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(5, 'acc_cnt2.raw', 'acc_cnt2', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(6, 'fft_of_cnt.raw', 'fft_on_cnt', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(7, 'fft_shift.raw', 'fft_shift', 'int64');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(8, 'fpga_temp.raw', 'fpga_temp', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(9, 'pi_temp.raw', 'pi_temp', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(10, 'sync_cnt1.raw', 'sync_cnt1', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(11, 'sync_cnt2.raw', 'sync_cnt2', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(12, 'sys_clk1.raw', 'sys_clk1', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(13, 'sys_clk2.raw', 'sys_clk2', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(14, 'time_start.raw', 'time_sys_start', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(15, 'time_stop.raw', 'time_sys_stop', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(16, 'time_rtc_start.raw', 'time_rtc_start', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(17, 'time_rtc_stop.raw', 'time_rtc_stop', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(18, 'time_sys_start.raw', 'time_sys_start', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(19, 'time_sys_stop.raw', 'time_sys_stop', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(20, 'antenna.scio', 'antenna', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(21, 'noise.scio', 'noise', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(22, 'open.scio', 'open', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(23, 'short.scio', 'short', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(24, 'res50.scio', 'res50', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(25, 'res100.scio', 'res100', 'int32');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(26, 'temp_100A_top_lna.raw', 'temp_100A_top_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(27, 'temp_100A_bot_lna.raw', 'temp_100A_bot_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(28, 'temp_100A_noise.raw', 'temp_100A_noise', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(29, 'temp_100A_switch.raw', 'temp_100A_switch', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(30, 'temp_100B_top_lna.raw', 'temp_100B_top_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(31, 'temp_100B_bot_lna.raw', 'temp_100B_bot_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(32, 'temp_100B_noise.raw', 'temp_100B_noise', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(33, 'temp_100B_switch.raw', 'temp_100B_switch', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(34, 'temp_100_ambient.raw', 'temp_100_ambient', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(35, 'temp_70A_top_lna.raw', 'temp_70A_top_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(36, 'temp_70A_bot_lna.raw', 'temp_70A_bot_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(37, 'temp_70A_noise.raw', 'temp_70A_noise', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(38, 'temp_70A_switch.raw', 'temp_70A_switch', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(39, 'temp_70B_top_lna.raw', 'temp_70B_top_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(40, 'temp_70B_bot_lna.raw', 'temp_70B_bot_lna', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(41, 'temp_70B_noise.raw', 'temp_70B_noise', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(42, 'temp_70B_switch.raw', 'temp_70B_switch', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(43, 'temp_70_ambient.raw', 'temp_70_ambient', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(44, 'temp_pi.raw', 'temp_pi', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(45, 'temp_snapbox.raw', 'temp_snapbox', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(46, 'time_pi.raw', 'time_pi', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(47, 'time_start_therms.raw', 'time_start_therms', 'float');
INSERT INTO DataFiles(data_file, file_name, file_alias, data_type)
VALUES(48, 'time_stop_therms.raw', 'time_stop_therms', 'float');

INSERT INTO DataDirectories(data_directory, directory_address, data_category, hardware_configuration, time_start, time_stop, directory_completness)
VALUES(0, '/marion2018/patches_100MHz/15244/1524485407', 0, 0, 1524485412, 1524500742, 1);
VALUES(1, '/marion2018/patches_100MHz/15247/1524700435', 0, 0, 1524700452, 1524787198, 1);
VALUES(2, '/marion2018/patches_100MHz/15252/1525200770', 0, 0, 1525200785, 1525300118, 1);
VALUES(3, '/marion2018/patches_100MHz/15260/1526046765', 0, 0, 1526046776, 1526100606, 1);
VALUES(4, '/marion2018/patches_100MHz/15261/1526100607', 0, 0, 1526100623, 1526200089, 1);

INSERT INTO DataChannels(data_directory, data_file, channel_group, data_quality, file_integrity)
