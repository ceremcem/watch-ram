#!/bin/bash

mkdir -p logs
while :; do
	./show-usage.sh >> ./logs/`date '+%s'`.log	\
		&& echo "`date -u`: Logged." \
		|| echo "`date -u`: Whatt???"
	sleep 5m
done
