#!/bin/bash 

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3700
#SBATCH --time=24:00:00

# Tell numpy, scipy etc. how many cpus are available
MY_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$MY_NUM_THREADS

# Set up the environment
module purge 
module load GCC/10.2.0  OpenMPI/4.0.5 scikit-learn/0.23.2 

# Run the job
srun python ./regression.py 

