#!/usr/bin/perl 
# Author: Ajay Joshi, email: joshi.ajay@gmail.com
# usage: use matrix.csv as a csv file for the input data. Input 0 for all blank numbers. Pass that file as an argument.
# e.g.: sudoku_solver.pl matrix.csv
# version: 2.8

print "\n\nAuthor: Ajay Joshi, email: joshi.ajay\@gmail.com\n\n\n";

$num_remaining=81;

# Initialize number arrays:
@pos1, @pos2, @pos3, @pos4, @pos5, @pos6, @pos7, @pos8, @pos9; my $num_arr, $s, $p, $q, $r, $num;

for ($num=1; $num<10;$num++) {
 	$num_arr="pos"."$num";
      for ($s=0;$s<7;$s+=3) {
		for ($p=0;$p<3;$p++) {
			for ($q=$s;$q<$s+3;$q++){
			                for ($r=0;$r<3;$r++) {
					${$num_arr}[$q][$p][$r]=1;
			                }
			}
		}
      }
}

$data_file=$ARGV[0];
$detail_flag=$ARGV[1];
if ($detail_flag eq "-details" || $detail_flag eq "") {

} else{
print "Invalid parameter: $detail_flag. It should be either blank or '-details'\nExiting...!\n";
exit;
}

&read_problem();
for ($iteration=1; $iteration<5; $iteration++) {
if ($num_remaining > 0) {
print "Iteration $iteration\n", if ($detail_flag eq '-details');
&lookup();
&lookup_num_tie();
&lookup_loc_uniquness();
	if ($num_remaining == 0) {
		print "\nDone! Answer found in just $iteration iterations!!\n\n";
		last;
	}
}
}

&print_all_num() if ($num_remaining > 0 && $detail_flag eq '-details');
&print_ans();

# The sub routine reads the problem from the file.
sub read_problem {
open (READ_FILE, "<$data_file") || die "Can't Open file: $!"; 
while (<READ_FILE>) {
        chomp($_);
        push @data_array, split(/,/,$_); 
        }
close (READ_FILE);
	my $i, $j;
	for ($a=0;$a<7;$a+=3) {
	for ($i=0;$i<3;$i++) {
		for ($b=$a;$b<$a+3;$b++){
		for ($j=0;$j<3;$j++) {
                $current_num=shift(@data_array);
		$main[$b][$i][$j]=$current_num;
			if ($current_num > 0) {
			$arr_name="pos"."$current_num";
			$num_remaining--;
			#print "Details of num found: $arr_name, curr sqr num: $b, $i, $j\n";
			&clear_row_col($arr_name,$b,$i,$j);
			&clear_location_all_num($b,$i,$j);
			&clear_square_num($b,$arr_name);
			}
		}
		}
	}
	}
print "Total digits found: ", 81 - $num_remaining, "\n";
}


sub print_ans {
my $a, $i, $j;

print "\nNumbers remaining: $num_remaining\n"; 
print "Data file: $data_file:\n";
print "Below is the final answer:\n\n";

  for ($a=0;$a<7;$a+=3) {
        for ($i=0;$i<3;$i++) {
                for ($b=$a;$b<$a+3;$b++){
                for ($j=0;$j<3;$j++) {
		if($main[$b][$i][$j] > 0) {
                print "$main[$b][$i][$j]";
                } else {
                print "?";
                }
	print ("\t");	
		}
		}
        print ("\n");
        }
  }

#print ("Above is the answer\n");
}

#This sub routine clears all the posible positions for a number when it is read for its relative row and column 
sub clear_row_col { 
my ($current_num_arr,$current_sqr_num,$current_num_row,$current_num_col)=@_;
##print "In sub: $current_num_arr,$current_sqr_num,$current_num_row,$current_num_col\n";
my $m, $k, $l;

# Clear rows
$starting_sqr=$current_sqr_num -($current_sqr_num % 3);
##print"Starting square: $starting_sqr\n";

for ($m=$starting_sqr;$m < $starting_sqr+ 3; $m++) {
	for ($k=0; $k<3; $k++) {
	${$current_num_arr}[$m][$current_num_row][$k]=0;
	}
}

# Clear columns:
$starting_sqr=$current_sqr_num % 3;
##print"Starting square: $starting_sqr\n";

for ($m=$starting_sqr;$m < $starting_sqr+ 7; $m+=3) {
        for ($k=0; $k<3; $k++) {
	${$current_num_arr}[$m][$k][$current_num_col]=0;	
        }
}

}

