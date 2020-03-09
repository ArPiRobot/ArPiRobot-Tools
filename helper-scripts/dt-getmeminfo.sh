#!/bin/bash

#Print used mem
free -k | awk '/used/ {for (i=1;i<=NF;i++) {if ($i=="used") col=i+1}} /^Mem:/ {print $col}'

# Print total mem
free -k | awk '/total/ {for (i=1;i<=NF;i++) {if ($i=="total") col=i+1}} /^Mem:/ {print $col}'
