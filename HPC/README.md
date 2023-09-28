# Scientific Computing Research Technology Platform (SCRTP)
The SCRTP manages various computing facilities that are available for you to use.  First you will need an SCRTP account (which differs from, but requires your normal Warwick ITS account).  Obtain your SCRTP account [here](https://warwick.ac.uk/research/rtp/sc/desktop/gettingstarted).

## High Performance Clusters (HPC)
Warwick currently has one active, internal HPC cluster, called Avon. It has a total of 9528 CPU cores and 16 multi-GPU nodes, connected to a high-performance storage solution. It is suitable both for parallel and distributed CPU based workloads, as well as gpu workloads. You can read more on the [SCRTP docs page](https://docs.scrtp.warwick.ac.uk/hpc-pages/hpc-hardware.html).

To gain access to the HPC facilities, click [here](https://warwick.ac.uk/research/rtp/sc/hpc/register/). Note that you will need an SCRTP account to apply for HPC access.

Avon is running a cluster mamagement system called SLURM. The recommended way of working on Avon is to submit batch jobs into the queue to be run when resources become available, although working interactively is possible if required.

> [!NOTE]  
> Once you have set up your account, information on connecting to the cluster and running jobs can be found here: https://docs.scrtp.warwick.ac.uk/hpc.html

You can log in via ssh:
```bash
ssh matgxj@avon.scrtp.warwick.ac.uk
```
The first time you log in, you will need to set up [two-factor authentication](https://docs.scrtp.warwick.ac.uk/hpc-pages/connecting-pages/twofactor.html).

> [!WARNING]  
> Remember to **never** run expensive workloads on the login node! You will impact on everyone trying to submit jobs and will get suspended from HPC!

Some useful SLURM commands to run on the login node include:
```bash
# Submit a job
sbatch my-script.sbatch

# Query the status of my jobs
squeue --me

# Look at where you are in the priority queue (before your job is started)
sprio --long --sort=r,-y | less -N

# Cancel a job when you realise you made a mistake
scancel <job-number>
```

## Taskfarm
The taskfarm is a system which allows users to submit job scripts to a batch processing queue. Like the HPC clusters, it is running SLURM, however it lacks the network connectivity and GPU nodes available on the HPC clusters.

You can submit jobs from any computer running SCRTP linux, but SCRTP provides and supports `godzilla.csc.warwick.ac.uk` as a server-class reliable system for remote access.
You can log in to the node via ssh:
```bash
ssh username@godzilla.csc.warwick.ac.uk
```
This should be your scrtp username (e.g. `matxxx`) and you will be asked for your scrtp password.

> [!WARNING]  
> **Do not** run computationally intensive scripts directly on godzilla since this will disrupt many users workflows and you will get suspended from Taskfarm!


## MathSys SCRTP Machines (CPUs)
MathSys have their own machines and list of hostnames for the complexity SCRTP machines are:

| bulalo | caldereta | lechon  |  niliga |  okoy | torta  |
|-----|----|---|---|---|---|

You can access these machines using the following command in the terminal:
```bash
ssh username@hostname.complexity.warwick.ac.uk
```

Once you have your scrtp account, try accessing one of the complexity machines. You could also apply the techniques learnt earlier in the week regarding bash and ubuntu. Note that some machines are no longer maintained so if you do not connect withing 20 seconds, try another hostname.

## MathSys SCRTP Machines (GPUs)
MathSys also have machines with GPUs since Summer 2019. The hostnames are:

| keiko | kumeta | kalocsa  |
|-----|----|---|

You can access these machines usng the following command in the terminal:
```bash
ssh username@hostname.scrtp.warwick.ac.uk
```

