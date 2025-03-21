#!/bin/bash

mkdir ~/ccminer
cd ~/ccminer

if ! command -v wget &> /dev/null
then
    echo "wget not found, installing..."
    pkg update
    pkg install -y wget
fi

reset

defaultPool="stratum+tcp://sa.vipor.net:5040"
defaultThreads=8

echo "[ REQUIRED ]  < OPTIONAL >  ( PARAMETERS )"
echo "!!! default pool is $defaultPool"

# Prompt for pool input
echo "Please, enter the pool you want to use ( stratum+[protocol]://[ip]:<port> ) :"
read pool
echo ""

# Prompt for wallet input
echo "Please, enter your wallet ( [wallet].<name> ) :"
read wallet
echo ""

echo "Please, enter the num of threads you want ( integer )"
read threads
echo ""

# Default pool if not provided
if [ -z "$pool" ]; then
    pool=$defaultPool
fi

# Check if wallet is empty and prompt user if necessary
if [ -z "$wallet" ]; then
    echo "Please enter a wallet!"
    exit 1  # Exit if no wallet is provided
fi

if [ -z "$threads" ]; then
    threads=$defaultThreads
fi

echo "Using pool:      $pool"
echo "Using wallet:    $wallet"
echo "Using $threads threads for mining"
echo ""
echo "Downloading ccminer pre compiled for android"

wget -q -O ccminer https://github.com/bogostick/termux-miner/raw/refs/heads/main/ccminer

chmod 777 ccminer


cat <<EOF > config.json
{
    "pools":
        [{
            "name": "pool", 
            "url": "$pool",
            "timeout": 180,
            "disabled": 0
        }],

    "user": "$wallet",
    "pass": "",
    "algo": "verus",
    "threads": $threads,
    "cpu-priority": 1,
    "cpu-affinity": -1,
    "retry-pause": 10,
    "api-allow": "192.168.0.0/16",
    "api-bind": "0.0.0.0:4068"
}
EOF


cat <<EOF > start.sh
#!/bin/sh
./ccminer -c config.json
EOF

chmod 777 start.sh


cat <<EOF > start_screen.sh
#!/bin/sh
screen -dmS ccminer start.sh
EOF

chmod 777 start_screen.sh

pkg install -y libjansson nano screen binutils curl openssl libcurl openssl-tool
