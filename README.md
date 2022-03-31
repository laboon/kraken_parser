# kraken_parser
For parsing Kraken staking data

## Instructions

Download "ledger" data from Kraken. You can get it from the "History - Export" tab. This will give you a CSV file.

Note that currently this calculates USD "staking" differently than token staking. You need to use usd_parser.rb, and not parser.rb, for this. See below for details.

### Calculating DOT and KSM Rewards

Run "ruby parser.rb *name of file* *currency*"

It will show you all DOT and KSM staking rewards received and their value. It will also show total DOT and KSM received and total value in USD, EUR, or CHF.

#### Example

```
$ ruby parser.rb ../staking-rewards-collector/kraken_data.csv eur

2021-12-24: 3.70716535 DOT ( 95.72 eur )
2021-12-28: 5.04562268 DOT ( 138.25 eur )
2021-12-31: 3.82805825 DOT ( 93.1 eur )
No KSM rewards found.
Total DOT Received: 12.58084628 ( 327.07 EUR )
```


### Calculating USD Rewards

Run "ruby usd_parser.rb *name of file*"

It will show you all USD staking rewards received and their value. It will also show total USD.M received and total USD value (which are the same, since we assume that the USD.M are equal to USD).

### Information Source

DOT prices were downloaded from CoinGecko and cover up until 31 Mar 2022. You can easily update by going to CoinGecko, selecting historic data, and then "export data".

### Future Plans

1. Combine code into a single file and show all staking rewards.
2. Support other tokens (should be relatively straightforward).
