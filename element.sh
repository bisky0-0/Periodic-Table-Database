#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "Please provide an element as an argument."

read ARG

SELECTED_ELEMENT=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ARG' OR name='$ARG' OR atomic_number=$ARG")
echo $SELECTED_ELEMENT


