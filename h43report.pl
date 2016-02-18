#!/usr/bin/perl
#
# H43. Report tool for HDS midrange arrays.
# Copyright (c) 2014-2015  Korolev Igor (http://h43.unixpin.com)
# Licensed under the MIT license.
# Based on flot (http://www.flotcharts.org/) JavaScript plotting library for jQuery
#
# Tips:
# how to add new array to hitachi snm2 cli:
# ./auunitadd  -unit ams2100_83051949 -ctl0 10.0.67.33 -ctl1 10.0.67.34 -communicationtype nonsecure
# how to collect pfm files
# ./auperform -unit ams2100_83051949  -auto 1 -count 2 -pfmstatis -path $PWD/83051949 < pass.txt
#
# author Igor Korolev korolev-ia[at]yandex.ru


use Data::Dumper;
use Cwd;
use Getopt::Long;
use HTML::Template;
#use DateTime;
use Time::Local;
use File::Path qw(make_path);
use File::Spec;
use H43;

$version="1.5 / 2015.04.24";

$result = GetOptions ("d=s" => \$data_dir,
                      "o=s" => \$out_dir,
                      "n" => \$noindex,
                      "v" => \$verbose,
                      "s=s" => \$old_array_sn,
                      "version" => \$version_only,
                      "help|h|?"  => \$help ); 



if($version_only) {
	print STDERR  "$version\n";
	exit 0;
}
show_help() if($help);
show_help() unless( $data_dir );


# set the paths to lib, templates and output dir
my ($volume,$directories,$file) =File::Spec->splitpath( $0 );
push( @INC,$directories );
$TemplatePath="$directories/template";
$out_dir=getcwd()."/output" unless($out_dir); 


$html_template_default='template_multi_charts.html';
$html_template_index='template_index.html';
$index="index.html";

opendir(my $dh,$data_dir);
@ls= grep { /\.txt$/ && -f "$data_dir/$_" } readdir($dh);
close $dh;

#push( @{$reppack}, 'main' ); # main reports generate in any case
foreach (keys %{$Reports}) { push( @{$reppack},$_) }; # generate all reports


foreach $rp (@{$reppack}) {
	my $j=${ $Reports->{$rp}->{reports} };
	foreach $k ( keys %{$j}  ) {
		push ( @{ $Collect->{ $j->{$k}->{info} }}, $j->{$k}->{header} );
	}
}


my $headerno=0;
my $i=0;
my $sn;
foreach $filename( sort(@ls) ) {
	open(IN, "$data_dir/$filename") || die $!;
	print "Read data from $data_dir/$filename\n" if( $verbose );
	 while(<IN>) {
		chomp;
		if( /^No.(\d+)/ ) {
			$no=$1;
			next;
		}
		if( /^(\d+\/\d\d\/\d\d)\s+(\d+:\d+:\d+) - (\d+\/\d\d\/\d\d)\s+(\d+:\d+:\d+) - SN:(\d+)$/ ) {				
				$h->{$no}->{date}=$1;
				$h->{$no}->{time}=$2;
				$h->{$no}->{datef}=$3;
				$h->{$no}->{timef}=$4;
				$h->{$no}->{sn}=$5;
				$sn=$5 unless($sn);
				die "Different array serial number( SN# $5 ) in pfm file $data_dir/$filename ( in previrous pfm file(s) SN# $sn )\n" if( $sn ne $5 );
				next;
		}

		if( /^(\d+\/\d\d\/\d\d)\s+(\d+:\d+:\d+) - (\d+\/\d\d\/\d\d)\s+(\d+:\d+:\d+)/ ) {
				unless ( $old_array_sn ) {
					die "Please set serial number of array with '-s=xxxxxxxx' option
					\nExample: $0 -d=c:/data/pfm/ -o=c:/data/output/ -s=12345678\n";
				}
				$h->{$no}->{date}=$1;
				$h->{$no}->{time}=$2;
				$h->{$no}->{datef}=$3;
				$h->{$no}->{timef}=$4;
				$h->{$no}->{sn}=$old_array_sn;
				$sn=$old_array_sn;
				next;
		}
		
		if( /^---/ ) {		
			$info=$Struct->{deinfo}->{$_} ;
			print STDERR "Unknown tag info '$_' \n" unless($info);
			next;
		}
		if( /^CTL/ ) {
			# сбросить все
			foreach $a ( keys %{ $Collect } ) {
				foreach $b ( @{ $Collect->{$a} } ) {
					$start->{$a}->{$b}=0;
				}
			}
			$headerno=0;
			foreach $h0 ( @{ $Collect->{$info} } ) {
				if( $_ eq $Struct->{header}->{$info}->{$h0}  ) {
					$start->{$info}->{$h0}=1;
					$headerno=$h0;
					last;
				}
			}
			$i=0;
			next;
		}
		if( 1 == $start->{$info}->{$headerno} ) {
			my @a=split( /\s+/,$_) ;		
			push @{ $h->{$no}->{$info}->{$headerno}->{++$i} }, @a ;
		}

	 }
	close( IN);
}




