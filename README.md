# kraken_parser
For parsing Kraken staking data

## Instructions

Download "ledger" data from Kraken. You can get it from the "History - Export" tab. This will give you a CSV file. 

### Calculating DOT Rewards

Run "ruby dot_parser.rb *name of file*"

It will show you all DOT staking rewards received and their value. It will also show total DOT received and total USD value.

### Calculating KSM Rewards

Run "ruby ksm_parser.rb *name of file*"

It will show you all KSM staking rewards received and their value. It will also show total KSM received and total USD value.

### Calculating USD Rewards

Run "ruby usd_parser *name of file*"

It will show you all USD staking rewards received and their value. It will also show total USD.M received and total USD value (which are the same, since we assume that the USD.M are equal to USD).

### Information Source

DOT prices were downloaded from CoinGecko and cover up until 31 Mar 2022. You can easily update by going to CoinGecko, selecting historic data, and then "export data".

### Future Plans

1. Combine code into a single file and show all staking rewards.
2. Support other tokens (should be relatively straightforward).
3. Support other currencies besides USD.
