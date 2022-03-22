# PRIZM Metadatabase

The PRIZM metadatabase leverages `SQLite` and Python's `sqlite3` module to keep track of the experiment's data and deployment configurations. It provides scalability, ensures data consistency, and facilidates calibration and analysis by allowing complex data intersections to be retrieves in a straightfoward fashion.

## Dependencies

* [SQLite](https://www.sqlite.org/) version 3.36 or superior.
* [Python](http://www.python.org/) version 3.0 or superior.
* [Scio](https://pypi.org/project/pbio/) version 0.0.2 or superior.

## Installation

Build the binary metadatabase file by running the following commmand.

```bash
sqlite3 < build.sql
```

If successful, this will have produced a file named `metadatabase.db` within the repositories directory.

## Documentation

(Under Construction)
