import glob 
import itertools
import collections
import numpy as np
from metadatabase import _load


def add_switch_flags(data, instruments=['100MHz', '70MHz'], channels=['EW', 'NS']):
    """ Produces flags separating the data according to its associated switch states. """

    for channel, instrument in itertools.product(*[channels, instruments]):
        # Ensures the data dictionary has an entry for flags.
        if 'Flags' not in data[instrument][channel].keys():
            data[instrument][channel]['Flags'] = {}

        for file_alias, switch_data in data['Switch'].items():
            # Removes switch states with invalid timestamps, as well as unpaired switch states.
            switch_data = np.array([list(group)[0] for timestamp, group in itertools.groupby(switch_data, lambda entry: entry[1]) if timestamp != 0])
            switch_data = np.array([list(group)[-1] if state == 1 else list(group)[0] for state, group in itertools.groupby(switch_data, lambda entry: entry[0])])
            if switch_data[-1,0] == 1: switch_data = switch_data[:-1,:]

            # Initializes an empty flags object. 
            flags = np.zeros_like(data[instrument][channel]['time_sys_start'], dtype='bool')

            # Produces the Switch flags.
            for _, start, _, stop in np.reshape(switch_data, (-1,4)):
                lower_bound = data[instrument][channel]['time_sys_start'] >= start
                upper_bound = data[instrument][channel]['time_sys_stop'] <= stop
                flags[lower_bound*upper_bound] = True

            data[instrument][channel]['Flags'][entry] = flags

    return

def load(directory_addresses=['~'], classification_catalog={}, file_catalog={}):
    """ Loads the catalogued files located under the input directory addresses, organizing them according to the catalogued categories. """

    classification_catalog = {
            **{
                'switch':'Switch',
                'data_70MHz': '70MHz', 
                'data_100MHz': '100MHz',
                'temperature':'Temperature',
                },
            **classification_catalog
            }

    file_catalog = {
            **{
                'pol0.scio': ('float','EW','pol'),
                'pol1.scio': ('float','NS','pol'),
                'pol0.scio.bz2': ('float','EW','pol'),
                'pol1.scio.bz2': ('float','NS','pol'),
                'time_sys_stop.raw': ('float','EW','time_sys_stop'),
                'time_sys_stop.raw': ('float','NS','time_sys_stop'),
                'time_sys_start.raw': ('float','EW','time_sys_start'),
                'time_sys_start.raw': ('float','NS','time_sys_start'),
                'open.scio': ('float','','open'),
                'short.scio': ('float','','short'),
                'res50.scio': ('float','','res50'),
                'res100.scio': ('float','','res100'),
                'antenna.scio': ('float','','antenna'),
                },
            **file_catalog
            }

    # Initializes the result sets.
    count_result_set = []
    locate_result_set = []

    # Extracts all file names.
    file_names = list(file_catalog.keys())

    # Collects the classification, path, name, alias, and data type of each catalogued file located within the input directory addresses.
    for directory_address, file_name in itertools.product(*[directory_addresses, file_names]):
        for file_path in glob.iglob(directory_address + '/**/' + file_name, recursive=True):
            classification_name = classification_catalog[file_path.split('/')[-4]]
            file_extension = file_name.split('.')[1]
            data_type, orientation_name, file_alias = file_catalog[file_name]
            locate_result_set.append((classification_name, orientation_name, file_path, file_extension, file_alias, data_type))

    # Sorts the collected metadata.
    locate_result_set.sort()

    # Collects the classification, name, alias, data type, and count of each catalogued file of the same type located within the input directory addresses.
    for ((classification_name, orientation_name, file_extension, file_alias, data_type), file_count) in collections.Counter([(classification_name, orientation_name, file_extension, file_alias, data_type) for (classification_name, orientation_name, _, file_extension, file_alias, data_type) in locate_result_set]).items():
        count_result_set.append((classification_name, orientation_name, file_extension, file_alias, data_type, file_count)) 

    return _load(count_result_set, locate_result_set, '')

