#!/bin/bash
CALC_PATH='/home/terao/calc'

flag=0
case $# in
'2'	) SCF_CALC_NAME=$1; OTHER_CALC_NAME=$2;;
*	) echo "cpscf.sh: argument false"; flag=1 ;;
esac
if [ $flag -eq '1' ]; then exit 1; fi

if [ -d $CALC_PATH/$SCF_CALC_NAME ]; then
sp=$CALC_PATH/$SCF_CALC_NAME
else echo "sp not found"; exit 1; fi

if [ -d $CALC_PATH/$OTHER_CALC_NAME ]; then
op=$CALC_PATH/$OTHER_CALC_NAME
else echo "op not found"; exit 1; fi

while read dir; do
	if [ -d $op/input/$dir ]; then
		cp $sp/result/$dir/*.scf.out $op/input/$dir/
		cp -r $sp/result/$dir/work $op/input/$dir/		
	fi
done < <(ls -1 -F $sp/result | grep / | sed -e "s/\///g" )

