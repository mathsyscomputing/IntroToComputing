
#!/bin/bash

#SBATCH --job-name=ML_Extreme
#SBATCH --time=1-24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4571

MY_NUM_THREADS=$SLURM_CPUS_PER_TASK

export OMP_NUM_THREADS=$MY_NUM_THREADS


module purge

module load intel/2019.3.199-GCC-8.3.0-2.32
module load GCC/7.3.0-2.30
module load OpenMPI/3.1.1
module load Python/3.6.6

source ~/env/bin/activate

srun python3 your_code.py

deactivate
