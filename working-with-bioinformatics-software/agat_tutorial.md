# Create path to demo folder and descend into it
mkdir -p tutorials/agat_demo && cd $_ # Creates parent directories, if needed

# Download Arabidopsis reference genome
wget -r --no-parent -nH --cut-dirs=6 -R "index.html*" -e robots=off https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/735/GCF_000001735.4_TAIR10.1/

# Extract gff records for chromosome 1 (NC_003070.9)
zcat GCF_000001735.4_TAIR10.1/GCF_000001735.4_TAIR10.1_genomic.gff.gz | grep NC_003070.9 > NC_003070.9.ncbi.gff

# Extract fasta records for chromosome 1
zcat GCF_000001735.4_TAIR10.1/GCF_000001735.4_TAIR10.1_genomic.fna.gz | head -n 380347 > NC_003070.9.fna

# Load modules on graham or cedar (or use instructions for conda at https://github.com/NBISweden/AGAT if using your own computer)
module load StdEnv/2023
module load apptainer/1.2.4

# Install `AGAT` via `Apptainer` into a temp directory
apptainer pull docker://quay.io/biocontainers/agat:1.4.0--pl5321hdfd78af_0
apptainer run agat_1.4.0--pl5321hdfd78af_0.sif

# Kick the tires, was it successfully installed?
agat_convert_sp_gxf2gxf.pl --help | less # It should show tool specific information. Use 'q' to return the prompt
agat_<tab>  # tab-completion should result in a list of all the possible scripts; hit space to advance to next page, or 'q' to return the prompt

# Fix GFF file (to understand any messages and how to fix them, check the agat.readthedocs.io documentation)
agat_convert_sp_gxf2gxf.pl --gff NC_003070.9.ncbi.gff -o NC_003070.9.gff3

# Convert the GFF3 file to GTF2.5
agat_convert_sp_gff2gtf.pl -h   # To see help
agat_convert_sp_gff2gtf.pl --gtf_version 2.5 --gff NC_003070.9.gff3 -o NC_003070.9.gtf25

# Convert a GFF3 file to BED
agat_convert_sp_gff2bed.pl -h # To see help
agat_convert_sp_gff2bed.pl --nc filter --sub exon --gff NC_003070.9.gff3 -o NC_003070.9.bed12 

# Convert a GTF3 file to a TSV formatted file
agat_convert_sp_gff2tsv.pl -gff NC_003070.9.gff3 -o NC_003070.9.tab

# Select and keep longest isoform (this produces gff3 containing only records related to the longest isoforms)
agat_sp_keep_longest_isoform.pl -gff NC_003070.9.gff3 -o NC_003070.9.longest.gff3

# Extract fasta records for each transcript
agat_sp_extract_sequences.pl --gff NC_003070.9.longest.gff3 -f NC_003070.9.fna -o NC_003070.9.longest.faa

# To exit the Apptainer
Ctrl-D

 





