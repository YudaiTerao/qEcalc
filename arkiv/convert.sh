#!/bin/bash

CP=$(cd $(dirname $0); pwd)
CONDITION_PATH="$CP/cifcalc_condition"
if [ ! -e $CONDITION_PATH ]; then 
echo "convert.sh:condition not found"; exit 1; fi
source $CONDITION_PATH

#---tomlの書き換え---
c2qp=${C2QEms_PATH//\//\\\/}
c2cp=${C2CELL_PATH//\//\\\/}
ppp=${PP_PATH//\//\\\/}
cat $C2QEms_PATH/cif2qewan.toml \
| sed -e "1s/\".*\"/\"$c2cp\"/" \
| sed -e "2s/\".*\"/\"$ppp\"/" \
| sed -e "3s/\".*\"/\"$c2qp\/pp_psl_rrkj.csv\"/" \
> toml && mv toml $C2QEms_PATH/cif2qewan.toml 
#--------------------

RP=$C2QE_PATH/$1
CifP=$C2QE_PATH/$1/cif_$1

cd $RP; if [ -e $RP/cif_scf.in ]; then rm $RP/cif_scf.in; fi
while read CN; do
	MN=${CN#*$MN_start}; MN=${MN%$MN_end*}
	echo $MN
    echo ${@#*$1}
	python3 $C2QEms_PATH/cif2qewan.py $CifP/$CN $C2QEms_PATH/cif2qewan.toml $MN -s $RP ${@#*$1}
	if [ -e $RP/cif_scf.in ]; then rm $RP/cif_scf.in; fi
done < <(ls -1 -F $CifP | grep -v / )
