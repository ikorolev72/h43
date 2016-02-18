# h43 project
my $Reports_main,$Reports_dp, $Report_cache, $Report_port, $Report_cpu, $Report_drive, $Reports_drive_tag, 
$Report_vol,$Report_rg ;

$Reports= {
	'main'	=> {
		'outfile'	=> 'main.html',
		'reports'	=>	\$Reports_main,
		'desc'		=> 'Main reports',
	},
	'dp'	=> {
		'outfile'	=> 'dp.html',
		'reports'	=>	\$Reports_dp,
		'desc'		=> 'DP reports',
	},
	'cache'	=> {
		'outfile'	=> 'cache.html',
		'reports'	=>	\$Reports_cache,
		'desc'		=> 'Cache reports',
	},	
	'port'	=> {
		'outfile'	=> 'port.html',
		'reports'	=>	\$Reports_port,
		'desc'		=> 'Port reports',
	},	
	'cpu'	=> {
		'outfile'	=> 'cpu.html',
		'reports'	=>	\$Reports_cpu,
		'desc'		=> 'CPU reports',
	},	
	'drive'	=> {
		'outfile'	=> 'drive.html',
		'reports'	=>	\$Reports_drive,
		'desc'		=> 'Drive reports',
		#'template'		=> 'template_multi_charts_rg.html',
	},	
#	'drive_tag'	=> {
#		'outfile'	=> 'drive_tag.html',
#		'reports'	=>	\$Reports_drive_tag,
#		'desc'		=> 'Drive reports tag count',
#	},	
	'volume'	=> {
		'outfile'	=> 'vol.html',
		'reports'	=>	\$Reports_vol,
		'desc'		=> 'Volume reports',
		#'template'		=> 'template_multi_charts_rg.html',
	},	
	'rg'	=> {
		'outfile'	=> 'rg.html',
		'reports'	=>	\$Reports_rg,
		'desc'		=> 'Raid group reports',
		#'template'		=> 'template_multi_charts_rg.html',
	},	

};
		


$Reports_main1 = {
	'5' =>{
			'name'	=> 'iops summary',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'eval' => ' 
						my $sr=0;
						my $sw=0;
						foreach $y (  keys ( %{$u}) ) { 
							$sr+=${$u->{$y}}[ 4 ] ;
							$sw+=${$u->{$y}}[ 5 ] ;
						} 
						push ( @{ $allData->{"IOPS read"} },  $sr  );
						push ( @{ $allData->{"IOPS write"} }, $sw  );
						',
			'stacking'	=> 1,
			'title'	=> 'IOPS array summary',
			'outfile'	=> 'iops_sum.html',
			'sort'	=> 2,
		},
	'10' =>{
			'name'	=> 'iops',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'IOPS per port',
			'outfile'	=> 'iops_port.html',
		},	

	'20' =>{
			'name'	=> 'cpu',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'CPU Core usage (%)',
			'outfile'	=> 'cpu_core_usage.html',
			'sort'	=> 10,
		},		
	'25' =>{
			'name'	=> 'cpu old arrays',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 4, 		
			'lines'	=> [ 1 ], 	# ctl 
			'data'	=>  2 ,
			'stacking'	=> 0,
			'title'	=> 'CPU Core usage (%)',
			'outfile'	=> 'cpu_core_usage_old_arrays.html',
			'sort'	=> 10,
		},		
	'30' =>{
			'name'	=> 'cache wp %',
			'info'	=> 4, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1 ], 	# ctl port
			'data'	=>  2 ,
			'stacking'	=> 0,
			'title'	=> 'Cache write prending (%)',
			'outfile'	=> 'cache_wp.html',
			'sort'	=> 15,
		},


	
};

$Reports_main = {

	'5' =>{
			'name'	=> 'iops summary',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'eval' => ' 
						my $sr=0;
						my $sw=0;
						foreach $y (  keys ( %{$u}) ) { 
							$sr+=${$u->{$y}}[ 4 ] ;
							$sw+=${$u->{$y}}[ 5 ] ;
						} 
						push ( @{ $allData->{"IOPS read"} },  $sr  );
						push ( @{ $allData->{"IOPS write"} }, $sw  );
						',
			'stacking'	=> 1,
			'title'	=> 'IOPS array summary',
			'outfile'	=> 'iops_sum.html',
			'sort'	=> 2,
		},
	'10' =>{
			'name'	=> 'iops',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'IOPS per port',
			'outfile'	=> 'iops_port.html',
		},	
	'15' =>{
			'name'	=> 'trans summary',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'eval' => ' 
						my $sr=0;
						my $sw=0;
						foreach $y (  keys ( %{$u}) ) { 
							$sr+=${$u->{$y}}[ 9 ] ;
							$sw+=${$u->{$y}}[ 10 ] ;
						} 
						push ( @{ $allData->{"Trans read"} },  $sr  );
						push ( @{ $allData->{"Trans write"} }, $sw  );
						',
			'stacking'	=> 1,
			'title'	=> 'Transphere per array summary (mb/s)',
			'outfile'	=> 'trans_sum.html',
		},			
	'20' =>{
			'name'	=> 'cpu',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'CPU Core usage (%)',
			'outfile'	=> 'cpu_core_usage.html',
			'sort'	=> 10,
		},		
	'25' =>{
			'name'	=> 'cpu old arrays',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 4, 		
			'lines'	=> [ 1 ], 	# ctl 
			'data'	=>  2 ,
			'stacking'	=> 0,
			'title'	=> 'CPU Core usage (%)',
			'outfile'	=> 'cpu_core_usage_old_arrays.html',
			'sort'	=> 10,
		},		
	'30' =>{
			'name'	=> 'cache wp %',
			'info'	=> 4, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1 ], 	# ctl port
			'data'	=>  2 ,
			'stacking'	=> 0,
			'title'	=> 'Cache write prending (%)',
			'outfile'	=> 'cache_wp.html',
			'sort'	=> 15,
		},

	'40' =>{
			'name'	=> 'backend iops',
			'info'	=> 8, 		# see $Struct->{info}
			'header'=> 1, 		
			'eval' => ' 
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key="Ctl ${$u->{$y}}[1]";
						push ( @{ $allData->{"$key read"} },  ${$u->{$y}}[ 4 ]  );
						push ( @{ $allData->{"$key write"} }, ${$u->{$y}}[ 5 ]  );
				}
			',
			'stacking'	=> 1,
			'title'	=> 'Backend IOPS per ctl',
			'outfile'	=> 'be_iops.html',
			'sort'	=> 20,
		},		
	'45' =>{
			'name'	=> 'backend iops ols arrays',
			'info'	=> 8, 		# see $Struct->{info}
			'header'=> 3, 		
			'eval' => ' 
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key="Ctl ${$u->{$y}}[1]";
						push ( @{ $allData->{"$key read"} },  ${$u->{$y}}[ 5 ]  );
						push ( @{ $allData->{"$key write"} }, ${$u->{$y}}[ 6 ]  );
				}
			',
			'stacking'	=> 1,
			'title'	=> 'Backend IOPS per ctl',
			'outfile'	=> 'be_iops_old_array.html',
			'sort'	=> 20,
		},		
	'50' =>{
			'name'	=> 'backend trans (mb/s)',
			'info'	=> 8, 		# see $Struct->{info}
			'header'=> 1, 		
			'eval' => ' 
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key="Ctl ${$u->{$y}}[1]";
						push ( @{ $allData->{"$key read"} },  ${$u->{$y}}[ 7 ]  );
						push ( @{ $allData->{"$key write"} }, ${$u->{$y}}[ 8 ]  );
				}
			',
			'stacking'	=> 1,
			'title'	=> 'Backend transphere per ctl (mb/s)',
			'outfile'	=> 'be_trans.html',
			'sort'	=> 25,
		},				
	'55' =>{
			'name'	=> 'backend trans (mb/s) old arrays',
			'info'	=> 8, 		# see $Struct->{info}
			'header'=> 4, 		
			'eval' => ' 
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key="Ctl ${$u->{$y}}[1]";
						push ( @{ $allData->{"$key read"} },  ${$u->{$y}}[ 6 ]  );
						push ( @{ $allData->{"$key write"} }, ${$u->{$y}}[ 7 ]  );
				}
			',
			'stacking'	=> 1,
			'title'	=> 'Backend transphere per ctl (mb/s)',
			'outfile'	=> 'be_trans_old_array.html',
			'sort'	=> 25,
		},				

	
};