#This sub-routine clears the particular square for all other possible positions when a number is found, since 1 no is unique to a square
sub clear_square_num () {
my ($current_sqr_num,$current_num_arr)=@_;

for ($t=0;$t<3; $t++) {
        for ($u=0;$u<3;$u++) {
        ${$current_num_arr}[$current_sqr_num][$t][$u]=0;
        ##print "cleared: [$current_sqr_num][$t][$u]\n";
        }
}

}

# This sub-routine clears the location for all numbers when a num is found at that location.
sub clear_location_all_num () {
my $aname;
my ($sqr_num,$row_loc,$col_loc)=@_;
	for ($cur_num=1;$cur_num < 10; $cur_num++) {
	$aname="pos"."$cur_num";
	##print "$aname\n";
	${$aname}[$sqr_num][$row_loc][$col_loc]=0;
	}
}


sub print_all_num () {
for ($num=1;$num < 10; $num++) {
$current_num_arr="pos"."$num";
print "$current_num_arr:\n";
  for ($d=0;$d<7;$d+=3) {
        for ($f=0;$f<3;$f++) {
                for ($e=$d;$e<$d+3;$e++){
                for ($g=0;$g<3;$g++) {
                if(${$current_num_arr}[$e][$f][$g] > 0) {
                print "${$current_num_arr}[$e][$f][$g]";
                } else {
                print "x";
                }
        print ("\t");
                }
                }
        print ("\n");
        }
  }
}

}


#This funtion will find out unique possible positions for the numbers in a square.
sub lookup() {
$loop_pass=0;
until ($loop_pass > 3){
	for ($current_num=1;$current_num<10;$current_num++) {
	$array_name="pos"."$current_num";	
			for ($sqr_number=0;$sqr_number<9; $sqr_number++) {
			$possible_counter=0;
					for ($x=0;$x<3;$x++) { 
					for ($y=0;$y<3;$y++) { 
							if (${$array_name}[$sqr_number][$x][$y] > 0) {
							$possible_counter++;		
							$new_row_loc=$x;
							$new_col_loc=$y;
							#print "$array_name: [$sqr_number][$x][$y], counter= $possible_counter\n";
							}
					}
					}

				if ($possible_counter == 1) {	
				$main[$sqr_number][$new_row_loc][$new_col_loc]=$current_num;
				$num_remaining--;				
				print "Number found: $current_num [", $sqr_number +1, "] [", $new_row_loc + 1, "] [", $new_col_loc + 1, "] > square uniqueness\n", if ($detail_flag eq '-details');				
				#print "Remaining numbers: $num_remaining\n";
				&clear_row_col($array_name,$sqr_number,$new_row_loc,$new_col_loc);
				&clear_location_all_num($sqr_number,$new_row_loc,$new_col_loc);
				&clear_square_num($sqr_number,$array_name);											
				}
		}
		
		## lookup row uniquness:
		my $new_row, $new_col;
  for ($start_sqr=0;$start_sqr<7;$start_sqr+=3) {
        for ($row=0;$row<3;$row++) {
        $possible_counter=0;
                for ($h=$start_sqr;$h<$start_sqr+3;$h++){
                for ($col=0;$col<3;$col++) {
                #print "$array_name: [$h] [$row] [$col]\t";
                	if(${$array_name}[$h][$row][$col] > 0) {
                	$possible_counter++;		
                	$new_row=$row;
                	$new_col=$col;
                	$sq_number=$h;                	
                	} 
                }
                } 
             
        if ($possible_counter == 1) {	
									$main[$sq_number][$new_row][$new_col]=$current_num;
									$num_remaining--;
								  #print"Row: Data found: $current_num [$sq_number] [$new_row] [$new_col]\n";
									#print "Remaining numbers: $num_remaining\n";
									print "Number Found: $current_num [", $sq_number + 1, "] [", $new_row + 1, "] [", $new_col + 1, "] > row uniqueness\n", if ($detail_flag eq '-details');
									&clear_row_col($array_name,$sq_number,$new_row,$new_col);
									&clear_location_all_num($sq_number,$new_row,$new_col);
									&clear_square_num($sq_number,$array_name);											
   			}

				}     
	}
	
	
		## lookup col uniquness:
	  for ($start_sqr=0;$start_sqr<3;$start_sqr++) {
	        for ($col=0;$col<3;$col++) {
	        $possible_counter=0;
	                for ($h=$start_sqr;$h<9;$h+=3){
	                for ($row=0;$row<3;$row++) {
	                #print "$array_name: [$h] [$row] [$col]\t";
	                	if(${$array_name}[$h][$row][$col] > 0) {
	                	$possible_counter++;		
	                	$new_row=$row;
	                	$new_col=$col;
	                	$sq_number=$h;                	
	                	} 
	                }
	                } 
	                
	                #print"\n";
	             
	        if ($possible_counter == 1) {	
									$main[$sq_number][$new_row][$new_col]=$current_num;
									$num_remaining--;
								  #print"Col: Data found: $current_num [$sq_number] [$new_row] [$new_col]\n";
									#print "Remaining numbers: $num_remaining\n";
									print "Number found: $current_num [", $sq_number + 1, "] [", $new_row + 1, "] [", $new_col + 1, "] > column uniqueness\n", if ($detail_flag eq '-details');
									&clear_row_col($array_name,$sq_number,$new_row,$new_col);
									&clear_location_all_num($sq_number,$new_row,$new_col);
									&clear_square_num($sq_number,$array_name);											
	   			}
	
					}     
	  }
			
	}
	

$loop_pass++;
}

}


