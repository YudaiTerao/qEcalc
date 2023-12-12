#!/bin/bash
CP=$(cd $(dirname $0); pwd)
CONDITION_PATH="$CP/cifcalc_condition"
if [ ! -e $CONDITION_PATH ]; then 
echo "cifcalc_backup.sh:condition not found"; exit 1; fi
source $CONDITION_PATH

flag=0
case $# in
'0'	)  echo "cifcalc_backup.sh: argument false"; flag=1 ;; 
'1'	)  SAVE_PATH=$TRASH_PATH/`date '+%Y-%m-%d_%H%M%S'`
	   FILE_PATH=$1 ;;
*	)  SAVE_PATH=$TRASH_PATH/`date '+%Y-%m-%d_%H%M%S'`_$1
	   FILE_PATH=${@#*$1} ;;
esac
if [ $flag -eq 1 ]; then exit 1; fi

if [ ! -e $TRASH_PATH ]; then mkdir $TRASH_PATH; fi
mkdir $SAVE_PATH
mv $FILE_PATH $SAVE_PATH

