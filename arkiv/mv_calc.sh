#!/bin/bash

CP=$(cd $(dirname $0); pwd)
CONDITION_PATH="$CP/cifcalc_condition"
if [ ! -e $CONDITION_PATH ]; then 
echo "mv_calc.sh:condition not found"; exit 1; fi
source $CONDITION_PATH

NOW_PATH=`pwd`

flag=0
case $# in
'1' 	) qindir_PATH=$NOW_PATH/$1 
newcalc=${1%/*}; newcalc=${newcalc##*/} ;;
'2'	) qindir_PATH=$NOW_PATH/$1 
	  newcalc=$2 ;;
*	) echo "mv_calc.sh: argument false"; flag=1 ;;
esac
if [ $flag -eq 1 ]; then exit 1; fi

echo $newcalc $qindir_PATH

if [ ! -e $qindir_PATH ]; then
echo "mv_calc.sh: inputdir not found"
exit 1; fi

if [ -d $CALC_PATH/$newcalc ]; then
echo "mv_calc.sh: this calc name already used"
exit 1; fi

$MP/NewCalc.sh $newcalc
cp -r $qindir_PATH/* $CALC_PATH/$newcalc/input

