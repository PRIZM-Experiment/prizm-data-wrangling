import numpy as np
import itertools
from metadatabase import _load

def rectify(pairs):
    """ . """

    # Removes switch states with invalid timestamps.
    pairs = np.array([list(group)[0] for time, group in itertools.groupby(pairs, lambda pair: pair[1]) if time != 0])

    # Removes all unpaired switch states.
    pairs = np.array([list(group)[-1] if state == 1 else list(group)[0] for state, group in itertools.groupby(pairs, lambda pair : pair[0])])
    if pairs[-1,0] == 1: pairs = pairs[:-1,:]

    return pairs

def add_switch_flags(data, instruments=['100MHz', '70MHz']):
    """ . """

    for instrument in instruments:

        data[instrument]['switch_flags'] = {}

        for entry in data['switch']:

            pairs = rectify(data['switch'][entry])

            flags = np.zeros_like(data[instrument]['time_sys_start'], dtype='bool')

            for _, start, _, stop in np.reshape(pairs, (-1,4)):
                 flags[(data[instrument]['time_sys_start'] >= start)*(data[instrument]['time_sys_stop'] <= stop)] = True

            data[instrument]['switch_flags'][entry] = flags

    return

def load(directory_addresses=['~'], file_catalog={'pol0.scio.bz2':'float', 'time_sys_start.raw':'float', 'time_sys_stop.raw':'float'}):
    """ . """

    # Initializes the result sets.
    count_result_set = []
    locate_result_set = []

    # Extracts all file names.
    file_names = list(file_catalog.keys())

    # Collects the classification, path, name, alias, and data type of each catalogued file located within the input directory addresses.
    for directory_address, file_name in itertools.product(*[directory_addresses, file_names]):
        for file_path in glob.iglob(directory_address + '/**/' + file_name, recursive=True):
            classification_name = file_path.split('/')[-4]
            file_alias = file_name.split('.')[0]
            data_type = file_catalog[file_name]
            locate_result_set.append((classification_name, file_path, file_name, file_alias, data_type))

    # Sorts the collected metadata by file path.
    locate_result_set.sort(key=lambda entry: entry[2])

    # Collects the classification, name, alias, data type, and count of each catalogued file of the same type located within the input directory addresses.
    for ((classification_name, file_name), file_count) in collections.Counter([(classification_name, file_alias) for (classification_name, _, _, file_alias, _) in locate_result_set]).items():
        file_alias = file_name.split('.')[0]
        data_type = file_catalog[file_name]
        count_result_set.append((classification_name, file_name, file_alias, data_type, file_count)) 

    return _load(count_result_set, locate_result_set)

