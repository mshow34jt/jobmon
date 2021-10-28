#!/bin/perl
use strict;
use warnings;
use threads;
use Thread::Queue;
use Data::Dumper qw(Dumper);

use DBI;
 my $dsnLocal= "DBI:mysql:ISC:host=127.0.0.1:port=15306";
 my @runningJobs = ();
# my @runningXkJobs = ();
 my @jobs =();
 my @tests;
 my %jobNids;
 my $nodeOffset=600000;
 my $dsn="DBI:mysql:WORK:host=127.0.0.1:port=15306";
 my $thread_q = Thread::Queue -> new();

 my $iscdbconro = DBI->connect($dsnLocal)||
                        print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
 my $iscdbconrw = DBI->connect($dsnLocal)||
                        print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
 my $workdbconro = DBI->connect($dsn)||
                        print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
 my $workdbconrw = DBI->connect($dsn)||
                        print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";



        my $testName;
        my $testType;
        my $typeId;
        my $duration;
        my $metric;
        my $threshold;
        my $calc;
        my $groupby;
        my $now=time();

my $query="set workload='olap'";
 my $sth=$iscdbconro->prepare($query);
 $sth->execute();

 $sth=$workdbconro->prepare($query);
 $sth->execute();
 
 $query="select jobid from ISC.jobs where status='Running'";

 $sth=$iscdbconro->prepare($query);
 $sth->execute();

 while (my @row = $sth->fetchrow_array) {
#   print "jobid= $row[0]\n";
#   $joblist.=$row[0].",";
   push(@runningJobs,$row[0]);
 }



# $query="select jobid from ISC.jobs where status='Running' and RLneednodes like '%:xk%'";
#
# $sth=$iscdbconro->prepare($query);
# $sth->execute();
#
# while (my @row = $sth->fetchrow_array) {
##   print "jobid= $row[0]\n";
##   $joblist.=$row[0].",";
#    push(@runningXkJobs,$row[0]);
# }


 foreach my $job (@runningJobs) {
        my $nidList;
		my $host;
        my $query="select nid from ISC.job_hosts where jobid=$job";
        my $sth=$iscdbconro->prepare($query);
        $sth->execute();
        while (my @row = $sth->fetchrow_array) {
			  $host=$nodeOffset+$row[0];
              $nidList.=$host.",";
        }
        chop $nidList;
        $jobNids{$job}=$nidList;
 #      print "nids=$jobNids{$job}\n";
 } #end foreach job

 $query = "select testName,testType,typeId,duration,metric,threshold,calc,grouping from ISC.tests where testType='job' ";
# print "Query is $query\n";
 $sth = $iscdbconro->prepare($query)
        or die "Can't execute SQL statement: $DBI::errstr\n";
 $sth->execute()
        or die "Can't execute SQL statement: $DBI::errstr\n";
my $index=0;

  while( my @row =  $sth->fetchrow_array) {

        $testName=$row[0];
        $testType=$row[1];
        $typeId=$row[2];
        $duration=$row[3];
        $metric=$row[4];
        $threshold=$row[5];
        $calc=$row[6];
        $groupby=$row[7];
#       print "Index is $index\n";
        $index++;
        loadMetricData($metric,$now-$duration,$now);

        if($testType eq "job")
        {
                #if($typeId eq "gpu") {@jobs=@runningXkJobs;}
                #elsif ($typeId eq "all") { @jobs=@runningJobs;}
                if ($typeId eq "all") { @jobs=@runningJobs;}
                else {print "Unknown test Type $testType\n";}
                processJobs();

        }


   } #end While each test

  #my $sthFail=$iscdbconrw->prepare("delete from ISC.testFails where cTime<$now");
  #$sthFail->execute();


 $iscdbconro->disconnect();
 $iscdbconrw->disconnect();
 $workdbconro->disconnect();
 $workdbconrw->disconnect();


