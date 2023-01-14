#!/bin/bash

PSQL="psql --username=postgres --dbname=periodic_table --tuples-only -A -X -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
  #set escape var for later
  SHOULD_EXIT=TRUE
else
  #Argument given, check if it's a number.
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
  else
    #If NaN, test 2 types of text:
    #Check if it's a symbol.
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1';")
    #If blank, proceed to final check:
    if [[ -z $ATOMIC_NUMBER ]]
    then
      #Check if it's a name.
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1';")
      #If still blank, if statement below will deal with it
    fi
  fi
  #Once number is gotten (no matter how), proceed on
fi

#Only do stuff if an arg is given (SHOULD_EXIT being false)
if [[ ! $SHOULD_EXIT ]]
then
  #If atomic number found, output info
  if [[ ! -z $ATOMIC_NUMBER ]]
  then
    echo "Atomic number $ATOMIC_NUMBER found"
  else
    echo "I could not find that element in the database."
  fi
fi