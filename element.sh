#!/bin/bash

PSQL="psql --username=postgres --dbname=periodic_table --tuples-only -X -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
  echo "Argument \"$1\" found"
fi

