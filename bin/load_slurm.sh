for i in `ls -tr /data/slurm`
do 
	zcat  /data/slurm/$i |/jobmon/bin/parse_slurm; 
	mv  /data/slurm/$i  /data/slurm/bak/$i
	lastfile="/data/slurm/$i"
done


if [ -n "$lastfile" ]
then
	echo $lastfile > /jobmon/log/lastslurm.log
fi

