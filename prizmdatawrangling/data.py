import glob
import pickle
import operator
import itertools
import collections
import numpy as np
import prizmdatawrangling.metadatabase as mdb
from astropy.time import Time


class Data(collections.UserDict):

    def __init__(self, count_result_set, locate_result_set, parent_directory):
        super().__init__(mdb._load(count_result_set, locate_result_set, parent_directory))

    @classmethod
    def via_metadatabase(cls, categories=['Antenna', 'Switch', 'Temperature'], instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], intervals=[(1524400000.0,1524500000.0),], quality=[1, 0, 'NULL'], integrity=[1, 0, 'NULL'], completeness=[1, 0, 'NULL'], selection=None):
        """ Loads all data files matching the input arguments. """

        if selection == None:
            # Generates the needed result sets from the input arguments.
            count_result_set = mdb.count(categories, instruments, channels, intervals, quality, integrity, completeness)
            locate_result_set = mdb.locate(categories, instruments, channels, intervals, quality, integrity, completeness)
        else:
            # Loads the needed result sets from the input pickle file.
            count_result_set, locate_result_set = pickle.load(open(selection, 'rb'))

        return cls(count_result_set, locate_result_set, mdb._directories['data'])

    @classmethod
    def from_directories(cls, directory_addresses=['~'], classification_catalogue={'data_70MHz': '70MHz', 'data_100MHz': '100MHz'}, file_catalogue={'pol0.scio': ('float',['EW'],'pol'), 'pol1.scio': ('float',['NS'],'pol'), 'pol0.scio.bz2': ('float',['EW'],'pol'), 'pol1.scio.bz2': ('float',['NS'],'pol'), 'time_sys_stop.raw': ('float',['EW','NS'],'time_sys_stop'), 'time_sys_stop.raw': ('float',['EW','NS'],'time_sys_stop'), 'open.scio': ('float',['Switch'],'open'), 'short.scio': ('float',['Switch'],'short'), 'noise.scio': ('float',['Switch'],'noise'), 'res50.scio': ('float',['Switch'],'res50'), 'res100.scio': ('float',['Switch'],'res100'), 'antenna.scio': ('float',['Switch'],'antenna'), 'open.scio.bz2': ('float',['Switch'],'open'), 'short.scio.bz2': ('float',['Switch'],'short'), 'noise.scio.bz2': ('float',['Switch'],'noise'), 'res50.scio.bz2': ('float',['Switch'],'res50'), 'res100.scio.bz2': ('float',['Switch'],'res100'), 'antenna.scio.bz2': ('float',['Switch'],'antenna')}):
        """ Loads the cataloged files located under the input directory addresses, organizing them according to the input classification catalogue.

            Important: This constructor assumes that the data directory structure is headed by an instrument directory (e.g. '../data_70MHz') containing sub-directories for that instrument's antenna data (e.g. '../data_70MHz/16348', etc.), switch data (e.g. '../data_70MHz/switch'), and temperature data (e.g. '../data_70MHz/temperature'). 

        """

        # Initializes the result sets.
        count_result_set = []
        locate_result_set = []

        # Extracts all file names.
        file_names = list(file_catalogue.keys())

        # Collects the classification, path, name, alias, and data type of each cataloged file located within the input directory addresses.
        for directory_address, file_name in itertools.product(*[directory_addresses, file_names]):
            for file_path in glob.iglob(directory_address + '/**/' + file_name, recursive=True):
                classification_name = [classification for key, classification in classification_catalogue.items() if key in file_path.split('/')][0]
                file_extension = file_name.split('.')[1]
                data_type, subclassification_names, file_alias = file_catalogue[file_name]
                for subclassification_name in subclassification_names:
                    locate_result_set.append((classification_name, subclassification_name, file_path, file_extension, file_alias, data_type))

        # Sorts the collected metadata.
        locate_result_set.sort()

        # Collects the classification, name, alias, data type, and count of each cataloged file of the same type located within the input directory addresses.
        for ((classification_name, subclassification_name, file_extension, file_alias, data_type), file_count) in collections.Counter([(classification_name, subclassification_name, file_extension, file_alias, data_type) for (classification_name, subclassification_name, _, file_extension, file_alias, data_type) in locate_result_set]).items():
            count_result_set.append((classification_name, subclassification_name, file_extension, file_alias, data_type, file_count))

        return cls(count_result_set, locate_result_set, '')

    def lst(self, instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], location=('37.819638d', '-46.88694d')):
        """ Produces local sidereal time entries for each input instrument and channel. The default location is set to PRIZM's deployment site at Marion island."""

        lst(self, instruments, channels, location)

        return

    def partition(self, instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], buffer=(0, 0)):
        """ Produces partitions which slice the data according to the instrument's switch states. """

        partition(self, instruments, channels, buffer)

        return

    def get(self, data='pol', instrument='100MHz', channel='EW', partition='antenna'):
        """ Extracts the data partition associated with the input instrument and channel. """

        return get(self, data, instrument, channel, partition)

    def interpolate(self, times, instrument='100MHz', channel='EW', partition='short', threshold=500):
        """ Employs linear interpolation over a given data partition to extrapolate spectra for each input time. """

        return interpolate(self, times, instrument, channel, partition, threshold)


