#!/usr/bin/perl

($pdb_file, $chain, $disease_residue_list) = @ARGV;


open I, "< $disease_residue_list";
while(<I>){
	@c=split;
	$d{$c[0]}=1; #define disease residues
}
close I;

open P, "< $pdb_file";
while(<P>){ #get xyz coordinates from PDB file
	next unless (/^(ATOM|HETAT)/);
	$cx = substr $_,21,1;
	next unless ($cx eq $chain);
        $at = substr $_,11,5;
        $at =~ s/\s//g;
        next unless ($at eq 'CA');
        $x = substr $_,30,8;
        $y = substr $_,38,8;
        $z = substr $_,46,8;
        $x =~ s/\s//g;
        $y =~ s/\s//g;
        $z =~ s/\s//g;
        $res = substr $_,22,4;
        $res =~ s/\s//g;
        $x{$res} = $x;
        $y{$res} = $y;
        $z{$res} = $z;
}

for $i (keys %x){
	$min = '';
	for $d (keys %d){
		next if ($i==$d);
		$r2 = ($x{$i}-$x{$d})**2 + ($y{$i}-$y{$d})**2 + ($z{$i}-$z{$d})**2;
		if ($min eq '' or ($r2 < $min)){
			$min = $r2;
			$mind = $d;
		}
	}
	if ($d{$i}){
		$mean_disease += log(sqrt($min));
		$n_disease++;
	}else{
		$mean_other += log(sqrt($min));
		$n_other++;
	}
}

printf "%lf\n", ($mean_other/$n_other)/($mean_disease/$n_disease);
