# kraken_parser

This will parse Kraken staking data and let you know how much you received in staking rewards, along with the USD/EUR/CHF value at the time of receipt. 

## Instructions

Download "ledger" data from Kraken. You can get it from the "History - Export" tab. This will give you a CSV file.

Note that currently this calculates USD and EUR "staking" differently than token staking. You need to use usd_parser.rb/eur_parser.rb, and not parser.rb, for this. See below for details.

Note that some tokens are not yet supported, including KAVA, FLOWH, FLOW, MINA, TRX, and SCRT. See "Supported Tokens" below. Please file an issue if you would like these or other tokens to be supported and I can add them.

### Calculating Token Staking Rewards

Run "ruby parser.rb *filename* *currency*"

It will show you all staking rewards from supported tokens received and their value. It will also show total tokens of each type received and total value in USD, EUR, or CHF, calculated at the time of receipt.

#### Supported Tokens

1. DOT (Polkadot)
2. KSM (Kusama)
3. BTC (Bitcoin)
4. ETH (Ethereum)
5. SOL (Solana)
6. ADA (Cardano)
7. LUNA (Terra)
8. XTZ (Tezos)
9. ATOM (Cosmos)
10. ALGO (Algorand)

Note that any tokens other than this will simply be ignored. For now, you will have to calculate them manually (or make a PR to add them here).

#### Example

```
$ ruby parser.rb kraken_data.csv eur

2021-12-24: 3.70716535 DOT ( 95.72 EUR )
2021-12-28: 5.04562268 DOT ( 138.25 EUR )
2021-12-31: 3.82805825 DOT ( 93.1 EUR )
No KSM rewards found.
Total DOT Received: 12.58084628 ( 327.07 EUR )
```


### Calculating USD Rewards

Run "ruby usd_parser.rb *filename*"

It will show you all USD staking rewards received and their value. 

### Calculating Euro Rewards

Run "ruby eur_parser.rb *filename*"

It will show you all EUR staking rewards received and their value. 


### Information Source

Prices were downloaded from CoinGecko and cover up until 31 Mar 2022. You can easily update by going to CoinGecko, selecting historic data, and then "export data". You just need to replace the relevant file in the ./data subdirectory. Note that name and case matters! Files downloaded from CoinGecko have a -max suffix that needs to be deleted.

### Future Plans

2. Support all tokens that Kraken supports - KAVA, FLOWH, FLOW, MINA, TRX, SCRT are still missing.
2. Move EUR/USD to parser.rb. This should just involve reading ".M" instead of ".S" as the suffix for these "tokens".
