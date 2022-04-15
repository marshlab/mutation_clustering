# mutation_clustering
mutation clustering script from Gerasimavicius et al 2022

A Perl script to calculate the clustering of disease mutations from a PDB file
Example:
>mutation_clustering.pl 1grnA.pdb A cdc42_clinvar.txt

Reads the PDB file 1grnA.pdb, looks at chain A, and calculates the clustering of residues where disease mutations occur provided in cdc42_clinvar.txt (one residue per line)
