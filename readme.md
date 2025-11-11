# Automatic PD search

This script automatically finds recent mass spec raw files on the Lumos, 480, astral or bstral, searches them using PD, then transfers the search files to the folder on proteinchem.

## Getting Started

### Dependencies

* Must be run from discoverer1 server.
* Folder for search output needs to exist on proteinchem before this script is run.
* PD 2.4 needs to be running on the server for this script to work.

### Config.ini setup

* Add the location of the script.
* Add age of the files in days.
* Add search pattern for finding the raw files e.g. "_RS_" for reagents and services files.


### Executing program

* Double click on "main.bat". Results files will appear in the proteinchem folder once the search is complete.

## Authors

Iolo Squires

## Acknowledgments

* [awesome-readme](https://github.com/matiassingers/awesome-readme)
