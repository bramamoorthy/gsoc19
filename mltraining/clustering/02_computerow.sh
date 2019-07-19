#!/bin/bash

rows=$(cat $1)
n_cpus=$2 # Number of CPUs for parallel calculations

# Paths
source ../variables/paths

# Export variables for GNU parallel
export rows=${rows}
export gscripts=${gscripts}
export clusterdir=${clusterdir}

# Function to compute a single row of the similarity matrix
compute_row(){
    row=$1

    python ${gscripts}/compute_row.py \
        --pdbseqs seqs.dat \
        --row ${row} \
        --out rows/row-${row}
}

# Export function for GNU parallel
export -f compute_row

# Compute similarity of one system with all other systems
# Parallelised over all systems
nohup parallel -j ${n_cpus} compute_row ::: ${rows}