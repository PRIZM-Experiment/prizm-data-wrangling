# PRIZM Metadatabase

The PRIZM metadatabase leverages `SQLite` and Python's `sqlite3` module to keep track of the experiment's data and deployment configurations. It provides scalability, ensures data consistency, and facilitates calibration and analysis by allowing complex data intersections to be retrieved in a straightfoward fashion.

## Dependencies

* [SQLite](https://www.sqlite.org/) version 3.36 or superior.
* [Python](http://www.python.org/) version 3.0 or superior.
* [Scio](https://pypi.org/project/pbio/) version 0.0.2 or superior.

## Installation

Clone this repository within the directory of your choice.

```bash
git clone https://github.com/PRIZM-Experiment/prizm-data-wrangling.git
```

Run the following commmand within the repository's directory.

```bash
sqlite3 < build.sql
```

If successful, after a few minutes a binary file named `metadatabase.db` encapsulating all of PRIZM's metadata will have been generated. This file can be placed in whichever directory is most convenient for the user.

Next, edit the directory addresses in the `settings.json` file to reflect the chosen locations for the `metadatabase.db` file and the PRIZM data itself. As an example, for a user accessing PRIZM data through Niagara and keeping their `metadatabase.db` within a `prizm-data-wrangling` repository clones to their root directory, the settings should be as follows.

```bash
{
    "data": "/project/s/sievers/prizm",
    "metadata": "~/prizm-data-wrangling"
}
```

Finally, to conclude the installation, ensure your `PYTHONPATH` environment variable points to the location of the `prizm-data-wrangling` repository.

## Documentation

An interactive diagram of the metadatabase tables and their relationships can be found [here](https://dbdiagram.io/d/6221828954f9ad109a58a8b9).

### Sample Queries

Listing the experiment's catalogued hardware components.
```python
>>> import metadatabase as mdb
>>> mdb.retrieve("SELECT * FROM HardwareComponents")

[(0, 'VAT-3+', 'Mini-Circuits', '3 dB Fixed Attenuator, DC - 6000 MHz, 50 Ohm.'),
 (1, '6A', 'APITech Inmet', '3 dB Fixed Coaxial Attenuator, SMA Models A, DC - 6000 MHz.'),
 (2, 'SLP-200+', 'Mini-Circuits', 'Lumped LC Low Pass Filter, DC - 190 MHz, 50 Ohm.'),
 (3, 'SHP-25+', 'Mini-Circuits', 'Lumped LC High Pass Filter, 27.5 MHz - 800 MHz.'),
 ...
 (10, 'HIbiscus', 'RhoTech and Pinion & Adams', 'HIbiscus Four-Square Antenna.')]
```

(Under Construction)
