import numpy as np
import itertools

def rectify(pairs):
    """ . """

    # Removes switch states with invalid timestamps.
    pairs = np.array([list(group)[0] for time, group in itertools.groupby(pairs, lambda pair: pair[1]) if time != 0])

    # Removes all unpaired switch states.
    pairs = np.array([list(group)[-1] if state == 1 else list(group)[0] for state, group in itertools.groupby(pairs, lambda pair : pair[0])])

    return pairs

def add_switch_flags(data, instruments=['100MHz', '70MHz']):
    """ . """

    for instrument in instruments:

        data[instrument]['Flags'] = {}

        for entry in data['Switch']:

            pairs = rectify(data['Switch'][entry])

            flags = np.zeros_like(data[instrument]['time_sys_start'], dtype='bool')

            for _, start, _, stop in np.reshape(pairs, (-1,4)):
                 flags[(data[instrument]['time_sys_start'] >= start)*(data[instrument]['time_sys_stop'] <= stop)] = True

            data[instrument]['Flags'][entry] = flags

    return
