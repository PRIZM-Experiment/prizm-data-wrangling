# PRIZM Metadatabase

The PRIZM metadatabase leverages `SQLite` and Python's `sqlite3` module to keep track of the experiment's data and deployment configurations. It provides scalability, ensures data consistency, and facilitates calibration and analysis by allowing complex data intersections to be retrieved in a straightfoward fashion.

## Dependencies

* [SQLite](https://www.sqlite.org/) version 3.36 or superior.
* [Python](http://www.python.org/) version 3.0 or superior.
* [Scio](https://pypi.org/project/pbio/) version 0.0.2 or superior.

## Installation

Run the following commmand within the repository's directory.

```bash
sqlite3 < build.sql
```

If successful, after a few minutes this a binary file named `metadatabase.db` will have been generated which encapsulates all of PRIZM's metadata.

## Documentation

This section is under construction. An interactive diagram of the metadatabase tables and their relationships can be found [here](https://dbdiagram.io/d/6221828954f9ad109a58a8b9).