$Reports_dp = {
	'10' =>{
			'name'	=> 'dp_iops',
			'info'	=> 11, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'IOPS per DP',
			'outfile'	=> 'dp_iops.html',
		},		
	'20' =>{
			'name'	=> 'dp_iops_r',
			'info'	=> 11, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  4 ,
			'stacking'	=> 0,
			'title'	=> 'IOPS read per DP',
			'outfile'	=> 'dp_iops_r.html',
		},		
	'30' =>{
			'name'	=> 'dp_iops_w',
			'info'	=> 11, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  5 ,
			'stacking'	=> 0,
			'title'	=> 'IOPS write per DP ',
			'outfile'	=> 'dp_iops_w.html',
		},		
};	

$Reports_cache = {
	'10' =>{
			'name'	=> 'cache wp %',
			'info'	=> 4, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1 ], 	# ctl port
			'data'	=>  2 ,
			'stacking'	=> 0,
			'title'	=> 'Cache write prending (%)',
			'outfile'	=> 'cache_wp.html',
			'sort'	=> 15,
		},	
	'20' =>{
			'name'	=> 'read hit %',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  6 ,
			'stacking'	=> 0,
			'title'	=> 'Read hit (%)',
			'outfile'	=> 'cache_read_hit.html',
		},		
	'30' =>{
			'name'	=> 'write hit %',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  7 ,
			'stacking'	=> 0,
			'title'	=> 'Write hit (%)',
			'outfile'	=> 'cache_write_hit.html',
		},		
};	

$Reports_port = {
	'10' =>{
			'name'	=> 'iops',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'title'	=> 'IOPS per port',
			'outfile'	=> 'iops_port.html',
		},	
	'12' =>{
			'name'	=> 'iops r',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  4 ,
			'title'	=> 'IOPS per port read',
			'outfile'	=> 'iops_port_r.html',
		},	
	'20' =>{
			'name'	=> 'read hit %',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  6 ,
			'title'	=> 'Read hit (%)',
			'outfile'	=> 'cache_read_hit.html',
		},		
	'30' =>{
			'name'	=> 'iops read seq',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 8, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  4 ,
			'title'	=> 'IOPS read sequential',
			'outfile'	=> 'iops_r_seq.html',
		},			
	'40' =>{
			'name'	=> 'iops read rand',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 6, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  4 ,
			'title'	=> 'IOPS read random',
			'outfile'	=> 'iops_r_rand.html',
		},			
	'45' =>{
			'name'	=> 'average read block size',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 2, 		
			'eval' => ' 
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key="Ctl:Port ${$u->{$y}}[1]:${$u->{$y}}[2]";
					$dt=get_dt($h->{$nu}->{date},$h->{$nu}->{time});
					my $x=1;
					$x=1024*${$u->{$y}}[ 7 ]/${$u->{$y}}[ 3 ] if(${$u->{$y}}[ 3 ]>0);
						push ( @{ $allData->{$key} }, $x );
				}
			',
			'stacking'	=> 0,
			'title'	=> 'Average read block size (kb)',
			'outfile'	=> 'bs_r.html',
		},		
	'50' =>{
			'name'	=> 'iops w',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  5 ,
			'title'	=> 'IOPS per port write',
			'outfile'	=> 'iops_port_w.html',
		},	
	'60' =>{
			'name'	=> 'write hit %',
			'info'	=> 1, 		# see $Struct->{info}
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  7 ,
			'title'	=> 'Write hit (%)',
			'outfile'	=> 'cache_write_hit.html',
		},	
	'70' =>{
			'name'	=> 'iops write seq',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 8, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  5 ,
			'title'	=> 'IOPS write sequential',
			'outfile'	=> 'iops_w_seq.html',
		},			
	'80' =>{
			'name'	=> 'iops write rand',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 6, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  5 ,
			'title'	=> 'IOPS write random',
			'outfile'	=> 'iops_w_rand.html',
		},	
	'110' =>{
			'name'	=> 'average write block size',
			'info'	=> 1, 		# see $Struct->{info}
			'header'=> 2, 		
			'eval' => ' 
				foreach $y ( sort {$a <=> $b} ( keys ( %{$u}) )) { 
					my $key="Ctl:Port ${$u->{$y}}[1]:${$u->{$y}}[2]";
					$dt=get_dt($h->{$nu}->{date},$h->{$nu}->{time});
					my $x=1;
					$x=1024*${$u->{$y}}[ 8 ]/${$u->{$y}}[ 4 ] if(${$u->{$y}}[ 4 ]>0);
						push ( @{ $allData->{$key} }, $x );
				}
			',
			'title'	=> 'Average write block size (kb)',
			'outfile'	=> 'bs_w.html',
		},			
};	

