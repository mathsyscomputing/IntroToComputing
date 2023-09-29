#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=3700
#SBATCH --time=01:00:00

# Tell numpy, scipy etc. how many cpus are available
MY_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_NUM_THREADS=$MY_NUM_THREADS

# Set up the environment. If you do not know which (versions of) modules you need, then
# use `module spider`.
module purge
module load GCC/10.2.0  OpenMPI/4.0.5 scikit-learn/0.23.2

# Activate virtual environment (not needed for this example)
# (Note the line which adds the virtual environment to the PYTHONPATH. This is necessary
# because the module system on Avon modifies this path, breaking the way virtual
# environments usually work)
#source "$HOME/envs/myenv/bin/activate"
#export PYTHONPATH="$VIRTUAL_ENV/lib/python3.8/site-packages:$PYTHONPATH"

# Run the job
srun python ./regression.py
