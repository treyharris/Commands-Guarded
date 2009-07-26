# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Commands::Guarded qw(:step verbose);

#########################

verbose(0);

my @nums = (1..10);

my $step = step doForeachTest =>
  ensure { $nums[$_[0]] % 2 }
  using { $nums[$_[0]]++ }
  ;

$step->do_foreach(0..$#nums);

foreach (@nums) {
   ok(0) unless $_ % 2;
}

ok(1)
