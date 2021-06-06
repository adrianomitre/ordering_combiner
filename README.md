# Ordering combiner

This script finds the orderings that maximize the total Spearman rank-order correlation coefficient to the input orderings.

It can be used for combining preferences.

## Requirements

A recent Ruby version.

Suggest using [asdf-ruby](https://github.com/asdf-vm/asdf-ruby) or docker, mounting current directory as a (possibly read-only) volume.

## Usage

```
./main.rb <input_csv_file> [random_search_iterations]
```

input_csv_file is a spreadsheet with group member orderings.

Tip: feel free to modify main.rb to hard code your orderings to bypass this step.
