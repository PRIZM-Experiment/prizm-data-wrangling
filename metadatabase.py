import sqlite3
import itertools
import collections
import json
import pickle
import numpy as np
from scio import scio

# Loads the data and metadata directories as set by the user.
_directories = json.load(open('settings.json', 'r'))

def execute(query):
    """ Executes the input query against the metadatabase. """

    # Connects to the MDB and initializes a cursor.
    connection = sqlite3.connect(_directories['metadata'] + '/metadatabase.db')
    cursor = connection.cursor()

    # Queries the MDB.
    result_set = cursor.execute(query).fetchall()

    # Terminates the connection to the MDB.
    connection.commit()
    connection.close()

    return result_set

def count(categories=['Antenna', 'Switch', 'Temperature'], instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], intervals=[(1524400000.0,1524500000.0),], quality=['1', '0', 'NULL'], integrity=['1', '0', 'NULL'], completeness=['1', '0', 'NULL']):
    """ Collects the classification, name, alias, data type, and count of each file of the same type matching the input arguments. """

    # Initializes the SQLite query.
    query = ""

    # Builds the query from all possible combinations of the input arguments.
    for combination, (category, instrument, channel, (start, stop), quality, integrity, completeness) in enumerate(itertools.product(*[categories, instruments, channels, intervals, quality, integrity, completeness])):
        query = ("SELECT CASE " 
                 "            WHEN DataCategories.category_name = 'Antenna' THEN ArrayElements.element_name "
                 "            ELSE DataCategories.category_name "
                 "       END "
                 "       AS classification_name, "
                 "       DataTypes.file_name AS file_name, "
                 "       CASE "
                 "            WHEN DataTypes.file_alias LIKE 'time_sys_%' THEN DataTypes.file_alias || '_' || ChannelOrientations.orientation_name "
                 "            WHEN DataTypes.file_alias LIKE 'pol%' THEN 'pol_' || ChannelOrientations.orientation_name "
                 "            ELSE DataTypes.file_alias "
                 "       END "
                 "       AS file_alias, "
                 "       DataTypes.data_type AS data_type, "
                 "       DataDirectories.data_directory "
                 "FROM   DataDirectories "
                 "JOIN   DataCategories "
                 "ON     DataDirectories.data_category = DataCategories.data_category "
                f"AND    DataCategories.category_name = '{category}' "
                f"AND    DataDirectories.directory_completeness IS {completeness} "
                 "JOIN   DataFiles "
                 "ON     DataDirectories.data_directory = DataFiles.data_directory "
                f"AND    DataDirectories.time_start <= {stop} "
                f"AND    DataDirectories.time_stop >= {start} "
                f"AND    DataFiles.data_integrity IS {integrity} "
                f"AND    DataFiles.data_quality IS {quality} "
                 "JOIN   DataTypes "
                 "ON     DataFiles.data_file = DataTypes.data_file "
                 "JOIN   ChannelGroups "
                 "ON     DataFiles.channel_group = ChannelGroups.channel_group "
                 "JOIN   ChannelOrientations "
                 "ON     ChannelOrientations.channel_orientation = ChannelGroups.channel_orientation "
                f"AND    ChannelOrientations.orientation_name = '{channel}' "
                 "JOIN   ArrayElements "
                 "ON     ArrayElements.array_element = ChannelGroups.array_element "
                f"AND    ArrayElements.element_name = '{instrument}' ") + "UNION "*bool(combination) + query

    query = "SELECT classification_name, file_name, file_alias, data_type, COUNT(file_alias) FROM (" + query + ") GROUP BY classification_name, file_alias"

    # Queries the MDB.
    result_set = execute(query)

    return result_set

