#!/bin/bash

case "$1" in
  "Firefox") echo "󰈹" ;;
  "Code") echo "󰨞" ;;
  "Terminal") echo "" ;;
  "Finder") echo "󰀶" ;;
  "Zotero") echo "󰌱" ;;
  "LocalSend") echo "󰇚" ;;
  *) echo "󰀵" ;;
esac