#!/bin/bash

source variables/paths
source variables/annotation

foldcsv=probis.csv

# Remove previous files (python script appends)
rm ${typedir}/*.types

python ${pscripts}/buildtypefiles.py \
    ${database} \
    ${typedir} \
    --folds ${foldir}/${foldcsv}