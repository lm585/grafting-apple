#chr     pos     base    DNA-1380        DNA-2228        1380-4S.pair.noDup.c1
#chr1    407     C       C(14)   T(11)   N
#chr1    651     G       T(11)   G(14)   N
#chr1    11060   T       G(16)   T(10)   N

while(<>) {
	print if (/base/);
	chomp;
	@a = split "\t";
	for ($i = 3; $i < @a; $i++) {
		$a[$i] =~ s/\(.*?\)//g;
	}

	print "$_\n" if ($a[3] ne $a[5] && $a[5] ne "N" && $a[5] =~ /$a[4]/);
}
