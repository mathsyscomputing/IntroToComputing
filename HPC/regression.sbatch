#!/bin/bash 

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3700
#SBATCH --time=24:00:00

module purge 
module load GCC/10.2.0  OpenMPI/4.0.5 scikit-learn/0.23.2 

srun python ./regression.py 