$Reports_cpu = {
	'20' =>{
			'name'	=> 'cpu',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port
			'data'	=>  3 ,
			'title'	=> 'CPU Core usage (%)',
			'outfile'	=> 'cpu_core_usage.html',
			'sort'	=> 10,
		},
	'25' =>{
			'name'	=> 'cpu old arrays',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 4, 		
			'lines'	=> [ 1 ], 	# ctl 
			'data'	=>  2 ,
			'stacking'	=> 0,
			'title'	=> 'CPU Core usage (%)',
			'outfile'	=> 'cpu_core_usage_old_arrays.html',
			'sort'	=> 10,
		},			
	'30' =>{
			'name'	=> 'bus usage rate%',
			'info'	=> 5, 		# see $Struct->{info}
			'header'=> 3, 		
			'lines'	=> [ 1 ], 	# ctl port
			'data'	=>  4 ,
			'title'	=> 'Total Bus Usage Rate(%)',
			'outfile'	=> 'cpu_bus_usage.html',
		},		
};	

$Reports_drive = {
	'10' =>{
			'name'	=> 'drive operate ',
			'info'	=> 7, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2, 3], 	# ctl port etc
			'data'	=>  4 ,
			'stacking'	=> 0,
			'title'	=> 'Drive operative rate (%)',
			'outfile'	=> 'drive_op_rate.html',
			'sort'	=> 10,
		},
	'15' =>{
			'name'	=> 'drive operate old arrays',
			'info'	=> 7, 		# see $Struct->{info}
			'header'=> 2, 		
			'lines'	=> [ 1, 2, 3], 	# ctl port etc
			'data'	=>  4 ,
			'stacking'	=> 0,
			'title'	=> 'Drive operative rate (%)',
			'outfile'	=> 'drive_op_rate_old_array.html',
			'sort'	=> 10,
		},
};	

$Reports_drive_tag = {
	'20' =>{
			'name'	=> 'drive tag count',
			'info'	=> 7, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2, 3], 	# ctl port etc
			'data'	=>  5 ,
			'stacking'	=> 0,
			'title'	=> 'Drive tag count',
			'outfile'	=> 'drive_tag_count.html',
			'sort'	=> 20,
		},
};	

$Reports_vol = {
	'10' =>{
			'name'	=> 'volume iops',
			'info'	=> 3, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port etc
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'Volume iops',
			'outfile'	=> 'vol_iops.html',
		},
	'20' =>{
			'name'	=> 'volume iops read',
			'info'	=> 3, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port etc
			'data'	=>  4 ,
			'stacking'	=> 0,
			'title'	=> 'Volume iops read',
			'outfile'	=> 'vol_iops_r.html',
		},
	'30' =>{
			'name'	=> 'volume iops write',
			'info'	=> 3, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port etc
			'data'	=>  5 ,
			'stacking'	=> 0,
			'title'	=> 'Volume iops write',
			'outfile'	=> 'vol_iops_w.html',
		},
};	

$Reports_rg = {
	'10' =>{
			'name'	=> 'rg iops',
			'info'	=> 2, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port etc
			'data'	=>  3 ,
			'stacking'	=> 0,
			'title'	=> 'RG iops',
			'outfile'	=> 'rg_iops.html',
		},
	'20' =>{
			'name'	=> 'rg iops read',
			'info'	=> 2, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port etc
			'data'	=>  4 ,
			'stacking'	=> 0,
			'title'	=> 'RG iops read',
			'outfile'	=> 'rg_iops_r.html',
		},
	'30' =>{
			'name'	=> 'rg iops write',
			'info'	=> 2, 		# see $Struct->{info}
			'header'=> 1, 		
			'lines'	=> [ 1, 2 ], 	# ctl port etc
			'data'	=>  5 ,
			'stacking'	=> 0,
			'title'	=> 'RG iops write',
			'outfile'	=> 'rg_iops_w.html',
		},
};	


