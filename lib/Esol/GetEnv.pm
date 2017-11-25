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
		setEnvironmentFilePath
		setApacheEnvironmentFilePath
	 );
}

my $environmentFilePath  = "/etc/environment";
my $apacheEnvironmentFilePath  = "/etc/apache2/envvars";
my %hashEnv;

sub setEnvironmentFilePath{
	my ($filePath) = @_;
	$environmentFilePath = $filePath;
}

sub setApacheEnvironmentFilePath{
	my ($filePath) = @_;
	$apacheEnvironmentFilePath = $filePath;
}

sub getenv{
	my ($envVar) = @_;
	my $value;
	
	&setHashEnvFromEnvironmentFilePath($environmentFilePath);
	&setHashEnvFromEnvironmentFilePath($apacheEnvironmentFilePath);
	&setHashEnvFromSystemEnv;
	
	if($envVar eq ''){
		return %hashEnv; 
	}
	foreach my $k (keys(%hashEnv)){
		if(length($value) == 0){
			if($k eq $envVar){
				$value = $hashEnv{$k};
			}
		}
	}
	return $value;	
}

sub setHashEnvFromEnvironmentFilePath{
	my ($filePath) = @_;
	if(-e $filePath){
		open(FIC,$filePath) or die "fichier introuvable";
		my @fic = <FIC> ;
		foreach my $line (@fic){
			$line = &getStrWithoutExportFormStartOfLine($line);
			my @arrValue = split(/=/, $line);
			my $k = &trim($arrValue[0]);
			my $v = &trim($arrValue[1]);
			if($k ne '' && $v ne '' && $line !~ m/#/){
				$hashEnv{$k} = $v;
			}
		}
		close(FIC);
	}
}

sub setHashEnvFromSystemEnv{
	foreach my $k (keys(%ENV)){
		$hashEnv{$k} = $ENV{$k};
	}
}

sub getStrWithoutExportFormStartOfLine(){
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
