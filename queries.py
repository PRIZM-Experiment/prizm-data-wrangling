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
         "FROM DataDirectories JOIN DataCategories "
         "ON DataDirectories.data_category = DataCategories.data_category "
         "AND time_start < 1525030180 "
         "AND time_stop > 1524825001 ")
directories = cursor.execute(query).fetchall()
for directory in directories: print(directory)

# Terminates the connection to the MDB.
connection.commit()
connection.close()