$Struct = {
          'info' => {
                      '6' => '---- Drive Information ----',
                      '3' => '---- LU Information ----',
                      '7' => '---- Drive Operate Information ----',
                      '9' => '---- Management Area Information : RAID Group ----',
                      '2' => '---- RG Information ----',
                      '8' => '---- Backend Information ----',
                      '1' => '---- Port Information ----',
                      '4' => '---- Cache Information ----',
                      '5' => '---- Processor Information ----',
                      '11' => '---- DP Pool Information ----',
                      '10' => '---- Management Area Information : DP Pool ----',
                    },
          'deinfo' => {
                      '---- Drive Information ----' => 6,
                      '---- LU Information ----' => 3,
                      '---- Drive Operate Information ----' => 7,
                      '---- Management Area Information : RAID Group ----' => 9,
                      '---- RG Information ----' => 2,
                      '---- Backend Information ----' => 8,
                      '---- Port Information ----' => 1,
                      '---- Cache Information ----' => 4,
                      '---- Processor Information ----' => 5,
                      '---- DP Pool Information ----' => 11,
                      '---- Management Area Information : DP Pool ----' => 10,
                    },
          'field' => {
                       '10' => {
                                 '1' => {
                                          '4' => 'CacheHitRate(%)',
                                          '1' => 'CTL',
                                          '3' => 'DPPool',
                                          '2' => 'Core',
                                          '5' => 'AccessCount'
                                        }
                               },
                       '11' => {
                                '4' => {
                                         '4' => 'XCOPYMaxTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'XCOPYTime(microsec.)',
                                         '2' => 'DPPool'
                                       },
                                '1' => {
                                         '6' => 'ReadHit(%)',
                                         '3' => 'IORate(IOPS)',
                                         '7' => 'WriteHit(%)',
                                         '9' => 'ReadTrans.Rate(MB/S)',
                                         '2' => 'DPPool',
                                         '8' => 'Trans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'ReadRate(IOPS)',
                                         '10' => 'WriteTrans.Rate(MB/S)',
                                         '5' => 'WriteRate(IOPS)'
                                       },
                                '3' => {
                                         '6' => 'XCOPYReadTrans.Rate(MB/S)',
                                         '4' => 'XCOPYReadRate(IOPS)',
                                         '1' => 'CTL',
                                         '3' => 'XCOPYRate(IOPS)',
                                         '7' => 'XCOPYWriteTrans.Rate(MB/S)',
                                         '2' => 'DPPool',
                                         '5' => 'XCOPYWriteRate(IOPS)'
                                       },
                                '2' => {
                                         '6' => 'WriteCMDHitCount',
                                         '3' => 'ReadCMDCount',
                                         '7' => 'ReadTrans.Size(MB)',
                                         '2' => 'DPPool',
                                         '8' => 'WriteTrans.Size(MB)',
                                         '1' => 'CTL',
                                         '4' => 'WriteCMDCount',
                                         '5' => 'ReadCMDHitCount'
                                       }
                              },
                       '6' => {
                                '1' => {
                                         '6' => 'WriteRate(IOPS)',
                                         '3' => 'HDU',
                                         '7' => 'Trans.Rate(MB/S)',
                                         '9' => 'WriteTrans.Rate(MB/S)',
                                         '2' => 'Unit',
                                         '8' => 'ReadTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'IORate(IOPS)',
                                         '10' => 'OnlineVerifyRate(IOPS)',
                                         '5' => 'ReadRate(IOPS)'
                                       },
                                '2' => {
                                         '6' => 'ReadTrans.Size',
                                         '3' => 'HDU',
                                         '7' => 'WriteTrans.Size',
                                         '2' => 'Unit',
                                         '8' => 'OnlineVerifyCMDCount',
                                         '1' => 'CTL',
                                         '4' => 'ReadCMDCount',
                                         '5' => 'WriteCMDCount'
                                       }
                              },
                       '3' => {
                                '11' => {
                                          '6' => 'ReadMissDelayCMDCount(1000ms-)',
                                          '4' => 'ReadMissDelayCMDCount(300-499ms)',
                                          '1' => 'CTL',
                                          '3' => 'ReadMissDelayCMDCount(<300ms)',
                                          '2' => 'LU',
                                          '5' => 'ReadMissDelayCMDCount(500-999ms)'
                                        },
                                '21' => {
                                          '6' => 'XCOPYReadTrans.Rate(MB/S)',
                                          '4' => 'XCOPYReadRate(IOPS)',
                                          '1' => 'CTL',
                                          '3' => 'XCOPYRate(IOPS)',
                                          '7' => 'XCOPYWriteTrans.Rate(MB/S)',
                                          '2' => 'LU',
                                          '5' => 'XCOPYWriteRate(IOPS)'
                                        },
                                '7' => {
                                         '4' => 'ReadCMDJobTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'ReadCMDJobCount',
                                         '2' => 'LU',
                                         '5' => 'ReadCMDJobMaxTime(microsec.)'
                                       },
                                '17' => {
                                          '6' => 'RandomTrans.Rate(MB/S)',
                                          '3' => 'RandomIORate(IOPS)',
                                          '7' => 'RandomReadTrans.Rate(MB/S)',
                                          '2' => 'LU',
                                          '8' => 'RandomWriteTrans.Rate(MB/S)',
                                          '1' => 'CTL',
                                          '4' => 'RandomReadRate(IOPS)',
                                          '5' => 'RandomWriteRate(IOPS)'
                                        },
                                '2' => {
                                         '6' => 'WriteCMDHitCount',
                                         '3' => 'ReadCMDCount',
                                         '7' => 'ReadTrans.Size(MB)',
                                         '2' => 'LU',
                                         '8' => 'WriteTrans.Size(MB)',
                                         '1' => 'CTL',
                                         '4' => 'WriteCMDCount',
                                         '5' => 'ReadCMDHitCount'
                                       },
                                '22' => {
                                          '4' => 'XCOPYMaxTime(microsec.)',
                                          '1' => 'CTL',
                                          '3' => 'XCOPYTime(microsec.)',
                                          '2' => 'LU'
                                        },
                                '1' => {
                                         '6' => 'ReadHit(%)',
                                         '3' => 'IORate(IOPS)',
                                         '7' => 'WriteHit(%)',
                                         '9' => 'ReadTrans.Rate(MB/S)',
                                         '2' => 'LU',
                                         '8' => 'Trans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'ReadRate(IOPS)',
                                         '10' => 'WriteTrans.Rate(MB/S)',
                                         '5' => 'WriteRate(IOPS)'
                                       },
                                '18' => {
                                          '6' => 'RandomWriteTrans.Size(MB)',
                                          '4' => 'RandomWriteCMDCount',
                                          '1' => 'CTL',
                                          '3' => 'RandomReadCMDCount',
                                          '2' => 'LU',
                                          '5' => 'RandomReadTrans.Size(MB)'
                                        },
                                '23' => {
                                          '6' => 'TotalAverageTagCount',
                                          '3' => 'TotalTagCount',
                                          '7' => 'ReadAverageTagCount',
                                          '2' => 'LU',
                                          '8' => 'WriteAverageTagCount',
                                          '1' => 'CTL',
                                          '4' => 'ReadTagCount',
                                          '5' => 'WriteTagCount'
                                        },
                                '16' => {
                                          '6' => 'DataCMDTrans.Size(MB)',
                                          '3' => 'DataCMDIORate(IOPS)',
                                          '7' => 'DataCMDTime(microsec.)',
                                          '2' => 'LU',
                                          '8' => 'DataCMDMaxTime(microsec.)',
                                          '1' => 'CTL',
                                          '4' => 'DataCMDTrans.Rate(MB/S)',
                                          '5' => 'DataCMDCount'
                                        },
                                '13' => {
                                          '6' => 'ReadJobDelayCMDCount(1000ms-)',
                                          '4' => 'ReadJobDelayCMDCount(300-499ms)',
                                          '1' => 'CTL',
                                          '3' => 'ReadJobDelayCMDCount(<300ms)',
                                          '2' => 'LU',
                                          '5' => 'ReadJobDelayCMDCount(500-999ms)'
                                        },
                                '6' => {
                                         '4' => 'WriteCMDMissTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'WriteCMDMissCount',
                                         '2' => 'LU',
                                         '5' => 'WriteCMDMissMaxTime(microsec.)'
                                       },
                                '3' => {
                                         '4' => 'ReadCMDHitTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'ReadCMDHitCount2',
                                         '2' => 'LU',
                                         '5' => 'ReadCMDHitMaxTime(microsec.)'
                                       },
                                '9' => {
                                         '6' => 'ReadHitDelayCMDCount(1000ms-)',
                                         '4' => 'ReadHitDelayCMDCount(300-499ms)',
                                         '1' => 'CTL',
                                         '3' => 'ReadHitDelayCMDCount(<300ms)',
                                         '2' => 'LU',
                                         '5' => 'ReadHitDelayCMDCount(500-999ms)'
                                       },
                                '12' => {
                                          '6' => 'WriteMissDelayCMDCount(1000ms-)',
                                          '4' => 'WriteMissDelayCMDCount(300-499ms)',
                                          '1' => 'CTL',
                                          '3' => 'WriteMissDelayCMDCount(<300ms)',
                                          '2' => 'LU',
                                          '5' => 'WriteMissDelayCMDCount(500-999ms)'
                                        },
                                '20' => {
                                          '6' => 'SequentialWriteTrans.Size(MB)',
                                          '4' => 'SequentialWriteCMDCount',
                                          '1' => 'CTL',
                                          '3' => 'SequentialReadCMDCount',
                                          '2' => 'LU',
                                          '5' => 'SequentialReadTrans.Size(MB)'
                                        },
                                '14' => {
                                          '6' => 'WriteJobDelayCMDCount(1000ms-)',
                                          '4' => 'WriteJobDelayCMDCount(300-499ms)',
                                          '1' => 'CTL',
                                          '3' => 'WriteJobDelayCMDCount(<300ms)',
                                          '2' => 'LU',
                                          '5' => 'WriteJobDelayCMDCount(500-999ms)'
                                        },
                                '15' => {
                                          '4' => 'AverageTagCount',
                                          '1' => 'CTL',
                                          '3' => 'TagCount',
                                          '2' => 'LU'
                                        },
                                '8' => {
                                         '4' => 'WriteCMDJobTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'WriteCMDJobCount',
                                         '2' => 'LU',
                                         '5' => 'WriteCMDJobMaxTime(microsec.)'
                                       },
                                '4' => {
                                         '4' => 'WriteCMDHitTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'WriteCMDHitCount2',
                                         '2' => 'LU',
                                         '5' => 'WriteCMDHitMaxTime(microsec.)'
                                       },
                                '19' => {
                                          '6' => 'SequentialTrans.Rate(MB/S)',
                                          '3' => 'SequentialIORate(IOPS)',
                                          '7' => 'SequentialReadTrans.Rate(MB/S)',
                                          '2' => 'LU',
                                          '8' => 'SequentialWriteTrans.Rate(MB/S)',
                                          '1' => 'CTL',
                                          '4' => 'SequentialReadRate(IOPS)',
                                          '5' => 'SequentialWriteRate(IOPS)'
                                        },
                                '10' => {
                                          '6' => 'WriteHitDelayCMDCount(1000ms-)',
                                          '4' => 'WriteHitDelayCMDCount(300-499ms)',
                                          '1' => 'CTL',
                                          '3' => 'WriteHitDelayCMDCount(<300ms)',
                                          '2' => 'LU',
                                          '5' => 'WriteHitDelayCMDCount(500-999ms)'
                                        },
                                '5' => {
                                         '4' => 'ReadCMDMissTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'ReadCMDMissCount',
                                         '2' => 'LU',
                                         '5' => 'ReadCMDMissMaxTime(microsec.)'
                                       }
                              },
                       '7' => {
                                '1' => {
                                         '6' => 'UnloadTime(min.)',
                                         '4' => 'OperatingRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'HDU',
                                         '7' => 'AverageTagCount',
                                         '2' => 'Unit',
                                         '5' => 'TagCount'
                                       },
                                '2' => {
                                         '6' => 'UnloadTime(min.)',
                                         '4' => 'OperatingRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'HDU',
                                         '2' => 'Unit',
                                         '5' => 'TagCount'
                                       },							  
                              },
                       '9' => {
                                '1' => {
                                         '4' => 'CacheHitRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'RG',
                                         '2' => 'Core',
                                         '5' => 'AccessCount'
                                       }
                              },
                       '2' => {
                                '6' => {
                                         '6' => 'SequentialWriteTrans.Size(MB)',
                                         '4' => 'SequentialWriteCMDCount',
                                         '1' => 'CTL',
                                         '3' => 'SequentialReadCMDCount',
                                         '2' => 'RG',
                                         '5' => 'SequentialReadTrans.Size(MB)'
                                       },
                                '3' => {
                                         '6' => 'RandomTrans.Rate(MB/S)',
                                         '3' => 'RandomIORate(IOPS)',
                                         '7' => 'RandomReadTrans.Rate(MB/S)',
                                         '2' => 'RG',
                                         '8' => 'RandomWriteTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'RandomReadRate(IOPS)',
                                         '5' => 'RandomWriteRate(IOPS)'
                                       },
                                '7' => {
                                         '6' => 'XCOPYReadTrans.Rate(MB/S)',
                                         '4' => 'XCOPYReadRate(IOPS)',
                                         '1' => 'CTL',
                                         '3' => 'XCOPYRate(IOPS)',
                                         '7' => 'XCOPYWriteTrans.Rate(MB/S)',
                                         '2' => 'RG',
                                         '5' => 'XCOPYWriteRate(IOPS)'
                                       },
                                '2' => {
                                         '6' => 'WriteCMDHitCount',
                                         '3' => 'ReadCMDCount',
                                         '7' => 'ReadTrans.Size(MB)',
                                         '2' => 'RG',
                                         '8' => 'WriteTrans.Size(MB)',
                                         '1' => 'CTL',
                                         '4' => 'WriteCMDCount',
                                         '5' => 'ReadCMDHitCount'
                                       },
                                '8' => {
                                         '4' => 'XCOPYMaxTime(microsec.)',
                                         '1' => 'CTL',
                                         '3' => 'XCOPYTime(microsec.)',
                                         '2' => 'RG'
                                       },
                                '1' => {
                                         '6' => 'ReadHit(%)',
                                         '3' => 'IORate(IOPS)',
                                         '7' => 'WriteHit(%)',
                                         '9' => 'ReadTrans.Rate(MB/S)',
                                         '2' => 'RG',
                                         '8' => 'Trans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'ReadRate(IOPS)',
                                         '10' => 'WriteTrans.Rate(MB/S)',
                                         '5' => 'WriteRate(IOPS)'
                                       },
                                '4' => {
                                         '6' => 'RandomWriteTrans.Size(MB)',
                                         '4' => 'RandomWriteCMDCount',
                                         '1' => 'CTL',
                                         '3' => 'RandomReadCMDCount',
                                         '2' => 'RG',
                                         '5' => 'RandomReadTrans.Size(MB)'
                                       },
                                '5' => {
                                         '6' => 'SequentialTrans.Rate(MB/S)',
                                         '3' => 'SequentialIORate(IOPS)',
                                         '7' => 'SequentialReadTrans.Rate(MB/S)',
                                         '2' => 'RG',
                                         '8' => 'SequentialWriteTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'SequentialReadRate(IOPS)',
                                         '5' => 'SequentialWriteRate(IOPS)'
                                       }
                              },
                       '8' => {
                                '1' => {
                                         '6' => 'Trans.Rate(MB/S)',
                                         '3' => 'IORate(IOPS)',
                                         '7' => 'ReadTrans.Rate(MB/S)',
                                         '9' => 'OnlineVerifyRate(IOPS)',
                                         '2' => 'Path',
                                         '8' => 'WriteTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'ReadRate(IOPS)',
                                         '5' => 'WriteRate(IOPS)'
                                       },
                                '2' => {
                                         '6' => 'WriteTrans.Size',
                                         '4' => 'WriteCMDCount',
                                         '1' => 'CTL',
                                         '3' => 'ReadCMDCount',
                                         '7' => 'OnlineVerifyCMDCount',
                                         '2' => 'Path',
                                         '5' => 'ReadTrans.Size'
                                       },
                                '3' => {
                                         '6' => 'WriteRate(IOPS)',
                                         '3' => 'Loop',
                                         '7' => 'Trans.Rate(MB/S)',
                                         '9' => 'WriteTrans.Rate(MB/S)',
                                         '2' => 'Path',
                                         '8' => 'ReadTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'IORate(IOPS)',
                                         '10' => 'OnlineVerifyRate(IOPS)',
                                         '5' => 'ReadRate(IOPS)'
                                       },
                                '4' => {
                                         '6' => 'ReadTrans.Size',
                                         '3' => 'Loop',
                                         '7' => 'WriteTrans.Size',
                                         '2' => 'Path',
                                         '8' => 'OnlineVerifyCMDCount',
                                         '1' => 'CTL',
                                         '4' => 'ReadCMDCount',
                                         '5' => 'WriteCMDCount'
                                       }
                              },							  
                       '1' => {
                                '6' => {
                                         '6' => 'RandomTrans.Rate(MB/S)',
                                         '3' => 'RandomIORate(IOPS)',
                                         '7' => 'RandomReadTrans.Rate(MB/S)',
                                         '2' => 'Port',
                                         '8' => 'RandomWriteTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'RandomReadRate(IOPS)',
                                         '5' => 'RandomWriteRate(IOPS)'
                                       },
                                '11' => {
                                          '4' => 'XCOPYMaxTime(microsec.)',
                                          '1' => 'CTL',
                                          '3' => 'XCOPYTime(microsec.)',
                                          '2' => 'Port'
                                        },
                                '3' => {
                                         '6' => 'CTLCMDTrans.Size(KB)',
                                         '3' => 'CTLCMDIORate(IOPS)',
                                         '7' => 'CTLCMDTime(microsec.)',
                                         '2' => 'Port',
                                         '8' => 'CTLCMDMaxTime(microsec.)',
                                         '1' => 'CTL',
                                         '4' => 'CTLCMDTrans.Rate(KB/S)',
                                         '5' => 'CTLCMDCount'
                                       },
                                '7' => {
                                         '6' => 'RandomWriteTrans.Size(MB)',
                                         '4' => 'RandomWriteCMDCount',
                                         '1' => 'CTL',
                                         '3' => 'RandomReadCMDCount',
                                         '2' => 'Port',
                                         '5' => 'RandomReadTrans.Size(MB)'
                                       },
                                '9' => {
                                         '6' => 'SequentialWriteTrans.Size(MB)',
                                         '4' => 'SequentialWriteCMDCount',
                                         '1' => 'CTL',
                                         '3' => 'SequentialReadCMDCount',
                                         '2' => 'Port',
                                         '5' => 'SequentialReadTrans.Size(MB)'
                                       },
                                '2' => {
                                         '6' => 'WriteCMDHitCount',
                                         '3' => 'ReadCMDCount',
                                         '7' => 'ReadTrans.Size(MB)',
                                         '2' => 'Port',
                                         '8' => 'WriteTrans.Size(MB)',
                                         '1' => 'CTL',
                                         '4' => 'WriteCMDCount',
                                         '5' => 'ReadCMDHitCount'
                                       },
                                '8' => {
                                         '6' => 'SequentialTrans.Rate(MB/S)',
                                         '3' => 'SequentialIORate(IOPS)',
                                         '7' => 'SequentialReadTrans.Rate(MB/S)',
                                         '2' => 'Port',
                                         '8' => 'SequentialWriteTrans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'SequentialReadRate(IOPS)',
                                         '5' => 'SequentialWriteRate(IOPS)'
                                       },
                                '1' => {
                                         '6' => 'ReadHit(%)',
                                         '3' => 'IORate(IOPS)',
                                         '7' => 'WriteHit(%)',
                                         '9' => 'ReadTrans.Rate(MB/S)',
                                         '2' => 'Port',
                                         '8' => 'Trans.Rate(MB/S)',
                                         '1' => 'CTL',
                                         '4' => 'ReadRate(IOPS)',
                                         '10' => 'WriteTrans.Rate(MB/S)',
                                         '5' => 'WriteRate(IOPS)'
                                       },
                                '4' => {
                                         '6' => 'DataCMDTrans.Size(MB)',
                                         '3' => 'DataCMDIORate(IOPS)',
                                         '7' => 'DataCMDTime(microsec.)',
                                         '2' => 'Port',
                                         '8' => 'DataCMDMaxTime(microsec.)',
                                         '1' => 'CTL',
                                         '4' => 'DataCMDTrans.Rate(MB/S)',
                                         '5' => 'DataCMDCount'
                                       },
                                '10' => {
                                          '6' => 'XCOPYReadTrans.Rate(MB/S)',
                                          '4' => 'XCOPYReadRate(IOPS)',
                                          '1' => 'CTL',
                                          '3' => 'XCOPYRate(IOPS)',
                                          '7' => 'XCOPYWriteTrans.Rate(MB/S)',
                                          '2' => 'Port',
                                          '5' => 'XCOPYWriteRate(IOPS)'
                                        },
                                '5' => {
                                         '1' => 'CTL',
                                         '3' => 'TimeoutErrorCount',
                                         '2' => 'Port'
                                       }
                              },
                       '4' => {
                                '4' => {
                                         '4' => 'MiddleQueueUsageRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'CleanQueueUsageRate(%)',
                                         '2' => 'Partition',
                                         '5' => 'PhysicalQueueUsageRate(%)'
                                       },
                                '1' => {
                                         '1' => 'CTL',
                                         '2' => 'WritePendingRate(%)'
                                       },
                                '3' => {
                                         '1' => 'CTL',
                                         '3' => 'WritePendingRate(%)',
                                         '2' => 'Partition'
                                       },
                                '2' => {
                                         '4' => 'PhysicalQueueUsageRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'MiddleQueueUsageRate(%)',
                                         '2' => 'CleanQueueUsageRate(%)',
                                         '5' => 'TotalQueueUsageRate(%)'
                                       }
                              },
                       '5' => {
                                '1' => {
                                         '1' => 'CTL',
                                         '3' => 'Usage(%)',
                                         '2' => 'Core'
                                       },
                                '3' => {
                                         '4' => 'TotalBusUsageRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'DualBusUsageRate(%)',
                                         '2' => 'Cache(DRR)BusUsageRate(%)'
                                       },
                                '2' => {
                                         '4' => 'Processor-CacheBusUsageRate(%)',
                                         '1' => 'CTL',
                                         '3' => 'Drive-CacheBusUsageRate(%)',
                                         '2' => 'Host-CacheBusUsageRate(%)'
                                       },
                                '4' => {
                                         '1' => 'CTL',
                                         '2' => 'Usage(%)',
                                       },
                              }
                     },
          'header' => {
                        '10' => {
                                  '1' => 'CTL Core DP Pool   Cache Hit Rate(%)   Access Count'
                                },
                        '11' => {
                                 '4' => 'CTL DP Pool XCOPY Time(microsec.) XCOPY Max Time(microsec.)',
                                 '1' => 'CTL DP Pool        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS) Read Hit(%) Write Hit(%)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S)',
                                 '3' => 'CTL DP Pool     XCOPY Rate(IOPS) XCOPY Read Rate(IOPS) XCOPY Write Rate(IOPS) XCOPY Read Trans. Rate(MB/S) XCOPY Write Trans. Rate(MB/S)',
                                 '2' => 'CTL DP Pool       Read CMD Count      Write CMD Count   Read CMD Hit Count  Write CMD Hit Count Read Trans. Size(MB) Write Trans. Size(MB)'
                               },
                        '6' => {
                                 '1' => 'CTL Unit HDU        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S) Online Verify Rate(IOPS)',
                                 '2' => 'CTL Unit HDU       Read CMD Count      Write CMD Count     Read Trans. Size    Write Trans. Size Online Verify CMD Count'
                               },
                        '3' => {
                                 '11' => 'CTL    LU   Read Miss Delay CMD Count(<300ms)   Read Miss Delay CMD Count(300-499ms)   Read Miss Delay CMD Count(500-999ms)   Read Miss Delay CMD Count(1000ms-)',
                                 '21' => 'CTL    LU     XCOPY Rate(IOPS) XCOPY Read Rate(IOPS) XCOPY Write Rate(IOPS) XCOPY Read Trans. Rate(MB/S) XCOPY Write Trans. Rate(MB/S)',
                                 '7' => 'CTL    LU    Read CMD Job Count    Read CMD Job Time(microsec.)    Read CMD Job Max Time(microsec.)',
                                 '17' => 'CTL    LU Random IO Rate(IOPS) Random Read Rate(IOPS) Random Write Rate(IOPS) Random Trans. Rate(MB/S) Random Read Trans. Rate(MB/S) Random Write Trans. Rate(MB/S)',
                                 '2' => 'CTL    LU       Read CMD Count      Write CMD Count   Read CMD Hit Count  Write CMD Hit Count Read Trans. Size(MB) Write Trans. Size(MB)',
                                 '22' => 'CTL    LU XCOPY Time(microsec.) XCOPY Max Time(microsec.)',
                                 '1' => 'CTL    LU        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS) Read Hit(%) Write Hit(%)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S)',
                                 '18' => 'CTL    LU Random Read CMD Count Random Write CMD Count Random Read Trans. Size(MB) Random Write Trans. Size(MB)',
                                 '23' => 'CTL    LU Total Tag Count  Read Tag Count  Write Tag Count  Total Average Tag Count  Read Average Tag Count  Write Average Tag Count',
                                 '16' => 'CTL    LU Data CMD IO Rate(IOPS) Data CMD Trans. Rate(MB/S)       Data CMD Count Data CMD Trans. Size(MB) Data CMD Time(microsec.) Data CMD Max Time(microsec.)',
                                 '13' => 'CTL    LU    Read Job Delay CMD Count(<300ms)    Read Job Delay CMD Count(300-499ms)    Read Job Delay CMD Count(500-999ms)    Read Job Delay CMD Count(1000ms-)',
                                 '6' => 'CTL    LU  Write CMD Miss Count  Write CMD Miss Time(microsec.)  Write CMD Miss Max Time(microsec.)',
                                 '3' => 'CTL    LU   Read CMD Hit Count2    Read CMD Hit Time(microsec.)    Read CMD Hit Max Time(microsec.)',
                                 '9' => 'CTL    LU    Read Hit Delay CMD Count(<300ms)    Read Hit Delay CMD Count(300-499ms)    Read Hit Delay CMD Count(500-999ms)    Read Hit Delay CMD Count(1000ms-)',
                                 '12' => 'CTL    LU  Write Miss Delay CMD Count(<300ms)  Write Miss Delay CMD Count(300-499ms)  Write Miss Delay CMD Count(500-999ms)  Write Miss Delay CMD Count(1000ms-)',
                                 '20' => 'CTL    LU Sequential Read CMD Count Sequential Write CMD Count Sequential Read Trans. Size(MB) Sequential Write Trans. Size(MB)',
                                 '14' => 'CTL    LU   Write Job Delay CMD Count(<300ms)   Write Job Delay CMD Count(300-499ms)   Write Job Delay CMD Count(500-999ms)   Write Job Delay CMD Count(1000ms-)',
                                 '15' => 'CTL    LU   Tag Count   Average Tag Count',
                                 '8' => 'CTL    LU   Write CMD Job Count   Write CMD Job Time(microsec.)   Write CMD Job Max Time(microsec.)',
                                 '4' => 'CTL    LU  Write CMD Hit Count2   Write CMD Hit Time(microsec.)   Write CMD Hit Max Time(microsec.)',
                                 '19' => 'CTL    LU Sequential IO Rate(IOPS) Sequential Read Rate(IOPS) Sequential Write Rate(IOPS) Sequential Trans. Rate(MB/S) Sequential Read Trans. Rate(MB/S) Sequential Write Trans. Rate(MB/S)',
                                 '10' => 'CTL    LU   Write Hit Delay CMD Count(<300ms)   Write Hit Delay CMD Count(300-499ms)   Write Hit Delay CMD Count(500-999ms)   Write Hit Delay CMD Count(1000ms-)',
                                 '5' => 'CTL    LU   Read CMD Miss Count   Read CMD Miss Time(microsec.)   Read CMD Miss Max Time(microsec.)'
                               },
                        '7' => {
                                 '1' => 'CTL Unit HDU Operating Rate(%)  Tag Count  Unload Time(min.)  Average Tag Count',
                                 '2' => 'CTL Unit HDU Operating Rate(%)  Tag Count  Unload Time(min.)'
                               },
                        '9' => {
                                 '1' => 'CTL Core  RG       Cache Hit Rate(%)   Access Count'
                               },
                        '2' => {
                                 '6' => 'CTL    RG Sequential Read CMD Count Sequential Write CMD Count Sequential Read Trans. Size(MB) Sequential Write Trans. Size(MB)',
                                 '3' => 'CTL    RG Random IO Rate(IOPS) Random Read Rate(IOPS) Random Write Rate(IOPS) Random Trans. Rate(MB/S) Random Read Trans. Rate(MB/S) Random Write Trans. Rate(MB/S)',
                                 '7' => 'CTL    RG     XCOPY Rate(IOPS) XCOPY Read Rate(IOPS) XCOPY Write Rate(IOPS) XCOPY Read Trans. Rate(MB/S) XCOPY Write Trans. Rate(MB/S)',
                                 '2' => 'CTL    RG       Read CMD Count      Write CMD Count   Read CMD Hit Count  Write CMD Hit Count Read Trans. Size(MB) Write Trans. Size(MB)',
                                 '8' => 'CTL    RG XCOPY Time(microsec.) XCOPY Max Time(microsec.)',
                                 '1' => 'CTL    RG        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS) Read Hit(%) Write Hit(%)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S)',
                                 '4' => 'CTL    RG Random Read CMD Count Random Write CMD Count Random Read Trans. Size(MB) Random Write Trans. Size(MB)',
                                 '5' => 'CTL    RG Sequential IO Rate(IOPS) Sequential Read Rate(IOPS) Sequential Write Rate(IOPS) Sequential Trans. Rate(MB/S) Sequential Read Trans. Rate(MB/S) Sequential Write Trans. Rate(MB/S)'
                               },
                        '8' => {
                                 '1' => 'CTL Path        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S) Online Verify Rate(IOPS)',
                                 '2' => 'CTL Path       Read CMD Count      Write CMD Count     Read Trans. Size    Write Trans. Size Online Verify CMD Count',
                                 '3' => 'CTL Path Loop        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S) Online Verify Rate(IOPS)',
                                 '4' => 'CTL Path Loop       Read CMD Count      Write CMD Count     Read Trans. Size    Write Trans. Size Online Verify CMD Count',
                               },
                        '1' => {
                                 '6' => 'CTL  Port Random IO Rate(IOPS) Random Read Rate(IOPS) Random Write Rate(IOPS) Random Trans. Rate(MB/S) Random Read Trans. Rate(MB/S) Random Write Trans. Rate(MB/S)',
                                 '11' => 'CTL  Port XCOPY Time(microsec.) XCOPY Max Time(microsec.)',
                                 '3' => 'CTL  Port  CTL CMD IO Rate(IOPS)  CTL CMD Trans. Rate(KB/S)        CTL CMD Count  CTL CMD Trans. Size(KB)  CTL CMD Time(microsec.)  CTL CMD Max Time(microsec.)',
                                 '7' => 'CTL  Port Random Read CMD Count Random Write CMD Count Random Read Trans. Size(MB) Random Write Trans. Size(MB)',
                                 '9' => 'CTL  Port Sequential Read CMD Count Sequential Write CMD Count Sequential Read Trans. Size(MB) Sequential Write Trans. Size(MB)',
                                 '2' => 'CTL  Port       Read CMD Count      Write CMD Count   Read CMD Hit Count  Write CMD Hit Count Read Trans. Size(MB) Write Trans. Size(MB)',
                                 '8' => 'CTL  Port Sequential IO Rate(IOPS) Sequential Read Rate(IOPS) Sequential Write Rate(IOPS) Sequential Trans. Rate(MB/S) Sequential Read Trans. Rate(MB/S) Sequential Write Trans. Rate(MB/S)',
                                 '1' => 'CTL  Port        IO Rate(IOPS)      Read Rate(IOPS)     Write Rate(IOPS) Read Hit(%) Write Hit(%)    Trans. Rate(MB/S) Read Trans. Rate(MB/S) Write Trans. Rate(MB/S)',
                                 '4' => 'CTL  Port Data CMD IO Rate(IOPS) Data CMD Trans. Rate(MB/S)       Data CMD Count Data CMD Trans. Size(MB) Data CMD Time(microsec.) Data CMD Max Time(microsec.)',
                                 '10' => 'CTL  Port     XCOPY Rate(IOPS) XCOPY Read Rate(IOPS) XCOPY Write Rate(IOPS) XCOPY Read Trans. Rate(MB/S) XCOPY Write Trans. Rate(MB/S)',
                                 '5' => 'CTL  Port    Timeout Error Count'
                               },
                        '4' => {
                                 '4' => 'CTL Partition Clean Queue Usage Rate(%) Middle Queue Usage Rate(%) Physical Queue Usage Rate(%)',
                                 '1' => 'CTL Write Pending Rate(%)',
                                 '3' => 'CTL Partition Write Pending Rate(%)',
                                 '2' => 'CTL Clean Queue Usage Rate(%) Middle Queue Usage Rate(%) Physical Queue Usage Rate(%) Total Queue Usage Rate(%)'
                               },
                        '5' => {
                                 '4' => 'CTL Usage(%)',
                                 '3' => 'CTL Cache(DRR) Bus Usage Rate(%)        Dual Bus Usage Rate(%)           Total Bus Usage Rate(%)',
                                 '2' => 'CTL Host-Cache Bus Usage Rate(%) Drive-Cache Bus Usage Rate(%) Processor-Cache Bus Usage Rate(%)',
                                 '1' => 'CTL Core Usage(%)',
                               }
                      }
        };


1;