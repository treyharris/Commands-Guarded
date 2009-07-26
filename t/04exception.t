# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Commands::Guarded qw(:step verbose);

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

verbose(0);

my $var = 0;

eval {
   step nullOp =>
     ensure { $var == 1 }
       using {
	  $var = 0	; # shouldn't work
       };
};

ok($@);
