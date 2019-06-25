# FlexDock Dataset

The `flexdock` dataset is the main dataset produced by this Google Summer of Code 2019 project. It is produced by performing flexible docking using `smina` on the whole PDBbind18 dataset and by collecting and analysing all the results.

## Production Pipeline

### 01 - Build

The script `01_build.sh` uses the results of flexible docking with `smina` to build the `flexdock` dataset. `smina` produces two `.pdb` files as a result of flexible docking: `dock.pdb` contains the different docking poses of the ligand (as models), while `flex.pdb` contains the different poses of the flexible residues (as models). 

In order to build the `flexdock` dataset, the different poses in `dock.pdb` and `flex.pdb` are split (using OpenBabel) and re-named. Finally, the flexible residue are re-inserted into the whole receptor crystal structure using the `makeflex.py` script (originally written by David R. Koes).

### 02 - Score

The script `02_score.sh` produces a `score.csv` file for every system, containing the following fields for the different poses:

* `system`: PDB code of the system, 
* `rank`: rank of the pose,
* `rmsd_ligand`: RMSD of the ligand with respect to the crystal structure,
* `rmsd_flex`: RMSD of the flexible residues with respect to the crystal structure,
* `rmsd_tot`: Combined RMSD of the ligand and the flexible residues,
* `score`: pose score.

The same information for all the systems is also collected on a single file `analysis/allscores.csv` for convenience.

### 03 - Analysis

The script `03_analysis.sh` plots the RMSD distributions for the ligand, the flexible residues and the whole system (ligand and flexible residues).

### 04 - Fix No Flex

The script `04_fixnoflex.sh` fix systems where no flexible residues where found by adding the crystal structure to the system folder.