#!/bin/bash

failed=analysis/failed.lst
noflex=analysis/noflex.lst

# Remove systems failed
for dir in $(cat ${failed})
do
    rm -r ${dir}
done

# Remove systems without flexible residues
for dir in $(cat ${noflex})
do
    rm -r ${dir}
done