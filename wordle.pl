#!/usr/bin/env perl
# https://www.nytimes.com/games/wordle/
use strict;
use warnings;
use feature 'say';

my @dict = sub {
    my %hash;
    open my $dict, '<', shift || die;
    while(<$dict>){
        chomp;
        $hash{uc($_)}++ if length == 5;
    }
    keys(%hash);
}->('/usr/share/dict/words');

@dict = grep(/A/, @dict);
@dict = grep(/^A/, @dict);
@dict = grep(/R/, @dict);
@dict = grep(/^.R/, @dict);
@dict = grep(/I/, @dict);
@dict = grep(/^..I/, @dict);
@dict = grep(/S/, @dict);
@dict = grep(/^...S/, @dict);
@dict = grep(/E/, @dict);
@dict = grep(/^....E/, @dict);

map {say} (sort @dict);

my ($hash, $order) = ({}, {});

for my $position (0..4){
    $hash->{$position} = {};
    $order->{$position} = [];
    for my $word (@dict){
        $hash->{$position}->{substr($word, $position, 1)}++;
    }
    for my $char (sort {
        $hash->{$position}->{$b} - $hash->{$position}->{$a}
                  } keys(%{$hash->{$position}})){
        push @{$order->{$position}}, $char;
    }
}

while(1){
    my @buf;
    for my $position (0..4){
        if(my $char = shift @{$order->{$position}}){
            push @buf, sprintf('%4d %s', $hash->{$position}->{$char}, $char);
        }else{
            push @buf, '      ';
        }
    }

    my $s = join('  ', @buf);
    exit if $s =~ /^\s+$/;
    say $s;
}

exit;
