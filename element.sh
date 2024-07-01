#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

echo "Please provide an element as an argument."

read ARG

SELECTED_ELEMENT=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ARG' OR name='$ARG' OR atomic_number=$ARG")
echo $SELECTED_ELEMENT

ELEMENT_PROPS=$($PSQL "SELECT * FROM properties WHERE atomic_number=$SELECTED_ELEMENT")
echo $ELEMENT_PROPS

cat ELEMENT_PROPS | while read ATOMIC_NUMBER BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID

done