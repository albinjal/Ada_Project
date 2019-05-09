#!/bin/bash
# alias for compiling and running
# echo "What is your hostname?"
alias gk="gnatmake $(/courses/TDDD11/TJa/bin/tja_config) klient.adb"
alias gs="gnatmake $(/courses/TDDD11/TJa/bin/tja_config) server.adb"
alias rk="./klient su13-105 1337"
alias rs="./server 1337"
