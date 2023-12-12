#!/bin/bash

CP=$(cd $(dirname $0); pwd)
CONDITION_PATH="$CP/cifcalc_condition"
if [ ! -e $CONDITION_PATH ]; then 
echo "mv_c2qe.sh:condition not found"; exit 1; fi
source $CONDITION_PATH

NOW_PATH=`pwd`

flag=0
case ${#} in
'0'     ) echo "mv_c2qe.sh: argument false"; flag=1 ;;
*       ) INPUT_DIR_PATH=$NOW_PATH/$1
newc2qe_Name=${1%/*}; newc2qe_Name=${newc2qe_Name##*/} ;;
esac
if [ $flag -eq 1 ]; then exit 1; fi

newc2qe=$C2QE_PATH/$newc2qe_Name

###-- Error処理 --###
if [[ "$( ls $newc2qe )" != '' ]]; then 
	$MP/cifcalc_backup.sh "c2qe" $newc2qe
	if [ $? -eq 1 ]; then echo "backup failed"; exit 1; fi
fi

if [ ! -e $newc2qe ]; then mkdir $newc2qe ; fi
if [ ! -e $newc2qe/cif_$newc2qe_Name ]; then mkdir $newc2qe/cif_$newc2qe_Name ; fi
####################

###----- Main -----###
cp -r $INPUT_DIR_PATH/* $newc2qe/cif_$newc2qe_Name/
$MP/convert.sh $newc2qe_Name ${@#*$1}
######################
