#/bin/csh

#setenv exp_path /discover/nobackup/projects/gmao/g6dev/jjcampb2/Replay_Experiments/KM_v11.0.0-rc.1_BACM_HY_L072_C360_RepE5/
#setenv log_pre  gcm_run.o

setenv exp_path /discover/nobackup/sakella/OM4_like_M2/
setenv log_pre  slurm-

set jobId = $1

echo ${jobId}

#grep 'Mem Comm:Used' $exp_path/${log_pre}${jobId}.out | cut -c 146-150 > mem_committed_${jobId}
grep 'Mem Comm:Used' $exp_path/${log_pre}${jobId}.out | cut -c 154-159 > mem_used_${jobId}
