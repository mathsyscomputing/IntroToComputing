# Avon tutorial
In this tutorial, you will schedule a simple regression job on Avon.

## Set-up
Clone the IntroToComputing repo on Avon:
```bash
mkdir repos
cd repos
git clone https://github.com/mathsyscomputing/IntroToComputing.git
```
Now change directory to the HPC directory inside this repository:
```bash
cd IntroToComputing/HPC
```

## Run a single task
The regression script is found in `regression.py`. It trains an elastic-net regression
model to predict the quality of red wine, and saves the results to a file.

The file `regression-single.sbatch` contains the instructions necessary to run this in
Avon. We will talk through what is going on in this file in class.

You can schedule the task on Avon by running:
```bash
sbatch regression-single.sbatch
```
For small jobs when you are still getting your sbatch file to work, you can use the
development queue, but your actual research jobs should be run on the main queue.
```bash
sbatch -p devel regression-single.sbatch
```

Watch the progress of your job using `squeue`. If you are not being prioritised, then
use `sprio` to find out how far from the front of the queue you are. Note that, even
if you are next in the queue, you must still wait for enough currently running jobs to
finish for resources to become available.

When the job is finished, the results should have been saved in a new `results/` folder.
```bash
ll results
```
You should also have a log file written, containing what `regression.py` wrote to stdout
and stderr.
```bash
cat slurm-<job-number>.out
```

## Repeat the experiment with different parameters
Lots of problems in research are what is known as "embarassingly parallel". In these
problems, we want to run several versions of an experiment with different parameters,
say. Alternatively, we might want to keep the parameters the same, but run with a
different random seed to establish statistical significance.

For this tutorial, we will set off several experiments, each with a different value for
the parameter `alpha`, which controls the amount of regularisation in the elasticnet.
The file `regression-multi.sbatch` is a modified version of `regression-single.sbatch`
which uses the `parallel` command from gnu-parallel to schedule multiple tasks within
the job.

Again, you can schedule the job using
```bash
sbatch regression-multi.sbatch
```
and watch its progress using
```bash
squeue --me
```

When it has finished, you will have two new log files:
1. One called `slurm-<job-number>.out` which contains the logs from all your runs;
2. One called `parallel-<job-number>.log` written by the parallel command, as each task
   is scheduled.
Have a look at them now using either the `cat` or `less` commands.

You will also now have a separate file for each experiment in the `results/` directory.
We will download them using a program called `rsync`. Open a new terminal, and navigate
to somewhere where you want to save the results (using `cd`). Then run:
```bash
rsync -avz \
  <username>@avon.scrtp.warwick.ac.uk:repos/IntroToComputing/HPC/results/ \
  avon-results/
```
It is possible to do this with `scp -r` instead, but `rsync` is a more powerful command
and well worth learning!

## Other useful commands
### Cancelling jobs
If you accidentally schedule a job and want to cancel it (for example, if your sbatch
file is corrupt, or you realise you ran the wrong code version), then you can use
```bash
scancel <job-number>
```

### Investigating priorities
If you aren't getting scheduled, then you can find out where you are in the queue with
the following command:
```bash
sprio --long --sort=r,-y | less -N
```
Note that there are different queues for CPU nodes, GPU nodes, high memory nodes and
development jobs. Also, remember that even if you have the highest priority, you will
still need to wait for enough currently running jobs to finish before your job can be
scheduled.

### Running code from private repos
At the beginning of this tutorial, we were able to clone the `IntroductionToComputing`
repository because it is a public repository. If you have a private repository and want
to run the code then Avon will need to authenticate with GitHub to clone it. The
recommended way to do this is with deploy keys:
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys#deploy-keys
