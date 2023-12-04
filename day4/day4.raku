my @lines = 'input.txt'.IO.lines;
my @cards = 1 xx +@lines;
my $sump1;

for ^+@lines -> $i {
    my ($winning-numbers, $nums) = @lines[$i].split(/<[:|]>/)[1,2].map(*.words.Array);
    my $cnt = +$nums.grep(* == $winning-numbers.any);

    $sump1 += 2**($cnt-1) if $cnt > 0;
    @cards[$i+1 .. $i+$cnt] »+=» @cards[$i];
}

put 'part 1: ', $sump1;
put 'part 2: ', @cards.sum;