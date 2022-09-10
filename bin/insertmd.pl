#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use threads;

use DBI;


my $lineCounter=0;
my $valCounter=0;
my $valCount=8;
my $f1;
my $f2;
my $f3;
my $f4;
my $f5;
my $f6;
my $f7;
my $f8;
my $dsn= "DBI:mysql:ISC:host=127.0.0.1:port=15306";
my $query;	


while (my $line = <STDIN>) {
    chomp $line;
#   remove quotes if the exist
    $line =~ s/"//g;
    $line =~ s/'//g;
    $lineCounter++;
#    print "reading line $lineCounter\n";
    
	($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8) = split(',',$line,$valCount);
#	print "$f1 $f2 $f3 $f4 $f5 $f6 $f7 $f8\n";

	$query="insert into metrics_md (`order`,name,string,divisor,units,description,hidden,metric_table) values ($f1,\'$f2\',\"$f3\",$f4,\'$f5\',\"$f6\",$f7,\'$f8\') ON DUPLICATE KEY UPDATE `order`=$f1 , string=\"$f3\" , divisor=$f4 , units=\'$f5\' , description=\"$f6\" , hidden=$f7 , metric_table=\'$f8\'";
#	print "query=$query\n";	
	 my $dbcon = DBI->connect($dsn)||
                  print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
                  chomp ( $query );
#                 print "$query\n";
                  $dbcon->do($query);
                  $dbcon->disconnect();
}
