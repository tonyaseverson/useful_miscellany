# Create directory for tutorial materials
mkdir -p agat_tutorial && cd $_

# Download reference files from NCBI


# Load modules on Cedar or Graham
module load StdEnv/2023
module load apptainer/1.2.4

# Pull docker container for `AGAT` and run the `AGAT` image
apptainer pull docker://quay.io/biocontainers/agat:1.4.0--pl5321hdfd78af_0
apptainer run agat_1.4.0--pl5321hdfd78af_0.sif

# Display `help` page

