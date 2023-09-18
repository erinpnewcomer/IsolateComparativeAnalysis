# IsolateComparativeAnalysis

All scripts I used for general isolates comparison, like phylogenetic tree construction or strain tracking.

Guide:

s20_gubbins.sh: Will run gubbins on core_gene_alignment.aln from Panaroo. While the Gubbins literature says not to use Panaroo, I wonder if it was written for an earlier version of Panaroo, because Panaroo uses MAFFT to align. I've also seen a lot of C. diff people use this, though not sure how much that can be trusted.

Specifically, Gubbins is not meant for species-wide analysis. It's meant for smaller clades (like how C. diff has 5 clades). I would recommend breaking your samples up somehow, possibly by a preliminary recombination-naive core SNP screen. I use it for all C. diff to match what's done in literature, but I wouldn't say it's a great idea.
* One note: Gubbins does require at least 3 isolates to run. Either make your clades bigger or use references if you don't have enough.
* This script will produce:
  * a recombination-masked core gene alignment for phylogenetic tree construction
  * pairwise_distances.txt that lists the SNP distances between all samples in your clade, with SNPs from recombination regions masked out. 

ALSO: I still need to mess with the prefix tag in the initialy gubbins.py call. The way this is set up, you will get major errors if you try to array it out and run more than 1 gubbins at a time. 
