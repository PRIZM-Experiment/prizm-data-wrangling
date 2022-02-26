import sqlite3


# Connect to the MDB and initializes a cursor.
connection = sqlite3.connect('metadatabase.db')
cursor = connection.cursor()


# Sample SQL queries:

# Retrieves and prints all hardware components.
query = ("SELECT * "
         "FROM HardwareComponents ")
components = cursor.execute(query).fetchall()
for component in components: print(component)

# Retrieves and prints all directories within a ctime interval along with the type of data it contains.
query = ("SELECT directory_address, category_name "
         "FROM DataDirectories INNER JOIN DataCategories "
         "ON DataDirectories.data_category = DataCategories.data_category "
         "AND time_start < 1525030180 "
         "AND time_stop > 1524825001 ")
directories = cursor.execute(query).fetchall()
for directory in directories: print(directory)

query = ("SELECT DataDirectories.data_category, DataDirectories.directory_address, DataTypes.file_name, DataTypes.file_alias, DataTypes.data_type "
         "FROM DataDirectories "
         "INNER JOIN DataFiles "
         "ON DataDirectories.data_directory = DataFiles.data_directory "
         "AND DataDirectories.time_start < 1525030180 "
         "AND DataDirectories.time_stop > 1524825001 "
         "AND DataFiles.data_integrity = True "
         "AND DataFiles.data_quality != False "
         "INNER JOIN DataTypes "
         "ON DataFiles.data_file = DataTypes.data_file "
         "AND DataTypes.file_name LIKE '%.scio' "
         "INNER JOIN ChannelGroups "
         "ON DataFiles.channel_group = ChannelGroups.channel_group "
         "AND ChannelGroups.channel_orientation = 'EW' "
         "AND ChannelGroups.array_element = '100' "
         "ORDER BY DataDirectories.data_category, DataTypes.file_alias, DataDirectories.time_start ")

# Terminates the connection to the MDB.
connection.commit()
connection.close()
