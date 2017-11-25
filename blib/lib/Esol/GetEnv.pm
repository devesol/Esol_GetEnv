#!/usr/bin/perl

use strict;

package Esol::GetEnv;

require Exporter;
BEGIN {
    $Esol::GetEnv::VERSION   = 1.00;
    @Esol::GetEnv::EXPORT_OK = qw();
    @Esol::GetEnv::ISA       = qw(Exporter);
    @Esol::GetEnv::EXPORT    = qw( 
		getenv
	 );
}

sub getenv{
	my ($envVar) = @_;
	my $valueToReturn;
	my $environmentFilePath  = "/etc/environment";

	open(FIC,$environmentFilePath) or die "fichier introuvable";
	my @fic = <FIC> ;
	foreach my $line (@fic)
	{
		$line = &removeExportFormStartOfLine($line);
		my @arrValue = split(/=/, $line);
		my $key = &trim($arrValue[0]);
		my $value = &trim($arrValue[1]);
#		print $arrValue[0].":".$arrValue[0]."<br>";
#		print $envVar."<>".$arrValue[0]."<br>";
		if(length($valueToReturn) == 0){
			if($key eq $envVar){
				$valueToReturn = $value;
			}
		}
	}
	return $valueToReturn;	
	close(FIC);

}

sub removeExportFormStartOfLine(){
	my ($str) = @_;
	$str =~ s/^\s*export//gi;
	$str = &trim($str);
	return $str;
}

sub trim(){
	my ($str) = @_;
	$str =~ s/^\s*(.*)\s*$/$1/;
	return $str;
}


return 1;