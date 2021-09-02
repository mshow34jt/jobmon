for i in `ls -tr /scratch_B/slurm/eclipse/spool/job_detail/`
do 
	zcat  /scratch_B/slurm/eclipse/spool/job_detail/$i |/ascldap/users/mtshowe/vitess/parsers/parse_slurm; 
	mv  /scratch_B/slurm/eclipse/spool/job_detail/$i  /scratch_B/slurm/eclipse/spool/complete/job_detail/$i
	lastfile="/scratch_B/slurm/eclipse/spool/complete/job_detail/$i"
done


if [ -n "$lastfile" ]
then
	echo $lastfile > /ascldap/users/mtshowe/vitess/log/lastslurm.log
fi

