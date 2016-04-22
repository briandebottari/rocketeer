#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

watched="laravel-`date +%Y-%m-%d`.log"
tail -f "$DIR/../storage/logs/$watched"
