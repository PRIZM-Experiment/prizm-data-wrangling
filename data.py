import glob
import operator
import itertools
import collections
import numpy as np
from metadatabase import _load


def add_switch_flags(data, instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], buffer=(0, 0)):
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
            flags = list()

            # Produces the Switch flags.
            for _, start, _, stop in np.reshape(switch_data, (-1,4)):
                beginning = np.searchsorted(data[instrument][channel]['time_sys_start'], start) + buffer[0]
                end = np.searchsorted(data[instrument][channel]['time_sys_stop'], stop, side='right') - buffer[1]
                if beginning < end: flags.append(slice(beginning, end, None))

            data[instrument][channel]['Flags'][file_alias] = flags

    return

def get(data, entry='pol', instrument='100MHz', channel='EW', kind='antenna'):
    """ Extracts the spectra of a given kind from the input data. """

    return np.r_[operator.itemgetter(*data[instrument][channel]['Flags'][kind])(data[instrument][channel][entry])]

def interpolate(data, times, kind='short', instrument='100MHz', channel='EW', threshold=500):
    """ Employs linear interpolation to obtain the spectra of a given kind for each input time. """

    # The data to be interpolated: y = interpolant_(x)
    x = data[instrument][channel]['time_sys_start']
    y = data[instrument][channel]['pol']
    interpolation_data = list()

    # Collects the appropriate flags located in the vicinity of each input time value.
    flags = data[instrument][channel]['Flags'][kind]
    slices = [slice(index, index + 1, None) for index in np.searchsorted(x, times)]
    flags = [(flags[index - 2], flags[index - 1], flags[index], flags[index + 1]) for index in np.searchsorted(flags, slices)]

    # Selects pairs of flags to be used in the interpolation.
    for flag, time in zip(flags, times):
        # Identifies which flags in the vicinity of the current time satisfy the input threshold.
        pattern = list(map(np.mean, operator.itemgetter(*flag)(x)))
        pattern.insert(2, time)
        pattern = np.abs(np.diff(pattern)) < threshold

        # Picks the appropriate pair of flags based on the pattern identified above.
        if np.all(pattern[1:3] == [True,True]): selection = (flag[1],flag[2])
        elif np.all(pattern[0:2] == [True,True]): selection = (flag[0],flag[1])
        elif np.all(pattern[2:4] == [True,True]): selection = (flag[2],flag[3])
        elif np.all(pattern[0:3] == [False,True,False]): selection = (flag[1],flag[1])
        elif np.all(pattern[1:4] == [False,True,False]): selection = (flag[2],flag[2])
        else:
            # None of the flags clear the input threshold.
            interpolation_data.append((np.NaN, np.empty(y.shape[1]), np.NaN, np.empty(y.shape[1]), time))
            continue

        # Appends a new pair of points to be interpolated.
        interpolation_data.append((x[selection[0]].mean(), y[selection[0]].mean(axis=0), x[selection[1]].mean(), y[selection[1]].mean(axis=0), time))

    return np.array(list(map(_interpolant, interpolation_data)))

def _interpolant(interpolation_data):
    """ Linear inerpolant used to extrapolate spectra of a given kind over time. """
 
    # Unpacks the input interpolation data.
    x0, y0, x1, y1, x = interpolation_data

    # Returns the linearly interpolated spectra.
    if x0 == x1:
        return y0
    else:
        return y0*(x1 - x)/(x1 - x0) + y1*(x - x0)/(x1 - x0)

def load(directory_addresses=['~'], classification_catalog={}, file_catalog={}):
    """ Loads the catalogued files located under the input directory addresses, organizing them according to the catalogued categories. """

    classification_catalog = {
            **{
                'switch': 'Switch',
                'data_70MHz': '70MHz', 
                'data_100MHz': '100MHz',
                'temperature': 'Temperature',
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

