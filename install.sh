#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No color

# Function to prompt for input with a fallback value
prompt() {
    local var_name=$1
    local prompt_text=$2
    local default_value=$3

    # Ask the user for input
    echo -e "${CYAN}${prompt_text} (${default_value}): ${NC}"
    read input

    # Use the default value if input is empty
    if [ -z "$input" ]; then
        eval "$var_name='$default_value'"
    else
        eval "$var_name='$input'"
    fi
}

# Asking for variables
prompt "USERNAME" "Enter your username" "guest"
prompt "AGE" "Enter your age" "18"
prompt "CITY" "Enter your city" "Unknown"

# Display results
echo -e "\n${GREEN}User Information:${NC}"
echo -e "${YELLOW}Username:${NC} $USERNAME"
echo -e "${YELLOW}Age:${NC} $AGE"
echo -e "${YELLOW}City:${NC} $CITY"
