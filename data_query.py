import sqlite3


# Connect to the MDB and initializes a cursor.
connection = sqlite3.connect('metadatabase.db')
cursor = connection.cursor()


query = ("SELECT DataDirectories.data_category, DataDirectories.directory_address || '/' || DataTypes.file_name, DataTypes.file_alias, DataTypes.data_type "
         "FROM DataDirectories "
         "INNER JOIN DataFiles "
         "ON DataDirectories.data_directory = DataFiles.data_directory "
         "AND DataDirectories.time_start <= :end "
         "AND DataDirectories.time_stop >= :begin "
         "AND DataFiles.data_integrity = :integrity "
         "AND DataFiles.data_quality = :quality "
         "INNER JOIN DataTypes "
         "ON DataFiles.data_file = DataTypes.data_file "
         "INNER JOIN ChannelGroups "
         "ON DataFiles.channel_group = ChannelGroups.channel_group "
         "INNER JOIN ChannelOrientations "
         "ON ChannelOrientations.channel_orientation = ChannelGroups.channel_orientation "
         "AND ChannelOrientations.orientation_name = :channel "
         "INNER JOIN ArrayElements "
         "ON ArrayElements.array_element = ChannelGroups.array_element "
         "AND ArrayElements.element_name = :instrument "
         "ORDER BY DataDirectories.data_category, DataTypes.file_alias, DataDirectories.time_start ")

parameters = {'integrity': int(True), 'quality': int(True), 'begin': 1524500000, 'end': 1524700000, 'channel': 'EW', 'instrument': '100'}

data = cursor.execute(query, parameters).fetchall()

# Prints the query results.
for entry in data:
    print(entry)


# Terminates the connection to the MDB.
connection.commit()
connection.close()
