#!/usr/bin/env bash

symbols=('-' '\' '|' '/')

while true; do
	for symbol in "${symbols[@]}"; do
		printf "\r %c " "$symbol"
		sleep .075
	done
done
