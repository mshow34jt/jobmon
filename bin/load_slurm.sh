for i in `find /data/slurm -maxdepth 1 -type f -printf "%f\n"`
do 
	zcat  /data/slurm/$i |/jobmon/bin/parse_slurm; 
	mv  /data/slurm/$i  /data/slurm/bak/$i
	lastfile="/data/slurm/$i"
done


if [ -n "$lastfile" ]
then
	echo $lastfile > /data/log/lastslurm.log
fi
