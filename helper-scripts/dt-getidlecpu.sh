#!/bin/bash

S_TIME_FORMAT=ISO mpstat 1 1 | awk '/%idle/ {for (i=1;i<=NF;i++) {if ($i=="%idle") col=i}} /^Average:/ {print $col}'