sub lookup_num_tie () {
#This portion will find out number tie in a sqr
for ($sqr_num=0;$sqr_num<9;$sqr_num++) {
	@double_check=();
	for ($num=1;$num<10;$num++) {
	$arr_name="pos"."$num";
	$check_no="try"."$num";
	@{$check_no} = ();
			for ($x=0;$x<3;$x++) {
			for ($y=0;$y<3;$y++) {
				if (${$arr_name}[$sqr_num][$x][$y] > 0 ) {
					push @{$check_no}, $x, $y;					
				}
			}
			}
	
	if (scalar @{$check_no} == 6) {
		if (${$check_no}[0] == ${$check_no}[2] && ${$check_no}[0] == ${$check_no}[4]) {
			#print "Triplet: Number $num blocks row ${$check_no}[0] in sqr $sqr_num\n";
			&self_dealloc_row($sqr_num, $num,${$check_no}[0]);
		}
		if (${$check_no}[1] == ${$check_no}[3] && ${$check_no}[1] == ${$check_no}[5]) {
			#print "Triplet: Number $num blocks col ${$check_no}[1] in sqr $sqr_num\n";
			&self_dealloc_col($sqr_num, $num,${$check_no}[1]);
		}
	}
	
	
	if (scalar @{$check_no} == 4) {
	push @double_check, $check_no;
	#print "look: $num, sqr: $sqr_num, @{$check_no}\n";
		if (${$check_no}[0] == ${$check_no}[2]) {
		#print "Number $num blocks row ${$check_no}[0] in sqr $sqr_num\n";
		&self_dealloc_row($sqr_num, $num,${$check_no}[0]);
		}
		if (${$check_no}[1] == ${$check_no}[3]) {
				#print "Number $num blocks col ${$check_no}[1] in sqr $sqr_num\n";
				&self_dealloc_col($sqr_num, $num,${$check_no}[1]);
		}
	}
	}

	if (scalar @double_check > 1) {
		for ($i=0; $i<$#double_check; $i++) {
		for ($k=$i+1;$k<=$#double_check;$k++) {
		$str1= join "", @{$double_check[$i]};
		$str2= join "", @{$double_check[$k]};
			if ($str1 == $str2) {  
			#print "square=$sqr_num, 1: $double_check[$i] ($str1), 2:$double_check[$k] ($str2)\n";
			$row1= shift @{$double_check[$i]};
			$col1= shift  @{$double_check[$i]};
			$row2=  shift @{$double_check[$i]};
			$col2=  shift @{$double_check[$i]};
			$double_check[$i] =~ /(\d)/;
			$num1=$1;
			$double_check[$k] =~ /(\d)/;
			$num2=$1;
			#print "sqr number= $sqr_num, num1=$num1, num2=$num2, $row1, $col1, $row2, $col2\n";
			&dealloc($sqr_num,$num1,$num2,$row1, $col1);
			&dealloc($sqr_num,$num1,$num2,$row2, $col2);		 
			}
		}
		}	
	}

}

#This portion will find out tie along a row:
  for ($start_sqr=0;$start_sqr<7;$start_sqr+=3) {
      for ($row=0;$row<3;$row++) {
      @double_check=();
      @tripple_check=();
        	for ($num=1;$num<10;$num++) {
        	$arr_name="pos"."$num";
					$check_no="try"."$num";
					@{$check_no} = ();
                	for ($h=$start_sqr;$h<$start_sqr+3;$h++){
                	for ($col=0;$col<3;$col++) {
										#print "$num [$h][$row][$col] ";
										if (${$arr_name}[$h][$row][$col] > 0 ) {
										push @{$check_no}, $h, $row, $col;			
										}
									}
									}
									#print "\n";
						if (scalar @{$check_no} == 6) {
						push @double_check, $check_no;
						}
						if (scalar @{$check_no} == 9) {	
						push @tripple_check, $check_no;	
						}	
					}
					#print "@double_check\n";					
					 #print "row: @tripple_check\n";		
						if (scalar @double_check > 1) {
							for ($i=0; $i<$#double_check; $i++) {
							for ($k=$i+1;$k<=$#double_check;$k++) {
							$str1= join "", @{$double_check[$i]};
							$str2= join "", @{$double_check[$k]};
								if ($str1 == $str2) {  
								#print "row: 1: $double_check[$i] ($str1), 2:$double_check[$k] ($str2)\n";
								$sqr_num1= shift @{$double_check[$i]};
								$row1= shift @{$double_check[$i]};
								$col1= shift  @{$double_check[$i]};
								$sqr_num2= shift @{$double_check[$i]};
								$row2=  shift @{$double_check[$i]};
								$col2=  shift @{$double_check[$i]};
								$double_check[$i] =~ /(\d)/;
								$num1=$1;
								$double_check[$k] =~ /(\d)/;
								$num2=$1;
								#print "sqr number= $sqr_num1, $sqr_num2, num1=$num1, num2=$num2, $row1, $col1, $row2, $col2\n";
								&dealloc($sqr_num1,$num1,$num2,$row1, $col1);
								&dealloc($sqr_num2,$num1,$num2,$row2, $col2);		 
								}
							}
							}	
						}

			}
	}
	
#This portion will find out tie along a col:
  for ($start_sqr=0;$start_sqr<3;$start_sqr++) {
      for ($col=0;$col<3;$col++) {
      @double_check=();
      @tripple_check=();
        	for ($num=1;$num<10;$num++) {
        	$arr_name="pos"."$num";
					$check_no="try"."$num";
					@{$check_no} = ();
                	for ($h=$start_sqr;$h<9;$h+=3){
                	for ($row=0;$row<3;$row++) {
										#print "$num [$h][$row][$col] ";
										if (${$arr_name}[$h][$row][$col] > 0 ) {
										push @{$check_no}, $h, $row, $col;			
										}
									}
									}
									#print "\n";
						if (scalar @{$check_no} == 6) {
						push @double_check, $check_no;
						}
						if (scalar @{$check_no} == 9) {
						push @tripple_check, $check_no;
						}
					}
					#print "@double_check\n";					
					#print "col: @tripple_check\n";	
						if (scalar @double_check > 1) {
							for ($i=0; $i<$#double_check; $i++) {
							for ($k=$i+1;$k<=$#double_check;$k++) {
							$str1= join "", @{$double_check[$i]};
							$str2= join "", @{$double_check[$k]};
								if ($str1 == $str2) {  
								#print "col: 1: $double_check[$i] ($str1), 2:$double_check[$k] ($str2)\n";
								$sqr_num1= shift @{$double_check[$i]};
								$row1= shift @{$double_check[$i]};
								$col1= shift  @{$double_check[$i]};
								$sqr_num2= shift @{$double_check[$i]};
								$row2=  shift @{$double_check[$i]};
								$col2=  shift @{$double_check[$i]};
								$double_check[$i] =~ /(\d)/;
								$num1=$1;
								$double_check[$k] =~ /(\d)/;
								$num2=$1;
								#print "sqr number= $sqr_num1, $sqr_num2, num1=$num1, num2=$num2, $row1, $col1, $row2, $col2\n";
								&dealloc($sqr_num1,$num1,$num2,$row1, $col1);
								&dealloc($sqr_num2,$num1,$num2,$row2, $col2);		 
								}
							}
							}	
						}

			}
	}
	

}


