# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 2 };
use Commands::Guarded qw(:step verbose);

#########################

verbose(0);

my $var = 1;

step makeVarZero =>
  ensure { $var == 0 }
  using { $var = 0 }
  rollback { $var = 1 };

ok($var == 0);

eval {
   step failForRollback =>
     ensure { 1 == 0 }
       using { 1 }
	 ;
};

ok($var == 1);
