#!/bin/bash

PSQL="psql --username=postgres --dbname=periodic_table --tuples-only -X -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  #Argument given, check if it's a number.
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")
  #If blank, proceed to next check:
  if [[ -z $ATOMIC_NUMBER ]]
  then
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