my $sz_of_h= ( sort {$b <=> $a} ( keys ( %{$h}) ))[0] ;
my $first=get_first_h_no();
my $last=get_last_h_no();
my $sn=$h->{ $first }->{sn};
my $datatime=make_report_datatime();

foreach $rp (@{$reppack}) {
	my $j=$Reports->{$rp} ;
	my $html_template=$html_template_default;
	$html_template=$j->{'template'} if( $j->{'template'} );

	my $template = HTML::Template->new(
						filename => $html_template, 
						case_sensitive => 0, 
						die_on_bad_params => 0, 
						path=>[$TemplatePath, './template']
						);
	my $v=0;
	my @outer_loop;
	my $overview_data;


	foreach $r ( sort {$a <=> $b} keys( %{ ${$j->{reports}} }) ) {
		my $rep;
		make_report ( ${ $j->{reports} }->{$r} , \$rep);
		
		next unless ( defined( $rep->{inner_loop}->[0] )) ;

		my %outer_hash;
		$template->param( M_DATATIME => $datatime );
		$outer_hash{M_INNER_LOOP}=$rep->{inner_loop};
		$outer_hash{M_STACKING}=${ $j->{reports}}->{$r}->{stacking};
		$outer_hash{M_VERSION}=++$v;
		my $title=${ $j->{reports}}->{$r}->{title};
		$outer_hash{M_REPORT_NAME}=$title;
		push @outer_loop, \%outer_hash;	
	}
	next unless ( defined( @outer_loop[0])) ;
	$template->param( M_OVERVIEW_DATA => @outer_loop[0]->{'M_INNER_LOOP'}->[0]->{M_DATA}) ;
	$template->param( M_OUTER_LOOP => \@outer_loop);
	$template->param( M_TITLE => "Array SN:$sn. Report information. $j->{desc}."   );
	my $dt="$h->{$first}->{date} $h->{$first}->{time} - $h->{ $last }->{datef} $h->{ $last }->{timef}";
	$dt=~s|/|\.|g;
	$template->param( M_PAGE_DESC => "<table border=0>
								<tr><td>	Array: </td><td> <font size=+1>SN# $sn</font></td></tr>
								<tr><td>	Datetime: </td><td> <font size=+1> $dt </font></td></tr>
								<tr><td>	Reports: </td><td> <font size=+1> $j->{desc} </font></td></tr></table>"  );
	$template->param( M_PATH => "<a href='../../$index'> root </a>  / <a href='../$index'> array# $sn </a> /  <a href='$index'> $dt </a>" );
	$dt="$h->{$first}->{date}_$h->{$first}->{time}-$h->{ $last }->{datef}_$h->{ $last }->{timef}";
	$dt=~s/\//\./g;
	$dt=~s/:/\./g;

	my $do="$out_dir/$sn/$dt";
	make_path( $do, { mode => 0755 } ) unless (-d $do);
	open(OUT,">$do/$j->{outfile}") || die "Cannot open file $do/$j->{outfile} for writing:$!\n";
	print OUT $template->output;
	close OUT;	
	print "Create report file $do/$j->{outfile}\n" if( $verbose );
}

unless( $noindex ) {
	do_tree_index($out_dir) ;
}

exit 0;


sub make_report_datatime {    
my @dataTime;
	foreach $nu ( sort {$a <=> $b} ( keys ( %{$h}) )) {
		$dt=get_dt($h->{$nu}->{date},$h->{$nu}->{time});
		push ( @dataTime , $dt );		
	}
	return ( join(',', @dataTime  ));
}


sub make_report {                                              	
	my $r=shift;
	my $rep=shift;
my @inner_loop;
my $dt;
my $w;
my $allData;

foreach $nu ( sort {$a <=> $b} ( keys ( %{$h}) )) {
			my $u=$h->{ $nu }->{ $r->{info} }->{ $r->{header} };
			if( $r->{eval}) {
				eval( $r->{eval}  );
				if( $@ ) {
					print( "Error with 'eval' code for report '$r->{title}': $@" ); 
					exit 2;
				}				
			} else { # if use simple form of report
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key=join( ':', map{ $Struct->{field}->{ $r->{info} }->{ $r->{header} }->{$_} }@{ $r->{lines} })." ".join(':',  map{ ${$u->{$y}}[$_] } @{$r->{lines} } );
					$dt=get_dt($h->{$nu}->{date},$h->{$nu}->{time});
#					push @{ $w->{ $key } }, "\[ $dt, ${$u->{$y}}[ $r->{data} ]  \]";  
					push ( @{ $allData->{$key} }, ${$u->{$y}}[ $r->{data}] );
				}
			}
}

foreach $key ( sort ( keys( %{ $allData } ) ) ){
	my %row_data;
		$row_data{M_ALLDATA}=join(',', @{$allData->{$key}} );
#		$row_data{M_DATA}=join(',', @{$w->{$key}} );
	 	$row_data{M_TAG}="d_$key";
		$row_data{M_TAG}=~s/\W/_/g;
	 	$row_data{M_LABEL}=$key;
		push(@inner_loop, \%row_data);
}
$$rep->{inner_loop}=\@inner_loop;

return (1);

}



