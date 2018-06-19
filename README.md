# San Francisco June Election Data

This repository contains a parsing script and resulting data from the June 2018 San Francisco elections.

## Summary

There was a city-wide election in June, for a variety of local ballot measures, candidates, and statewide primaries. The SF Department of Elections puts out election data as they process the ballots, which are available at [their website](https://sfelections.sfgov.org/june-5-2018-election-results-detailed-reports).

## Usage

There is a `parser.R` file in this directory which does the job of parsing the file coded at the head under `ELECTION_DATA_FILE`. The one being processed in the current version is the 15th report, and the raw data is contained in the `raw_data` folder. Packrat is used for dependencies, and if you open up the `Rproj` file in this directory in RStudio, everything should be bootstrapped.

This script outputs the processed election results (in TSV format) to the `processed_data` folder, with a suffix of `precinct` or `district` depending on which level of aggregation it describes.