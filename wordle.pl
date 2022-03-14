#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

my @dict;

{
    my %hash;
    open DICT, '<', '/usr/share/dict/words' || die;
    while(<DICT>){
        chomp;
        $_ = uc($_);
        $hash{$_}++ if length == 5;
    }
    close DICT;
    @dict = keys(%hash);
}

@dict = grep(/A/, @dict);
@dict = grep(/R/, @dict);
@dict = grep(/I/, @dict);
@dict = grep(/S/, @dict);
@dict = grep(/E/, @dict);

map {say} (sort @dict);

for my $i (0..4){
    say $i;
    my %hash;
    for my $word (@dict){
        $hash{substr($word, $i, 1)}++;
    }
    for my $char (sort {$hash{$b}-$hash{$a}} keys(%hash)){
        printf "%3d %s\n", $hash{$char}, $char;
    }
}

exit;
