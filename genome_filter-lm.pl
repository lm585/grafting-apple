#chr     pos     base    DNA-1380        DNA-2228	RNA-Seq
#chr1    680     A       A(7)    A(4)T(7)
#chr1    10973   C       C(9)    C(11)T(7)       C(2)   
#chr1    10975   A       A(9)    A(11)C(6)       A(2)   

# column 4:  rootstock DNA
# column 5:  scion DNA
# column 6:  rootstock RNA

while(<>) {
	print if (/base/);
	my $homo1;
	my $homo2;
	my %geno1;
	my %geno2;
	@a = split "\t";
	$genotype1 = $a[3];
	$genotype2 = $a[4];
	$genotype1 =~ s/\)/#/g;
	$genotype1 =~ s/\(/#/g;
	$genotype2 =~ s/\)/#/g;
	$genotype2 =~ s/\(/#/g;

	@g1 = split("#", $genotype1);
	my @geno1;
	for ($i = 1; $i < @g1; $i+=2) {
		push(@geno1, $g1[$i]);
		$geno1{$g1[$i]} = $g1[$i-1] 
	}
	my @sorted_geno1 = sort { $b <=> $a } @geno1;
#	print join("\t", @sorted_geno1), "||"; 

	if ($sorted_geno1[0] < 7) { $homo1 = 0; }
	elsif (@sorted_geno1 < 2) { $homo1 = 1; }
#	elsif ($sorted_geno1[0] / $sorted_geno1[1] >= 10) { $homo1 = 1; }
	else { $homo1 = 0; }

	@g2 = split("#", $genotype2);
	my @geno2;
	for ($i = 1; $i < @g2; $i = $i + 2) {
		push(@geno2, $g2[$i]);
		$geno2{$g2[$i]} = $g2[$i-1]
	}
	my @sorted_geno2 = sort { $a <=> $b } @geno2;
#	print join("\t", @sorted_geno2), "||";
	if ($sorted_geno2[0] < 7) { $homo2 = 0; }
	elsif (@sorted_geno2 < 2) { $homo2 = 1; }
#	elsif ($sorted_geno2[0] / $sorted_geno2[1] >= 10) { $homo2 = 1; }
	else { $homo2 = 0; }

	print if ($homo1 && $homo2 && ($geno1{$sorted_geno1[0]} ne $geno2{$sorted_geno2[0]}));
}