def iso(ctimes):
    """ Converts UNIX times (UTC) to the ISO 8601 compliant date-time format 'YYYY-MM-DD HH:MM:SS.sss'. """

    return Time(ctimes, format='unix', scale='utc').iso

def _interpolant(interpolation_data):
    """ Linear interpolant used to extrapolate spectra of a given kind over time. """

    # Unpacks the input interpolation data.
    x0, y0, x1, y1, x = interpolation_data

    # Returns the linearly interpolated spectrum.
    if x0 == x1:
        return y0
    else:
        return y0*(x1 - x)/(x1 - x0) + y1*(x - x0)/(x1 - x0)

def lst(self, instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], location=('37.819638d', '-46.88694d')):
    """ Produces local sidereal time entries for each input instrument and channel. The default location is set to PRIZM's deployment site at Marion island."""

    for channel, instrument in itertools.product(*[channels, instruments]):
        # Converts UNIX time to local sidereal time.
        self[instrument][channel]['lst_sys_start'] = Time(self[instrument][channel]['time_sys_start'], format='unix', scale='utc', location=location).sidereal_time('apparent').value
        self[instrument][channel]['lst_sys_stop'] = Time(self[instrument][channel]['time_sys_stop'], format='unix', scale='utc', location=location).sidereal_time('apparent').value

    return

def partition(self, instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], buffer=(0, 0)):
    """ Produces partitions which slice the data according to the instrument's switch states. """

    for channel, instrument in itertools.product(*[channels, instruments]):
        # Ensures the data dictionary has an entry for data partitions.
        if 'Partitions' not in self[instrument][channel].keys():
            self[instrument][channel]['Partitions'] = dict()

        for file_alias, switch_data in self[instrument]['Switch'].items():
            # Removes switch states with invalid timestamps, as well as unpaired switch states.
            switch_data = np.array([list(group)[0] for timestamp, group in itertools.groupby(switch_data, lambda entry: entry[1]) if timestamp != 0])
            switch_data = np.array([list(group)[-1] if state == 1 else list(group)[0] for state, group in itertools.groupby(switch_data, lambda entry: entry[0])])
            if switch_data[-1,0] == 1: switch_data = switch_data[:-1,:]

            # Initializes an empty list of data portions.
            portions = list()

            # Produces the data portions.
            for _, start, _, stop in np.reshape(switch_data, (-1,4)):
                beginning = np.searchsorted(self[instrument][channel]['time_sys_start'], start) + buffer[0]
                end = np.searchsorted(self[instrument][channel]['time_sys_stop'], stop, side='right') - buffer[1]
                if beginning < end: portions.append(slice(beginning, end, None))

            self[instrument][channel]['Partitions'][file_alias] = portions

    return

def get(self, data='pol', instrument='100MHz', channel='EW', partition='antenna'):
    """ Extracts the data partition associated with the input instrument and channel. """

    if partition == None:
        return self[instrument][channel][data]
    else:
        return np.r_[operator.itemgetter(*self[instrument][channel]['Partitions'][partition])(self[instrument][channel][data])]

def interpolate(self, times, instrument='100MHz', channel='EW', partition='short', threshold=500):
    """ Employs linear interpolation over a given data partition to extrapolate spectra for each input time. """

    # The data to be interpolated: y = _interpolant(x)
    x = self[instrument][channel]['time_sys_start']
    y = self[instrument][channel]['pol']

    # Warning!
    if threshold >= (x[-1] - x[0]):
        raise Exception("The chosen threshold exceeds the time interval spanned by the data.")

    # Allocates the interpolation result.
    interpolation = np.empty((len(times), y.shape[1]))

    # Collects the appropriate portions of the data located in the vicinity of each input time value.
    portions = self[instrument][channel]['Partitions'][partition]
    slices = [slice(index, index + 1, None) for index in np.searchsorted(x, times)]
    portions = [(portions[index - 2], portions[index - 1], portions[index % len(portions)], portions[(index + 1) % len(portions)]) for index in np.searchsorted(portions, slices)]

    # Selects pairs of data portions to be used in the interpolation.
    for index, (portion, time) in enumerate(zip(portions, times)):
        # Identifies which data portions in the vicinity of the current time satisfy the input threshold.
        pattern = list(map(np.mean, operator.itemgetter(*portion)(x)))
        pattern.insert(2, time)
        pattern = np.abs(np.diff(pattern)) < threshold

        # Picks the appropriate pair of data portions based on the pattern identified above.
        if np.all(pattern[1:3] == [True,True]): selection = (portion[1],portion[2])
        elif np.all(pattern[0:2] == [True,True]): selection = (portion[0],portion[1])
        elif np.all(pattern[2:4] == [True,True]): selection = (portion[2],portion[3])
        elif np.all(pattern[0:3] == [False,True,False]): selection = (portion[1],portion[1])
        elif np.all(pattern[1:4] == [False,True,False]): selection = (portion[2],portion[2])
        else:
            # None of the data portions clear the input threshold.
            interpolation[index,:].fill(np.nan)
            continue

        # Interpolates.
        interpolation[index,:] = _interpolant((x[selection[0]].mean(), y[selection[0]].mean(axis=0), x[selection[1]].mean(), y[selection[1]].mean(axis=0), time))

    return interpolation

# Aliases included for backwards compatibility.
timestamp_from_ctime = iso
siderealtime_from_ctime = lst
add_switch_flags = partition
