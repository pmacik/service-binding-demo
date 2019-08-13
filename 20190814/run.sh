#!/bin/bash
echo "Container started"
echo "Listing all MYDB evn variables:"
echo "╭─[ MYDB ]"
env | grep MYDB
echo "╰─[ MYDB ]"
echo "That's all, folks! Taking a nap for 1 hour..."
sleep 3600