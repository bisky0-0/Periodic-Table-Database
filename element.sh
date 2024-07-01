#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if there's no argument provided
if [[  -z $1 ]]
then
echo "Please provide an element as an argument."

#if there's argument
else
SELECTED_ELEMENT=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1' OR name='$1' OR atomic_number=$1")

#if the argument is invalid output
if [[ -z $SELECTED_ELEMENT ]]
then 
echo "I could not find that element in the database."

#if the argument is vaild
else
ELEMENT_PROPS=$($PSQL "SELECT * FROM properties WHERE atomic_number=$SELECTED_ELEMENT")

echo "$ELEMENT_PROPS" | while IFS="|" read ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID
do

TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

#name and symbol of the element
ELEMENT=$($PSQL "SELECT name, symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")

echo $ELEMENT | while IFS="|" read NAME SYMBOL
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
done
fi
fi