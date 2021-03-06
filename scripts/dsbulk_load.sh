#!/bin/bash

DSBULK=/home/rcs/lib/dsbulk-1.8.0/bin/dsbulk
cqlsh -f scripts/schema_raw.cql

echo "Loading exchange_rates"
$DSBULK load -logDir /tmp -c json -k eth_raw -t exchange_rates -url src/test/resources/cassandra/test_exchange_rates.json
echo "Loading blocks"
$DSBULK load -logDir /tmp -c csv -header true -k eth_raw -t block -url src/test/resources/cassandra/test_blocks.csv
echo "Loading transactions"
$DSBULK load -logDir /tmp -c csv -header true -k eth_raw -t transaction -url src/test/resources/cassandra/transactions.csv --schema.allowMissingFields true
echo "Loading traces"
$DSBULK load -logDir /tmp -c csv -header true -k eth_raw -t trace -url src/test/resources/cassandra/traces.csv