# this function finds out if any no can be placed "at a location" uniquely. i.e. If at any location if only 1 number is possible then that number should assume that location.
sub lookup_loc_uniquness() {

for ($starting_sqre=0;$starting_sqre<3;$starting_sqre++) {
	for ($colu=0;$colu<3;$colu++) {
	@check_loc_tie=();
	%num_loc=();
		for ($sqr_numb=$starting_sqre;$sqr_numb< $starting_sqre + 7;$sqr_numb +=3) {
			for ($rowu=0;$rowu<3;$rowu++) {
			@unique_loc=();	
			#print "hey: $sqr_numb [$rowu][$colu]\n";
					for ($num=1;$num<10;$num++) {
						$arr_nam="pos".$num;
						if (${$arr_nam}[$sqr_numb][$rowu][$colu] >0) {
						push @unique_loc, $num;
						$unique_num=$num;
						$unique_arr=$arr_nam;							
#						push $num_loc{$num}, $sqr_numb, $rowu;
						}
					}
					if (scalar @unique_loc == 1) {
										#print "Found unique position for @unique_loc at [$sqr_numb][$rowu][$colu]: $unique_num\n";
										#&print_all_num();
										#print "x $arr_nam x, $unique_arr, $sqr_numb, $rowu, $colu\n";
										$main[$sqr_numb][$rowu][$colu]=$unique_num;
										$num_remaining--;
										print "Number found: $unique_num [", $sqr_numb + 1, "] [", $rowu + 1, "] [", $colu + 1, "] > location uniqueness\n", if ($detail_flag eq '-details');
										&clear_row_col($unique_arr,$sqr_numb,$rowu,$colu);										
										&clear_location_all_num($sqr_numb,$rowu,$colu);
										&clear_square_num($sqr_numb,$unique_arr);													
					}
					
					if (scalar @unique_loc == 2) {
					#print "@unique_loc\n";						 AJAY
					$naked_pair="$unique_loc[0]"."$unique_loc[1]";
					push @check_loc_tie, $naked_pair;								
					}
					
			}
		
		}
			#print "@check_loc_tie\n";		
			for ($i=0; $i<$#check_loc_tie; $i++) {
												for ($k=$i+1;$k<=$#check_loc_tie;$k++) {
												$str1= join "", $check_loc_tie[$i];
												$str2= join "", $check_loc_tie[$k];
													if ($str1 == $str2) {  
					#print "Tie: square=$sqr_numb, col=$colu, 1: $check_loc_tie[$i] ($str1), 2:$check_loc_tie[$k] ($str2)\n";
					($num1,$num2)=split "", $str1;
					#print "$num1,$num2\n";
					}
					}
			}
	}

}


}

