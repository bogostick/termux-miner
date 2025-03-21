#!/bin/bash

# Asking for variables directly with fallback values
echo "Enter your username (guest):"
read USERNAME
USERNAME=${USERNAME:-guest}

echo "Enter your age (18):"
read AGE
AGE=${AGE:-18}

echo "Enter your city (Unknown):"
read CITY
CITY=${CITY:-Unknown}
