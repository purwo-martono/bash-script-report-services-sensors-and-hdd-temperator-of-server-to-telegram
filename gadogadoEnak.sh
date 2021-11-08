#!/bin/bash

telegram-send "$(cat YOUR_FILE_NAME.txt)"
echo "" > YOUR_FILE_NAME.txt
