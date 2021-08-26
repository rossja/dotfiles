#!/usr/bin/perl
# scriptkitty is best kitty!
use strict;

my @chars=(

   "\x0a","\x0a","\x3d","\x78",
   "\x3d","\x20","\x0a","\x6f",
   "\x20","\x2e","\x20","\x0a",
   "\x5e","\x5f","\x5f","\x5f",
   "\x5e","\x0a","\x0a","\x79",
   "\x74","\x74","\x69","\x6b",
   "\x0a","\x74","\x70","\x69",
   "\x72","\x63","\x73","\x0a",

);


for(my $i=scalar(@chars); $i>=0; $i--) {
   print "$chars[$i]";
}
