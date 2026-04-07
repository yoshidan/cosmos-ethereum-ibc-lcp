#!/usr/bin/env bash
set -eux

GENESIS_TIMESTAMP=${GENESIS_TIMESTAMP}

MINIMAL_SECONDS_PER_SLOT=6
MINIMAL_SLOTS_PER_EPOCH=8

HF_TIMESTAMP_DIFF=$((EPOCH_HF * MINIMAL_SECONDS_PER_SLOT * MINIMAL_SLOTS_PER_EPOCH))
HF_TIMESTAMP=$((GENESIS_TIMESTAMP + HF_TIMESTAMP_DIFF))

sed -i.bak s/"\"osakaTime\": 0/\"osakaTime\": ${HF_TIMESTAMP}/" /execution/genesis.json

# Init
geth --datadir=/execution init --state.scheme hash --db.engine=leveldb /execution/genesis.json

# Import keys
geth --datadir=/execution account import --password /dev/null /config/dev-key0.prv
geth --datadir=/execution account import --password /dev/null /config/dev-key1.prv

geth $*
