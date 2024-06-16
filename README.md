# ASSetUnfold

Bringing to the public a very old script designed to expand an AS-SET. The script queries WHOIS databases to retrieve and process Autonomous System (AS) information, displaying hierarchical relationships within AS-SETs.

## Usage

```bash
% ./ASSetUnfold.sh
Usage: ./ASSetUnfold.sh <ASSET>

ASSET: The Autonomous System Set to query.

Example:
  ./ASSetUnfold.sh AS-EXAMPLE
```

Example:
```bash
% ./ASSetUnfold.sh AS-GOOGLE
ASSET: AS-GOOGLE
AS-GOOGLE-IT AS-MEEBO AS-METAWEB-2 AS11344 AS139070 AS139190 AS13949 AS15169 AS15276 AS19425 AS19527 AS22577 AS24424 AS26684 AS26910 AS32381 AS36039 AS36040 AS36383 AS36384 AS36411 AS36492 AS36520 AS36561 AS394089 AS394699 AS394725 AS395973 AS396982 AS40873 AS41264 AS43515 AS55023 AS6432
Level 1 - AS-GOOGLE - AS-GOOGLE-IT AS-MEEBO AS-METAWEB-2 AS11344 AS139070 AS139190 AS13949 AS15169 AS15276 AS19425 AS19527 AS22577 AS24424 AS26684 AS26910 AS32381 AS36039 AS36040 AS36383 AS36384 AS36411 AS36492 AS36520 AS36561 AS394089 AS394699 AS394725 AS395973 AS396982 AS40873 AS41264 AS43515 AS55023 AS6432
Level 2 - AS-GOOGLE-IT - AS36384 AS36385 AS41264 AS45566
Level 2 - AS-METAWEB-2 - AS19527 AS26684
AS36384 AS36385 AS41264 AS45566 AS19527 AS26684
```

## Notes
* The script uses the whois service to query AS-SET members.
The script recursively expands AS-SETs to list all contained ASes.
If no argument is provided, the script will display a help message and exit.

* whois.radb.net will apply rate-limit if you abuse it. Reference: [RADb Whois](https://www.radb.net/support/developer/whois.html).

* if you need to find AS-SET, an easy way is just to check on PeeringDB. Look for the field `IRR as-set/route-set` @ https://as15169.peeringdb.com/

* Very old script, feel free to improve it.