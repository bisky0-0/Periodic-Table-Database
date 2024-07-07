#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#if there's no argument provided
MAIN_FUN(){
if [[  -z $1 ]]
then
echo "Please provide an element as an argument."

#if there's argument
else
if [[ $1 =~ ^[1-9]+$ ]]
then 
SELECTED_ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where atomic_number = '$1'")
else 
SELECTED_ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where name = '$1' or symbol = '$1'")
fi
#if the argument is invalid output
if [[ -z $SELECTED_ELEMENT ]]
then 
echo "I could not find that element in the database."

#if the argument is vaild
else
echo $SELECTED_ELEMENT | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT 
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done
fi
fi
}

MAIN_FUN 2
MAIN_FUN He
MAIN_FUN Helium