sub get_dt {
	my $date=shift;
	my $time=shift;
	my ($year,$month,$day)=split('/',$date);
	my ($hour,$minute,$second)=split(':',$time);
	my $dt=timegm( $second, $minute, $hour, $day, $month-1, $year );
#my $dt = DateTime->new(
#      year	 => $year,
#      month      => $month,
#      day        => $day,
#      hour       => $hour,
#      minute     => $minute,
#      second     => $second,
#      time_zone  => 'Europe/Moscow',
#  );
	return 1000*$dt;	

}


sub get_first_h_no {
	my $w= ( sort {$a <=> $b} ( keys ( %{$h}) ))[0] ;
	return $w;
}

sub get_last_h_no {
	my $w= ( sort {$b <=> $a} ( keys ( %{$h}) ))[0] ;
	return $w;
}



sub show_help {
	print STDERR "Usage:$0 -d=dir_with_pfm_files [-o=dir_for_reports] [-n] [-v] [-h]
	Where:
	-d - directory with pfm files
	-o - directory for reports (must have in root 'flot js library')
	-s - set the 'serial number' for array ( need for old array like AMS1000 )
	-h - this help
	-n - do not rebuld index files in directory tree
	-v - verbose 
	-version - show version and exit 
	Example: $0 -d=c:/data/pfm/ -o=c:/data/output/\n";
	exit 1;
}


sub read_title {
	my $filename=shift;
	my $body;
	open (IN,$filename) || print STDERR "Cannot open file $filename for reading: $!\n" ;
		while(<IN>) { $body.=$_ ; }
	close(IN);
	$body=~/\<title\>(.+)\<\/title\>/mi;
	return $1;
}

sub read_dir {
		my $dir=shift;
		opendir(my $dh,$dir);
			my @REP= readdir($dh);	
		close $dh;
	return @REP;
}


sub do_tree_index {
	my $out_dir=shift;
	my @SN, @REP, @DT;
	my %SNs, %REPs, %DTs;
	@SN=grep { /^\d+$/ && -d "$out_dir/$_" } read_dir($out_dir);

	foreach $sn(  @SN ) {
		$SNs{$sn}="./$sn/$index";
		my @DT= grep { /^\d+/ && -d "$out_dir/$sn/$_" } read_dir("$out_dir/$sn");	
		my %DTs;
		foreach $dt ( @DT) {
			my @REP= grep { /\.html$/  && -f "$out_dir/$sn/$dt/$_" } read_dir("$out_dir/$sn/$dt");	
			my %ft;
			my %REPs;
			foreach $rep ( @REP ) {
					next if( $rep=~/^$index$/ );
					my $k=read_title( "$out_dir/$sn/$dt/$rep" );
					#$ft{ $rep }=$k if( $k );
					#print "$k $rep\n";
					$REPs{ "$k $rep" }=$rep if( $k );
			}
			my $d=$dt;
			$d=~s/_(\d\d)\.(\d\d)\.(\d\d)/ $1:$2 /g;
			$d=~s/-/ - /g;
			$DTs{$d}="./$dt/$index";
			make_index(	
				"$out_dir/$sn/$dt/$index",
				"Reports of array# $sn by date" ,
				"Array# $sn . Date: $d . Select report",
				"<a href='../../$index'> root </a>  / <a href='../$index'> array# $sn </a> /  $d ",
				\%REPs
			);		
		}
		make_index(	
			"$out_dir/$sn/$index",
			"Reports of array# $sn by date-time" ,
			"Array# $sn . Select your report date",
			"<a href='../index.html'> root </a>  /  array# $sn ",
			\%DTs
		);		
	}	
	make_index(	
		"$out_dir/$index",
		"Reports of arrays" ,
		"Arrays. Select your array serial number",
		" root ",
		\%SNs
	);
}

sub make_index {
	my $outfile=shift;
	my $title=shift;
	my $desc=shift; 
	my $path=shift;
	my $N=shift;
	my $template = HTML::Template->new(
						filename => $html_template_index, 
						case_sensitive => 0, 
						die_on_bad_params => 0, 
						path=>[$TemplatePath, './template']
						);	
my @outer_loop;
foreach $n( reverse sort ( keys(%{$N})) ) {
	my %outer_hash;	
	$outer_hash{M_LOOP_VAL}=$n;
	$outer_hash{M_LOOP_LINK}=$N->{$n};
	push @outer_loop, \%outer_hash;	
}

$template->param( M_PATH =>  $path   );
$template->param( M_TITLE =>  $title   );
$template->param( M_PAGE_DESC => $desc   );
$template->param( M_OUTER_LOOP => \@outer_loop);
	open(OUT,">$outfile") || die "Cannot open file $outfile for writing:$!\n";
	print OUT $template->output;
	close OUT;	
	print "Renew index file $outfile\n" if( $verbose );

}