sub processJobs{


        foreach my $job (@jobs)
        {
                my $jobStart;
                my $start;
                my $end=$now;
                my $sth2;
                my $fail=0;
               $query="select start from ISC.jobs where jobid=$job";
               $sth2=$iscdbconro->prepare($query);
               $sth2->execute();

                while (my @row2 = $sth2->fetchrow_array) {
                        $jobStart=$row2[0];
#                       print "jobstart= $jobStart\n";
                }

                $start=$now-$duration;
                if ($start<$jobStart) { $start=$jobStart;}
                #$query="select $conditions where CompId in ($jobNids{$job}) and cTime between $start and $end";
                if ($groupby eq "none")
                {
                        $query="select $calc(metric) from $metric where CompId in ($jobNids{$job}) and cTime between $start and $end";
                }
                else
                {
                        $query="select $calc(metric),$groupby from $metric where CompId in ($jobNids{$job}) and cTime between $start and $end group by $groupby";
                }
                #print "$query\n";
                #print "Processed $testName for job:$job\n";
                $sth2=$workdbconro->prepare($query);
                $sth2->execute();
                while( my @row =  $sth2->fetchrow_array) {
			#print "processing rows\n";
                        my $dtime=$end-$start;
                        if(!defined $row[0])
                        {
                                #print("Start=$start End=$end duration=$dtime  Jobstart=$jobStart\n");
                                #print Dumper(@row);
                                print("What? $query\n");
                        }
                        elsif($threshold>0)
                        {
                                if($row[0]>$threshold)
                                {
                                        if ($fail == 0) {print("Job: $job has violated $testName with a score of $row[0] / $threshold\n");}
                                        $fail=1;
                                }

                        }
                        elsif($threshold<0)
                        {
                                 if($row[0]<-$threshold)
                                {
                                        if ($fail == 0) {print("Job: $job has violated $testName with a score of $row[0] / $threshold\n");}
                                        $fail=1;
                                }

                        }
                }

                if($fail)
                {
                        $query=  sprintf "select failCount from ISC.testFails where jobId=$job and testName=\"%s\"",$testName;
                        #print "Query= $query\n";
                        my $sthFails=$iscdbconrw->prepare($query);
                #       print "testquery: $query\n";
                        $sthFails->execute();
                        if( my @row =  $sthFails->fetchrow_array) {
                                my $failCount=$row[0]+1;
                                $query="update ISC.testFails set cTime=$now , failCount=$failCount where jobid=$job and testName=\"$testName\"";
                                #print "Query= $query\n";
                                $sthFails=$iscdbconrw->prepare($query);
                                $sthFails->execute();
                        }
                        else
                        {
                                $query= sprintf "insert into ISC.testFails(cTime,failcount,testType,typeId,testName,jobid,testLink) values($now,1,%s,%s,\"%s\",%s,\"%s\")", $iscdbconrw->quote($testType), $iscdbconrw->quote($metric),  $testName, $job,"https://mon1.sandia.gov/~mtshowe/jobmon/qjobchart.php?metric=$metric&calc=$calc&jobid=$job";
                                $sthFails=$iscdbconrw->prepare($query);
                                #print "query: $query\n";
                                $sthFails->execute();
                        }
                }
        }


        my $sth2=$workdbconrw->prepare("drop table $metric");
        $sth2->execute();




} #end processAllJobs


sub loadMetricData{
 my ($metric,$t1,$t2)=@_;

# print ("$metric $t1 $t2\n");

 my $nthreads = 4;
# my $thread_q = Thread::Queue -> new();
 $thread_q = Thread::Queue -> new();
 my $pending_t=0;
 my $numLines=8000;
 my $counter=0;
 my $values;


 my $queryHeader="insert into $metric(cTime,CompId,metric) values ";

 sub worker
 {
  #NB - this will sit a loop indefinitely, until you close the queue.
  #  #using $process_q -> end
  #    #we do this once we've queued all the things we want to process
  #      #and the sub completes and exits neatly.
  #        #however if you _don't_ end it, this will sit waiting forever.
  while ( my $query = $thread_q -> dequeue() )
  {
            my $dbcon = DBI->connect($dsn)||
                       print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
             chomp ( $query );
             #print threads -> self() -> tid(). ": thread running\n";
               $dbcon->do($query);
             #print threads -> self() -> tid(). ":  done \n";
              $dbcon->disconnect();

                                                                                                         }
 }


for ( 1..$nthreads )
{
  threads -> create ( \&worker );
}
my $tableName;
my $dbGetCon  = DBI->connect($dsn)||
        print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
my $getQuery = " CREATE TABLE $metric ( cTime bigint(20),  `CompId` bigint(20), metric bigint(20), PRIMARY KEY (`cTime`,`CompId`), KEY `cTime` (`cTime`), KEY `CompId` (`CompId`) ) ENGINE=MEMORY";

$dbGetCon->do($getQuery);

$getQuery= "select metric_table from ISC.metrics_md where name='$metric'";
my $sth_thread = $dbGetCon->prepare($getQuery);
$sth_thread->execute();
while (my @row = $sth_thread->fetchrow_array) {
	$tableName=$row[0];

	#print "table is $tableName\n";
}
$sth_thread->finish;
$tableName='ISC.'.$tableName;
#$tableName='ISC.'."procstat_72";
$getQuery= "select cTime,CompId,$metric from $tableName where cTime between $t1 and $t2";
#print "$getQuery\n";
$sth_thread = $dbGetCon->prepare($getQuery);
$sth_thread->execute();

while (my @row = $sth_thread->fetchrow_array) {
    $counter++;
#    print "counter is $counter\n";
    if($counter<$numLines)
    {
        $values.="(".$row[0].",".$row[1].",".$row[2]."),\n";
    }
    else
    {
        $values.="(".$row[0].",".$row[1].",".$row[2].")";
        if($thread_q->pending())
        {
                while($thread_q->pending() == $nthreads)
                {
                        sleep(1);
                        $pending_t= $thread_q->pending();
                }
        }
        $thread_q -> enqueue ( $queryHeader.$values);
        $counter=0;
        $values="";
    }
}
if($counter>0)
{
        chop($values);
        chop($values);
         $thread_q -> enqueue ( $queryHeader.$values);
}

$dbGetCon->disconnect();
$thread_q->end();
foreach my $thr ( threads -> list() )
{
  $thr -> join();
}

}
