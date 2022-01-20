#!/usr/bin/env perl
# start with ARISE or ARIES
use strict;
use warnings;
use feature 'say';

my @dict;

{
    open DICT, '<', '/usr/share/dict/words' || die;
    while(<DICT>){
        chomp;
        push @dict, uc if length == 5;
    }
    close DICT;
}

@dict = grep(!/A/, @dict);
@dict = grep(!/I/, @dict);
@dict = grep(!/S/, @dict);
@dict = grep(!/E/, @dict);
@dict = grep(!/C/, @dict);
@dict = grep(!/K/, @dict);
@dict = grep(!/U/, @dict);
@dict = grep(!/N/, @dict);
@dict = grep(!/D/, @dict);
@dict = grep(!/P/, @dict);

@dict = grep(/R/, @dict);
@dict = grep(/T/, @dict);
@dict = grep(/O/, @dict);
@dict = grep(/B/, @dict);

@dict = grep(!/^.R...$/, @dict);
@dict = grep(!/^T....$/, @dict);
@dict = grep(!/^..O..$/, @dict);
@dict = grep(!/^B....$/, @dict);
@dict = grep(!/^..R..$/, @dict);

{
    print scalar(@_);
    print ' ';
    for(1..5){
        print pop @_;
        print ' ';
    }
    say '';
}

exit;