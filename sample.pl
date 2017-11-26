#!/usr/bin/perl

use Esol::GetEnv;

########################################################################

&setEnvironmentFilePath('/etc/environment');
&setApacheEnvironmentFilePath('/etc/apache2/envvars');

print getenv("psql_yr_db_host")."<br>";

my %hash = getenv();

foreach my $k (sort keys(%hash)){
	print $k."=". $hash{$k}."\n";
}
 