sub dealloc() {
my ($sqr_number, $num1, $num2, $dealloc_row, $dealloc_col)=@_;
	for ($number=1; $number<10; $number++) {
	$arr_name="pos"."$number";
	unless ($number == $num1 || $number == $num2) {
	${$arr_name}[$sqr_number][$dealloc_row][$dealloc_col] = 0;
	#print "$arr_name [$sqr_number] [$dealloc_row] [$dealloc_col] = ${$arr_name}[$sqr_number][$dealloc_row][$dealloc_col] \n";
	}
	}

}

sub self_dealloc_row() {
my ($sqr_number,$number, $row)=@_;
$starting_sqr=$sqr_num - ($sqr_num % 3);
$current_num_arr = "pos".$number;
#print "$starting_sqr, $current_num_arr\n";
	for ($m=$starting_sqr;$m < $starting_sqr+ 3; $m++) {
		for ($k=0; $k<3; $k++) {
			unless ($m == $sqr_num) {
			#print "self, row: $current_num_arr [$m][$row][$k]\t" if (${$current_num_arr}[$m][$row][$k]>0);
			${$current_num_arr}[$m][$row][$k]=0;
			
			}
		}
	}
#print "\n";
}


sub self_dealloc_col() {
my ($sqr_number,$number, $col)=@_;
$starting_sqr=$sqr_num % 3;
$current_num_arr = "pos".$number;
#print "$starting_sqr, $current_num_arr\n";
	for ($m=$starting_sqr;$m < $starting_sqr+ 7; $m+=3) {
		for ($k=0; $k<3; $k++) {
			unless ($m == $sqr_num) {
			#print "self, col: $current_num_arr [$m][$k][$col]\t" if (${$current_num_arr}[$m][$k][$col]>0);
			${$current_num_arr}[$m][$k][$col]=0;
			
			}
		}
	}
#print "\n";
}
