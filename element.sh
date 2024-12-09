#! /bin/bash
 
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"


if ! [[ -z $1 ]]
  then
    ELEMENT="$1"
  else
  echo -e "Please provide an element as an argument."
fi

if ! [[ -z $ELEMENT ]]
then
  NUMLIST=($($PSQL "SELECT atomic_number FROM elements;"))
  SYMBOLLIST=($($PSQL "SELECT symbol FROM elements;"))
  NAMELIST=($($PSQL "SELECT name FROM elements;"))
   
  # Buscar el elemento ingresado por el usuario
  FOUND=false
  for i in "${!NUMLIST[@]}"; do
    # Si el ELEMENT coincide con el número atómico
    if [[ ${NUMLIST[$i]} == $ELEMENT ]]; then
      FOUND=true
      VALUES_ELEMENT=($($PSQL "select elements.atomic_number as atomic_number, elements.name as name, symbol as symbol, types.type as type, properties.atomic_mass as atomic_mass, properties.melting_point_celsius as melting_point, properties.boiling_point_celsius as boiling_point from elements inner join properties on elements.atomic_number = properties.atomic_number inner join types on properties.type_id = types.type_id WHERE elements.atomic_number = $ELEMENT"))
      ATOMIC_NUMER=${VALUES_ELEMENT[0]}
      NAME=${VALUES_ELEMENT[2]}
      SYMBOL=${VALUES_ELEMENT[4]}
      TYPE=${VALUES_ELEMENT[6]}
      ATOMIC_MASS=${VALUES_ELEMENT[8]}
      MELTING_POINT=${VALUES_ELEMENT[10]}
      BOILING_POINT=${VALUES_ELEMENT[12]}
      echo -e "The element with atomic number $ATOMIC_NUMER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      break
    fi
    # Si el ELEMENT coincide con el símbolo
    if [[ ${SYMBOLLIST[$i]} == $ELEMENT ]]; then
      FOUND=true
      VALUES_ELEMENT=($($PSQL "select elements.atomic_number as atomic_number, elements.name as name, symbol as symbol, types.type as type, properties.atomic_mass as atomic_mass, properties.melting_point_celsius as melting_point, properties.boiling_point_celsius as boiling_point from elements inner join properties on elements.atomic_number = properties.atomic_number inner join types on properties.type_id = types.type_id WHERE elements.symbol = '$ELEMENT'"))
      ATOMIC_NUMER=${VALUES_ELEMENT[0]}
      NAME=${VALUES_ELEMENT[2]}
      SYMBOL=${VALUES_ELEMENT[4]}
      TYPE=${VALUES_ELEMENT[6]}
      ATOMIC_MASS=${VALUES_ELEMENT[8]}
      MELTING_POINT=${VALUES_ELEMENT[10]}
      BOILING_POINT=${VALUES_ELEMENT[12]}
      echo -e "The element with atomic number $ATOMIC_NUMER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      break
    fi
    # Si el ELEMENT coincide con el nombre
    if [[ ${NAMELIST[$i]} == $ELEMENT ]]; then
      FOUND=true
      VALUES_ELEMENT=($($PSQL "select elements.atomic_number as atomic_number, elements.name as name, symbol as symbol, types.type as type, properties.atomic_mass as atomic_mass, properties.melting_point_celsius as melting_point, properties.boiling_point_celsius as boiling_point from elements inner join properties on elements.atomic_number = properties.atomic_number inner join types on properties.type_id = types.type_id WHERE elements.name = '$ELEMENT'"))
      ATOMIC_NUMER=${VALUES_ELEMENT[0]}
      NAME=${VALUES_ELEMENT[2]}
      SYMBOL=${VALUES_ELEMENT[4]}
      TYPE=${VALUES_ELEMENT[6]}
      ATOMIC_MASS=${VALUES_ELEMENT[8]}
      MELTING_POINT=${VALUES_ELEMENT[10]}
      BOILING_POINT=${VALUES_ELEMENT[12]}
      echo -e "The element with atomic number $ATOMIC_NUMER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      break
    fi
  done

  if ! $FOUND; then
    echo "I could not find that element in the database."
  fi
  
fi



