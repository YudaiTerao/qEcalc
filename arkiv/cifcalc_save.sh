#!/bin/bash
CP=$(cd $(dirname $0); pwd)
CONDITION_PATH="$CP/cifcalc_condition"
if [ ! -e $CONDITION_PATH ]; then 
echo "cifcalc_save.sh:condition not found"; exit 1; fi
source $CONDITION_PATH

flag=0
case $# in
'1'     ) SAVE_NAME=${1//\//} ;;
'2'     ) SAVE_NAME=${2//\//} ;;
*   ) echo "cifcalc_save.sh: argument false"; flag=1 ;;
esac
if [ $flag -eq 1 ]; then exit 1; fi

FILE_PATH=$CALC_PATH/$1
SAVE_PATH=$DATA_PATH/$SAVE_NAME
WORK_SAVE_PATH=$WORK_PATH/$SAVE_NAME

###-- Error処理 --###
if [ ! -e $FILE_PATH ]; then
echo "cifcalc_save.sh: $1 not found"; exit 1; fi

if [ -e $SAVE_PATH ]; then
echo "cifcalc_save.sh: $SAVE_NAME already exist"; exit 1; fi

if [ -e $WORK_SAVE_PATH ]; then
echo "cifcalc_save.sh: $SAVE_NAME_work already exist"; exit 1; fi
####################


###----- Main -----###
mkdir $SAVE_PATH $WORK_SAVE_PATH
while read MN; do
    if [ -e $FILE_PATH/result/$MN/work ]; then
        mkdir $WORK_SAVE_PATH/$MN
        mv $FILE_PATH/result/$MN/work $WORK_SAVE_PATH/$MN/
    fi
done < <(ls  -1 -F $FILE_PATH/result | grep / | sed -e "s/\///g")

while read MN; do
    str=""
    if [ -e $FILE_PATH/input/$MN/work ]; then
        str="$str $FILE_PATH/input/$MN/work"
    fi
done < <(ls  -1 -F $FILE_PATH/input | grep / | sed -e "s/\///g")
$MP/cifcalc_backup.sh "inputwork" $str

mv $FILE_PATH/result/* $FILE_PATH/input $SAVE_PATH
$MP/cifcalc_backup.sh "clc" $FILE_PATH
######################