def locate(categories=['Antenna', 'Switch', 'Temperature'], instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], intervals=[(1524400000.0,1524500000.0),], quality=['1', '0', 'NULL'], integrity=['1', '0', 'NULL'], completeness=['1', '0', 'NULL']):
    """ Collects the classification, path, name, alias, and data type of each file matching the input arguments. """

    # Initializes the SQLite query.
    query = ""

    # Builds the query from all possible combinations of the input arguments.
    for combination, (category, instrument, channel, (start, stop), quality, integrity, completeness) in enumerate(itertools.product(*[categories, instruments, channels, intervals, quality, integrity, completeness])):
        query = ("SELECT CASE " 
                 "            WHEN DataCategories.category_name = 'Antenna' THEN ArrayElements.element_name "
                 "            ELSE DataCategories.category_name "
                 "       END "
                 "       AS classification_name, "
                 "       DataDirectories.directory_address || '/' || DataTypes.file_name AS file_path, "
                 "       DataDirectories.time_start AS time_start, "
                 "       DataTypes.file_name AS file_name, "
                 "       CASE "
                 "            WHEN DataTypes.file_alias LIKE 'time_sys_%' THEN DataTypes.file_alias || '_' || ChannelOrientations.orientation_name "
                 "            WHEN DataTypes.file_alias LIKE 'pol%' THEN 'pol_' || ChannelOrientations.orientation_name "
                 "            ELSE DataTypes.file_alias "
                 "       END "
                 "       AS file_alias, "
                 "       DataTypes.data_type AS data_type "
                 "FROM   DataDirectories "
                 "JOIN   DataCategories "
                 "ON     DataDirectories.data_category = DataCategories.data_category "
                f"AND    DataCategories.category_name = '{category}' "
                f"AND    DataDirectories.directory_completeness IS {completeness} "
                 "JOIN   DataFiles "
                 "ON     DataDirectories.data_directory = DataFiles.data_directory "
                f"AND    DataDirectories.time_start <= {stop} "
                f"AND    DataDirectories.time_stop >= {start} "
                f"AND    DataFiles.data_integrity IS {integrity} "
                f"AND    DataFiles.data_quality IS {quality} "
                 "JOIN   DataTypes "
                 "ON     DataFiles.data_file = DataTypes.data_file "
                 "JOIN   ChannelGroups "
                 "ON     DataFiles.channel_group = ChannelGroups.channel_group "
                 "JOIN   ChannelOrientations "
                 "ON     ChannelOrientations.channel_orientation = ChannelGroups.channel_orientation "
                f"AND    ChannelOrientations.orientation_name = '{channel}' "
                 "JOIN   ArrayElements "
                 "ON     ArrayElements.array_element = ChannelGroups.array_element "
                f"AND    ArrayElements.element_name = '{instrument}' ") + "UNION "*bool(combination) + query

    query = "SELECT classification_name, file_path, file_name, file_alias, data_type FROM (" + query + ") ORDER BY classification_name, time_start"

    # Queries the MDB.
    result_set = execute(query)

    return result_set

def _load(count_result_set, locate_result_set):
    """ Loads all files matching the result sets outputted by the `count` and `locate` functions. """

    # Initializes auxiliary data-loading dictionaries.
    data = collections.defaultdict(dict)
    rows = collections.defaultdict(dict)
    counter = collections.defaultdict(dict)

    # Allocates the auxiliary data-loading dictionaries.
    for (classification_name, _, file_alias, _, file_count) in count_result_set: 
        data[classification_name][file_alias] = [None]*file_count
        rows[classification_name][file_alias] = [0] + [None]*file_count
        counter[classification_name][file_alias] = 0

    # Loads each file matching the input arguments.
    for (classification_name, file_path, file_name, file_alias, data_type) in locate_result_set: 
        index = counter[classification_name][file_alias]

        if '.scio' in file_name:
            data[classification_name][file_alias][index] = scio.read(_directories['data'] + file_path) 

        elif '.raw' in file_name:
            data[classification_name][file_alias][index] = np.fromfile(_directories['data'] + file_path, data_type)

        rows[classification_name][file_alias][index+1] = rows[classification_name][file_alias][index] + len(data[classification_name][file_alias][index])
        counter[classification_name][file_alias] += 1

    # Initializes the output dictionary.
    output = collections.defaultdict(dict)

    # Allocates and populates the output dictionary.
    for (classification_name, file_name, file_alias, data_type, _) in count_result_set:
        if '.scio' in file_name:
            output[classification_name][file_alias] = np.empty((rows[classification_name][file_alias][-1], data[classification_name][file_alias][-1].shape[1]), data_type)

        elif '.raw' in file_name:
            output[classification_name][file_alias] = np.empty((rows[classification_name][file_alias][-1],), data_type)

        for file_data, file_rows in zip(data[classification_name][file_alias], rows[classification_name][file_alias]):
            output[classification_name][file_alias][file_rows:file_rows+len(file_data)] = file_data

    return output

def load(categories=['Antenna', 'Switch', 'Temperature'], instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], intervals=[(1524400000.0,1524500000.0),], quality=['1', '0', 'NULL'], integrity=['1', '0', 'NULL'], completeness=['1', '0', 'NULL'], selection=None):
    """ Loads all data files matching the input arguments. """

    if selection == None:
        # Generates the needed result sets from the input arguments.
        count_result_set = count(categories, instruments, channels, intervals, quality, integrity, completeness)
        locate_result_set = locate(categories, instruments, channels, intervals, quality, integrity, completeness)
    else:
        # Loads and unpacks the input data selection.
        count_result_set, locate_result_set = pickle.load(open(selection, 'rb'))

    return _load(count_result_set, locate_result_set)
